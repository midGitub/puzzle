--[[
	又是Cocos2d-x-Lua自带的，看用得那么爽，就直接搬过来了啦
	这里非常的巧妙，使用的类自身带有一个对象
	所以就像调用静态函数般使用
	注意：这里必须创建一个instance，
	instance是CCRect的对象
	否则会造成size不存在及origin为nil
	增加了Origin和VisbleSize的X和Y值
--]]

require "Extension/class"

VisibleRect = class("VisibleRect")
--还是不知道设来有什么用，没用暂时没有发现问题
--VisibleRect.__index = VisibleRect

VisibleRect = 
{
	s_visibleRect = CCRect:new();
}

function VisibleRect:lazyInit()
    if (self.s_visibleRect.size.width == 0.0 and self.s_visibleRect.size.height == 0.0) then
		--用CCDirector:sharedDirector()貌似是一样的
        local pEGLView = CCEGLView:sharedOpenGLView();
        self.s_visibleRect.origin = pEGLView:getVisibleOrigin();
        self.s_visibleRect.size = pEGLView:getVisibleSize();
    end
end

function VisibleRect:getVisibleRect()
    self:lazyInit();
    return CCRectMake(self.s_visibleRect.origin.x, self.s_visibleRect.origin.y, self.s_visibleRect.size.width, self.s_visibleRect.size.height);
end

function VisibleRect:left()
    self:lazyInit();
    return ccp(self.s_visibleRect.origin.x, self.s_visibleRect.origin.y+self.s_visibleRect.size.height/2);
end

function VisibleRect:right()
    self:lazyInit();
    return ccp(self.s_visibleRect.origin.x+self.s_visibleRect.size.width, self.s_visibleRect.origin.y+self.s_visibleRect.size.height/2);
end

function VisibleRect:top()
    self:lazyInit();
    return ccp(self.s_visibleRect.origin.x+self.s_visibleRect.size.width/2, self.s_visibleRect.origin.y+self.s_visibleRect.size.height);
end

function VisibleRect:bottom()
    self:lazyInit();
    return ccp(self.s_visibleRect.origin.x+self.s_visibleRect.size.width/2, self.s_visibleRect.origin.y);
end

function VisibleRect:center()
    self:lazyInit();
    return ccp(self.s_visibleRect.origin.x+self.s_visibleRect.size.width/2, self.s_visibleRect.origin.y+self.s_visibleRect.size.height/2);
end

function VisibleRect:leftTop()
    self:lazyInit();
    return ccp(self.s_visibleRect.origin.x, self.s_visibleRect.origin.y+self.s_visibleRect.size.height);
end

function VisibleRect:rightTop()
    self:lazyInit();
    return ccp(self.s_visibleRect.origin.x+self.s_visibleRect.size.width, self.s_visibleRect.origin.y+self.s_visibleRect.size.height);
end

function VisibleRect:leftBottom()
    self:lazyInit();
    return self.s_visibleRect.origin;
end

function VisibleRect:rightBottom()
    self:lazyInit();
    return ccp(self.s_visibleRect.origin.x+self.s_visibleRect.size.width, self.s_visibleRect.origin.y);
end

--originX和originY只是为了直观而写，其实直接调用leftBottom效果一样
function VisibleRect:originX()
	self:lazyInit();
	return self.s_visibleRect.origin.x;
end

function VisibleRect:originY()
	self:lazyInit();
	return self.s_visibleRect.origin.y;
end

function VisibleRect:visibleX()
	self:lazyInit();
	return self.s_visibleRect.size.width;
end

function VisibleRect:visibleY()
	self:lazyInit();
	return self.s_visibleRect.size.height;
end


Return-Path: <netdev+bounces-125472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBB696D332
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 11:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15661F27462
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 09:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEBF199EA6;
	Thu,  5 Sep 2024 09:27:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE5B19882C
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528468; cv=none; b=CFFzTzuFiQa50sOKka53fkR+ZxAZ15Yk9lUQamqR2F6VTu6nM25KjdmHnORHeP85BuuywLvdUc5vCmI2qXr0Rba2cEETsTTWjBUfWxaVU6b3dwwrrzmdaOCm9dzXf8jSNvwzK1B7fVR8Vb7yYZHdjaYwHHtmju1paNn2YIzBS28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528468; c=relaxed/simple;
	bh=D8laMsjycFODZcfrn7fXNVSHpR/GMmLmddayQy2A6nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cc1zjI+sP+mkX7co0iTqCFi4SAcP4ntXxAking6/JGz7nD2Cr1GFXy1ZJGg41XWeW5tQkFg2Us+JeqPaxjeeXqPq5H1HUuhtQiXGzUvediaS26Xcu/g14H02/3BeoaPg1xHR5lPUpjhQoM7yS22tgWhTkWgsitdJtV0wnXRoxCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a86a37208b2so86817566b.0
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 02:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725528464; x=1726133264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2V9tzqJMuVEJDOgGrMQX1flExuJcGCW/Jzah4ggBR8=;
        b=W+xAZ2SWlc33HmHY5XDCrwQ+s3hJ/xos0ahBRp1tXK3eZla6yW1SX1o7sDJB+M4IVh
         zAyXm9t27qsdIixKRf/nPcTXI/D5ZWm/E337YL+lh9HfEdV2s0RtiZLMiBuP2dBRqN7J
         ozXiPjB8KsdOSTnIsJnZX/77PChyWOkVyJ/HCAa45YpNkLN2NahNIUuAIrSRjveTpnYL
         OR+u4C3r6/7NG0jmrzf1nCiWs2oTw5n5KI3BI/q3WM5Q97J4UYgSldbUxkwbW6oKSLjk
         j6D88scKMAOa8Z1KgOVTFq8DxHP9Ff5ZMs2Kdnfa2UxhVaXgDfkjn5zGhmkYS0aQN/5W
         jTig==
X-Forwarded-Encrypted: i=1; AJvYcCWLmTCuUUjkiIr6BuHundy/Z96Bq1UdMkKatLOM9HTPDf+rlQmwFAnAe368Xds5nGq2kphMS/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTgxUEkB/VDW1YsxnYQp1RYzXGqU9pVUs5s5nElfmaGMFTzFZ3
	ZkM9IZgtWw/ygyNkI1AscrvCnsTwyGWZe1IYpNRCW9g6obFC8IVM
X-Google-Smtp-Source: AGHT+IG6QhWre85BCuK2rL6efqidAFJmiFe7nUYREOe9BLu0vHbuBMje9HG4ZNBwiNXXPnvxJ8KZiw==
X-Received: by 2002:a17:906:cad9:b0:a8a:4456:41ad with SMTP id a640c23a62f3a-a8a44572988mr325369366b.26.1725528463215;
        Thu, 05 Sep 2024 02:27:43 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623a6c68sm110907066b.177.2024.09.05.02.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 02:27:42 -0700 (PDT)
Date: Thu, 5 Sep 2024 02:27:40 -0700
From: Breno Leitao <leitao@debian.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] netpoll: remove netpoll_srcu
Message-ID: <20240905-witty-naughty-kakapo-7eae8b@devvm32600>
References: <20240905084909.2082486-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905084909.2082486-1-edumazet@google.com>

Hello Eric,

On Thu, Sep 05, 2024 at 08:49:09AM +0000, Eric Dumazet wrote:
> netpoll_srcu is currently used from netpoll_poll_disable() and
> __netpoll_cleanup()
> 
> Both functions run under RTNL, using netpoll_srcu adds confusion
> and no additional protection.

Thanks for fixing it. I have never understood that SRCU in netpoll.

Reading this code now again, I have the impression that netpoll_srcu was
created to be able to dereference ->npinfo using an RCU primitive.

> Moreover the synchronize_srcu() call in __netpoll_cleanup() is
> performed before clearing np->dev->npinfo, which violates RCU rules.

I think the goal was to make sure that all the readers are not in the
critical section anymore, and wait for them. But it is unclear why it is
mixing srcu_read_lock() and rcu_read_lock() together.

Anyway, thanks for solving this.

> After this patch, netpoll_poll_disable() and netpoll_poll_enable()
> simply use rtnl_dereference().
> 
> This saves a big chunk of memory (more than 192KB on platforms
> with 512 cpus)
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Breno Leitao <leitao@debian.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

I've double checked that netpoll_poll_disable() and
netpoll_poll_enable() is always called with rtnl held, so, the change is
safe.


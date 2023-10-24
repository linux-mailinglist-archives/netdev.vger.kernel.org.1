Return-Path: <netdev+bounces-43764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A0D7D49DF
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 10:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8EF1F21AE5
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 08:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D174A1BDC8;
	Tue, 24 Oct 2023 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Kb6BXI4Q"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEF6111BD
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 08:21:33 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C208F
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 01:21:31 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5859a7d6556so3315397a12.0
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 01:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698135691; x=1698740491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HUo6nBDSjHnWxlBYRXP9wvzcVcvr9aSoPVi9khaxylQ=;
        b=Kb6BXI4QgZ7xPLow1JYc2OaFq4/PbC7AJbBpZbaepuRaJYkyIEqQrZTYFNnIlmvI7d
         aQYqOJBrj7FtZgsD1O2Lcq/XF45Kk0I47yleg6bKvERdXp0Vu440L/iiJS5IYL1vrth5
         qbQoJEpZiqC11v9DhWYRhar94KhULRBbG2zefgatzCCADkCYNA7kTcTW3IFwIXxVAe/Q
         rXceJy+7WY/4zSwtPZFQYoztLADv55XYQMz4ubLypldzIZyIE/0F1zWujm4uOtWTA8lx
         Mbo8SIkHlPxLY/UGIAdi0VjmsBEGodbojUAf1/BOJdTNteCkjbgqoe/cH8UarjMUZXMk
         Blmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698135691; x=1698740491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUo6nBDSjHnWxlBYRXP9wvzcVcvr9aSoPVi9khaxylQ=;
        b=C4GcYA4+9B1FALfNVkMHSmW/LmJdhTzcEFgWIzpSIUPr+mKfivVa4Wd+zgU6lnBHjs
         I0rbLa6AhR9gL1IqrvRHTcpFwAVQ6i+UEs7QHnF0lMDU6P7tZSSoyV0FufQhBWPCqlxf
         LnEl/elOkjpFGbTdm84UQ4lr45T4K5uP3Fc+vncE+bKm5nCCCdQIwRKXiKIbanEHPdVj
         JVeSg0kqZ4f42IDGt2GppJgOsr2A6Ir7bJdfcC2iUJzJa1zAKTc8SAp2368u3dXXJ5g2
         n7xHc7EelcObM88qFKaoRoav2++bhkYI4cPi8VrvHPb7mN4IWgz8IvBIKZ68t8Y5YLTl
         yPKA==
X-Gm-Message-State: AOJu0Yxnee2FtpGha3RtZ85A/XZAM2BWbRbwAvxhlvBQ5vwDscfhtUdH
	rTcO6L8NeUJ2vQAHowylNFClgIlrMLKk8cO/4CI=
X-Google-Smtp-Source: AGHT+IHbILyu6kZBKayDDb4NnoqcCDA4V3hXD153HR0lhVyDjX8ZUOVIYiA3+aqhk3W6AOa8Rx4r+A==
X-Received: by 2002:a05:6a21:a109:b0:15d:e68d:a850 with SMTP id aq9-20020a056a21a10900b0015de68da850mr1519205pzc.29.1698135691165;
        Tue, 24 Oct 2023 01:21:31 -0700 (PDT)
Received: from [10.84.152.177] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id fb22-20020a056a002d9600b006be17e60708sm7200680pfb.204.2023.10.24.01.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 01:21:30 -0700 (PDT)
Message-ID: <b2bde6a6-a242-4eeb-9a65-4081e8ac5df7@bytedance.com>
Date: Tue, 24 Oct 2023 16:21:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH net v3 3/3] sock: Ignore memcg pressure heuristics
 when raising allocated
To: Paolo Abeni <pabeni@redhat.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Shakeel Butt <shakeelb@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231019120026.42215-1-wuyun.abel@bytedance.com>
 <20231019120026.42215-3-wuyun.abel@bytedance.com>
 <69c50d431e2927ce6a6589b4d7a1ed21f0a4586c.camel@redhat.com>
Content-Language: en-US
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <69c50d431e2927ce6a6589b4d7a1ed21f0a4586c.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/23 3:08 PM, Paolo Abeni Wrote:
> On Thu, 2023-10-19 at 20:00 +0800, Abel Wu wrote:
>> Before sockets became aware of net-memcg's memory pressure since
>> commit e1aab161e013 ("socket: initial cgroup code."), the memory
>> usage would be granted to raise if below average even when under
>> protocol's pressure. This provides fairness among the sockets of
>> same protocol.
>>
>> That commit changes this because the heuristic will also be
>> effective when only memcg is under pressure which makes no sense.
>> So revert that behavior.
>>
>> After reverting, __sk_mem_raise_allocated() no longer considers
>> memcg's pressure. As memcgs are isolated from each other w.r.t.
>> memory accounting, consuming one's budget won't affect others.
>> So except the places where buffer sizes are needed to be tuned,
>> allow workloads to use the memory they are provisioned.
>>
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>> Acked-by: Shakeel Butt <shakeelb@google.com>
>> Acked-by: Paolo Abeni <pabeni@redhat.com>
> 
> It's totally not clear to me why you changed the target tree from net-
> next to net ?!? This is net-next material, I asked to strip the fixes
> tag exactly for that reason.

Sorry I misunderstood your suggestion..

> 
> Since there is agreement on this series and we are late in the cycle, I
> would avoid a re-post (we can apply the series to net-next anyway) but
> any clarification on the target tree change will be appreciated,
> thanks!

Please apply to net-next.

Thanks!
	Abel


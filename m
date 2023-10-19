Return-Path: <netdev+bounces-42721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B117CFF54
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 18:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7CC91C20AD9
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 16:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5F3321BA;
	Thu, 19 Oct 2023 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmgWcJ9Z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47DA321B0
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 16:20:39 +0000 (UTC)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304B712F;
	Thu, 19 Oct 2023 09:20:38 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-352a3a95271so30464425ab.0;
        Thu, 19 Oct 2023 09:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697732437; x=1698337237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B9Bop2WmUVBXPTMnv1oP6kyprFa3JCCsq3aX8cDNu2o=;
        b=AmgWcJ9ZdCwyqQxwGZpMgziCA6TTN8MYKyRFmP6FlF9DErrtQq9BkDgaFWu5by7UI+
         m6qf+tS1OdX30Yxz9fueZykhu98RN4F/NmuX4zhbKy8UNlqrv5Tbbv/QLBYt4mDKbw3H
         DCOViumuJkOScpXIZXPcZOT+EQej12neJLjdIlo8Tl5PdjS/RNU3pOrhwpr9N619AVBY
         GfwZ0rLrF3mZkfEy4BXD81UoSM8YU35HmxONMmZ1JCUlrLuDKqOG+yr+sAG+GkXvy4Pk
         rXxKzq4doEXE6IajmnvPBoaNId1Cd1zTExO+vn+EDM/CAZXbmHfyNwE5jJgZOgDAtNf0
         yTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697732437; x=1698337237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B9Bop2WmUVBXPTMnv1oP6kyprFa3JCCsq3aX8cDNu2o=;
        b=aSP2WPowSTLlbxDJW3tCAYSclugQLpXbmv3ABpfipW88shwbGaumAHIush8gVzMwEI
         JRWaBm6SIduKebO4UMGDQHNRw1iyI3FDQxejQ6OVEfyZez8ajLfVhMmawfBUfXDM7+tR
         FiXg6YgwF5FU5Ftz9B2zbSD+j78vikVazotkcS/vRAY6kBmsnR4akMM54KE/3WHPxGb3
         dlkVwk46pc6TKSnDKw1RfKo3pwF0ktlXNTY/tjxN0fnnDVjmjW5ekhoUpn26Ryvj/WW+
         ezF4l8SZ2pFUdHgBBpi+dGzy3sO5sOFywFU01OfLSi96QfKESt1AXTTDH5srImY/WYmY
         KOiQ==
X-Gm-Message-State: AOJu0Yw5jJtsmgjyi6YpAEq2gG2c7nCD+aJaD0gWGpFGLBFi8wCbbg97
	7U5lEezDN3IbPpGzly5ueX90dc5sKbE=
X-Google-Smtp-Source: AGHT+IF+uY1jl61TSt/2mynTkep7aI6pwUAy/4eE/x2mbe30Gmf0uXFpheHiInxcfWsruQovG+m8sg==
X-Received: by 2002:a05:6e02:1be2:b0:34f:525d:198 with SMTP id y2-20020a056e021be200b0034f525d0198mr3467718ilv.13.1697732437418;
        Thu, 19 Oct 2023 09:20:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i7-20020a056a00004700b006862b2a6b0dsm5502748pfk.15.2023.10.19.09.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 09:20:36 -0700 (PDT)
Message-ID: <c0f98227-459f-43c6-9c0e-db0a7ea07c9e@gmail.com>
Date: Thu, 19 Oct 2023 09:20:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/1] ethtool: fix clearing of WoL flags
Content-Language: en-US
To: =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Michal Kubecek <mkubecek@suse.cz>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20231019070904.521718-1-o.rempel@pengutronix.de>
 <20231019090510.bbcmh7stzqqgchdd@lion.mk-sys.cz>
 <20231019095140.l6fffnszraeb6iiw@lion.mk-sys.cz>
 <20231019122114.5b4a13a9@kmaincent-XPS-13-7390>
 <20231019105048.l64jp2nd46fxjewt@lion.mk-sys.cz>
 <20231019152743.09b28ef4@kmaincent-XPS-13-7390>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231019152743.09b28ef4@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/19/23 06:27, Köry Maincent wrote:
> On Thu, 19 Oct 2023 12:50:48 +0200
> Michal Kubecek <mkubecek@suse.cz> wrote:
> 
>> On Thu, Oct 19, 2023 at 12:21:14PM +0200, Köry Maincent wrote:
>>> On Thu, 19 Oct 2023 11:51:40 +0200 > Michal Kubecek <mkubecek@suse.cz>
>>> wrote:
>>>>
>>>> The issue was indeed introduced by commit 108a36d07c01 ("ethtool: Fix
>>>> mod state of verbose no_mask bitset"). The problem is that a "no mask"
>>>> verbose bitset only contains bit attributes for bits to be set. This
>>>> worked correctly before this commit because we were always updating
>>>> a zero bitmap (since commit 6699170376ab ("ethtool: fix application of
>>>> verbose no_mask bitset"), that is) so that the rest was left zero
>>>> naturally. But now the 1->0 change (old_val is true, bit not present in
>>>> netlink nest) no longer works.
>>>
>>> Doh I had not seen this issue! Thanks you for reporting it.
>>> I will send the revert then and will update the fix for next merge-window.
>>
>> Something like the diff below (against current mainline) might do the
>> trick but it's just an idea, not even build tested.
> 
> Seems a good idea without adding too much complexity to the code.
> Will try that and send it in next merge window.

Not sure what you mean by next merge window, we need a fix for right 
now, or we need to revert 6699170376ab ("ethtool: fix application of 
verbose no_mask bitset").
-- 
Florian



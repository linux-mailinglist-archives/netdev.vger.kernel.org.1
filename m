Return-Path: <netdev+bounces-42756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07177D00AC
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E2AB213A9
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A77335DB;
	Thu, 19 Oct 2023 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D05tFMRf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D571438DD7
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 17:34:54 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DE9CF;
	Thu, 19 Oct 2023 10:34:53 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b2ec9a79bdso1245793b6e.3;
        Thu, 19 Oct 2023 10:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697736893; x=1698341693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/62ZgoTi3SSzkbLGsJ1Vo2TqsEllvmMDi2mGJdwfjxg=;
        b=D05tFMRfJaT0G+qaDSQzOxN4sUNGrhkEoqb0AFPn/0/z30y+26w3HEvUWf3VrPFSK0
         bvyen7jb5Ru9GavQC69zHaJBzNrLiz6CFrZtNhS1CWey0NdHV/GEgy0GEpU8+0TUdwT8
         /GFjafz4Hj2e8M4KSF9JIvzB8VVmGC8C2UtwivvsJjk8TwpWepxWTkMv533yQC2PJDWm
         +BP7MysscyMWIi8OJsP7cFffFiN0YZFp9rXeRGjODYM/r032h4mMQlJumy3KtUzF/f+y
         HhegkCdHtUWGhIFkRGu+Zw/GWSAgiDE+Ugmqi8ImN8jXPFKWcpp2rwtXBPFuIuNi/nUp
         p2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697736893; x=1698341693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/62ZgoTi3SSzkbLGsJ1Vo2TqsEllvmMDi2mGJdwfjxg=;
        b=L/HnUf9pMr/kZVdmcGAYdtVp+GRZz/UKqrUIJoGJZV+UCBL0/qCHms+/kiw5tlzZgs
         D1bxmFFdNgyM6FHaR6cB1sggCgpfiikiPCwSTdtsCXd9s33j8p+YY+aZQW4LLbXPh/PT
         NfjaUlRRkzHJd6Buym9pvyLJsZhUDfRspLT5aYcC6YKArRno61Lfq5opEy/5SWTed0nC
         mpZdK3f0ZONtN/eSs7LEcE6EvsuI6mmfWEShFc77clgKg3YzDmziROmS+vaXrHICgh7H
         SQm8JeDUxYgLNDjBqEUFQ9i5NGoOz6UBPeHETPeK1OWAwpqrUQ3Mu0IFeUyTpCxctifM
         C31Q==
X-Gm-Message-State: AOJu0YwcmNn17mKq+ojWgasZav9A3QfLwIpiMbFVjCzS1stwdwOQHFhc
	M2JiGJ4qDiFuoF7tI2/LI0Y=
X-Google-Smtp-Source: AGHT+IFzK8OJRCXovwSUpAWCNgFhVZ0dOThZwS+dQBOQj9NV+mZfr+sn/sgCC+FNpjGYB1/KPSStpg==
X-Received: by 2002:a05:6358:facd:b0:143:a15f:65d4 with SMTP id ts13-20020a056358facd00b00143a15f65d4mr2511206rwb.26.1697736892795;
        Thu, 19 Oct 2023 10:34:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bv8-20020a632e08000000b00578b8fab907sm16521pgb.73.2023.10.19.10.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 10:34:52 -0700 (PDT)
Message-ID: <68d7e387-aa2b-40a6-b0bf-f2f57053df8e@gmail.com>
Date: Thu, 19 Oct 2023 10:34:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/1] ethtool: fix clearing of WoL flags
Content-Language: en-US
To: Michal Kubecek <mkubecek@suse.cz>
Cc: =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
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
 <c0f98227-459f-43c6-9c0e-db0a7ea07c9e@gmail.com>
 <20231019164553.zcc6d2vbxzw4m4c2@lion.mk-sys.cz>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231019164553.zcc6d2vbxzw4m4c2@lion.mk-sys.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/19/23 09:45, Michal Kubecek wrote:
> On Thu, Oct 19, 2023 at 09:20:31AM -0700, Florian Fainelli wrote:
>> On 10/19/23 06:27, Köry Maincent wrote:
>>> On Thu, 19 Oct 2023 12:50:48 +0200
>>> Michal Kubecek <mkubecek@suse.cz> wrote:
>>>
>>>> On Thu, Oct 19, 2023 at 12:21:14PM +0200, Köry Maincent wrote:
>>>>> On Thu, 19 Oct 2023 11:51:40 +0200 > Michal Kubecek <mkubecek@suse.cz>
>>>>> wrote:
>>>>>>
>>>>>> The issue was indeed introduced by commit 108a36d07c01 ("ethtool: Fix
>>>>>> mod state of verbose no_mask bitset"). The problem is that a "no mask"
>>>>>> verbose bitset only contains bit attributes for bits to be set. This
>>>>>> worked correctly before this commit because we were always updating
>>>>>> a zero bitmap (since commit 6699170376ab ("ethtool: fix application of
>>>>>> verbose no_mask bitset"), that is) so that the rest was left zero
>>>>>> naturally. But now the 1->0 change (old_val is true, bit not present in
>>>>>> netlink nest) no longer works.
>>>>>
>>>>> Doh I had not seen this issue! Thanks you for reporting it.
>>>>> I will send the revert then and will update the fix for next merge-window.
>>>>
>>>> Something like the diff below (against current mainline) might do the
>>>> trick but it's just an idea, not even build tested.
>>>
>>> Seems a good idea without adding too much complexity to the code.
>>> Will try that and send it in next merge window.
>>
>> Not sure what you mean by next merge window, we need a fix for right now, or
>> we need to revert 6699170376ab ("ethtool: fix application of verbose no_mask
>> bitset").
> 
> Not that one, that's an old commit that was correct from functional
> point of view (the only problem was that it sometimes triggered
> a notification even when the value was not changed but that also happens
> in other places).
> 
> A revert of commit 108a36d07c01 ("ethtool: Fix mod state of verbose
> no_mask bitset") is already in net tree as commit 524515020f25 ("Revert
> "ethtool: Fix mod state of verbose no_mask bitset"").

Got it, thanks!
-- 
Florian



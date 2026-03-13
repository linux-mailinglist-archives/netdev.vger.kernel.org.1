Return-Path: <netdev+bounces-267587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UWSeK8JxtGkkoQAAu9opvQ
	(envelope-from <netdev+bounces-267587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:21:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5CB289AB9
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FDB03096EF9
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A4F37F8D5;
	Fri, 13 Mar 2026 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Yap6c9v1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3B640DFB7
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433279; cv=none; b=HpENDQ/gihIGlCruod5IDaLr65020vl/SvTKTBxRnC0Gh+LuPwOQoKTQBOGd9oK6PfB3R3W1xMMDMrNkCFNejMvwb8A179wyEKj9SyGNeYpK3WvD22FBJBZc9XYLL58+fYq+c2hYI9sTOe6PRlt3AOb+84BMy1SgFLfp58C/coQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433279; c=relaxed/simple;
	bh=VJwaa6ZBevXtqjqrbKE0miu+7ixAxnGaQqS6WFN00jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xnm3X9kKNpuyAZvf2sMnbefBvIxiEXX2AWlz8Tv/3Le3+1i7zaIlv60Jw1jjMpm2MpWyLaM+HhOTDYclxq9nknn8SXk5G8r7PwR4AXcx6hTzDM/YToKAKSATe0suYhoreOjJtslzPkZ5AAaC9DeaDyN9pnT5hcDlxxVzdmLBrFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Yap6c9v1; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso1438903a91.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773433278; x=1774038078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8JK6V7032whjgzqIGyd2xgej5sufPJxwij598fvXyg=;
        b=RqCfzrxBi1HSp2h77JqLa27YYNaZj34ANbuLrNVy72wWEmgM3nnj1c9wLTaeJYuUc9
         KvOQyPWCK+OZENvYHNFSW6haPRiAjWqzlvV3rMj0q7j1zBGaXU4nQ71hSqjh58SG5kjN
         nQj5LKcmPSXaYGzAxFJbROuw48zXrjd94LGsQuChzEXRthMRmbbacXofDzYawkV7Oe6u
         ODSrMTZ9wItrjaDItFs5eRUGJ7JFIUBJ6Y5pS+Qee48WcWPjOFuS8BAYnvcG1f+m1gPG
         9bT+oiusLD5qECcLK7TSjt4l6USLA6f+LUoscgvdg93kd+bn68VaXCd4kTaKQZxB5TcU
         txLw==
X-Gm-Message-State: AOJu0YzMh4zJf/oqxTPjOCsaJ3MfC/SnVUuGiEmf+1HvfYEPuSlpiUy2
	ofhl4gnmgLliwx3kkDPy7rNjb5ZVgPQ3tINnFYHQCqSlfg8XMJOVvOtjU1tk63SMsfTdJ30vzx8
	BPslhS+G2OSwuAnLMAszY0NTGOqBJuP2cu3xBcs3oyVxCFEhEGJbyqXaHPpJJnjKuSB9m1tJzA5
	ybglCqFtUpcIunG6xQzPN9ElF7J5A6gG8LfJ9G8RWKykQp4zjM1jCu1OAcnwf4tBxVsXadOtIcQ
	YLKtIMIxA==
X-Gm-Gg: ATEYQzxjbRD5OUInLQtUzVfD8Sz/OCW5Qdmk94tA2o9eCuZszNf+3gWu3DLAxtJVSW0
	Xy/RZcGyr22AmW0a/o7cPOWJAjkqhhIu19Z32XF7LnicffIZMx74va7ZFJe7UZH57HZ95zyU3u3
	l61tQT69+qzoK3s06f6gWVPlcC6Z+71iHrwC65z/br5IEXHz71S8WKD2bxdrDwiYcqN73z5+vqA
	okVo6k8a9xDjoc62vmaGMoWVpqHNA9Lk2pmYtZhEkzf1QcbeSSq1CnyBbUjXcvjxV+HfPtBWd5r
	fIG3NWLLdLOOBvgVzSoBPzy122lxmadygSF3CQm/dsMXcIkH9spsV90YFi7lLvRE9LnTEgtch2o
	1RbDP+ncpYwaJzeeiL5uoS4OPL+kuRi3gSs8a5cCa4cme9emYCVPfwrRaW5iDNSvxICMbLRaOIW
	Z3v0TidVzAjmFF9Iw6O79PYlH3e7v7I21Spw4GBnThjuddOE/43DG7ZCn/9A==
X-Received: by 2002:a17:90b:1d89:b0:354:a09a:1016 with SMTP id 98e67ed59e1d1-35a22063fc5mr4137565a91.30.1773433278039;
        Fri, 13 Mar 2026 13:21:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35a1dd5d41csm574702a91.4.2026.03.13.13.21.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2026 13:21:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2bead0a9123so27445012eec.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773433276; x=1774038076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q8JK6V7032whjgzqIGyd2xgej5sufPJxwij598fvXyg=;
        b=Yap6c9v1pLbFlrqvdCqgNXa4zy7CznKHcxaYEQvi3ROAFvzKvXSunG4NyKV3HO+CZZ
         v/osxsFxiLS+50+erZIBKyhPw161z3ApoORkvMMEd0D5r1YP4DePd+dugYEKPGMQt6Fj
         jGuMbMPrny75UgeGLCD5RavlK6dYKYoHh1dq8=
X-Received: by 2002:a05:7301:4085:b0:2be:1365:b6dc with SMTP id 5a478bee46e88-2bea54621e4mr2191682eec.15.1773433276275;
        Fri, 13 Mar 2026 13:21:16 -0700 (PDT)
X-Received: by 2002:a05:7301:4085:b0:2be:1365:b6dc with SMTP id 5a478bee46e88-2bea54621e4mr2191666eec.15.1773433275776;
        Fri, 13 Mar 2026 13:21:15 -0700 (PDT)
Received: from [10.14.5.82] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab555846sm3990015eec.23.2026.03.13.13.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 13:21:15 -0700 (PDT)
Message-ID: <02ddee5f-260d-47bc-a842-8938cddc55f5@broadcom.com>
Date: Fri, 13 Mar 2026 13:21:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bcmasp: fix double frees during remove
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, florian.fainelli@broadcom.com
References: <20260312200814.1977164-1-justin.chen@broadcom.com>
 <20260313165533.GA1368619@kernel.org>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20260313165533.GA1368619@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267587-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0F5CB289AB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/13/26 9:55 AM, Simon Horman wrote:
> On Thu, Mar 12, 2026 at 01:08:14PM -0700, justin.chen@broadcom.com wrote:
>> From: Justin Chen <justin.chen@broadcom.com>
>>
>> We have two double frees during remove.
>> - We do not need to free wol_irq since it was instantiated with
>>    devm_request_irq(). So devres will free for us.
> 
> Hi Justin,
> 
> The above seems clear enough.
> 
>> - Switch to devm_clk_get_optional() instead of
>>    devm_clk_get_optional_enabled() so we can manage the clock ourselves.
> 
> But it is unclear to me what problem this is solving.
> Or how it relates to the first point - usually the aim
> is to have one fix per patch.
> 
> Could you elaborate?
> 
The double free happens because we double disable the clock. Guess it is 
not exactly a double free. We manage the clock at the driver level so we 
disable it when it is unneeded. The default state is clock disabled when
no interfaces are up. After we bring down the interfaces, the clock is 
disabled, then when we unbind the driver, it hits a double disable.

Sure I can turn this into two fixes.

Thanks,
Justin
>>
>> Fixes: a2f0751206b0 ("net: bcmasp: Add support for WoL magic packet")
>> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
>> Signed-off-by: Justin Chen <justin.chen@broadcom.com>



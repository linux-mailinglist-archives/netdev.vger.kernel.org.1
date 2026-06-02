Return-Path: <netdev+bounces-294409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Zq/KKrlCH2o3jQAAu9opvQ
	(envelope-from <netdev+bounces-294409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:53:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFAD631E82
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:53:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LjQGWDDA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294409-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294409-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 652F2307E98D
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 20:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E656D388862;
	Tue,  2 Jun 2026 20:47:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715FF377EC3
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 20:47:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433225; cv=none; b=e8YBUjwVxbfpz8I1IiHhBQxgeHe/goKFgdOS0sIYzYXckgbSOwV+72SK5xgNYH+zi67zv97MHMYUIVIDaBeYyG4onuqpVHFMQMfhinABCH2Y1ueJqvgrl0nHGYd++rXcENZehqCww3yrD+AfmI1AKfP7/1k4OIMDO+7WI2cW0/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433225; c=relaxed/simple;
	bh=kQ8cgB3chOAN17hEm/eeLSHJ5xg3tiadPzBdxt9aOWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ogg3mCtScaBzclFl0ZzYT7Dx2/a45qoTInNNCoYtMYHJg5dS2DeOFuWXQlnzMMoLB8Lf7HY3g4VhaCYAkv257NDs5ZXz7U/1PUBFU0wT7O6RCHlTD8LlRfVfopeeOJPY/yrmvyuwYEy+VWAZLydEDd9dqQtmpqSCuFA10Dd9I1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjQGWDDA; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49041e84237so97133455e9.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 13:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780433223; x=1781038023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/F9SBkHIYEzDXTuA4BV3hptq8kg192HlVg4BWvVGGE=;
        b=LjQGWDDA9Sy9tOZbDBiE5u9g4+2nVK5G6R7zW3H1jwqDbvVCeqVPeCJ/QhDoKOKidJ
         lyDZ613diL+iE8dfwRlU0nAZGAZ5IB1G0tEON/WQMWHOIirlIWe25gvFHKshlhPB8nCO
         OsjycmkyzJNcYNMaKxua/PYMejOv/MEahjBV5+m4hZhM+lJAM8ZpkVKnqimswxuByT9Z
         DpVVGY1sQYHZ6QBQfs8UivESfasd/qFVxJUpRy8W7C4KhCrh2Pua1PP5XHnXcp97j18e
         ec//MC8XgmkN48EMwIvAkYOFSEnhEZQ9MIYGSGFm4FoAhOeE/WePnA8HQ1BPPYwzT4Re
         AZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780433223; x=1781038023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/F9SBkHIYEzDXTuA4BV3hptq8kg192HlVg4BWvVGGE=;
        b=pPPbpGCEvVbP/F2coeliGcS5HxyHI4oA794/KSnZ9N37/vbPf+uzqKzDNutwnfq9YE
         QzWMHIcc2kWH2fA72dqF5OT8VbH+r54VyLh3HkcqRmcZ64yg96+4XCxd4IZhroc/0stv
         39H3MCYj0w24a7t6b2C9fk47JIy/Udu1PUogrt5MdGbW4xAR/uU0HK/kFrOHGkE/bai4
         NT/LPqhsW39lFRefje2MhGPtHkE9UgGflH87p6hB6c8M83T/5hV/pIdP/NwZm68s2DGO
         ptSszuQrtOrpGzlwTqvpsmR5/bAJ3qpPw8zgkqgqi7pFyuP+Rf/WKHDOAORlKPKaLscC
         wyow==
X-Forwarded-Encrypted: i=1; AFNElJ9/GuXHjfp6Ve8JzQ+p+dyeW/74Qa7OnBE+4FtGDXbrOTDbgMZfsjZtD9PeSwIJWAFykLYD8SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEFa8OeHXeWVqO5vBXDkLnkeKe62/LguEO+axL2oJsSL7DehXJ
	LVNwjjkaelS583XpyGhmTX3R3jeK53BPUP7G158EE+b7DqoLlJA08RKW
X-Gm-Gg: Acq92OGIIS0RSGR25H+XriN6L+D4YCD/ceUnU4SwL3aeULyCWfYxSTzrEmpGoD2fRkf
	iZw3B4I1h0c5PHGK3g09WNWtaR2CgyWyGUnBcrFYXfi61hqMnTl6DPeYI+428GKyOpxM5sYplz7
	5RoMKRkoiPN8XtYrbHFaW9X1+lOYlFsqsvE5IvWBV5iOSzW/oqSbZ/a4U01VjpMAxnRpvvdR21J
	yw9g7525V4li93yBlo4uRa+rQ3Q7xfQ+amWrjDtNR2SZwJ/q4FANm+upiSn2uERAV3Chw6ai6ZX
	IGAnnh9kFDicwvCziefB+TWWRwTxt5YkDIAY35EwG7ueKObgoxtW3LnYDLOxQ/8s1WBuM7v2q7i
	DSWXUS/IZ4yIql54o0kib9kfPuLMkmIlSZUbvh/0+nzWMHozcMPXc1I0LyNFTWEbXu8kpl9/s/c
	QF++1uOATrqLRl+Gqir2yNt0MeJeZN0EkK0uAALA==
X-Received: by 2002:a05:600c:458b:b0:490:af63:2cb1 with SMTP id 5b1f17b1804b1-490b6128dc3mr5058205e9.7.1780433222731;
        Tue, 02 Jun 2026 13:47:02 -0700 (PDT)
Received: from [192.168.0.2] ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b60f6d5asm5811745e9.0.2026.06.02.13.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 13:47:02 -0700 (PDT)
Message-ID: <e7df5082-ef48-43d0-ad07-10e1e64e1d26@gmail.com>
Date: Tue, 2 Jun 2026 23:46:59 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] net: wwan: t9xx: Add MediaTek T9XX WWAN driver
To: "Wu. JackBB (GSM)" <JackBB_Wu@compal.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Jack Wu via B4 Relay <devnull+jackbb_wu.compal.com@kernel.org>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>,
 Shi-Wei Yeh <shi-wei.yeh@mediatek.com>,
 Minano Tseng <Minano.tseng@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20260529-t9xx_driver_v1-v1-0-bdbfe2c01e57@compal.com>
 <20260601173401.2c892526@kernel.org>
 <c279aea41ecf41c6aca4314a2f4e306b@compal.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <c279aea41ecf41c6aca4314a2f4e306b@compal.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294409-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[ryazanovsa@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:JackBB_Wu@compal.com,m:kuba@kernel.org,m:devnull+jackbb_wu.compal.com@kernel.org,m:loic.poulain@oss.qualcomm.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:wen-zhi.huang@mediatek.com,m:shi-wei.yeh@mediatek.com,m:Minano.tseng@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-doc@vger.kernel.org,m:devnull@kernel.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,redhat.com,mediatek.com,gmail.com,collabora.com,kernel.org,lwn.net,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryazanovsa@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,jackbb_wu.compal.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3AFAD631E82

Hi,

let me join the discussion and put my 2c.

On 6/2/26 13:58, Wu. JackBB (GSM) wrote:
> Hi Jakub,
> 
>> On Fri, 29 May 2026 18:31:39 +0800 Jack Wu via B4 Relay wrote:
>>> 43 files changed, 14761 insertions(+)
>>
>> Please try to cut this down to ~5kLoC for the initial submission.
>> Whatever the absolute minimum sensible chunk of code is.
>>
>> Each patch must build cleanly with W=1
> 
> We've already reduced this significantly from the original 41k LoC
> down to ~14.7k by stripping out non-essential features such as
> exception handling, memory logging, devlink, statistics, debug
> tracing, and others.
> 
> We even removed some arguably necessary features (PM, mdlog,
> throughput optimizations) that we plan to submit as follow-up
> series.

Great work. Highly appreciate!

> Note that the line count may slightly increase in v2, as we plan
> to add missing kdoc comments based on review feedback.
> 
> For reference, the t7xx driver (two generations older, simpler HW)
> had an initial submission of ~11.3k LoC [1]. The t9xx hardware is
> more complex, so we believe being in a similar range is reasonable.

Let me elaborate a bit here. The size problem is not due to a git or a 
mailbox limitation. It arise due to the human limitation. The T7xx 
submission review took something about 4 months and 8 iterations. And it 
was 'only' 11.3k lines. Let's do some extrapolation assuming that 
function is linear. 14.7k is 30% bigger, thus, estimated reviewing time 
should be 5 months and 2 weeks. And this looks optimistic.

Recommendation, shared by Jakub, is practical. 5k lines might be 
reviewed in a reasonable time and merged with the full confidence of the 
quality.

> We'd like to keep the driver functional and reviewable in its
> current scope. Do you have any suggestions on how we could further
> reduce the size while maintaining a working initial submission?

Off the top of my head, I would suggest joining T7xx and T9xx code 
bases. It could be done through factoring out a core functionality of 
T7xx into a library, or through making the driver layered.

I am not pretending being an expert in any of these drivers, but 
generally divide-n-conqueror together with code reuse work reliable. As 
an alternative, I could spend a couple of weeks reviewing the new 
submission and will come with more specific ideas on what can be thrown 
away or reused.

> [1] https://patchwork.kernel.org/project/netdevbpf/cover/20220506181310.2183829-1-ricardo.martinez@linux.intel.com/
> 
> Thanks.
> 
> 
> ================================================================================================================================================================
> This message may contain information which is private, privileged or confidential of Compal Electronics, Inc. If you are not the intended recipient of this message, please notify the sender and destroy/delete the message. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information, by persons or entities other than the intended recipient is prohibited.
> ================================================================================================================================================================

And this disclaimer does not facilitate the review. Am I 'intended' 
recipient or should I destroy the message ASAP?

--
Sergey


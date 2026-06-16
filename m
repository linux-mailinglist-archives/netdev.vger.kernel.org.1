Return-Path: <netdev+bounces-299812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mLEKK4suMWrDdQUAu9opvQ
	(envelope-from <netdev+bounces-299812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:07:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFB368EA54
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:07:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bynar.io header.s=google header.b=cQ0V94Kh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299812-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299812-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bynar.io;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3DB230837D2
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5385D429825;
	Tue, 16 Jun 2026 11:04:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CEB426D02
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 11:04:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607882; cv=none; b=APHf5zslx5qKMt1PTDGo8XRC7wxIDr17v48X0cpGHWyDj5Dl2rXFkqoPho4ycrnFBUm4tROW+aDRmJ/R9AWRIYqbDN6ZA5CsVutFcmELg1AfeVkMH09UqkPSyIKm/zzu0dcCQIkmtRaFs3MffQvvAUKnmHrtIybufisUtzPMe38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607882; c=relaxed/simple;
	bh=jsrjb1gJOrLNfKVeyrgWHu2ndB1T3GxIUzfpraL1a4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkoqK5juGrm80bGtiEiD2hJO5PlZqGEBGw/MFxUz4dQBUrJuRs0U00RcpcI8K81QAYS/qDi2wwrPGcEotwS9O3S/f0rhmO1aa1sgtQL+8f/qRPC3yUcRdEguMYttsFWMpXM98qFLuoI5McRDh1d+kVCzzBuV6PWL25H9nvrNiMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=cQ0V94Kh; arc=none smtp.client-ip=209.85.167.49
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa2c25c632so4440293e87.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 04:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1781607879; x=1782212679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=be9SAeX73nlM0ApRPdBK338zST/MXfWJxoZEdM6cwMg=;
        b=cQ0V94Kh4fDe7vFkKPmwOXcuNSXd18So0R13CfUVBT962BlpZwhVg904t8wEBD7oSN
         eqsMjTfZCd2bCdBwGUKNds7CFinc+FgN0+q0bIA7KcMSdk3nD4jDre12sGDptmiJmqrb
         XZXk9OsSeB4SFtzXNUcOKsCnl/l6jdy3CbuwGNkEIhsTPSXE9LJFwM9HC3F2Cwb5/y8k
         0BXfguvH/qZnKSF8lz+Fm3nMxTzkCm6DVHEtJfLwVDsYUfiPQVyFSOq+rKI1pyufYBjx
         l7pfCKPZsFgq7soo3MmXvzVxQk8V8kgIQHkqLJQ0GR86XqSAzpHhbqwAdLJ4pDFmwm+5
         eIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781607879; x=1782212679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=be9SAeX73nlM0ApRPdBK338zST/MXfWJxoZEdM6cwMg=;
        b=aty3HalhycFg/BHrLoOD35gS3FRgtXnAXH8BXiWn3/ovmBMsAhiSHrWAN2/Y5goPAy
         yKhhsSrvBiLZ2EqVOXVodJbnUZ8Wb5I8I16aCKi6A4sopUc8O//scFJS2HY1CLdZdn43
         YXeFS979NlqbFsxyylhkFLiB1luEVr9xN3T6edSG610cTQlk7P4EvzrIPAXgcuKUX+DI
         ic4j4Of1IpnMlRasCl1XGAIyhEiJQj4nZobqNriX2jsRq8marM6Pn0sntriX6WZqBLsg
         R20Qv7y8g3RCvo/VPnY8gHXMEGtKQ3txWAEhrOk7DYwF/GmNyHYu3SWMZKkdipAHc4kx
         2fTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8jED3Z0dlCqtWojeP1byzbY6iZJ1kRvzWCTmTz44ly8zndt4fhb4KQIfoPejacXM7w6l81rQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsN9S4LKAu7QN1A7G+9MYSguJ6cEYzs7wBEqJ30IY53LOF1Ulc
	CsGbH8tBSDZEFkQYkuMUkum0s7Hai+yL6QlKads0bAkOdBIvCJ4EAtc+W9LDolSAuWr/
X-Gm-Gg: Acq92OH5JsG1WGakzCNwlYjMop4tbldm64DeVtD/XH7UUXRAkUFJ5LQg5Q+Pi2XsIf+
	ePKA0CFEXF6xkAlowBQW/SOAUqjwQs1KOATl0gwSGF6fHz9CYTbJMe3AoRU7XVjGjYmi37YGGYv
	bF0PmZybjKo4uyoFPyLCB/jVxgEBee2Z3JBbGXzg5mNw3RgyvHjjpQ2zMqhXmhFs/9opZXiJGAC
	lIqBpumdB+zYP2QZSFemAlSgmye1RihK0GoKG1CMVoSvXYJ/vlBJ6kUXWCdj7GEtj/fw+auXCzO
	h2y/X7xFqi7cp1kovBf8nVQ6fz0w+DK7TMA+KORz2l7o8yxMx0zGUrxtgHWASjbSjoF9qhM5niS
	j+kUnGfzGAthR70e6/l4ccH9qpaQMuybMxCembOQTYjEWLgMDaOYxLvTLEirggSMaYTrKpTiRfd
	HoE5VtVH4X1YXWGIbyx7htJSw7nnd7WLi0sm87mkfFQt84MtAhQ1mj4XiNzxgV
X-Received: by 2002:a05:6512:3984:b0:5aa:6290:f78d with SMTP id 2adb3069b0e04-5ad30d99426mr3972154e87.2.1781607878023;
        Tue, 16 Jun 2026 04:04:38 -0700 (PDT)
Received: from ?IPV6:2a00:23ee:1510:399a:1882:f251:1d3c:955? ([2a00:23ee:1510:399a:1882:f251:1d3c:955])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e16915dsm3486523e87.19.2026.06.16.04.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 04:04:37 -0700 (PDT)
Message-ID: <fa2e0cfb-9d60-4295-8a46-f69ce1229094@bynar.io>
Date: Tue, 16 Jun 2026 12:04:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tipc: free bearer discoverer via RCU to fix
 tipc_disc_rcv UAF
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "tipc-discussion@lists.sourceforge.net"
 <tipc-discussion@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Jon Maloy <jmaloy@redhat.com>, bestswngs@gmail.com
References: <20260615150009.1734270-1-sam@bynar.io>
 <GV1P189MB19887A9A37B5B170C112DF8EC6E52@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Content-Language: en-GB
From: Sam P <sam@bynar.io>
In-Reply-To: <GV1P189MB19887A9A37B5B170C112DF8EC6E52@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bynar.io,reject];
	R_DKIM_ALLOW(-0.20)[bynar.io:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.sourceforge.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299812-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tung.quang.nguyen@est.tech,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:jmaloy@redhat.com,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sam@bynar.io,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[bynar.io:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam@bynar.io,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BFB368EA54

On 16/06/2026 08:50, Tung Quang Nguyen wrote: 
> A similar patch was submitted 6 days ago: https://patchwork.kernel.org/project/netdevbpf/patch/20260610153349.2546041-2-bestswngs@gmail.com/
> 
> I do not receive updated patch from the submitter yet.
> Your patch has the same coding style issue (long line, over 80 columns), see linux/Documentation/process/coding-style.rst
> 
> If you break the long line into 2 lines and submit again, I think I can acknowledge your patch.

Oops, I missed that patch! I'm not sure what the etiquette
is in this case, but I'm happy to defer to the original
submitter (CCd) if they're working on a new patch and/or
add any appropriate trailers to my v2.

I've prepared a v2 to submit after the ~24h period,
addressing your changes and taking into account Eric's
feedback from the earlier submission as well
(adding an rcu_barrier() in tipc_exit()).



Return-Path: <netdev+bounces-306692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z1scCFdZUWq3CwMAu9opvQ
	(envelope-from <netdev+bounces-306692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 22:43:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 675C273E712
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 22:43:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rDxTIpV9;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306692-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306692-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6D5F30097F5
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A9039A4C5;
	Fri, 10 Jul 2026 20:42:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B1D39DBC5
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 20:42:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783716138; cv=none; b=Dw/csw0buuUigBH3xvT+ZdmqMe3F3D/S1WwtroGVDh4xqnFGs7DrhapmpXhO1WBfI+aAXlp5wWNZ6y7M81atLtKHse63S9l52fp9mHwrNqsNsgVrVE1Pgt7zlD7QBH7ZefS9ySYd+nlkHWhIzi5T/Q37n6sx4yOZz+hhmDHQ8WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783716138; c=relaxed/simple;
	bh=0sCmD1F+8BTDN3gBq9eXXpUcvX2/qZ2FhkPZ1LSzN6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gS/o8MadhFvxMSq/b+v92VC5O83X6SYtYhmgSCZAruta90+CEkiG5hGf7iNvr1jcfQrdpXxU4GG5nBw2l8qwBxJhrJLr4LJ7RjRdNLoFdxlN/e2EEAqJoYSKMYqYpKfB7zKZ+CjMPk+j10g/7bMularuiFGV2x2tVoPvo0d19gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rDxTIpV9; arc=none smtp.client-ip=209.85.219.43
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-90327237340so5592086d6.1
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 13:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783716136; x=1784320936; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0sCmD1F+8BTDN3gBq9eXXpUcvX2/qZ2FhkPZ1LSzN6g=;
        b=rDxTIpV9eRcDpKxce8El1atvt5w31cbrs4qtFWYQY41J+U34wZTpQ5qTfHO87c2cxQ
         0IfAfu0hFSoWZxW7mgTBkYLkKneIJ4ork+6DNeMPbsQAGDo2X5Rx1PrfdgX+A4MZC/wi
         0K1xBHov3TJvDSFc31+qE8R4F7W6lfMKsYr9WyX5Qpl8fDrNaLgSD0R5hKr+g0LULI+n
         ZILU/0WIGdFKdP6E2xuj7eekx8Ji7qLincea1dkCi4fLGKLO/eRx5KC3NZpJ+Wotayd/
         d4nAcs9D5ajW5JFdGguhswAeV+DQ9hK5/aqK3ZECk7A69DEI+g6L4PtKp03IRiM+dVxR
         Xx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783716136; x=1784320936;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0sCmD1F+8BTDN3gBq9eXXpUcvX2/qZ2FhkPZ1LSzN6g=;
        b=Nb2oBjCLiHCvXuFKZnsUody6gzizZ/W5Rg/Og8xlntIAqSvApugnPU0pv0TFGxC11Q
         UHSzCZfv9yOkru2iJ5ltk4IwFd7lANVg0rxa6XXIfVKp5W7WBcJUJsPG7TrpKkdLCqqj
         xx61cpWrsihoTbk9/JVRNZBuUAH9bX302n27ZHs1WPDuQGTMZX7Kw45CRxDEtf0xCNQ0
         v3/F7DLbXNnmdSyCCAOwgw39gn+/CKBGGM3rgO5QziTZju4F30DI7xipG7ApcBsZMses
         iGLCH2LyKJLjHUZbCsLUQ0kHTWzrqPS6Ex35WVJoorNO1zxGMNIsGBmPYkZBxyTvOeru
         0cAw==
X-Forwarded-Encrypted: i=1; AHgh+RoXyYUIDfnJPOIyTzAbOTJ4WNtfhXtp/m+wuiOqzZXeK5rcUVyJ23ccjy/u4u7T7LK6DTM3vro=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTMRvjgQRq3T7a9MeXpj71Npm+axgPlnQpbd443aNYA/toiCCZ
	f9zP0qy67Vj+a+YxVUy5LwmGf9w7r5N5C2L0bu+hmyip/Hm8CxjO9uv/
X-Gm-Gg: AfdE7cnNXtvbkuCX9N6mfRGmshrTvahWi/2r+1JoLB6Ga6hBPkQ67Mg7r535DMM6gJI
	Hwu2acLK5ApnCamqug50RC00qBAVG1zOQS9AceZ/LaaL4yxB13Uvb/QVD8MUc0QY45+M+O7S1hK
	BR8sFo1mabdN/hKlA8vNaFjiLKQI7/egb/1gug/vHOPz7A5eXuiZSIgxIwsV6mPpGlBUqy0xX2m
	l1iYa5+nrV6ywO/9MUk75rbdPGQPMTkpaemQJiNqaYjJweSxNbOXADE/47cC/ZyzNMalLPYuAcF
	jbHKg8dSBggfLnD+15nWC0r1IHv2el1m3/t140RmB/feQe8rG6Mfjuei2CE+CJjDRRQtp6GFg6n
	/7dySzHUhgF+3AHfzzBCTwbE78Gl5XfkGbK0kRSe9wXEnMvHe6vPXuo6byIlDVhTomhucVBa9LM
	iTIseplmg/fTEPxOaGMxmNX7lX67BtyoVsjlmlybfImsoH7vuxkW41nW40W9OCejZGGtM=
X-Received: by 2002:ad4:4eee:0:b0:8f1:5e32:9b06 with SMTP id 6a1803df08f44-9023523d659mr67575446d6.13.1783716136133;
        Fri, 10 Jul 2026 13:42:16 -0700 (PDT)
Received: from ?IPV6:2600:4040:93b4:e600:a22c:878f:7c1a:1976? ([2600:4040:93b4:e600:a22c:878f:7c1a:1976])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd57baf8dsm50297136d6.20.2026.07.10.13.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 13:42:15 -0700 (PDT)
Message-ID: <fda6de85-55b5-4972-afe8-2d89f427628b@gmail.com>
Date: Fri, 10 Jul 2026 16:42:14 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: fix TIME_WAIT socket reference leak on PSP
 policy failure
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260710181317.4060230-1-edumazet@google.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260710181317.4060230-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306692-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:willemdebruijn.kernel@gmail.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:willemdebruijnkernel@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 675C273E712


On 7/10/26 2:13 PM, Eric Dumazet wrote:
> Release the TIME_WAIT socket reference and jump to discard_it
> upon PSP policy failure in both IPv4 and IPv6 receive paths.
> This prevents a memory leak of tcp_tw_bucket structures.
>
> Fixes: 659a2899a57d ("tcp: add datapath logic for PSP with inline key exchange")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>


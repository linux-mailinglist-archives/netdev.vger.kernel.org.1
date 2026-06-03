Return-Path: <netdev+bounces-294744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fKM8KBIjIGoIwwAAu9opvQ
	(envelope-from <netdev+bounces-294744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 14:50:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3698D637B1D
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 14:50:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=6wind.com header.s=google header.b=UYyI+Owj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294744-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294744-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=6wind.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A51E530098AC
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 12:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864C336F903;
	Wed,  3 Jun 2026 12:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74843D669C
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 12:50:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491023; cv=none; b=b6uxehBZstNKY1PmQE2Rrhf4hBdxczWIcllhyCJVPT1z8PhGQJu/O2hpq+lgbnWbeK8Jfg8btYzuswuR9LaguDYp0kUQdPPXk6He7nxE2tPYGRNtsvscQw4mO4bjwnAvoYNeHMBPqdtOEnPhgYPobIZxSn0MQems8jvdsfzHVH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491023; c=relaxed/simple;
	bh=1t2N9FlpK1rsDX6UrHeNGsOFniWuGUPAw8jqLhc3RnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEwvyrkjTUwndoFXJbNKlupe8v23dqGr2VUvGHJgboRiHamoYjammYMeVnfU5UqxmumZi1a7vhk2Hkfs6x8akQEr7sM4q6gJkkU37Zz7DFrYaZt8gwAvu+hC6YKlLCm7qFS0/nnLqV7iK/8im8SAp2SFWFCi9wPiG6EJ8w4e2IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=UYyI+Owj; arc=none smtp.client-ip=209.85.221.45
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ef93a0b0fso499615f8f.2
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 05:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1780491020; x=1781095820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nGEEWPJTTgct2NOgDQ5OZsShqufcXg/np8YkRX61iG4=;
        b=UYyI+OwjZlopoidAJbwP92BN9sKtOc2gZ6MYcqoEar8syqsk/smrF8OfuvFrGhSFGE
         PKnL4TLFsXQ1YvXgapVPgmh1h7bhCmL55NqbJyiNYpAQSLsXxMRu4KofZTJ0ULQw9H4u
         udm4twHuLGGQl6BmCi6aLT91k3e9R63ZUkysAMVa9f55DW+qXn94WDCCr+SxiyU/M7rm
         eXqEMruvdVkE4WwITJjqoOwUWvwQqZCtRcxXxJbMR6RSUVZxshbg3gIrCEopqMWbgSqm
         a6sJ3qZXDno2jKH89UeJgQu5KaBZHRRqTDB4Ru0ybgJ8hY2z2qWHIqX+e4UKZFSFA8mZ
         pfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780491020; x=1781095820;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGEEWPJTTgct2NOgDQ5OZsShqufcXg/np8YkRX61iG4=;
        b=BGheTKLYPn+LPsw6heN6WziGVWiRAOOeDycsvCR5lzDUN1r1qNEh2asZyNEQ1FJTqo
         FM0tl3xwQjgUItmpdLp4/1cfawLtEj0sMJZI02glH6VaVkbUZt1Ojf2eG7WJQLb2+V0f
         6/oGFXmJhF21c8M47av/JlBQ9KFu+W3unBYGLJorHB6cA//lc0KQutyANnKo/UCLOER4
         BOhEbc/cdmNjP7f5mRG4lgsdBM4q18NVe9o9B1sjcRU+StYfp+KjnxsqwSCi/9wNTa0F
         i1FE9xEydzSIcZQlfXf2wrDP4wPjMPxms8OmxrPB6R6LG/1g8JB5cew0a3J1+A6pNNv2
         nb3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+RkD2O4NXBedG08LX65vPh4ZQ9w45p304aN5x87lmKV7+256IfoaFmPSB9zaXi2eDbq+7h+TI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIxjghbHv0BGh7MkX63H4zSLxEUt8/ocRLK4rvXp+Nen+Inxtz
	ZK8umJVb/DHEgl5KoBM/6jhgamPCEdvajgEBSGLXnCAH3yCgcH1AY2TCJLEIvZnJ/x4=
X-Gm-Gg: Acq92OGEyMNzcza1xpPAsW3+G7Ifqq9ulO4+wmKXBzH2Xu38sO8LSGgFSgFHdEOJOCz
	pkzgPX/4k7Pu/3GZGIAhIi4sFYswA5huP+HKexWsZaOB9+8ZZlze2/M/vYVxTYNPzOuXCnOdjWg
	wYbnSJ6TiQlL0KDst7dtkv7Re+8hAYpwAm4JVux8ZB1TI185Pc9cB/V7G5PjWgGiQM00phfNQA/
	BKA2/BGCbgttKWS6W3z6WZHL652csYc9X0/4O3Ky8bMo8vsSzj/pw3grTZ55cyT87kLoSLApHVY
	a5J4Tm8D6pDgOC1+i1Y8VxeHfBec47YLNQN4Q42zB9HbIxdvVjViP4JDB0R6XzAyFtwIf0K3ZyW
	CRiJMw00LI8jTJSh87wvGFJq45TSu0ITBFuDRFIoVqMZIYayf4Jw/He9qE2zNxllzOM98D6knVF
	RaefzxjbTQFx42JrvoWlO/UhGV0Gxz1UbFX8JDMyEOy/98Ru95pVrDP0auGEVd9149N/5Agr1cb
	bUwxpk99kn20ds=
X-Received: by 2002:a05:600c:46d5:b0:48a:797f:24f8 with SMTP id 5b1f17b1804b1-490b4eec318mr34241735e9.0.1780491020175;
        Wed, 03 Jun 2026 05:50:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm8220268f8f.20.2026.06.03.05.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 05:50:19 -0700 (PDT)
Message-ID: <6365ef1e-d62d-4b2d-8e41-526881bbbe37@6wind.com>
Date: Wed, 3 Jun 2026 14:50:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH iproute2-next] iplink: add support for setting IPv4
 devconf parameters
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, stephen@networkplumber.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
References: <20260601143242.6729-1-fmancera@suse.de>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260601143242.6729-1-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294744-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:stephen@networkplumber.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3698D637B1D

Le 01/06/2026 à 16:32, Fernando Fernandez Mancera a écrit :
> Currently, modifying IPv4 interface configuration parameters requires
> interacting with sysctl (/proc/sys/net/ipv4/conf/*). While
> ip-netconf exists for monitoring these values, there has been no native
> way to set them directly through iproute2.
> 
> This patch introduces the support for that via 'inet' at the 'ip link
> set'. It uses IFLA_INET_CONF netlink attribute to set the parameter.
> 
> Example to enable forwarding on an interface:
> 
> ip link set dev enp8s0 inet forwarding on
> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Do you plan to add the ipv6 part also?


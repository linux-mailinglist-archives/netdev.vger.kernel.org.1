Return-Path: <netdev+bounces-303287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xCBbGD7nQ2pFlQoAu9opvQ
	(envelope-from <netdev+bounces-303287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:56:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6506E629D
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:56:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=C38UeUeB;
	dkim=pass header.d=redhat.com header.s=google header.b=JTVlFutK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303287-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303287-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A354304C06A
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A4A4657FE;
	Tue, 30 Jun 2026 15:49:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD57E45BD5F
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:49:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834566; cv=none; b=bRLjtiYoTd6ZfdTWkgFrnIzZfbPWJJW3AKZL1TeREQ87efgpmZU/kaSlE/RsaDVxtLD9p1bo8K78ueA7RlcJOZbqI20w5x6yegAFCWt4Z5SIGQ76nKXxZWGV5k68fYILt7QWSvkl/+pmFMP0CpwgUb3NZaJ10wZAxz55NrNvbH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834566; c=relaxed/simple;
	bh=uOUXiuu2gk9jozaUGkU89UMF7rfF2U5T71UJJbhI+L4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=REKcrqbesXFuDBCgM/WAYrmQ8vDYWyPrCBLHvmx/o0CKkpZWJqYVp6guAct3Cdx1h0trTzWz5j80xHs1NrTmNERyJserh9H5Z2Bc3DbqFDUBQ8sV1GVF21nv/QLuxaPARoWkoiZ67q9Wm0bdPBCWoQMjVJrVmZ9sflGADd8hPg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C38UeUeB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JTVlFutK; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782834563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTD6v+WOVsO8BscP05zQC7/J56T8cQoXSWwoIsFjkx4=;
	b=C38UeUeBdF22MVSWpZaUDKTb1LtovScwzN9v4SYu8jnZ8YVFlODHCAr926BYLANwdrjr3y
	IwDlivNomA7Puko/80SSFfnzdAP5jh/RGXzo5U59B49L2u6694h3LmECrRPG8QsqjN3uuc
	RAjHgdzbrdUa7bjyunDTRVvwP/pAgvQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-7ITcOrkuNvujteARoLB1zw-1; Tue, 30 Jun 2026 11:49:22 -0400
X-MC-Unique: 7ITcOrkuNvujteARoLB1zw-1
X-Mimecast-MFC-AGG-ID: 7ITcOrkuNvujteARoLB1zw_1782834562
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-80fb555dc76so24497837b3.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782834562; x=1783439362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DTD6v+WOVsO8BscP05zQC7/J56T8cQoXSWwoIsFjkx4=;
        b=JTVlFutK4E40k1MRRuFk1eXUflQ52SbaDcKzL46+w+w2MJ+OiGRovb2LjI5nt48o9a
         6BMrVbGbg9pzNLyOtIouDOtN0gbHOO2PQWtIPwuE3Xk1EI1l4i4+NTLYJ4xTHLCNEFaH
         vfCxl4KAzAKgQey/rOcfGilNXowq5RZu+AMGvFQQJMiJs8ra+vXHZDPSr188qku4RETx
         +rmBmkGUH7fpzX++AkLjtKM4hlPgDLsWUPgmXwL4/mJHluYlJCMbdD1jJz2TcM+SIG4S
         L5EHwWOTqqof4GUOmgKqSOfcfzvz/6IrTcRQgh7YKdksNwGMTcMv+j/WtTlqMbr3P2P9
         qVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834562; x=1783439362;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DTD6v+WOVsO8BscP05zQC7/J56T8cQoXSWwoIsFjkx4=;
        b=KpyGqv4TPZmn+qVDt1YdUOQzZL9d/Pf1f4+t4o55QNR71f/TS9dMtwHgJETaB4kgnX
         z4jPPv+KU+LGE7z8WVfSKR/HzsoYO+Ts+zr6qMg1VfyY7W4eVNaH11TUGJsEdGt54PuH
         AyhwPt/ijYx183bvl6PsoHIdEeoi71Vcebeao9JJBkrzLppSwSqzIt0nyOnTnzvaSoPX
         QKFqUSwWxAggqdgfqWfvCaKT/RJofLygO3Smd9ZP6strzozzIFJ5sFKDyVn+OQNC86Cs
         j2RnT8r8mrfwffRJTh4YQ6GeOQ+epJn0Ag9FSPoDWTFqTODJfKkFCgCHicXYTFMKZx4z
         yffA==
X-Forwarded-Encrypted: i=1; AHgh+RoduXALAdLKNMXNv2OTSgbxqNMSWXELZAh8XVp2n7KNDNsMfoviv1U4FhPNvxcAdAO54ToXuXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg0F0+ie+Zptsylr8QTeX0mcrmpsg5i0p5JXm6SJi67CiiOfT9
	Ke13XEquR2wzs9ttImAeno276jqteCpnZOLPkDUNjuwTzj/54qrkaKma9HkTjphib34VjOK6yW1
	6Fs77H/8U0AIVYjdGiF/caGlE/Uzp9yo56dd/gPM1VsOUDjC2U2lrokj5Sw==
X-Gm-Gg: AfdE7cnxuM9e5Z1h9r2fJOQlRjim7KH0pD8VscNG1v+B5CWO38YkN7YSVFP0e2nWPOw
	mlWg3T0KsPIboIArHiWwBP0gDNKhTkBYWW5XdI3IBLp+MKgWfQEakqlV6Og30GjX1QBmaE6XBYI
	W0y6eI0H+gQZ/KSG3CPAqWDbpi1rYcLQkfStBJyNYI6BUWJfESH0BrtGudsXlocsXQtTiM0NVNi
	yx2pTv3s8XYpBPdFwDscja6I4J5dGKZHIQEDg0ICMz/hZYtiTTz/xA8Okf9LmI3djj7lAGUNkyu
	RWNhZLLPyYlqKpv0bXQ8rLqxpc8PkGyOGJ5RyKkK9029GMukqocmcwn3jRx0sSU/m4/T4zQtMY3
	XkgJbhPcTjiJY9Dlp0FfiLjJsUIOtipWXlONCIgWDJ2WyVeBaBIIjgZn9HS9i+9UPVKiq1WKcPA
	r5LZf0/EErRQ==
X-Received: by 2002:a05:690c:368f:b0:80b:bfee:c424 with SMTP id 00721157ae682-812012333ccmr10773537b3.18.1782834561627;
        Tue, 30 Jun 2026 08:49:21 -0700 (PDT)
X-Received: by 2002:a05:690c:368f:b0:80b:bfee:c424 with SMTP id 00721157ae682-812012333ccmr10773147b3.18.1782834561065;
        Tue, 30 Jun 2026 08:49:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-810ea1620b2sm12566107b3.35.2026.06.30.08.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 08:49:20 -0700 (PDT)
Message-ID: <6dbb6d6d-26b6-4b9a-8e06-0a53212d022d@redhat.com>
Date: Tue, 30 Jun 2026 17:49:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: gianfar: dispose irq mappings on probe failure
 and device removal
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Andy Fleming <afleming@freescale.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20260626225228.427392-1-rosenp@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260626225228.427392-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303287-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:claudiu.manoil@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:afleming@freescale.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF6506E629D

On 6/27/26 12:52 AM, Rosen Penev wrote:
> irq_of_parse_and_map() creates irqdomain mappings that should be
> balanced with irq_dispose_mapping(). The driver never called
> irq_dispose_mapping(), leaking mappings on probe failure and
> device removal.
> 
> Fix by adding irq_dispose_mapping() in free_gfar_dev() and
> expanding its loop from priv->num_grps to MAXGROUPS so the
> error path also catches partially-initialized groups. All
> irqinfo pointers are pre-initialized to NULL in gfar_of_init(),
> making the NULL-guarded walk in free_gfar_dev() safe for every
> scenario.
> 
> gfar_parse_group() itself is left as a simple parse function
> with no resource management; cleanup is centralized in the
> caller's error path.
> 
> Assisted-by: opencode:big-pickle
> Fixes: b31a1d8b4151 ("gianfar: Convert gianfar to an of_platform_driver")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

The PW bot is on holiday, no automated notifications for a while.

Applied, thanks!

/P



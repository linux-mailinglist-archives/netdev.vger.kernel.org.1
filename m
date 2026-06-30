Return-Path: <netdev+bounces-303286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MQ8cGvvlQ2r2lAoAu9opvQ
	(envelope-from <netdev+bounces-303286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:51:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D518A6E61DE
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:51:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=FNL25nQv;
	dkim=pass header.d=redhat.com header.s=google header.b=IJ2hcW9M;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303286-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303286-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB67530731D9
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3073545BD6F;
	Tue, 30 Jun 2026 15:48:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61B245BD5F
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:48:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834486; cv=none; b=kXz/uTZt3Vf8Iynl9TFGyfIIY0DBtTf4R9KSsRlI3BSH+LZo3KKIXgwqdBh4L4ONJxSVjsK0QvByg82eDQYXXulWLzavBY2bGv1rH5OzYb3ThyyBev1bSbz2s9uHzIu0H/yLlfsxet3OsvsD6eQixL3iYEynslgSS0N59Db95T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834486; c=relaxed/simple;
	bh=twAyy9xwYCSMvApgyBYUMDHVlW/irdnupyHPndRGu7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dG3JLhRHjbkDo5LTO0Y2vfhJRdIru7JdOCDWsyRqW4M6rWP1ADf814kD0tVjPogJ1OtIZuwOJTYWT7pzhJMCXaLryJgmeu0SxGvDnEZULIIEg/18aY9wdduw8nOENuNXH/ACUK36G6ZB3lznLnOqAWLyVyAuUU9ovt4I4hu0NXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FNL25nQv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJ2hcW9M; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782834484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yl4pxIPjVlnHUWDpO5Lxb9ymfeFrDg7e0YhAWoqeXok=;
	b=FNL25nQvyZdAK4X30EwDiM3B2l0gHoYysH6jUBYPR3yBRFHoS4Z0FC3ULdfmzHgPs+Xzw/
	MyilgLuxgfA6AwXSywbjpHKGWgiEsFYQezb2xi1V1QvaHA/3kJ4zKX/626QsZ4Flcruz19
	teZb9AJLsTIXfgJm5hQLzWkxVxaU7tM=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-0Xt5HJPbNVqT7qCdsamcjQ-1; Tue, 30 Jun 2026 11:48:02 -0400
X-MC-Unique: 0Xt5HJPbNVqT7qCdsamcjQ-1
X-Mimecast-MFC-AGG-ID: 0Xt5HJPbNVqT7qCdsamcjQ_1782834482
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8067fa066bcso13419487b3.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 08:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782834482; x=1783439282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yl4pxIPjVlnHUWDpO5Lxb9ymfeFrDg7e0YhAWoqeXok=;
        b=IJ2hcW9MAQ3+5RGNNav0QdpJs+/lGjvDrEq9LexALQREDcqPVhd2UQo93ODmnIO5t6
         mHX5ZC4v9ffenC+72widAM/VIpvEBA5UlFhpTPpohM3yTay99lKvj/8V1x0bd2n5utzg
         NGTPsWo2Is4SrkQieBQllDNwEIray2O0STc7fXQgjUfvi4dFIi0nlfJ8oycFz/Q93Sog
         jX0tYlnRwC1CTczNVD/KyazIHWYCITDOIvanmC4GQsSFuUuzjVsmSj0bbXSAAICEpzRC
         t9rpnsJkJC03lwf8ocLZYhY7zq8U0hXYMxy/z1hGOl6TTUN7wpIVsBsw8+ivzt31pLG/
         aj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834482; x=1783439282;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yl4pxIPjVlnHUWDpO5Lxb9ymfeFrDg7e0YhAWoqeXok=;
        b=rizzh/PQ0ACo1ssmWdHRgCN72SOW5nnAyp8zeZJp+OxX3QfJzsDZUH7LG7xofKzzql
         OYTjgK0Gmykb9eKgQdt8nc6U9hNx+WFCfHZ9XUVIUu1FgReYTLihfJv9PznZ9kZO6eSi
         eFpxWSFYCfbGVhoTVbOn8nQqtxtEyLV7MYPfelpsTRuPR1nsuigqIUclChW+qW2woV2/
         zLeHJBDypG8UBpkVIVbMXIekT7ezFEGB3+kA1AZ3OqyQfOp8hG2F+m9zYj7WIk1OGWdk
         qZhftV1uL8bH0bW+3fb067S6AphGYzUFp1Kx4/gBpohopqHsAY1875iQEFNBY6Yb0PbJ
         0qVA==
X-Forwarded-Encrypted: i=1; AHgh+RqvqGkvSv45im3t5GvNMfMqZMubXzeHazqopp49W5CHk/WwGUqAUR3htRbQLgteXlcwVe+DBDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQdvwbm3ZXgSE/zPrSwkbLs/xxQTOwshExwY3c2+QsYPRpGQt2
	oK8xdy2h0aBQEIZOvs+fhEUvEVvDopz2NJOTBEbntv1AVRa2C6SEE7ci9lkDzI66ML9peoPG+l9
	Z2lL0oyA5t6ieEr538zSmwPi12haCJpY5wctWoJji4INfNqy34g4pEmANqQ==
X-Gm-Gg: AfdE7cmykJwBsp95yR7z38wn41Y66vgwBax61kgCredITmzfdH9fvPiwG+d5YVIKYLq
	Qr2Vn4fwob1kW5fgC/pDmA/dsLqzFih341gt+sFNhBfzn6NckqSvDFFIEmQH7fOjQhI61JgtN2o
	IMkOG0r+5fJa+Sxixnq5pgl8rga004HFZqw3jOA+Nk6HfWY1oPrS1PhhpbIkaymTCbu3yZ1Ah6Y
	PSjr3hPRSGULfmctlk0NBQdE6Ta6PJj75fiycH9RWsmGT9p0HiCrpviYfLEAEN+AkP7Hpg2lz75
	hJerjR4qnkeB9QwDaM3a90dIW6ngXsuTPGvqo4cBGsy6XOh4Y/hA2d0F8nSjRm4zzKAMWGOSoug
	LjNEzDj3jtRGMXXNgXSsqtliwMQz1lVDbKKWlgKKTpaoJUck7Y93FBZjQ2Liucr+g56jborR/aA
	poplC1pWo3tA==
X-Received: by 2002:a05:690c:3588:b0:80c:c6f:1b48 with SMTP id 00721157ae682-8117ff89193mr21073407b3.24.1782834481846;
        Tue, 30 Jun 2026 08:48:01 -0700 (PDT)
X-Received: by 2002:a05:690c:3588:b0:80c:c6f:1b48 with SMTP id 00721157ae682-8117ff89193mr21073027b3.24.1782834481421;
        Tue, 30 Jun 2026 08:48:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-810ea95254dsm12263797b3.46.2026.06.30.08.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 08:48:00 -0700 (PDT)
Message-ID: <07a9834b-6c68-46ae-8cfe-32e17f32ebe2@redhat.com>
Date: Tue, 30 Jun 2026 17:47:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lan743x: Initialize eth_syslock spinlock before use
To: Andrea Righi <arighi@nvidia.com>,
 Bryan Whitehead <bryan.whitehead@microchip.com>, UNGLinuxDriver@microchip.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
 David Thompson <davthompson@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260626163218.3591486-1-arighi@nvidia.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260626163218.3591486-1-arighi@nvidia.com>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303286-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:arighi@nvidia.com,m:bryan.whitehead@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:Raju.Lakkaraju@microchip.com,m:davthompson@nvidia.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D518A6E61DE

On 6/26/26 6:32 PM, Andrea Righi wrote:
> lan743x_hardware_init() calls pci11x1x_strap_get_status() during the
> PCI11x1x probe sequence. That helper acquires the Ethernet subsystem
> hardware lock via lan743x_hs_syslock_acquire(), which relies on
> adapter->eth_syslock_spinlock to serialize access.
> 
> The spinlock is currently initialized only after the strap status is
> read. With CONFIG_DEBUG_SPINLOCK enabled, taking the zeroed initialized
> spinlock can trip the spinlock debug check.
> 
> Fix by initializing adapter->eth_syslock_spinlock before reading the
> strap status so the probe path never attempts to lock an uninitialized
> spinlock.
> 
> Fixes: 46b777ad9a8c ("net: lan743x: Add support to SGMII 1G and 2.5G")
> Cc: stable@vger.kernel.org # v6.0+
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

The PW bot is on holiday, no automated notifications for a while.

Applied, thanks!

/P



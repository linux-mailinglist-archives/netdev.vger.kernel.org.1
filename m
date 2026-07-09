Return-Path: <netdev+bounces-306179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QoO6Ofd8T2oZiAIAu9opvQ
	(envelope-from <netdev+bounces-306179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:50:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D0C72FE07
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:50:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=sU+3+KFh;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306179-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306179-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F1523064AA4
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 10:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2D540B6C3;
	Thu,  9 Jul 2026 10:45:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C59A32B121;
	Thu,  9 Jul 2026 10:45:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593929; cv=none; b=s+O655jAj6dw+dPkG7hw4WeBeA80vFlcHipmwznUs1uHvPc2mIFok6VrWXryifsCO5uP4INXLoY/MtukBsD7friIpU+eto9raq9dtCaDeGGWkKe6euTj9cLORCms0sFl+oLUkcXPosGVVss/CxmvWsu8dw8r13/7DnYZxZ7NJys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593929; c=relaxed/simple;
	bh=v11CCaM2SO1sjN3FanFJterfJszpcdVADsPjT6gZ5+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlhQ4ET3lKksYv904CGe5jI8+PpV3F1hQPb7GfzgAYdACsHg6phuJta68XfqwyUg+P3WbnuK0O8hBmJZn9mWkHkxtVpWAfgngJPstJWWqn7GUQafh1Tr7Njym4KV9UkeLotRfsgVQhyAij+tiXCQvLrKPAG3xK68Td9A/G2V+bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sU+3+KFh; arc=none smtp.client-ip=91.218.175.182
Message-ID: <4a847a6b-7837-4044-8a87-0ddac47725f8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783593915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U1zptSwNIN+3sFSND6E6Pez9u+xDKFIGwqm4Rxh1P9w=;
	b=sU+3+KFhltGJBoRT0JuwZfDvcZOV2uNhnSWhxO46Qu1fcznF7EaE0UtRnGF8MZHXJW+0Qr
	xX4xG560Pw/p4dDjnIz1Qd6csX1rxq3csMxLmYs2z7pFcAL8Cj2pvwEqJa16ioCC0BIgGZ
	kmwtue0SRDHaoHwZuXeXxg0fy2i88Fw=
Date: Thu, 9 Jul 2026 11:44:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v7 08/15] net: ethernet: oa_tc6: Support for
 hardware timestamp
To: Selvamani.Rajagopal@onsemi.com, Andrew Lunn <andrew@lunn.ch>,
 Piergiorgio Beruto <pier.beruto@onsemi.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 Jerry Ray <jerry.ray@microchip.com>
References: <20260708-s2500-mac-phy-support-v7-0-478c877aa1a9@onsemi.com>
 <20260708-s2500-mac-phy-support-v7-8-478c877aa1a9@onsemi.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260708-s2500-mac-phy-support-v7-8-478c877aa1a9@onsemi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:andrew@lunn.ch,m:pier.beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306179-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[onsemi.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,onsemi.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55D0C72FE07

On 08/07/2026 18:12, Selvamani Rajagopal via B4 Relay wrote:
> From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> 
> PTP register/unregister calls are implemented in oa_tc6_ptp.c.
> The APIs that work with the hardware for timestamp is provided
> by vendor code as it may be vendor dependent.
> 
> Interface for ndo_hwtstamp_set/get, ioctl, control and status
> callback for ethtool are provided to support hardware timestamp
> feature.
> 
> Besides ioctl interface, hardware timestamp functions that handles
> header and footer data are in oa_tc6.c. Helper functions are in
> oa_tc6_tstamp.c.
> 
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> 
> ---
> changes in v7
>    - Fixed the parameter name mismatch in function protoype and
>      definition
>    - CONFIG0 is set with 64 bit timestamp support by default.
>    - Added information about return value for API documentation.
> changes in v6
>    - Fixed the issue of function parameter in oa_tc6_get_ts_stats
>      not described in comments section for documentation.
>    - Avoided typecasting __be32 as u32
> changes in v5
>    - As subtracting skb len by FCS size is considered bug, changes
>      are removed. Will be fixed in stable branch (net repo)
> changes in v4
>    - Fixed the condition check for subtracting the FCS size
>      from skb len.
> changes in v3
>    - Replaced warning printk with ratelimited printk
>    - Checking the hardware register before enabling hardware
>      timestamp
> changes in v1
>    - Added hardware timestamp support to the OA TC6 framework.
> ---
>   MAINTAINERS                                  |   1 +
>   drivers/net/ethernet/oa_tc6/Makefile         |   2 +-
>   drivers/net/ethernet/oa_tc6/oa_tc6.c         | 218 +++++++++++++++++++++++++--
>   drivers/net/ethernet/oa_tc6/oa_tc6_ptp.c     |  70 +++++++++
>   drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h |  34 +++++
>   drivers/net/ethernet/oa_tc6/oa_tc6_tstamp.c  | 205 +++++++++++++++++++++++++
>   include/linux/oa_tc6.h                       |  12 ++
>   7 files changed, 527 insertions(+), 15 deletions(-)
> 

[...]

> +/**
> + * oa_tc6_ioctl - generic ioctl interface for MAC-PHY drivers.
> + * @tc6: oa_tc6 struct.
> + * @rq: request from socket interface
> + * @cmd: value to set/get timestamp configuration
> + *
> + * Return: 0 on success otherwise failed.
> + */
> +int oa_tc6_ioctl(struct oa_tc6 *tc6, struct ifreq *rq, int cmd)
> +{
> +	if (!netif_running(tc6->netdev))
> +		return -EINVAL;
> +
> +	if (cmd == SIOCSHWTSTAMP || cmd == SIOCGHWTSTAMP)
> +		return oa_tc6_tstamp_ioctl(tc6, rq, cmd);

ioctl interface for HW timestamp configuration is deprecated, kernel
code was recently cleaned up to aviod these ioctl commands in favor of
ndo_hwtstamp_get/ndo_hwtstamp_set callbacks. New drivers must not use
deprecated ioctl commands.

> +	else
> +		return phy_do_ioctl_running(tc6->netdev, rq, cmd);
> +}
> +EXPORT_SYMBOL_GPL(oa_tc6_ioctl);
> +


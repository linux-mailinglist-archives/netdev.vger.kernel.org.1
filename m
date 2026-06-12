Return-Path: <netdev+bounces-298700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KK6qEl8ZLGqQLQQAu9opvQ
	(envelope-from <netdev+bounces-298700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:36:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CAA67A3D6
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:36:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nabladev.com header.s=dkim header.b=fxqbFf14;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298700-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298700-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nabladev.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07BAC3002324
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65D0365A13;
	Fri, 12 Jun 2026 14:36:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6311D389105
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 14:36:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274971; cv=none; b=iLoxWdFzPD4gPFQtbhJ2pNkNMnRhSznR/jefuDZ3h5+DSY5PlJadMLXlPtIM2DFJy3NPhTQaeqkKTbRQQywaBHbMZkGUDuXkK9fsPZOi6QTZ8WKXnXytEjxJHFdlBirJgoVm2g70wwXdRQKGIeVML9sbGmYN3sWvdl48HjV7yiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274971; c=relaxed/simple;
	bh=1dNfJIoVeV3xIOJONU/1MpzK5+bpNVZYH1L3PPNAaoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqBpduDFpn3cGOCBBlJ1A1FcpH5dBrAcJBCjPNVmKcvidleG0fYfPzewRU9Fb/uDgNlKyCwRw6NVJdwAkAiAi3O8a+UVm6k84j0zsE80ZJ7gLqOIegqrwtk5185Ps3Rmv/g60Wxhurelm9xL+GNKhVLm5aggYcg/tD9U1vvoS9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=fxqbFf14; arc=none smtp.client-ip=178.251.229.89
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 01B8C117B24;
	Fri, 12 Jun 2026 16:36:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1781274966;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=uY+1NEvOAAvd9IoaizLv9zBPMWJ6mlr69Yd9IQoJU4E=;
	b=fxqbFf14O0/VnzhuMKjwFoQSlFsUidD8LKGMzwsawaPwO6zqTAtXoBfVbD1624Fk09gY3X
	1b+5BrKDzDDUHFqqPSeMWgLx5+1busQwgV45GK7DW+NebV78fac1Crvxp0wDBDzbuKQ0rH
	wdzaFgn8rHVFUipSpMXH3ofSh8ETfN7ggmPxJn199D3MBc6LC+5GJzN8jIfK5ugqEkGzGL
	AgKB51cFARbBMxSJ51fhjRdh2lvsEhCEsq/eK7iQ+/flQQ87Chpedbq8dXwl8582V5Mr/v
	KWFnwn/K7C6C9wZw+tKCnOBdkO0p5uHQmqnQhN0ZY3YAQfHq7Dpzqa0CD51aDg==
Message-ID: <41eb645c-717b-4f02-9f40-747d369b7a27@nabladev.com>
Date: Fri, 12 Jun 2026 16:36:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ethtool: add userspace support for KSZ87xx PHY tunables
To: Fidelio Lawson <lawson.fidelio@gmail.com>, netdev@vger.kernel.org
Cc: andrew@lunn.ch, kuba@kernel.org,
 Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260612-add-ksz87xx-tunables-support-v1-1-0e97a91b78c8@exotec.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260612-add-ksz87xx-tunables-support-v1-1-0e97a91b78c8@exotec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lawson.fidelio@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:kuba@kernel.org,m:fidelio.lawson@exotec.com,m:lawsonfidelio@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[marex@nabladev.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298700-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[nabladev.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91CAA67A3D6

On 6/12/26 11:02 AM, Fidelio Lawson wrote:
> Add userspace support for three new KSZ87xx PHY tunables introduced in
> the kernel:
> 
>    - ETHTOOL_PHY_SHORT_CABLE_PRESET
>    - ETHTOOL_PHY_LPF_BW
>    - ETHTOOL_PHY_DSP_EQ_INIT_VALUE
> 
> Extend --get-phy-tunable and --set-phy-tunable to query/set these
> tunables through ETHTOOL_PHY_GTUNABLE/ETHTOOL_PHY_STUNABLE.
> 
> Also update:
>    - bundled uapi/linux/ethtool.h phy_tunable_id enum
>    - CLI help text
>    - man page documentation
>    - bash completion for get/set phy tunables
> 
> This enables full userspace control of KSZ87xx short-cable/low-loss
> tuning knobs.
> 
> Kernel-side link: https://git.kernel.org/netdev/net-next/c/13655144ddca
> 
> Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
> ---
> Add support for the recently introduced KSZ87xx PHY tunables:
> - phy-short-cable-preset
> - phy-lpf-bandwidth
> - phy-dsp-eq-init-value
> 
> These tunables allow control of the KSZ87xx PHY equalizer and
> low-pass filter settings to handle short or low-loss cables.
> 
> The UAPI definitions were introduced in the kernel through:
> net: ethtool: add KSZ87xx low-loss cable PHY tunables
For what its worth:

Reviewed-by: Marek Vasut <marex@nabladev.com>

(it looks very similar to what I cobbled together locally for testing 
purposes too)

Thank you !


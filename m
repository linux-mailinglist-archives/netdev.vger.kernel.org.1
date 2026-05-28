Return-Path: <netdev+bounces-292676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2D+LLy40GGpwfggAu9opvQ
	(envelope-from <netdev+bounces-292676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:25:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2716A5F20C1
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9BFE302DB75
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954B73E9C0A;
	Thu, 28 May 2026 12:20:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF92E3E92BC;
	Thu, 28 May 2026 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779970827; cv=none; b=WXlKJ1u3NbLAP2+8eKtrCmXFh+YbUjqqMobBJqiOWzSOiGZ+MbzMEDOzn/CWPL3dKhib7Xy5KLke8ELSdRW0KJeqW0cvzu7G448TnCmrsuWVsze1aSusesO7vTcdl17EYkKodzHr7EzAR3nbTZk7PF7Hyt3yeEFH2QnBOR/Pq/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779970827; c=relaxed/simple;
	bh=xt+tIAuY1qRBUbzTBjqohZUCP7nPKpHFgakFTMUkD5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZV5Q2Thl+ukOmCIJHuKWBajCC39OLBKboMy35IZBcrrBrl1d0nkDEWd5XKRcBNehV/f7S35eodSmSXby+zAQUANMwm1HCTDXqFpwMzI5uyvJ33A+lUksmhI27VYldlhOatm4ypbFX5jf5y1+GarogX7YMl8WywF+NwRJ9AXZAOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wSZiZ-000000007ty-1LZT;
	Thu, 28 May 2026 12:20:07 +0000
Date: Thu, 28 May 2026 13:20:04 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: javen <javen_xu@realsil.com.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, freddy_gu@realsil.com.cn, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, vladimir.oltean@nxp.com,
	=?iso-8859-1?Q?Bal=E1zs?= Triszka <info@balika011.hu>
Subject: Re: [PATCH net-next v1 2/2] net: phy: realtek: load firmware for
 RTL8261C
Message-ID: <ahgy9Cce9MmY6KLl@makrotopia.org>
References: <20260528075226.1054-1-javen_xu@realsil.com.cn>
 <20260528075226.1054-3-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260528075226.1054-3-javen_xu@realsil.com.cn>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,vger.kernel.org,nxp.com,balika011.hu];
	TAGGED_FROM(0.00)[bounces-292676-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realsil.com.cn:email]
X-Rspamd-Queue-Id: 2716A5F20C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 03:52:26PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for loading firmware. Download some parameters
> for RTL8261C.

I'd like to bring to your attention that the OpenWrt community
has impemented a more complete support for initial register patching
using a extremely similar firmware format.

https://github.com/openwrt/openwrt/blob/main/target/linux/generic/pending-6.18/742-net-phy-realtek-add-5G-and-10G-PHY-support.patch

We used 'RTK_PATCH_OP_*' while this series uses only 'OP_*' as
macro names defining the initval patching operations.

As the vendor downstream driver had the operations hard-coded in tables
our community came up with a tool to generate the patching blobs from the
GPL-licensed vendor driver:

https://github.com/balika011/realtek_phy_firmware

Given the similarity I wonder if this code has been taken from Balázs
Triszka work (which clearly predates it) without giving him the due
credit.


Return-Path: <netdev+bounces-278811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH3WHfuj32miXAAAu9opvQ
	(envelope-from <netdev+bounces-278811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:43:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9144056FD
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34CFE30561FE
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB843D3D1E;
	Wed, 15 Apr 2026 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OAN0R2Gd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338603D3337;
	Wed, 15 Apr 2026 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264040; cv=none; b=EhyG003ANiBeZKbbSDYt5sXxUAAI+u0CUGAXhCJLjyywCPKEKqmQ2wct0W3waMrpcG3uRVuFkL3Nb8i2fkfGatTcqCd+uZfS2iuNbu9mpr5rnP0D+fHxW3E0g9H3c5ZU5XmTJsRaM0BhY2kAQQ8521mrk+Cotpr/mQkrhCT3BPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264040; c=relaxed/simple;
	bh=s7mDl+C0Xf/TmpSKXsBlooDSvSgzqqB/GXqlveYuVBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+SwMI5O8t5OM8urOn9AHqrPV0KeuSl/9EgtHNM7khffAYyfG7r+UxC1tHawOCCS7t9xPD0+1GVprEJpznYGL+Hffok9JjBP0MhFzPqs66x+V6sEAwtKaAEwhrqtoCj3UUr82mePAauq0RijGMWVUpgASA2b7lDRSwfBzu6Mhx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OAN0R2Gd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rJm4iNDEdoaIaHgoaHEiUGa6+jJgBVQA/QcaFEWsbik=; b=OAN0R2GdGSLdWnLYOwvEe5uAbk
	jnf6YT7uBMICvEsFaCOxMDOYpRu48NUTheR7uJNVp0XWQ8vCx1tj2VxRdU1v7e4HNLUCupaHBNoBF
	SqAc8RN+R99Oo1paFaIxdsqS9zu7NZbh9PFbHopoiIEYPFzxzqVZRAe7okQFMGJBMfZ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wD1Pg-00GBK4-AB; Wed, 15 Apr 2026 16:40:20 +0200
Date: Wed, 15 Apr 2026 16:40:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Frank <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v1 1/3] net: phy: motorcomm: Add yt8531_set_ds()
 mdio_locked bool parameter
Message-ID: <f308dd00-e589-48e8-8edb-d3b9ed5565e6@lunn.ch>
References: <20260415092654.64907-1-minda.chen@starfivetech.com>
 <20260415092654.64907-2-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415092654.64907-2-minda.chen@starfivetech.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[motor-comm.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-278811-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: DC9144056FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 05:26:52PM +0800, Minda Chen wrote:
> yt8531_set_ds() default set register with mdio lock and only called
> with YT8531 PHY. But new type YT8531s support RGMII and has the same
> pin strength setting with YT8531, YT8531s need to call yt8531_set_ds()
> setting pin drive strength. But Its config init function
> yt8521_config_init() already get the mdio lock with phy_select_page().
> 
> Need to add ytphy API without lock in yt8531_set_ds() and a new
> bool parameter for YT8531s RGMII case.

This is ugly.

Please try to modify the code so that both PHYs can call
yt8531_set_ds() in the same locking context. You then don't need the
mdio_locked parameter.

    Andrew

---
pw-bot: cr


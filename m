Return-Path: <netdev+bounces-288365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJF4NUlMB2pZwwIAu9opvQ
	(envelope-from <netdev+bounces-288365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:39:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E59A6553AEA
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E57E302995F
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ED131F999;
	Fri, 15 May 2026 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p1KbMoJq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C438630569C;
	Fri, 15 May 2026 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862941; cv=none; b=tWxkwMIb0Et9IzbFzLIs609rGNVPVWw09j2SE+MkvDRWSrdrUDAegum1lKyujjcfOoR/zM0MexuZz3gNJy4seEGIJPbSwSJHT1cmZ66IeP8d2Opg8bC+GC0qKHpwnOtU27UQl3ZIIhY3oAhRInOAmMxAL2snLMLYN0xAgd0HoXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862941; c=relaxed/simple;
	bh=z0TToX7NuQQDS0WTa8JQyVq2hvOXUS0Rv14QeiIfwpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfjbXayLYZFt5zNadrcT0onZS+rxoQXKYJy9lBnpv5ITzNf1hTAUCViB05H1AKkWU47tr4i3QEP4wULOpKDIy2GQFGKRx7dZo4SiiQ0xd8103fWxs2QhB8ak1T1L/qRc25WqWoRlVUJmDE/yMNFMxu9YdkXq4RUn2QbGJbyz1Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=p1KbMoJq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vQ2HtcE0Pc693HHxm8VI2FjMQ3HxiNYJHgGdi2s7BNk=; b=p1KbMoJqhbrMZ0jTRbmLHH8Kkq
	n8zp9GwQTEEpw0BaGTpAbq/wbKX+fBqZoMXgu04TO8fTxM873FsXzgnYBYsoUmg5HlhrxOAEstTML
	o94rIXlBx+O1ryM5sVGEiV8Z/qbQPINka8H2iD4shfDPB0EnnZ29Zn+dABiLXa6IPoK8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNvVR-0035Zy-FE; Fri, 15 May 2026 18:35:21 +0200
Date: Fri, 15 May 2026 18:35:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: "parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/2] net: ethernet: oa_tc6: Interrupt is active low,
 level triggered.
Message-ID: <3dd191d1-118a-4280-8da5-fe836ab1ed62@lunn.ch>
References: <CY8PR02MB9249D2392242AF27988B9C0583042@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB9249D2392242AF27988B9C0583042@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Rspamd-Queue-Id: E59A6553AEA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288365-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:email,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 04:13:48PM +0000, Selvamani Rajagopal wrote:
> According to OPEN Alliance 10BASET1x MAC-PHY Serial Interface
> specification, interrupt is active low, level triggered.
> 
> Fixes: 2c6ce5354453 ("net: ethernet: oa_tc6: implement mac-phy interrupt")
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


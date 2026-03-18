Return-Path: <netdev+bounces-269181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gILFAPgRu2nGegIAu9opvQ
	(envelope-from <netdev+bounces-269181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:58:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 517222C2C49
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B655D31F687E
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B12E36F42B;
	Wed, 18 Mar 2026 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="z1VQV0FN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E33371CE5;
	Wed, 18 Mar 2026 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867330; cv=none; b=IOzpETT2uxLwfg0ld82ctHvV9eo3bA5F8pgzNeDBKid2DIfvS+jBpOlJr5zJ8miPVgd8g010eIEkn15aYiIJv5FBPxTdHEChxs2tetxNhoeLuJNiUjoOih61KTYpnFrQgUT7fWVaqqZG9bnVVEA6T+MdMeaKGDQ5R77wYa+MshI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867330; c=relaxed/simple;
	bh=Fp9bALpijpzXu+imzgpBrk+XvdkS4v41RnkuqBBMaF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCKquHNOjc+8AYvafdPUDOlMrSz4PxPlz3aMnc//VnI9m9YVPYAm6kRlPzUDGfLowSwltFzmjWKEBp7a7oPriLpeemReMBu3gR3OiUZ1dIWCFT1/Ybo6pbOh3zZqc6DdJGswY9G3HoYn67aQI+/Ke63pKC/RrScDX4OlmM0q0oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=z1VQV0FN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kuoyiBA04+iSz14CVjPaHNmnrcrBPP6a7V1Lj2dm2g4=; b=z1VQV0FN8EHhr8Y8+igyO0s8jW
	q7WKrpZdMXE+1xpafHD065FeBD32JrJQiFzvfPY7dXDCpSZusHB/q5YH3gFU1vZ3JpdJ3+9HG0SzU
	uF0zItgapdYlEyIuTxKjdsoYIO7JSoVBpSICXJPN7S5X1ZKmbh5P8JupMYL74scEVOfs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w2xv6-00CHrl-Qk; Wed, 18 Mar 2026 21:55:12 +0100
Date: Wed, 18 Mar 2026 21:55:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: pse-pd: add LED trigger support
Message-ID: <b42fb036-89da-48cd-9525-d05a065096d5@lunn.ch>
References: <20260314235916.2391678-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314235916.2391678-1-github@szelinsky.de>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269181-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,szelinsky.de:email]
X-Rspamd-Queue-Id: 517222C2C49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 15, 2026 at 12:59:16AM +0100, Carlo Szelinsky wrote:
> Add LED trigger registration and polling into the PSE core subsystem.
> Per-PI "delivering" and "enabled" triggers are registered for each PSE
> controller, with a configurable poll interval via the DT property
> "led-poll-interval-ms".
> 
> Signed-off-by: Carlo Szelinsky <github@szelinsky.de>

Please also Cc: LED mailing list. Ideally you want an acked-by from
the LED Maintainer.

    Andrew

---
pw-bot: cr


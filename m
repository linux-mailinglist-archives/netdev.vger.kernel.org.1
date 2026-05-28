Return-Path: <netdev+bounces-292851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAcRAPCuGGpolwgAu9opvQ
	(envelope-from <netdev+bounces-292851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:09:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE125FA43D
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BF2C300D924
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E9E35203C;
	Thu, 28 May 2026 21:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bk/W4PVR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AACC347FCD;
	Thu, 28 May 2026 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780002381; cv=none; b=YFRW2Qg/ykTrGPccNtweP0PS1up3O1whEXnC51QMw1/adtmHtaTe3TN8ubzQrlN9smzL1unVQgppAeEtfYNt3IzGrArLU4ynVZ0AfRKhUqlm62h0k14ZG7bg/iJziNw/ciZrCQzcpB0z/mVcr+4+GSRwxBbbi4kdmO+nFePAKcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780002381; c=relaxed/simple;
	bh=idG2RhDkONGGLt9RjX1cScChSkVq6VdSriS7AOomIE0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/ZkKW7o3Aob/XRb5rAF905SaJj0BEVxf4BN3ImpYkgnHdBHHH/u/RHaqQuFWZ5o82SYBCN/BjwedEapISXpQTwSdfq6GRBJcBlPufV9IEpzzOWitANKC85fPfEywTCqrlCzjNU6ZeYTFiH/S7+WeIWwSn4g7rFU/nU5wTVnyX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bk/W4PVR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF6E1F000E9;
	Thu, 28 May 2026 21:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780002380;
	bh=z6gcAzUBIceq/59nqN1vGJJiFRYaPr6HW7vhYa+mIFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Bk/W4PVRxTue/AWBdaxaxcbZoIdijyqU0xdQHJ5WS0ay1HFeK7M9fkOcmHGV7tvZG
	 bD8qFjeKG3y07Jy1peCVkZ2XkayxNKpDn7DBh2/YRcLVdr+hVM16qb30zBHtncTsgY
	 Rulq0hIjdCggwfwUbPoz0q7XTs3LxSmf0+XcMA8oMyU1FHqAadcW8DZeGSYKBhpRQ6
	 m+Gnqv363t1pmVnCNMJ03WLrNCUDzW1pX5YlEQ6+kU+2ohXr2ATB51GNJLwMpDd3sW
	 Ho1/GtEM5mgWcETwTRNvZYHOjWBn787fn1V9ClTwInHcKPGjjPdfJov3gdA9EVnOkM
	 2mwgsssedopRQ==
Date: Thu, 28 May 2026 14:06:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, Lucien Jheng
 <lucienzx159@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, David Miller <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20260528140618.5b244eba@kernel.org>
In-Reply-To: <20260528130436.450720f9@kernel.org>
References: <ahhlcK0ufJn0VEzM@sirena.org.uk>
	<20260528130436.450720f9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-292851-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	FREEMAIL_TO(0.00)[collabora.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 8CE125FA43D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 13:04:36 -0700 Jakub Kicinski wrote:
> Unclear to me why this is using __mdiobus_write() instead of __phy_write
> when the callers have access to the phydev..
> 
> Our PR to Linus is now out, hopefully he pulls soon.
> The AIR_EXT_PAGE_ACCESS define is no longer visible in air_en8811h.c
> 
> Louis, I'm going to move the define to the header to keep the merge
> simple. Could you follow up with a cleanup once Linus pulls and I push
> out the merge? Or if you prefer another resolution just show me a diff.
> If I get it before Linus pulls I'll use it.

Pushed.


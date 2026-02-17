Return-Path: <netdev+bounces-259052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BfzGkd7lGkfFAIAu9opvQ
	(envelope-from <netdev+bounces-259052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:29:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D468414D284
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77AD73029A49
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E7136B07A;
	Tue, 17 Feb 2026 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1yL+h/VO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A44636165D;
	Tue, 17 Feb 2026 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338524; cv=none; b=ap/OMlg+XbKpqgKygI4D/M42lFnVx8H/6L1t4Kx4sWhBMmfI/zkNIARCat4O6CbhQurJ6BPAB2qtakH+sOHV4hlQa/73zKj2SV0gUQZgYj7RR+3a9ahyWONKoOARMP4BmWJ8OS7iXbLBBBo9npvvQjy6sq6p4L1dG+yJ9Q69YQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338524; c=relaxed/simple;
	bh=VirvtIUHgo0Gf4SqwcO2G+cEjTflTGCYrC1keU2u3y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6nvfl+cRu3O2TKXm+Xs0nRyHPPmA2Apdgu9q4jXPB5coYinVrm7Dpbjm+URa2zyA1GvPXaX/5AArbIF1N+4MBpyIFXKYf5Xgh6j5pL3aYeEhQcHzF2z5a3mTqMNCioNEzjdQXeXKfA+1K0sX1G4XH1bKhHgYhR+pRE6/AVB7nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1yL+h/VO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/WGhv/86WWuPA3cRvL4Nx0eYuYShgiOfOVrFkgY+AW0=; b=1yL+h/VOl+XcNUFzGt/RY8/50I
	Oo2NJkYCRRan072FA1cX1WmM/6074gYfTr2bxdSiNnOgpuVB7RR2oZdg2ZNWy3/OMsfeiwqN+Hpvg
	xskfpRKsI2VfYPS6fhVvHmo1dLFuLFsbXlEcMqTGdGclwS9UThLFvb2X7gUrRAex+Znk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vsM3s-007eNm-Mo; Tue, 17 Feb 2026 15:28:24 +0100
Date: Tue, 17 Feb 2026 15:28:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: cedric.jehasse@luminex.be, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2] net: dsa: mv88e6xxx: Add partial support
 for TCAM entries
Message-ID: <979ea346-6f8d-4659-a7c6-79bb2f653720@lunn.ch>
References: <20260217-net-next-mv88e6xxx-tcam-v2-1-d84cf420da46@luminex.be>
 <aZRu3f4RYhoEd1JX@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZRu3f4RYhoEd1JX@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[luminex.be,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-259052-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D468414D284
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 01:36:29PM +0000, Daniel Golle wrote:
> Hi Cedric,

Hi Daniel

Thanks for reviewing, but please trim email to just the relevant
context. It can be hard to find your actual comments, and some might
be missed.

	Andrew


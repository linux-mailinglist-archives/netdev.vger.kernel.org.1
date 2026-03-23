Return-Path: <netdev+bounces-270778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGMSFw69wWm/UwQAu9opvQ
	(envelope-from <netdev+bounces-270778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:22:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A792FE30D
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F0783010238
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC093822BB;
	Mon, 23 Mar 2026 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1zkw0Dkx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E412A381B0E;
	Mon, 23 Mar 2026 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304520; cv=none; b=h/Kxaok6dELJh4YOuMihfGC2AOBaDZJjdwEpu4t9JC4z7PY97CmGYf3xp4wLY5xlJF7jxarT+wVhGMA93ikGZ1Xx2TIlz2IvZ8xFmWSlDblrn0mnJqtv6YbqahrUw6DKfyCn9UieqkT7nMxoMQE89o8YSGFTQnUF5rzfj5fR0fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304520; c=relaxed/simple;
	bh=zmdHI8Tj4NyZY0lGoLj+imAfRWX6FsTo02ab2klFusM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwxj707dW5W8Uj24rOAr0GzkXW8qWRs9ZDX362vwO2OOXJiLj2YRmJjdlK/P9QKyLcmVcxYgGKMhrBPCraXIiggDg5LA5xt7DPlFuEKx29t5+0EnuElX7VipKA33WvS7zf9t9rG6uhugBy6e2ydvFA6v7lCUVvQ4Fh5lcPutjXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1zkw0Dkx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Xa8UKQ4Fs8ZPx1g3HZrGYESD7/aANxP4j1//9P3MV3w=; b=1zkw0DkxN8iulgvmPZWWMGVBDI
	thTwwkibm+V2THgw0n9N6L8/yg6mBy7/8UFxJB/SIqb/mxVArHSyGuSkEV1QQHbExgkpCuzMB8gMF
	DqxV7S6tuWyGisMGVKUG3XOeAYNMmX+G4XGVElq+MB6zbSaua9Uw8vLXpSkcJKsAdaI0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w4nen-00D0HS-4a; Mon, 23 Mar 2026 23:21:57 +0100
Date: Mon, 23 Mar 2026 23:21:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	fujita.tomonori@gmail.com, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, dakr@kernel.org
Subject: Re: [PATCH 1/4] rust: phy: add read-only device field accessors
Message-ID: <516925c8-1b16-45fc-a562-5a70f3f39642@lunn.ch>
References: <20260323201925.8405-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323201925.8405-1-iprintercanon@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270778-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,umich.edu,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0A792FE30D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +    /// Common values include `bindings::phy_interface_t_PHY_INTERFACE_MODE_RGMII`,

PHY_INTERFACE_MODE_RGMII is actually an uncommon one, and frequently
wrong. I would not use this as an example.

	Andrew


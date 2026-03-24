Return-Path: <netdev+bounces-271155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJcxJei1wmlolAQAu9opvQ
	(envelope-from <netdev+bounces-271155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:03:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3A73189F2
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2934F30BA797
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8752237F733;
	Tue, 24 Mar 2026 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gag5ZgA1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F872F8BF0;
	Tue, 24 Mar 2026 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367833; cv=none; b=VqLFw7kVI2RHNQluoJGn5HBJxU0ZM0KAYXu1QPtyC+Xafx/Q2TLvuiAYLfgiK4Q0Ym16JtTgQTABs/r1GPQeHAKeJDtRjTjN9XhZ0E31aflHopmWBBiTGSsFbJUGnKcmf1xCRZRPVUHfmk+rWjczzznr31Z4nUSS5iaPhvIHdwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367833; c=relaxed/simple;
	bh=2KEwl+6DMmKxvxX4/dYBxsLNPVAZs6egtIoD62fGT/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4pci1ZnQ/B3cfftmWdsN0M8dsqUuajTZ/aTlXVgZIgkNkcl78hEX+1Pzn8+UljlC7ddtjfmu8oHVosEMR8Ek9m8hErgXIga+So3pvoeYGJNfCISxMZqACaDv27OKjUhYPoUUjxXhYziALDuUvp6EmO708M+QmCD8yDlVt8RFy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gag5ZgA1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XBOut7lCVUlVjvSLZCJSiDRbqJp0Wozal6Q1uTqZhhU=; b=gag5ZgA15MivipamxaYePdo6zN
	vvT44VHYfxR2jZ7T+yIUzNyDTOkTz8MR7eTsYkhyXUEp0NJA4Uf/rLlpV1ii0AIarVyRuyZiTVI6b
	nrutxSdHAZfoTi1/1LNePBypSIjC6Heb+T56cCzrqCcnajK7GMIdfCJvK/SC5erJLNIE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w547x-00D7rY-BJ; Tue, 24 Mar 2026 16:57:09 +0100
Date: Tue, 24 Mar 2026 16:57:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	fujita.tomonori@gmail.com, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, dakr@kernel.org
Subject: Re: [PATCH net-next v2 5/5] net: phy: realtek: add Rust RTL8211F PHY
 driver
Message-ID: <137c5d9a-2750-49b1-a9e6-4367b3f28c90@lunn.ch>
References: <20260324155249.15098-1-iprintercanon@gmail.com>
 <20260324155249.15098-6-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324155249.15098-6-iprintercanon@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271155-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 1F3A73189F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 06:52:49PM +0300, Artem Lytkin wrote:
> Add a Rust implementation of the Realtek RTL8211F Gigabit Ethernet PHY
> driver.

We don't want duplicate C and Rust drivers. Sorry.

Just out of interest, what hardware have you tested on?

    Andrew

---
pw-bot: cr


Return-Path: <netdev+bounces-284803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBzoGZoy+2nfXgMAu9opvQ
	(envelope-from <netdev+bounces-284803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:22:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E784DA235
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B161E300422B
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 12:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5148441054;
	Wed,  6 May 2026 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jMvFFgWg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4589631716F;
	Wed,  6 May 2026 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778069944; cv=none; b=P6ue1Rd2D5Z64nDvpbcZ/gyrKKrbpedVPSDIJbjYCv/a0vDODx3J5e/IonFNrGh1/oUFt4bvMnjqKvn4tC2kLA9d5TUypXHwr/dOo6wN4/uLDcA/sF/UCqMQMnc2gcjcOu7Ka+eMRrdkl3ewmkKk47n8qSHvL8T5t13juldiPu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778069944; c=relaxed/simple;
	bh=TVosckRMj9sotc+r9onO1GprqoVfjJ+m3ME2L21FObI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLbESZcgq6Tu7qm3AOD1gwYjYLWXy9lWIygGBrz+agv9KEnmZ0ophAqJAtkrDpFyAP6bsH2G47diLd1gXS4S3680ohG3BVvptTPQ/0gBmMq7YVF5H748Tq4BbzFvxKmTyn9nzuxIgQhXHO8mKjaRk+0mDDtNKlvu8LpEsVCYZE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jMvFFgWg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5A9HcZx92YaaISTe948RP7Oj0YmqPRmTGkH92yS7uAg=; b=jMvFFgWgojVlxvN7UyP7TAVOy1
	BpFkTprjTeJPzrxXkWHHVQXrclkTJRw+H+g8ehvfJYg/a/68K+84xDzto0cjZKbjy6UqLg/mQbJmp
	2I2yQhN0MKbdj78I5ZTRtC7ZXdClWSn/A3qXPWR6PAy/yH6uVIIpZLROXte36kGVJHaY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKbDE-001dJ4-B8; Wed, 06 May 2026 14:18:48 +0200
Date: Wed, 6 May 2026 14:18:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "chunzhi.lin" <linchunzhi0@gmail.com>
Cc: netdev@vger.kernel.org, Frank.Sae@motor-comm.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, davem@davemloft.net,
	linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org
Subject: Re: [PATCH 1/2] net: phy: motorcomm: use device properties for
 firmware tuning
Message-ID: <7d209b85-6ea3-4b83-b710-28ce39dfecff@lunn.ch>
References: <20260506021813.3658669-1-linchunzhi0@gmail.com>
 <20260506021813.3658669-2-linchunzhi0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506021813.3658669-2-linchunzhi0@gmail.com>
X-Rspamd-Queue-Id: B7E784DA235
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284803-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,motor-comm.com,gmail.com,armlinux.org.uk,kernel.org,redhat.com,google.com,davemloft.net];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,lunn.ch:dkim,lunn.ch:mid]

On Wed, May 06, 2026 at 10:18:12AM +0800, chunzhi.lin wrote:
> The Motorcomm PHY driver reads optional firmware properties via
> of_property_read_*() from phydev->mdio.dev.of_node. This works for
> Device Tree based systems, but causes ACPI platforms to ignore the same
> properties when they are supplied through _DSD.
> 
> As a result, ACPI-described Motorcomm PHY devices fall back to default
> settings instead of applying firmware-provided tuning such as
> rx/tx internal delay, drive strength, clock output frequency, and
> optional boolean controls like auto-sleep-disabled,
> keep-pll-enabled, and tx clock inversion.
> 
> Switch these lookups to device_property_read_*() so the driver uses the
> generic firmware node interface and can consume the same property names
> from either Device Tree or ACPI.
> 
> This keeps the existing DT behavior unchanged while allowing ACPI
> platforms to honor PHY configuration from firmware.
> 
> We have completed testing on Sophgo RISC-V architecture server SD3-10.
> This server has a 64-core Thead C920 CPU whose DWMAC is connected to
> Motorcomm's PHY YT8531. This server supports UEFI boot and it would like
> to use the ACPI table.
> 
> Signed-off-by: chunzhi.lin <linchunzhi0@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


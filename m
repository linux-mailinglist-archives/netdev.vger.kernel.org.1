Return-Path: <netdev+bounces-278779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kC6NLLKU32l9WQAAu9opvQ
	(envelope-from <netdev+bounces-278779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:37:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0D0404E85
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A44830330B5
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 13:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3554C33F383;
	Wed, 15 Apr 2026 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Qb6hDTY7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B699E34C989;
	Wed, 15 Apr 2026 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776260270; cv=none; b=j4X/iZd0kIV9fPG5U0CWLI28ylkfA9uq9sKg1WATwnLqcm32lk3dJsk4gqtShRSxhSJLe7PJXQyoBijtzlXG4EppAwrtVeM0mf+wKgl17+YS9igATtr7ttnAxdZQynSsrXmPmKefBEvZOw8ojG2zuBk3gAH6Tf1YpcF3ez8PJrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776260270; c=relaxed/simple;
	bh=TTq1/2iu9U2NyPWRiYcRGwi7n925POt46l1FYsfSwXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkZBCN9NMo94euX2pLfeZna4PLOZhDT6v5jfKiCK9yT+VhZyGnd+SbRMAEB2rh4rCtgzSXpaqzsLSbHj5WuyU86DeLOhIGevbMdWjlxU7qIKvK9GQ6PH+f6FB18j3WG2Bshm4apuit/6U99WYnOUmugXhCFusiFtr9kRhYf3xcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Qb6hDTY7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fZHq9OE8S/jsDBJ+ay5ON3v07vYuClAf4uEDhBAa/eM=; b=Qb6hDTY7Ix7r0HVhMKqmFMCjdq
	GLfQWFboYV3OtFfwIssu2liZIF8anWX9Z4ZJTHNgKVPcPuJrx8o3qH8mqMGhb2emhBCcatTJKVB+H
	ShzT3HWNfx9MJCnbhPICUaac17s8SxxiZwCmffB9H/ytXG/zebJs2H/InHYWi5cNxSNk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wD0Qu-00GApB-Lr; Wed, 15 Apr 2026 15:37:32 +0200
Date: Wed, 15 Apr 2026 15:37:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "chunzhi.lin" <linchunzhi0@gmail.com>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, chunzhi.lin@sophgo.com
Subject: Re: [PATCH net] net: phy: motorcomm: use device properties for
 firmware tuning
Message-ID: <2c7a87b1-4ec6-4b4b-aec3-42f9e90bc133@lunn.ch>
References: <20260415131452.3492671-1-linchunzhi0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415131452.3492671-1-linchunzhi0@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278779-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[motor-comm.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,sophgo.com];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: EB0D0404E85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 09:14:52PM +0800, chunzhi.lin wrote:
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

Please document the new ACPI binding in
Documentation/firmware-guide/acpi/dsd and Cc: the ACPI list so they
can review the binding, same as a DT binding would be reviewed.

The Subject line is wrong. This patch is for net-next. Please read

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

and since the merge window is open at the moment, you will need to
wait two weeks before resubmitting.

    Andrew

---
pw-bot: cr


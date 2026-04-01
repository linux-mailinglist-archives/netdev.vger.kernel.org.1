Return-Path: <netdev+bounces-274081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OZgJzQMzWnhZgYAu9opvQ
	(envelope-from <netdev+bounces-274081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:14:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEA437A452
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E142F3014600
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 12:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1D840243C;
	Wed,  1 Apr 2026 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="MFbVrkyK"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6483C9EFB
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775045569; cv=none; b=dyZKAQLPEYYOQcm5B4YfHjbR06cXmP6gXIkseAKAJynZy4ADVjQiPV4v/Hn9YhrYAjz2M4wVSIZC9Ao9suXb0G12mNU1ivW7uDMZtsbywT6xJmatRxtAFGecy3sarvM7dSCyt7UNX2kRMpe6vV+qqpTP88qdAbbdi9t5cSnBi5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775045569; c=relaxed/simple;
	bh=Fsp/6US/7KL1XzPKpRKXB3hb8A3DUAEdX9NBLia0CCw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=TkAGBAULPgt7odYR2jH8J92BfFS8usz9GIBT1eKhCYq3maAmoujZTjRZsbnkdw2kWB7XUWXiB61/KTGz6x1FQRib9Mhc1p+5w7IJYfigEc5kJU8h5Xadgxs99XTHsYGFQIAqhStX+Fz4wsykTvGP9IiaePZBMxxiBGwaF9zzIoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=MFbVrkyK; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 49B57A56EE;
	Wed,  1 Apr 2026 14:12:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775045563; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DTaYfdkSL8cJwRACnfK1wtT8yim3JnxhmL9znpKAzSA=;
	b=MFbVrkyK8/HNVwU1Gg+cT9TfEFjp6W/REFI6Udbc1P1oEXgu/p9Ua3BX+/scP2SNsDY1kB
	tDslAO8ldIW78estrcPS7DzCB94VMV9CV7p4g5kwsup9hpVpmf4Z0XIg0QyTTFFocZRJWX
	xUZ9wq8U+8SQHa7oUSPGke6E8T4HyGgeH15r2NA8Q6uwfkWUZj6MGnoZztpxcIY1PGSgdq
	ss65z7LnA8zlg5jmQU5eUf3LYRCj3O3bEmbb9P4Mswm2/T63zP7ZP9ZJPxt/L/HMARSz/u
	lrdpanDjJSz13FyQA6vjdQs1PJfUtJQ1J3Exh0idVD38+v8ZegjW6MPqKYcuEg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 01 Apr 2026 14:12:43 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: RFC: phylink: disable PHY autonomous EEE when MAC manages LPI
In-Reply-To: <aczMqBNesQH-tHx0@shell.armlinux.org.uk>
References: <d86c53213a6328b701b8aabbde5d1c83@tipi-net.de>
 <04ff15af-26be-4278-bc2a-889e7802d271@lunn.ch>
 <aczMqBNesQH-tHx0@shell.armlinux.org.uk>
Message-ID: <ccb68eaaca5512d5d662326d0817bd50@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274081-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3EEA437A452
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1.4.2026 09:43, Russell King (Oracle) wrote:
> On Wed, Apr 01, 2026 at 12:56:08AM +0200, Andrew Lunn wrote:
>> On Tue, Mar 31, 2026 at 11:27:20PM +0200, Nicolai Buchwitz wrote:
>> > Hi
>> >
>> > Some PHYs (e.g. Broadcom BCM54xx "AutogrEEEn") manage EEE LPI
>> > autonomously without forwarding LPI signaling to the MAC. This works
>> > fine when the MAC doesn't support EEE, but conflicts with MACs that
>> > implement their own LPI control via phylink's mac_enable_tx_lpi /
>> > mac_disable_tx_lpi.
>> >
>> > When the MAC has lpi_capabilities set, the PHY should use Native EEE
>> > mode so the MAC can control LPI entry/exit and observe RX LPI
>> > transitions.
>> >
>> > I'm thinking of a flag on phy_device (similar to mac_managed_pm) that
>> > phylink sets when the MAC has lpi_capabilities, and that PHY drivers
>> > check in config_init to disable their autonomous EEE mode:
>> >
>> >   /* set by phylink when MAC manages LPI */
>> >   phydev->mac_managed_lpi = true;
>> >
>> >   /* in bcm54xx_config_init: */
>> >   if (phydev->mac_managed_lpi)
>> >       bcm_phy_modify_exp(phydev, MII_BUF_CNTL0,
>> >                          AUTOGREEEN_EN, 0);
>> >
>> > This came up while adding EEE support to the Cadence macb driver (used
>> > on Raspberry Pi 5 with a BCM54210PE PHY). The PHY's AutogrEEEn mode
>> > prevented the MAC from tracking LPI state. As a workaround, the
>> > Raspberry Pi tree currently carries a downstream patch that
>> > unconditionally disables AutogrEEEn for all BCM54xx PHYs, since both
>> > genet and macb now support EEE properly. That's obviously not suitable
>> > for upstream where other MACs paired with BCM54xx may not have LPI
>> > support.
>> >
>> > Does this seem like a reasonable approach, or is there a better way to
>> > handle PHY autonomous EEE within phylink?
>> 
>> You should also think about it from the other direction. What happens
>> with the MAC does not indicate it supports EEE, but the PHY has
>> autonomous EEE. At some point in the future we are going to want the
>> PHY drivers to export API calls so that phylink/phylib can implement
>> ethtool set_eee and get_eee using this autonomous EEE.
> 
> Indeed - this needs to first be solved in phylib so that non-phylink
> drivers can work before adding support to phylink.
> 
>> Maybe it makes more sense for Broadcom BCM54xx etc, to implement a
>> .set_eee() call which only accepts eee_enable == False, and when
>> called so, disables autonomous EEE. .get_eee() can similarly return
>> that EEE is disabled. When phylink sees the MAC implements EEE it can
>> calll into the PHY driver to turn off autonomous EEE. And we have a
>> path to later add support for turning on and fully configuring
>> autonomous EEE.
> 
> I think the current phylink_ethtool_[sg]et_eee() may eventually need
> tweaking - for the case where the MAC eee ops are populated but the
> MAC support is disabled for some reason - e.g. the instance doesn't
> support EEE but the driver does for other instances.
> 
> However, I don't think we can re-use phy_ethtool_set_eee() for this -
> even with MAC based EEE, we still call through to phylib's
> phy_ethtool_set_eee() which would change the on-PHY EEE support in
> ways we wouldn't want. This call remains necessary because of the
> requirement to configure the EEE advertisement which happens at phylib
> level.
> 
> I think we need a separate phylib interface which disables PHY-based
> EEE.

Thanks Russell and Andrew. You're both heading in the same direction,
so to make sure I understand correctly:

1. Add a new phylib interface (separate from phy_ethtool_set_eee) to
    control PHY-autonomous EEE, e.g. phy_set_autonomous_eee(phydev,
    enable) and phy_get_autonomous_eee(phydev) to query the current
    state.

2. PHY drivers implement it where applicable. BCM54xx AutogrEEEn as
    the first user, Realtek RTL8211F as a second - it already
    unconditionally disables PHY-mode EEE in config_init with the same
    intent.

3. phylib calls it when the MAC registers EEE support, phylink can
    build on top of that. Since EEE advertisement happens during
    autoneg and LPI management is independent, the autonomous EEE
    mode can be switched at any point after probe.

4. phy_ethtool_set_eee() handles EEE advertisement at the autoneg
    level and stays untouched. The new phy_set_autonomous_eee() only
    controls who manages LPI after EEE is negotiated: the PHY
    autonomously or the MAC.

I think solving this properly in phylib is the right approach. Having
to guess whether autonomous EEE is interfering with MAC-managed LPI is
a recurring pain point, so it's worth getting a clean interface for it.

I'd put together patches once we've agreed on the overall architecture.

Nicolai


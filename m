Return-Path: <netdev+bounces-274415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF3rGM4gzmnElAYAu9opvQ
	(envelope-from <netdev+bounces-274415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 09:54:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 273FA3857AE
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 09:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE3AA3072FD9
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 07:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B0D1EFFA1;
	Thu,  2 Apr 2026 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="R/gf+9n9"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89C1389453
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116427; cv=none; b=U1L/W8nq8R9noE/8V8kU8j3Ht1PU0c5XyK1CHLKkjL6jWl4iVqgwM5dxMQ6O+TK4b+6vWEfrYTrTftIG6744DmRdWZIbv7I1KeOwVvNxNpNXaEjc1pQ4vm6/RVgchUp+3dLtQyPJkkCdE/HLeeMcodd8dNBGFl9KHs6qycGM92I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116427; c=relaxed/simple;
	bh=cxswUciXDKg1tFVdlnYXr15eDbntibI7qxJyg1u1W08=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=bwgYate/k8U8SS/qVBk5wpnrlvde3a5PF8hyHtVlO7VY8Oeotw4ufqBWm/aahBZgYzwBOKz+Pb+leqHaiYoJba2VM8NK8S1HK4iO/5CXkx6BsP0wqLUI0eYuhMon+9+BhzeBnNkyLRczQHvPxH4bcp3YEUrd85D8KlfZ0CoVkXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=R/gf+9n9; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 775B0A5889;
	Thu,  2 Apr 2026 09:53:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775116417; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TdeYpSYp4B6Mqgm58fZxaLQAtyF0acc5UUwHJCTgTpk=;
	b=R/gf+9n9Jok8ulGtozz/n2nSB6T1MywDjzl43qpSDrYuKgI/vSIIgncnS2q6c3UjKbblvx
	F7RU/tKwrjmskKqPCh46v2Z34noqBVfIizSf9fujk1tUegGjpg6psJ4XJeyGSaA8mknVuX
	qYcb01evKyh5gS0Zs/Q26AGwF2lckXEz2wo++OR1BA/42mO8NbrRiCWt1QzqFV7S1PF9Dv
	XfuHbMc4G6kZcfqup1EeQSIo3xLtsJlmJrA92riJr4Ih9ct1o7pmO8UnKXILS7Q5gbCGs4
	5nTakuG+9/kEYy9CcVyq+aorbSOsTv6msXknjCiwrZP7pXz0JFRzQtspm7nC2Q==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 02 Apr 2026 09:53:37 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: RFC: phylink: disable PHY autonomous EEE when MAC manages LPI
In-Reply-To: <ac1Bj-02_ob7UPjh@shell.armlinux.org.uk>
References: <d86c53213a6328b701b8aabbde5d1c83@tipi-net.de>
 <04ff15af-26be-4278-bc2a-889e7802d271@lunn.ch>
 <aczMqBNesQH-tHx0@shell.armlinux.org.uk>
 <ccb68eaaca5512d5d662326d0817bd50@tipi-net.de>
 <48abd3e3-a3ee-4e85-a3d8-20c8ceedfb77@lunn.ch>
 <ac00PIpzXPjxktzC@shell.armlinux.org.uk>
 <ea94e96c-3e76-4c2b-a08c-43ce6decca08@lunn.ch>
 <ac1Bj-02_ob7UPjh@shell.armlinux.org.uk>
Message-ID: <4950b35ad3df1e8a09d063907dad32a3@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274415-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DMARC_DNSFAIL(0.00)[tipi-net.de : query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:mid]
X-Rspamd-Queue-Id: 273FA3857AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1.4.2026 18:02, Russell King (Oracle) wrote:
> On Wed, Apr 01, 2026 at 05:38:23PM +0200, Andrew Lunn wrote:
>> On Wed, Apr 01, 2026 at 04:05:32PM +0100, Russell King (Oracle) wrote:
>> > On Wed, Apr 01, 2026 at 03:11:24PM +0200, Andrew Lunn wrote:
>> > > > Thanks Russell and Andrew. You're both heading in the same direction,
>> > > > so to make sure I understand correctly:
>> > > >
>> > > > 1. Add a new phylib interface (separate from phy_ethtool_set_eee) to
>> > > >    control PHY-autonomous EEE, e.g. phy_set_autonomous_eee(phydev,
>> > > >    enable) and phy_get_autonomous_eee(phydev) to query the current
>> > > >    state.
>> > >
>> > > In the end, we want the MAC driver using phylib to just call the
>> > > phylib methods for configuring EEE, and the MAC driver should not care
>> > > if EEE is actually implemented in the PHY or the MAC. The adjust_link
>> > > callback would simply not enable LPI if the PHY is doing EEE.
>> >
>> > This won't work.
>> >
>> > If we mask out eee.tx_lpi_enabled when calling into phylib to tell
>> > phylib drivers to disable SmartEEE (that's what I'm calling it here
>> > because it's easier to type)),
>> 
>> We need phylib to handle some state information. Are we doing MAC EEE
>> or SmartEEE? We can then set phydev->enable_tx_lpi == True to indicate
>> if the MAC should be sending LPI indications, if and only if the
>> phylib knows we are doing MAC EEE and it should be enabled because the
>> user said so.
> 
> Right, and that's why I suggested phy_disable_autonomous_eee() to tell
> phylib to disable SmartEEE/autonomous EEE support at the PHY 
> independent
> of phy_ethtool_set_eee().
> 
> I was also suggesting that there's eventually a complementary function
> that says basically "please enable SmartEEE" because we may have phy
> drivers that disable it today.
> 
> In absence of either call, phy drivers need to maintain their current
> state.
> 
>> However, i think this is down the road. If the MAC driver calls
>> phy_support_eee(), we should call the SmartEEE disable method of the
>> PHY driver. When we add support for SmartEEE then we need this
>> additional state information.
> 
> That also works for me.

Thanks both. So if I understand correctly:

1. Add a .disable_autonomous_eee callback to struct phy_driver

2. Call it from phy_support_eee() so MAC drivers don't need to know
    or care whether the PHY does (autonomous|smart)eee

3. BCM54xx (AutogrEEEn) and RTL8211F as first users

4. No enable counterpart for now. PHY drivers maintain their current
    default behavior unless phy_support_eee() is called.

Sounds good. Sorting out the warts of (autonomous|smart)eee will be
iterative anyway, so starting with just the disable path makes sense
(and hopefully will make setups a bit less broken than they were with
both fighting for LPI).

I'll put the RFC patches together.

Nicolai


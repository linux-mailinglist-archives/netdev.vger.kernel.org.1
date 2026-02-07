Return-Path: <netdev+bounces-257674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kE8OIc+JhmmOOgQAu9opvQ
	(envelope-from <netdev+bounces-257674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 01:39:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D77731045B6
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 01:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D74073007CA8
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 00:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69AB2264A9;
	Sat,  7 Feb 2026 00:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sI4rQKbQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6B62153EA;
	Sat,  7 Feb 2026 00:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770424739; cv=none; b=HMyqKXTINIypZb77WkcaJFDbDdNBPtmIQS0P5H3aPX6YJu1UFC75wFHt9eN/+XgR3yLSdn4iKWSWi6WfklKbZe9CvTMcjZj82he/FyoEJIf1VFPTb9pciGnbPVIyWHlqOgUWqGwhKTPH0SoVP77yD7TqKw6gzVhVeotvD2aQrZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770424739; c=relaxed/simple;
	bh=C0NcXN4oJERPN4gCAYJ0fWZLR7QW3QeSK/shRgwEVAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oubt51NgfEVrSM+EwXoD0VV4l3DCKnjTF7yHe3hq/tSS85n1NoURT/cjCZtIorPGelDYg5GXlHooP+dwnMq70qerpWtQ1z9fLbW45dHMYdxUGNZp1a461P23E3EWbm6KICwH+B5G25BBCaboURsHXk2SqfJbxZW6jqWiFRgiLSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sI4rQKbQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DCo3lqvlIa9T2gu2WpWAQjYaukNS5eMnfKe8waRu45g=; b=sI4rQKbQufTXOFhqTMEki0WagR
	1Vo5Pp78Ukn2u53sgiPSmpYjPS3BYvItXW74ng/3zRr9YROoslDvvYv/1uO+7n28gTLcEudju+4PS
	nGfnAFfNzkBgVBvuww/e6uBJSujcFKDx4OHqyrf5Gx4RrBsyZF7azSmchQWa89a1uDcc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1voWLX-006R69-53; Sat, 07 Feb 2026 01:38:47 +0100
Date: Sat, 7 Feb 2026 01:38:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Lukas K." <kernel@0x83.eu>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	linux-kernel@vger.kernel.org, krzk@kernel.org,
	regressions@lists.linux.dev, netdev@vger.kernel.org,
	Michael Thalmeier <michael.thalmeier@hale.at>
Subject: Re: [REGRESSION] NFC broken on Thinkpad T14 Gen since 9c328f5
Message-ID: <ff97b58a-f422-4f15-99d3-cbf60bf90583@lunn.ch>
References: <11b7567e-b9a4-4546-9b1c-bb9820bead0c@0x83.eu>
 <b82d8cc1-2124-417d-95f8-5fed429e2d0e@leemhuis.info>
 <d73ccfcf-507c-4c22-beeb-efc24f671626@0x83.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d73ccfcf-507c-4c22-beeb-efc24f671626@0x83.eu>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257674-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hale.at:email]
X-Rspamd-Queue-Id: D77731045B6
X-Rspamd-Action: no action

On Sat, Feb 07, 2026 at 01:25:29AM +0100, Lukas K. wrote:
> On 06.02.26 17:24, Thorsten Leemhuis wrote:
> > On 2/6/26 16:15, Lukas K. wrote:
> > > 
> > > from 6.17.2 to 6.17.3, the integrated NFC reader (driver: nxp-nci_i2c)
> > > in the Thinkpad T14 Gen 4 (AMD) stopped detecting tags. This can be
> > > tested by running
> > > 
> > > sudo nfctool -1 -p -d nfc0
> > > 
> > > Looking at the commits between 6.17.2 and 6.17.3, 9c328f5 (net: nfc:
> > > nci: Add parameter validation for packet data) was the only one related
> > > to NFC.
> > > 
> > > To see if that commit indeed was the culprit, I reverted it on 6.18.7
> > > and nfctool is detecting tags again.
> > > 
> > > Since the offending commit merely adds some bounds checks, the root
> > > cause may very well be in another driver in the NFC stack.
> > 
> > Thx for the report. Seems Michael (now CCed) also ran into problems and
> > tried to fix them, but looks like that effort stalled; but might be good
> > to know if this fixes your problem, too:
> > 
> > https://lore.kernel.org/all/20260112124819.171028-1-michael.thalmeier@hale.at/
> 
> Hi Thorsten,
> 
> thanks for the pointer. Tried the patch you linked to and it works for me.
> 
> Don't know how to reply to the linked mail as I'm new to LKML, but one thing
> caught my eye:

If you look at the page you will see:

Message-ID: <20260112124819.171028-1-michael.thalmeier@hale.at>

You can take the message ID and give it to b4:

$ b4 mbox 20260112124819.171028-1-michael.thalmeier@hale.at
Looking up https://lore.kernel.org/r/20260112124819.171028-1-michael.thalmeier%40hale.at
Grabbing thread from lore.kernel.org/all
2 messages in the thread
Saved ./20260112124819.171028-1-michael.thalmeier@hale.at.mbx

You can then open
20260112124819.171028-1-michael.thalmeier@hale.at.mbx in a mail client
as a mailbox and hit group reply to one of the messages.

    Andrew


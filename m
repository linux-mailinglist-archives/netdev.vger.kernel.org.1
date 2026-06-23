Return-Path: <netdev+bounces-301319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6TSTKmBVOmpQ6QcAu9opvQ
	(envelope-from <netdev+bounces-301319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:44:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D5C6B5E36
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:44:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="Ug AIqaI";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301319-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301319-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D79F302177C
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 09:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEA83CDBDD;
	Tue, 23 Jun 2026 09:43:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6943B8409
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 09:43:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207838; cv=none; b=k6fnx2vZLfScqJTmKcKR+P+GlplW/I/jEoLCFPxxzg2FW9gyIgIG0t20GK/E/GaMKDV+roq6HRb2ApYpsARnQ9R7x4UTyyLgohVA0GQy/GpzVJ7OmPgcL7pIcc185reQ2qD2JijGJ+hUlxxhWECfS9yiFSNqhoRQG3cWZvUbyYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207838; c=relaxed/simple;
	bh=qaPXGDRkcAJTvBAWetJ5dJ687I86OgKCiGte70aqC8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUakQmJ4SObGs90o8SikwDh07Iw++dVF0K/0NZh0/V+/oiNXN+1OaccFMkgKDyP+oNmXPBTpwmYT5lYOsg+XBzNRxD7d5fObhU0sKQ4aTezNgpjYeH1sUA7KcDGAvpdgCm1HapDA7ABRoBv2EJOW4Gmx8VWDnjpENcr2IsLUT1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UgAIqaIl; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=p1rld7m3a2i7jF3lXUm4K6nlAwWQ4m5HnLt44pof6/Y=; b=Ug
	AIqaIlX6G3aZCeTF4lE/wI5BxJHtIgEh7WwInUYqqR9e3Af2lTUIjPPPZ0ERcdrIqqqx1NQGdK8EV
	StL1r3eZbP3zy0an7wzS50BSr9VZC8J1a9p6eMOkT0UmeXCE97MiFVE6BFp2H0qPRDxeIuzREKQ/S
	KbesXQGRGwE441Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wbxfV-008vmY-NY; Tue, 23 Jun 2026 11:43:45 +0200
Date: Tue, 23 Jun 2026 11:43:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Das, Shubham" <shubham.das@intel.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Alexander H Duyck <alexander.duyck@gmail.com>,
	"lee@trager.us" <lee@trager.us>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"mkubecek@suse.cz" <mkubecek@suse.cz>,
	"D H, Siddaraju" <siddaraju.dh@intel.com>,
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
	"Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>,
	"niklas.damberg@ericsson.com" <niklas.damberg@ericsson.com>
Subject: Re: Ethtool : PRBS feature
Message-ID: <5f22c491-b816-421e-a531-bf87a07fea70@lunn.ch>
References: <SN7PR11MB810923BBDEC398E860099150FF1B2@SN7PR11MB8109.namprd11.prod.outlook.com>
 <f4a3e4ad-91e2-4844-a29b-81f70151228e@lunn.ch>
 <SN7PR11MB81099B4885C10E16D52A2EB9FFE52@SN7PR11MB8109.namprd11.prod.outlook.com>
 <06d8c98da24e80d148ede4e933bb621c5515a7a2.camel@gmail.com>
 <SN7PR11MB8109C173933D08F994FBB084FFE22@SN7PR11MB8109.namprd11.prod.outlook.com>
 <26971635-b13a-4ed3-b2cb-ce35da9b63d3@lunn.ch>
 <SN7PR11MB81096CF160930DB8FA278B3CFFE12@SN7PR11MB8109.namprd11.prod.outlook.com>
 <be5c474b-c969-49af-8235-825580ee945c@bootlin.com>
 <SN7PR11MB8109149608172808784CDCBEFFEF2@SN7PR11MB8109.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN7PR11MB8109149608172808784CDCBEFFEF2@SN7PR11MB8109.namprd11.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301319-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:shubham.das@intel.com,m:maxime.chevallier@bootlin.com,m:alexander.duyck@gmail.com,m:lee@trager.us,m:netdev@vger.kernel.org,m:mkubecek@suse.cz,m:siddaraju.dh@intel.com,m:balaji.chintalapalle@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,gmail.com,trager.us,vger.kernel.org,suse.cz,intel.com,ericsson.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30D5C6B5E36

On Mon, Jun 22, 2026 at 03:38:30PM +0000, Das, Shubham wrote:
> Hi Maxime,
> 
> > Can you elaborate on what you have in mind for now ? what would the "ethtool --
> > phy-test" command look like in terms of its behaviour and parameters ?
> 
> We are trying to converge on a userspace uAPI for PRBS/BERT functionality that can work across
> different hardware models (PHY-managed, MAC/NIC-offloaded, or firmware-based implementations),
> without exposing those differences to userspace.
> 
> Based on the functionality we currently have, we proposed below commands in first email :
> 
> PRBS Transmitter/Checker Pattern Configuration:
> ethtool --phy-test eth1 tx-prbs prbs7
> ethtool --phy-test eth2 rx-prbs prbs7
> 
> BERT Test:
> ethtool --phy-test eth2 bert start
> ethtool --phy-test eth2 bert stop
> 
> BERT Test Counter Read/ PRBS Lock Status:
> ethtool --phy-test eth2 stats
> 
> BERT Clear stats - Symbol and Error counter:
> ethtool --phy-test eth2 clear-stats
> 
> TX Error Injection:
> ethtool --phy-test eth1 inject-error 1
> ethtool --phy-test eth1 inject-error 1e-3
> 
> Disable PRBS Pattern : TX/RX
> ethtool --phy-test eth1 tx-prbs off
> ethtool --phy-test eth2 rx-prbs off
> 
> Approach would be to add a generic ethtool netlink API for PHY/SerDes and allow drivers to implement the operations directly. 
> Conceptually:
>        ethtool ⇒ ethtool netlink ⇒ driver-specific implementation
> 
> We would appreciate your input on whether a command-based model is suitable for a uAPI, and how we should design
> it to accommodate different implementation models, such as PHY-based, phylib-based, and MAC/firmware-offloaded PRBS.

This is technical, not the uAPI. You need to define the netlink
messages and all the attributes that are passed between user space and
kernel. Please take a look at Documentation/netlink/specs and propose
an extension to ethtool.yaml.

Taking a quick look at this:

You are missing a way to enumerate what test patterns the hardware
supports. There is more than prbs7. You want to be able to report the
contents of C45 1.1500, and other similar registers.

To avoid race conditions, maybe some of these commands need combining. 
ethtool --phy-test eth1 tx-prbs prbs7 rx-prbs prbs7 bert start

The configuration is then atomic, with respect to the uAPI, so we
don't get two users configuring it at the same time, ending up with a
messed up configuration.

Traditionally, Unix does not offer a way to clear statistic counters
back to zero. So i'm not sure about clear-stats. We also need to think
about hardware which does not support that. And there is locking
issues, can the stats be cleared while a test is active? 

You need to think about the units for inject errors. There is no
floating point support. Also, is this corrupt packets? Or single bit
flips in the stream? It needs to be well defined what it actually
means. The driver can then convert it to whatever the hardware
supports. How does 802.3 specify this?

Also, 802.3 defines PRBS7 as a benign pattern. With a quick look, i
did not find a definition of benign, but injecting errors does not
seem benign to me.

I'm assuming when 'start' is used, the networking core will change the
interface status to IF_OPER_TESTING. It is not always obvious why an
interface is in testing mode, rather than IF_OPER_UP. Cable testing
could also be running, etc. So maybe there needs to be a way to report
why it is in IF_OPER_TESTING?

I also wounder if a timeout should be used with start, so that it will
return to IF_OPER_UP after a time period?

       Andrew



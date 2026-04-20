Return-Path: <netdev+bounces-279890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCgBOE5r5mmBwAEAu9opvQ
	(envelope-from <netdev+bounces-279890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:07:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 808BF432787
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A399531E4A70
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 17:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB0D3A7F4E;
	Mon, 20 Apr 2026 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="unXwWick"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F543537C8
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776707865; cv=none; b=rIkaVxePCFWHRplM6KLDZvNhrT+zEqDO3GMhNd8UMeakbLtgyyGX9iCEv17HODCBvIfZdlDMINXY7WMKvAaYjC/cymS0eNAVhbC7opQ2eVRrXRkIHFA96psRQvJOa1OxEUvYvbxvEs3AVGx82QM298K+lbov3Bg/QqS0hC4y95I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776707865; c=relaxed/simple;
	bh=IeoXm41MdbjQ+hHRP6tDYab53a1GZE5Jaecd2MtutQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPVh2VGP4PvtgKbkSrensb6os1qxQdykNW429PsyxFQcmpwcL8r8f93JoDbrky94lnpPpR/kObX2aDLacTbH/L6qjkCmD5h/yWRwbMWaaxlLjCYlsYmsAkVESaZjLe8VDhisJgTo1iumLrIC1+H+eSXWfMuJjPAuRLizeM4oxak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=unXwWick; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rSTyCwpRdH76BmwFS6jZFtMPyVKVsP9HMXJbTLjUDIc=; b=unXwWickz01+FbkVRZ8oRouR5I
	NZLExE87A0y18ETwNOiptD/Zpl6fwUll8fhBhBtT+poLHBeJZik3vXkWs2wdetkuUAk5hvHgldTeE
	qKjmMACCKP9PTSeZ42PqQHVQo+nF8zHTHL6I8J/ICUEpHyMYPNIj1Bz7TaEKKGf0pVzY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wEssL-00Gmtj-F6; Mon, 20 Apr 2026 19:57:37 +0200
Date: Mon, 20 Apr 2026 19:57:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: markus.stockhausen@gmx.de
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, netdev@vger.kernel.org,
	'Jonas Jelonek' <jelonek.jonas@gmail.com>, jan@3e8.eu, nbd@nbd.name,
	'Daniel Golle' <daniel@makrotopia.org>
Subject: Re: pre-boot plugged SFP autoneg advertisement
Message-ID: <664e6e24-4a94-43fa-8769-773a37a01c66@lunn.ch>
References: <007c01dccf15$9b4622c0$d1d26840$@gmx.de>
 <90958cc3-e291-44ff-8fc3-102c0f62a269@lunn.ch>
 <007701dcd0e1$11c45210$354cf630$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007701dcd0e1$11c45210$354cf630$@gmx.de>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,gmail.com,vger.kernel.org,3e8.eu,nbd.name,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-279890-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.11:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 808BF432787
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 06:16:34PM +0200, markus.stockhausen@gmx.de wrote:
> > Von: markus.stockhausen@gmx.de <markus.stockhausen@gmx.de> 
> > Gesendet: Sonntag, 19. April 2026 10:49
> > An: 'Andrew Lunn' <andrew@lunn.ch>
> > Betreff: AW: pre-boot plugged SFP autoneg advertisement
> >
> > Took that hint/question and digged deeper. Added further debug
> > to each and every linkmode_copy. I think I found the culprit in 
> > a userspace ethtool call. For now I assume OpenWrt netifd.
> 
> Hi Andrew,
> 
> once again thanks for your help. After further investigation I hopefully can
> add 
> more details. I think I got the whole picture now. So some additional
> background 
> information about the environment. 
> 
> - Realtek RTL930x devices with SFP+ module slots
> - These are driven directly by a SerDes (controlled by downstream PCS
> driver)
> - The DTS reads
> 
> 	port11: port@11 { 
> 		reg = <11>;
> 		label = "lan12" ;
> 		pcs-handle = <&serdes8>;
> 		phy-mode = "1000base-x";
> 		sfp = <&sfp1>;
> 		managed = "in-band-status";
> 	};
> 
> Sequence of events during boot is as follows:
> 
> - SFP module is already inserted (in my case 1G)
> - phylink_sfp_config_phy() runs long before any network config starts
> - OpenWrt netifd daemon starts and wants to configure the network interfaces
> - It reads current settings via ethtool ioctl and gets autoneg=off
> - It writes basic config values via ethtool ioctl including autneg=off
> - Later on it starts the interface and phylink_start() is issued

I would say netifd is not optimal. I'm not sure we every agree to
return the full ksetting on an interface which is admin down. Many
driver don't even connect to the PHY until open is called, and so are
likely to return -ENODEV. See phy_ethtool_set_link_ksettings().

Could you look into the behaviour of netifd, especially if it gets
-ENODEV during the first read. Does it try again after setting the
interface up?

Could you disable netifd and manually configure the interface up. Does
it get autoneg correct then?

Now, i think it is useful to be able to configure an interface when it
is admin down. So if ksetting_get does not return -ENODEV it probably
should return the full and correct information. However, im not sure
your change is sufficient to do that, since what an interface can
actually do is the common subset of what the MAC, PCS and SFP can
do. So just taking the value from the SFP does not feel correct to me,
at least not without having a deeper understanding of what phylink is
doing. And Russell King is busy with other things are the moment.

So i think we are looking at multiple problems/solutions here:

netifd should does a second ksettings_get after setting the interface
admin up, and reevaluates how the interface should be configured.

If we know phylink is going to return a subset of the correct
information when the interface is admin down, maybe it should return
-ENODEV?

Is it possible in general to make phylink return the full correct
ksetting when start() has not been called. We need to think about
multiple use cases here, not just an SFP, but also a PHY, a fixed link
and a BASE-T PHY inside an SFP module. Maybe it needs to sometimes
return -ENODEV, other times it can return correct information?

       Andrew


Return-Path: <netdev+bounces-257620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJBiFVcbhmlNJwQAu9opvQ
	(envelope-from <netdev+bounces-257620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 17:48:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8537C100866
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 17:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6779230028FE
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 16:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5893A32D43C;
	Fri,  6 Feb 2026 16:43:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A3427E1D7;
	Fri,  6 Feb 2026 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770396213; cv=none; b=PcISIOI38XZ8YxU721ZzKVffTV3G/9eIwnb+u+9YWDVmMLSdXZPE7n7pU6UL1Ln7HNTvb6CavBkHqfDoqUdYpOumRz25LeRhgg8gQ5tW9bTie9S7ZAHaoWndoUUkYYjMuHJgA9JBYV3q8Cwstf1DxxRZ1ETcMMpMLwxd7L5wLH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770396213; c=relaxed/simple;
	bh=4D+j56nscZZ81Cfld4fZ5xRP/szgePCMLc1/wT12BJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oI8zlspkRr52kgGFZVo/nX1kbNHDmZQTEbGFNxzQeuDX5BPc9rT7lB09NA3rZoCOpFl5kvf4L7ulFn6hU5A7ZpMDff9rYL/uE+AtPf/ThNJ2HIZ1wTIYNjPDnUIE2+6yGoul++pIrIR5Bb0SszF8HhZhqspMpNkDch+w0Q704y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1voOvT-0000000013J-1XmG;
	Fri, 06 Feb 2026 16:43:23 +0000
Date: Fri, 6 Feb 2026 16:43:19 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>, John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v13 4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <aYYaJ4Yp_MAQ0eqw@makrotopia.org>
References: <cover.1770211259.git.daniel@makrotopia.org>
 <2da8267175bfe7b8ff92d67ba5aa88755fab1710.1770211259.git.daniel@makrotopia.org>
 <20260205182117.41618f8d@kernel.org>
 <aYVckqToPwzR75EO@makrotopia.org>
 <20260206133418.vxui223u4d6jdpql@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206133418.vxui223u4d6jdpql@skbuf>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-257620-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.920];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8537C100866
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 03:34:18PM +0200, Vladimir Oltean wrote:
> On Fri, Feb 06, 2026 at 03:14:26AM +0000, Daniel Golle wrote:
> > Hi Jakub,
> > 
> > thank you for looking into this driver another time.
> > 
> > On Thu, Feb 05, 2026 at 06:21:17PM -0800, Jakub Kicinski wrote:
> > > On Wed, 4 Feb 2026 13:33:19 +0000 Daniel Golle wrote:
> > > > +/* The switch firmware expects all structs to be byte-aligned */
> > > > +#pragma pack(push, 1)
> > > 
> > > "Byte-aligned" means..? Generally aligned means that it starts
> > > at an address which is multiple of X. All addresses are multiple of 1
> > 
> > In case fo the firmware running on this switch it means that data types
> > used in structures used as input and output parameters for firmware
> > functions should be aligned to 8 bits, without any additional padding in
> > between.
> > 
> > struct foo {
> > 	u8	var1;
> > 	__le16	var2;
> > 	__le32	var3;
> > } __packed;
> > 
> > It's size is 7 bytes and it looks like this:
> > 
> > .||||||||.||||||||.||||||||.||||||||.||||||||.||||||||.||||||||.
> > |  var1  |       var2      |                var3               |
> > .        .   LSB  .   MSB  .  LSB                         MSB  .
> > 
> > 
> > This is what the firmware on the other end expects, from all data sent
> > to it and what the Linux host has to expect from all data received from
> > it.
> > 
> > > We used you push back against blanket __packed because it's forcing
> > > all *host* accesses to also assume that the structures are unaligned.
> > 
> > Understand that in general, and of course know that using packed structs
> > without a hardware requirement of doing so needlessly wastes CPU cycles
> > on each access to struct members.
> > 
> > However, in this case this is a header file which exclusively defines
> > structs which are only used to communicate with the firmware running on
> > the switch. Using them for anything else, such as storing or processing
> > data the driver deals with internally is, very inconvenient because all
> > types are also defined as little-endian, so not only unaligned access,
> > but also endian conversion burdens every access (in the sense that it
> > burdens the programmer on little-endian machines, but the CPU as well on
> > big-endian machines).
> > 
> > tl;dr: This whole file is only API definition. And this is how the
> > firmware API is defined, and that's the only way to deal with that
> > switch.
> > 
> > (I would have preferred if they just exposed the internal 16-bit
> > registers of the switch via MDIO, and have asked MxL for that several
> > times, without success)
> > 
> > > The best practice is to pack only specific structs which need it
> > > and add compile_assert()s to make sure that the compiler doesn't add
> > > any padding.
> > 
> > Imho checking whether each of these structs is naturally packed (ie.
> > 8-bit aligned without padding between 8-bit aligned members) is prone to
> > human errors which only become visible when testing on the real
> > hardware, and hence complicates maintainance.
> > 
> > Other drivers which operate on similar APIs (many GPU drivers, for
> > example) also use #pragma pack(push, 1) in header files defining
> > external API. Also there all external API definitions are kept in a
> > separate file, away from any of the datastructures used by the driver
> > internally at runtime.
> > 
> > Anyway, if you really really want me to set individual __packed for each
> > struct which isn't naturally packed in this whole file, please tell me
> > clearly that this is what you would like, and I will of course do it
> > despite disagreeing with the reasoning.
> 
> When I created the pack_fields() API it was exactly for situations like
> this. It helps you keep naturally aligned structures in native CPU
> endianness while adapting to whatever quirks the peripheral you're
> talking to has.

I've spent an hour studying the pack_fields() API and it's (well
written) documentation. The only example of it's use in the current
kernel I could find is the Intel E800 (ICE) driver. And there it does
make sense as it is handling conversion between CPU and hardware formats
in the hotpath for DMA descriptors, a total of 3 different structs, each
with their individual accessor functions.

Using this approach for this switch driver would require writing a lot
of boilerplate code, accessor functions for each and every struct,
and a struct definition once unpacked for the host platform and then
again using the PACKED_FIELD(...) notation for the hardware format.
Surely, most of that could be auto-generated using the existing
vendor drivers API definition. Yet (at least to me) it feels like
over-engineering and also it would require rewriting most of the driver
which has been discussed for almost 2 months now.

Also note that the driver doesn't need the naturally aligned version of
all these structs in native CPU endian -- they are not used for further
processing anything, you can see that because they aren't ever used as a
function parameters, but only ever as exchange formats when
communicating with the firmware.

Maybe I'm missing something obvious here and there is a more simple way
to use this API, some generic macros using compiler introspection to
magically handle everything without needing to write packed and unpacked
struct definitions and individual pack/unpack boiler-plate functions for
each struct. If so, please provide me with an example or explain how you
imagine the pack_fields() API to be used in the context of this driver
and it's total of at more than 30 different structs which will be used
for all the different firmware function I will need to use in order to
implement phylink_pcs as well as the various offloading and VLAN-related
functionality the driver should have in the end (ie. the structs you
currently see in the mxl862xx-api.h file are just a fraction of what I
hope to add there by follow-up series)



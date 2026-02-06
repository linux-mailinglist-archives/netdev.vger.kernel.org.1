Return-Path: <netdev+bounces-257454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LBgD2FghWmbAwQAu9opvQ
	(envelope-from <netdev+bounces-257454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:30:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F3BF9C07
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE3AF3003BE6
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 03:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD77C2D9787;
	Fri,  6 Feb 2026 03:30:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B36717AE11;
	Fri,  6 Feb 2026 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770348636; cv=none; b=M+trGJpUCbTH7hEHcAFUv7EZhp8/mxpFioSgx6coBc2yaxaDqW7vC6orOvAqk8mfEBOQNeVrCSLZJlCz4VOtP+KyjHUYdRxRmHsfV/qTH9L6QtwfEzC8bwPsf76o1wKGn/RkjhoGhIf13LwTwTNaGKncD8X8c/AtkGQvbDWKK0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770348636; c=relaxed/simple;
	bh=OlW2KzbKt1EZxW2BMZFxxdZ/fOjAgLS0vc9+chSiew0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOJpJQK7UQVo/ReTDHhf76g6arq2SegAbA/PRhSTFGsA7wkfh+dAWcPgYQqOvOK2G4gfiwlE2aLNyhh5HoEcZO49sDg9+wanOBH029UkSR5b9qGKyDGmwBvpTI8j9Rg/tiT5p5hX8jiagzHPmkQhl5J0J4kr5UpFD2NnzRZaDO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1voCYD-000000005yz-2S0t;
	Fri, 06 Feb 2026 03:30:33 +0000
Date: Fri, 6 Feb 2026 03:30:30 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
	conor+dt@kernel.org, krzk+dt@kernel.org, chad@monroe.io,
	devicetree@vger.kernel.org, lxu@maxlinear.com, frankwu@gmx.de,
	linux@armlinux.org.uk, john@phrozen.org, robh@kernel.org,
	cezary.wilmanski@adtran.com, hkallweit1@gmail.com, horms@kernel.org,
	edumazet@google.com, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, olteanv@gmail.com
Subject: Re: [net-next,v13,2/4] net: dsa: add tag format for MxL862xx switches
Message-ID: <aYVgVgf3nemHNSEF@makrotopia.org>
References: <82706bbd489b5c68699060630ec6577f9aefb849.1770211259.git.daniel@makrotopia.org>
 <20260206022134.3185316-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206022134.3185316-1-kuba@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257454-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,kernel.org,monroe.io,maxlinear.com,gmx.de,armlinux.org.uk,phrozen.org,adtran.com,gmail.com,google.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	DMARC_NA(0.00)[makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:url,makrotopia.org:mid]
X-Rspamd-Queue-Id: 63F3BF9C07
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 06:21:34PM -0800, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: dsa: add tag format for MxL862xx switches
> 
> This patch adds a DSA tag driver for MaxLinear MxL862xx switches. The
> tag format uses an 8-byte header with an ethertype marker that is shared
> with GSW1xx switches, though the format itself differs.
> 
> > diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
> > --- a/net/dsa/Kconfig
> > +++ b/net/dsa/Kconfig
> > @@ -104,6 +104,13 @@
> 
> [ ... ]
> 
> > +config NET_DSA_TAG_MXL_862XX
> > +	tristate "Tag driver for MxL862xx switches"
> > +	help
> > +	  Say Y or M if you want to enable support for tagging frames for the
> > +	  Maxlinear MxL86252 and MxL86282 switches using their native 8-byte
>           ^^^^^^^^^
> 
> This isn't a bug, but there's inconsistent capitalization here. The help
> text uses "Maxlinear" while the adjacent NET_DSA_TAG_MXL_GSW1XX entry uses
> "MaxLinear" (with capital L). The MODULE_DESCRIPTION in tag_mxl862xx.c also
> uses "MaxLinear".

+1 Will fix that.

> 
> > +	  tagging protocol.
> 
> > diff --git a/net/dsa/tag_mxl862xx.c b/net/dsa/tag_mxl862xx.c
> > --- /dev/null
> > +++ b/net/dsa/tag_mxl862xx.c
> > @@ -0,0 +1,110 @@
> 
> [ ... ]
> 
> > +static struct sk_buff *mxl862_tag_xmit(struct sk_buff *skb,
> > +				       struct net_device *dev)
> > +{
> > +	struct dsa_port *dp = dsa_user_to_port(dev);
> > +	struct dsa_port *cpu_dp = dp->cpu_dp;
> > +	unsigned int cpu_port, sub_interface;
> > +	__be16 *mxl862_tag;
> > +
> > +	cpu_port = cpu_dp->index;
> > +
> > +	/* target port sub-interface ID relative to the CPU port */
> > +	sub_interface = dp->index + 16 - cpu_port;
>                         ^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Can sub_interface overflow the 5-bit MXL862_SUBIF_ID field here? With
> dp->index = 16 and cpu_port = 0, the calculation would yield 32 which
> exceeds the valid range (0-31) for GENMASK(4, 0). FIELD_PREP would silently
> truncate this to 0 via masking. Is there a constraint on port configurations
> that prevents this from occurring?

Yes. Only the two SerDes interfaces (port 9 and port 13) can be used as
CPU ports. Also, when using a USXGMII-M 4-port PHY, it is recommended to
connect the PHY to SerDes 1 (port 9 to 12) while using port 13 as CPU
port.

Addressing port 16 is problematic when using the switch with DSA also
because the 4-bit EGP/IGP field used in the receive function can only
present port 0 to 15 obviously. There is a way to do it by also using
the sub-interface ID on switch-to-host tagged frames, but it is worth
avoiding that due to the performance hit which comes with the additional
lookup and multiple pointer dereference steps required when doing so.

As there are only disadvantages when using SerDes 1 for a USXGMII-M
quad-PHY while using SerDes 0 as CPU port it is reasonable to expect
that board designers will opt for the convenient and also
vendor-recommended way and use SerDes 0 for the quad-PHY while using
SerDes 1 as CPU port.

Hence this theoretical limitation will play no role in practise.

> 
> > +
> > +	/* provide additional space 'MXL862_HEADER_LEN' bytes */
> > +	skb_push(skb, MXL862_HEADER_LEN);
> 
> [ ... ]
> 
> > +	dsa_alloc_etype_header(skb, MXL862_HEADER_LEN);
> > +
> > +	/* special tag ingress */
>                       ^^^^^^^
> 
> This comment says "ingress" but mxl862_tag_xmit() is the TX/egress path.
> Should this say "egress" instead?

"ingress" is the perspective of the switch, and how the tag to be used
to send frames from the host to the switch is called in the datasheet[1]

[1]: https://www.mouser.com/datasheet/2/146/621181_MxL86282I_DS_Rev1_1-3675315.pdf
     page 95



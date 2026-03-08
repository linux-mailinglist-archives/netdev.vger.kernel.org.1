Return-Path: <netdev+bounces-265312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BlSJzeUrWlH4gEAu9opvQ
	(envelope-from <netdev+bounces-265312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 16:22:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E785230EE7
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 16:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17BC9304A596
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 15:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4A621257F;
	Sun,  8 Mar 2026 15:19:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE36A1F4181;
	Sun,  8 Mar 2026 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772983158; cv=none; b=IXdSjQtz5NAVM94gPWyGthdP8fPo5ProIEMegWHRnTo4Mtau0i40W01mSS3r88jcquKqdRShEdTpkJRskWuQmDpTpKwZGmDHZD5d57JefGnZjr/H2fCor8QaCMP6aWGqLfrp4URoQDwVzuUw3cJNxF6pztvv4qCkPUs9NK8/yRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772983158; c=relaxed/simple;
	bh=acBv3VbP9SzjRO66t5HLGnGIKuxwF5A2AiO8VDY+Hb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYVDlIw0GbJLvkMx+sIrV5b4s4Oq+sLyefuVBWd1Z/lxyjjo49yte6WcrkmqxIoMElOyBNoL4vIWFO5yEyhG0+mfh2Sp/8XHplI4/tUvXqahc3nwX4UlGc7f1AaDbF+3QtWMnSrNhRzEXagi74xGW8yKAvbDSLQjEaLddc8G3I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vzFuI-000000000ND-2gX4;
	Sun, 08 Mar 2026 15:19:02 +0000
Date: Sun, 8 Mar 2026 15:18:59 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Wunderlich <frankwu@gmx.de>,
	Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next 1/2] dsa: tag_mxl862xx: set
 dsa_default_offload_fwd_mark()
Message-ID: <aa2TYxEHQ91SbT3A@makrotopia.org>
References: <cover.1772853341.git.daniel@makrotopia.org>
 <d9d8e6058e635c1fdd4689c875204d48d0235295.1772853341.git.daniel@makrotopia.org>
 <3bee5ef1-0692-4779-832f-193017810c38@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bee5ef1-0692-4779-832f-193017810c38@gmail.com>
X-Rspamd-Queue-Id: 0E785230EE7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-265312-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.306];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,makrotopia.org:mid,makrotopia.org:email]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 10:57:56AM +0100, Jonas Gorski wrote:
> Hi,
> 
> On 07/03/2026 04:30, Daniel Golle wrote:
> > The MxL862xx offloads forwarding between bridged ports to the
> > hardware, so set dsa_default_offload_fwd_mark() to avoid duplicate
> > forwarding of packets of (eg. flooded) frames arriving at the CPU
> > port.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  net/dsa/tag_mxl862xx.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/net/dsa/tag_mxl862xx.c b/net/dsa/tag_mxl862xx.c
> > index 01f2158682718..c02f69de61cbb 100644
> > --- a/net/dsa/tag_mxl862xx.c
> > +++ b/net/dsa/tag_mxl862xx.c
> > @@ -92,6 +92,8 @@ static struct sk_buff *mxl862_tag_rcv(struct sk_buff *skb,
> >  	skb_pull_rcsum(skb, MXL862_HEADER_LEN);
> >  	dsa_strip_etype_header(skb, MXL862_HEADER_LEN);
> >  
> > +	dsa_default_offload_fwd_mark(skb);
> 
> Does the switch (by default) also flood link local traffic (e.g. STP, LACP,
> etc)? If not, you should not mark these as fwd offloaded.

No, it doesn't. Testing revealed that apparently it silently consumes them.
I assume we'll need something like

if (likely(!is_link_local_ether_addr(eth_hdr(skb)->h_dest)))
    dsa_default_offload_fwd_mark(skb);

similar to tag_brcm.c, right?

> Is there is a bit in the header that says whether a packet was flooded or
> trapped that you can check?

Earlier testing showed that frames arriving at the microcontroller under
some conditions are relayed to the DSA CPU port -- and are destinguishable
as such. However, there is not bit directly indicating whether the packet
was (also) flooded already.


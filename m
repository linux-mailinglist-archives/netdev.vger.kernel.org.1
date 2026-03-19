Return-Path: <netdev+bounces-269431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBEKD3rpu2kKqQIAu9opvQ
	(envelope-from <netdev+bounces-269431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 13:18:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DF42CB0CF
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 13:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 236E5301DE30
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6004D15E97;
	Thu, 19 Mar 2026 12:15:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5D540DFC6;
	Thu, 19 Mar 2026 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773922550; cv=none; b=FkHxuYAgV1D/19entvtOx58veEgfBpnThtKyx32znVuvu0J4jsMKDklbufT4uJPbU6uy6W0QdcPwxsoL4AKWV6MsYcnR0Af9bocFnK0OOQfqGMAtFT3EzF62TnDLqB1QfwJR296LPK24Hm9BMwHOrW7bhmvy1WWZMcDx6L6amCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773922550; c=relaxed/simple;
	bh=19XxAzhDrc1Owrbv6TTg91nZYH3hxDpmrtdg7QfCmPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RByoufN2AxSlWxuLn4JYr7W41JQXDmwugfRq5ZVqpuKB14/J/jLPtV9FnoqLxWYar4aGHznIuvqfuVyHo4flgLBK5iGNvFvwo3v+n6g35+P5FciE6mjhAQ1Je+0mbF+VNa3Tsj6iFXj/5fgOSbBENALoPqPlEs19mE6CWiD33nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w3CHv-000000003tB-0PvF;
	Thu, 19 Mar 2026 12:15:43 +0000
Date: Thu, 19 Mar 2026 12:15:39 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Wunderlich <frankwu@gmx.de>,
	Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v5 2/2] net: dsa: mxl862xx: implement bridge
 offloading
Message-ID: <abvo67rR_a-bPCkW@makrotopia.org>
References: <cover.1773591297.git.daniel@makrotopia.org>
 <0cf66a043eff3585270785a35e821e9a44afd6b6.1773591297.git.daniel@makrotopia.org>
 <fe46d64b-1b12-48b6-b663-e7d5122b7b8a@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe46d64b-1b12-48b6-b663-e7d5122b7b8a@redhat.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	TAGGED_FROM(0.00)[bounces-269431-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.453];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,makrotopia.org:mid]
X-Rspamd-Queue-Id: 96DF42CB0CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 09:57:42AM +0100, Paolo Abeni wrote:
> On 3/15/26 5:20 PM, Daniel Golle wrote:
> > (struct dsa_switch *ds, int port,
> > +				     struct dsa_bridge bridge,
> > +				     bool *tx_fwd_offload,
> > +				     struct netlink_ext_ack *extack)
> > +{
> > +	struct mxl862xx_priv *priv = ds->priv;
> > +	struct mxl862xx_bridge *mxlbridge;
> > +
> > +	mxlbridge = mxl862xx_find_bridge(ds, bridge);
> > +	if (!mxlbridge) {
> > +		mxlbridge = mxl862xx_allocate_bridge(ds, bridge.num);
> > +		if (IS_ERR(mxlbridge))
> > +			return PTR_ERR(mxlbridge);
> > +	}
> > +
> > +	__set_bit(port, mxlbridge->portmap);
> 
> AFAICS mxl862xx_bridge role is to track the above portmap, which in turn
> looks like a quite generic information which could be easily tracked by
> the DSA core. I'm wondering if it would be useful to move implement
> tracking there, and remove the mxl862xx_bridge entirely.

DSA generally uses unsigned int as port ID, however, 500MB of a bitmap
seems excessive to cover the full 32-bit range. 256-bit would be
more than sufficient (u8 range), or the 128-bit (positive s8 range)
the firmware of MxL862xx also uses...

So what should be the size of the to-be-defined generic DSA portmap?

Or should tracking happen internally using other (dynamic) structures
(eg. link list) and we provide a helper taking a driver-allocated
bitmap and its size as parameters?

The to-be-invented tracking structure should also come with a priv
pointer which can be used by the driver to (in this case) track the
firmware-assigned bridge ID as well.

Alternatively, instead of inventing a new structure, the driver could
iterate over dsa_ports which carries a pointer to dsa_bridge, and we
could just extend dsa_bridge to contain a priv pointer which allows
drivers to track what ever they want together with the DSA bridge.

Let me know what you think.


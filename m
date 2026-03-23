Return-Path: <netdev+bounces-270615-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDl2L511wWkQTQQAu9opvQ
	(envelope-from <netdev+bounces-270615-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:17:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6EE2F9AFC
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91C3C31921F4
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB6E3C2792;
	Mon, 23 Mar 2026 16:45:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2F93C1980;
	Mon, 23 Mar 2026 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284338; cv=none; b=b8DRBkeMaxf8UWg01n0bTJ4U/8w7/7wHmDgmM4HK4hhyde/DzAAbhnMssWhASA7pn3646Jm6kKJcs4TNqsh8UmHDH0IXY9yI6hrJS3pffZnpUYStlxbFOpjjVWgvGCucHfD4lzxeVx7gmXBIq+MeBx6wioD9GOZUv+wW+ln0M80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284338; c=relaxed/simple;
	bh=RdyaqyK9LYtMwNW/xDt1lbRE2JftZYrsHRh38HarS6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnRldXfPOP24UoPYKgilTXIhDbjq5rtlxka0xHX7pEMG8wEBDhx+ym0ALugLamVu0JuCPn9T9F4L08DSKohH8as5+tOXdAtHzYjp4nAjOrmGzcDOoyBO55T/ShQH0ejyceHSmZFR54lMVEUZ2S5RwxNQHLB59aKq24whWleCplA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w4iP3-000000000Ek-2HPG;
	Mon, 23 Mar 2026 16:45:21 +0000
Date: Mon, 23 Mar 2026 16:45:18 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
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
Subject: Re: [PATCH net-next v6 2/4] net: dsa: add bridge member iteration
 macro and port mask helper
Message-ID: <acFuHka4RdmAXm73@makrotopia.org>
References: <cover.1774136876.git.daniel@makrotopia.org>
 <ff936ce4ad3044102c367c55e7a455ab0020e4b7.1774136876.git.daniel@makrotopia.org>
 <acCllYmKczZrDgv9@makrotopia.org>
 <20260323163104.a2d2hbs7jfgsptj3@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323163104.a2d2hbs7jfgsptj3@skbuf>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	TAGGED_FROM(0.00)[bounces-270615-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1F6EE2F9AFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 06:31:04PM +0200, Vladimir Oltean wrote:
> On Mon, Mar 23, 2026 at 02:29:41AM +0000, Daniel Golle wrote:
> > I wasn't aware of the similar and equally named function in
> > yt921x.c[1]
> 
> Yeah, I did request from the beginning for it to be moved to
> include/net/dsa.h, but I didn't follow through with the request (I guess
> I forgot):
> https://lore.kernel.org/netdev/20250825212357.3acgen2qezuy533y@skbuf/
> 
> > Patchwork CI has loudly uncovered it and I've learned my lesson to
> > always test an all-y build when changing even the most innocent
> > looking things which technically may affect other drivers.
> 
> Since all DSA drivers are all in the same folder, technically you may be
> excused if you just enable all those when working on infra, instead of
> allyesconfig.
> 
> > I'll move that function as-is, in a dedicated commit, to
> > include/net/dsa.h as an inline function instead of the helper
> > suggested here.
> > 
> > A second commit will introduce the new helper macro
> > dsa_switch_for_each_bridge_member (modified to use (struct net_device
> > *) as parameter instead of (struct dsa_bridge *), and make use of it
> > in dsa_bridge_ports().
> > 
> > I'm also planning to introduce dsa_bridge_for_each_member macro in
> > addition to that which works on (struct dsa_bridge *) and uses
> > dsa_switch_for_each_bridge_member.
> 
> I don't like the dsa_bridge_for_each_member() name. You are likely
> not considering cross-chip bridging, where a bridge spans multiple
> dsa_switch structures. That is also a serious reason why your
> bridge->priv design is not viable (two switches can't lay their eggs
> in the same basket without overwriting each other).

That means the driver *does* have to track a mapping between DSA
bridges and hardware/firmware bridges on that specific switch somehow.

Or is there another existing structure in DSA I'm not aware of and
which could be used to implement Paolo's suggestion:

https://lore.kernel.org/netdev/fe46d64b-1b12-48b6-b663-e7d5122b7b8a@redhat.com/


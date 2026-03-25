Return-Path: <netdev+bounces-271490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIOFJXu+w2kRtwQAu9opvQ
	(envelope-from <netdev+bounces-271490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 11:52:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BBB323549
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 11:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80BE5318580E
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F943A8743;
	Wed, 25 Mar 2026 10:43:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55252750ED;
	Wed, 25 Mar 2026 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774435399; cv=none; b=OLQ1gGEJXY8zw3ZIUObFosDfgCRQp8z4NHS2zdbw03NDKt/29s/u5SVokc0AhgldP5cHvnVW9j6E+cvyRzFMG+Fdu/WS4t9QmS720Vopu8AGJ8PsXcWNo7dwcDCliYFOQiIVf0DJBZpz4Nq2ThtCgj+7oDVYTQfqPK8Vy3ZMfKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774435399; c=relaxed/simple;
	bh=/KKBO46fIiQfZJaoULyevUqcMISDb643GiOSYMjvEiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntjHxJ6qEtws3xgHaskIOOzoJo1w9I68eND9aTcVmc1M9iyj3CE94m4DfscFwqTcnvZ12zegrbrkm+/QmnN/Oqr9hOgBJHj3YsBa/Iyq7ewTbV6RHT1njm5pSJCBV9dvSk7RQFogivSF4WCCluaV/2JW/ulJGttZ1Fpq2jkKEEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w5Lhc-000000007kj-46hK;
	Wed, 25 Mar 2026 10:43:09 +0000
Date: Wed, 25 Mar 2026 10:43:05 +0000
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
Message-ID: <acO8OYhW2YH9eHiD@makrotopia.org>
References: <cover.1774136876.git.daniel@makrotopia.org>
 <ff936ce4ad3044102c367c55e7a455ab0020e4b7.1774136876.git.daniel@makrotopia.org>
 <acCllYmKczZrDgv9@makrotopia.org>
 <20260323163104.a2d2hbs7jfgsptj3@skbuf>
 <acMe0vr5GT8ZSfI3@makrotopia.org>
 <20260325083427.eef2dmpv6lnyvlmn@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325083427.eef2dmpv6lnyvlmn@skbuf>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-271490-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04BBB323549
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 10:34:27AM +0200, Vladimir Oltean wrote:
> On Tue, Mar 24, 2026 at 11:31:30PM +0000, Daniel Golle wrote:
> > On Mon, Mar 23, 2026 at 06:31:04PM +0200, Vladimir Oltean wrote:
> > > On Mon, Mar 23, 2026 at 02:29:41AM +0000, Daniel Golle wrote:
> > > > I'm also planning to introduce dsa_bridge_for_each_member macro in
> > > > addition to that which works on (struct dsa_bridge *) and uses
> > > > dsa_switch_for_each_bridge_member.
> > > 
> > > I don't like the dsa_bridge_for_each_member() name. You are likely
> > > not considering cross-chip bridging, where a bridge spans multiple
> > > dsa_switch structures. That is also a serious reason why your
> > > bridge->priv design is not viable (two switches can't lay their eggs
> > > in the same basket without overwriting each other).
> > 
> > dsa_bridge_for_each_local_member() ?
> > 
> > dsa_switch_for_each_dsa_bridge_member()
> > (but that's too close to dsa_switch_for_each_bridge_member imho)
> > 
> > I was planning to have both, dsa_switch and dsa_bridge as parameters,
> > of course, limiting the scope to a single dsa_switch.
> 
> I'm not sure that we do need two iterators. Just
> dsa_switch_for_each_bridge_member() should be fine.

Just for convenience. In my case, all callers always have a reference
to 'struct dsa_bridge *', so instead of having the callers dereference
'struct net_device *' from that, have a macro that does it for me.


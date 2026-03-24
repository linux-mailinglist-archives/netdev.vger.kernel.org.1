Return-Path: <netdev+bounces-271338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zPnlC+sew2knogQAu9opvQ
	(envelope-from <netdev+bounces-271338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 00:31:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB9931DBF6
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 00:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B06F4301C162
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 23:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A9C3090CD;
	Tue, 24 Mar 2026 23:31:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE081624DF;
	Tue, 24 Mar 2026 23:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774395110; cv=none; b=Bfr0SdUpfNOXgLir2YckfKOi71nPx2ShZDRYFs48CC0x2u1vsJK+oJ8FB1WmC9FCddrPQC31kwHiV2Xw3FkaIxe8kybwB1nub7N+vGpH61cIypLnvxtWFmGOG5CpsJU3VKaDBX2B53NCwesnHYrOwl3p8BEtgOonxZWDI6eZ3vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774395110; c=relaxed/simple;
	bh=FkWCAwi5D50TjF839k3QTQ8Sse/PwE7yi64JOZy7wK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPyJ8dgJ1HpfNezMEY6fSZdbpq8jWAYnFh3tFtUK1wupECUhXCDKxvBjFF3J/QDKPk92X59NmrdFqPms43Y5eCtW7014wke9hRI475sH47vc5A/ms3GT0Cm4pG9MEa9621tyv52bAIMiJhEWOrGbprGTeAbfrcbg3ueJ3dHU4Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w5BDh-000000003Fe-3wwA;
	Tue, 24 Mar 2026 23:31:34 +0000
Date: Tue, 24 Mar 2026 23:31:30 +0000
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
Message-ID: <acMe0vr5GT8ZSfI3@makrotopia.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-271338-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 7CB9931DBF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 06:31:04PM +0200, Vladimir Oltean wrote:
> On Mon, Mar 23, 2026 at 02:29:41AM +0000, Daniel Golle wrote:
> > I'm also planning to introduce dsa_bridge_for_each_member macro in
> > addition to that which works on (struct dsa_bridge *) and uses
> > dsa_switch_for_each_bridge_member.
> 
> I don't like the dsa_bridge_for_each_member() name. You are likely
> not considering cross-chip bridging, where a bridge spans multiple
> dsa_switch structures. That is also a serious reason why your
> bridge->priv design is not viable (two switches can't lay their eggs
> in the same basket without overwriting each other).

dsa_bridge_for_each_local_member() ?

dsa_switch_for_each_dsa_bridge_member()
(but that's too close to dsa_switch_for_each_bridge_member imho)

I was planning to have both, dsa_switch and dsa_bridge as parameters,
of course, limiting the scope to a single dsa_switch.



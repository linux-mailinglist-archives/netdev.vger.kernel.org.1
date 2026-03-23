Return-Path: <netdev+bounces-270753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOQDJfi0wWnlUgQAu9opvQ
	(envelope-from <netdev+bounces-270753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:47:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 403022FDEBD
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 629E3300FED3
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69163806D5;
	Mon, 23 Mar 2026 21:47:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AADE304BDC;
	Mon, 23 Mar 2026 21:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774302450; cv=none; b=jlZIYiGB3CUPZMNpgHvz5jIHuw6gxs6PGDgbbKtDuvEW+oKLtmxb6oZYSXx05IIokc8ThlxN3Z21dp6Vp8yy68SBLOmLwntZ8OZnb8/s3nBFBxj3XG95fw3ybcwF6+Dg5RWNHFbQxf2ONEq75lEMKs3IScuXtg0yAIKW8ZWdJR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774302450; c=relaxed/simple;
	bh=mPI5Ov8iFnJNWxqhvU3QELhRwgMQQR5ozF0+mW1NKek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgfgpWQabQOeLRb56moGoqoxRi9jML6oDh91oErh0OGFawg/CkI5kwUQAdQmU5syQ7c3ZFaRpGpd9iGp4AmiAgKx1oDJcUsD5aVJz1L8Y6sMnj2IaBJLnIfubLICYFsovfKzODro60Bp/fbodhXJwVifptg+RIUGnMv7S9Ee4xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w4n7I-0000000021C-1Kln;
	Mon, 23 Mar 2026 21:47:20 +0000
Date: Mon, 23 Mar 2026 21:47:16 +0000
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
Message-ID: <acG05C2ktiGePhQE@makrotopia.org>
References: <cover.1774136876.git.daniel@makrotopia.org>
 <ff936ce4ad3044102c367c55e7a455ab0020e4b7.1774136876.git.daniel@makrotopia.org>
 <acCllYmKczZrDgv9@makrotopia.org>
 <20260323163104.a2d2hbs7jfgsptj3@skbuf>
 <acFuHka4RdmAXm73@makrotopia.org>
 <20260323211536.iqopuy2zxd75pfbh@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323211536.iqopuy2zxd75pfbh@skbuf>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-270753-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 403022FDEBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 11:15:36PM +0200, Vladimir Oltean wrote:
> On Mon, Mar 23, 2026 at 04:45:18PM +0000, Daniel Golle wrote:
> > That means the driver *does* have to track a mapping between DSA
> > bridges and hardware/firmware bridges on that specific switch somehow.
> 
> That's correct. From DSA's perspective, it's not an mxlbridge, it's just
> a bridge with at least one DSA switch port under it, which is given a
> kernel-wide identifier. The ports can hold a single reference to the
> common bridge, but the common bridge cannot hold a single back-reference
> to individual ports. And holding multiple references would severely
> complicate the implementation.
> 
> Even if you don't implement accelerated cross-switch bridging, you can
> still have two mxl ports belonging to different switches that are both
> put by the user under the same bridge. And both switch driver instances
> would want to allocate a potentially different bridge ID, and surely
> maintain a different portmap, for that same bridge.
> 
> > Or is there another existing structure in DSA I'm not aware of and
> > which could be used to implement Paolo's suggestion:
> > 
> > https://lore.kernel.org/netdev/fe46d64b-1b12-48b6-b663-e7d5122b7b8a@redhat.com/
> 
> The API was intended so that you could either use the bridge.num directly,
> transform it through some linear formula or as an index into a privately
> maintained array of data structures with switch-specific meaning.
> 
> I didn't question why you maintain a parallel list of dynamically
> allocated mxlbridge structures instead of just having an array of
> MXL862XX_MAX_BRIDGES * sizeof(u16) for the bridge identifiers, plus
> maintain a separate portmap instead of walking through the DSA data
> structures, but now that Paolo brought it up: why?

The firmware requires bridges to be allocated, and the bridge
allocation firmware API returns the ID we got to use.

Maintaing a simple array ((ds->max_num_bridges + 1) * sizeof(u16))
to map DSA bridge num to firmware bridge ID in the driver works
fine, of course.

Regarding the request not to maintain a separate portmap for each
bridge (which was my initial approach) but instead walk through DSA
data:

My guess was the intention is to avoid duplciating data, as in: if
there is only one copy, we can be sure it's not stale or
out-of-sync...? But that's just my guess, only Paolo can tell his
reasons for having requested that.

> 
> I see in v6 you're halfway there with the conversion, you got rid of the
> portmap and you could just use the array for the rest.

Ack. I'll do that and post v7.


Return-Path: <netdev+bounces-296787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x3tXEU5XJ2rtuwIAu9opvQ
	(envelope-from <netdev+bounces-296787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 01:59:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D3865B3E3
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 01:59:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ABy1IeMI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296787-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296787-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84C8E308C91D
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 23:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1618B2EA75E;
	Mon,  8 Jun 2026 23:58:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E59F2D73A6
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 23:58:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780963109; cv=none; b=IT7fOR0qoESVnLCLa/L2a75ooAd5A7JO86/sN+kTnaniH6hxKWYWGwATPfNvwtuOhI/Ie9xZALannluuxi5QSr4vl+hn6QWKS6DFfbn6YgLWAtm1qVl65qo/GsGhZFHe5TpgT+8fiLdIxq0mPBdA2Vr1z3xXghK/WIxij5B6up8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780963109; c=relaxed/simple;
	bh=VK7Vqow+LqCery+/hsHgtw8qYAMwYsSWaSrW7ccFX/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZ6eeQLN0XefBpW/SrZSjun/fCFze7v/qbfWg/2tt1DOkuusW9nj9RGn1UsgxqEypLWT5IGesEvPgo4BjaIjLL/G1IkN6rSLcitn55+A/2WHJG5T4Zl/8hH1SSeAK1RFMKeFspWTU4rs7MisGuapeNs9HVBPRyjeqzoqApXzGS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABy1IeMI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053341F00893;
	Mon,  8 Jun 2026 23:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780963107;
	bh=SpuO1pUoTIrSq1m5OY7yRHg7Tt7TntzPrjMkqWCxi7I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ABy1IeMIu38/22RtGd/Zcr1xfUCr2WSirekSf1B9bUzvCJk1OqV3vufmuJICClxSS
	 Og/X1/9rsCFMRxEZl40MlVZ00TbLdynqPCWF4xDEeGvOzU0FZ4ygmchEg54dVGOm4W
	 dVA7SteMYjjx1urtwTgQ4bCrZrKFsb2gD0gyuxwsvTOowU7JIc9pLYMJqcCWcV9YkS
	 frzrqph3LJqf+HgsTavZpK/e9oVZzR3SqBhWsKrNte5Soov184WfblVnATZegNx4/r
	 v4CKr1fc7NGxuWhiockONbi3UD/lEPNmWgEFSNC1DNW9XHbr/9JJ7L78ZqeITlUO33
	 rxxLdA4ceUThA==
Date: Mon, 8 Jun 2026 16:58:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
 <michael.chan@broadcom.com>, <hkallweit1@gmail.com>,
 <maxime.chevallier@bootlin.com>, <joshwash@google.com>,
 <tariqt@nvidia.com>, <alexanderduyck@fb.com>, <willemb@google.com>,
 <kory.maincent@bootlin.com>, <sdf.kernel@gmail.com>,
 <jakub@cloudflare.com>, <nb@tipi-net.de>
Subject: Re: [PATCH net-next v2 05/12] net: ethtool: optionally skip
 rtnl_lock on Netlink path for SET ops
Message-ID: <20260608165826.2525b726@kernel.org>
In-Reply-To: <ce45017d-8caf-4b4c-b04a-44806bcf5e72@intel.com>
References: <20260605002912.3456868-1-kuba@kernel.org>
	<20260605002912.3456868-6-kuba@kernel.org>
	<ce45017d-8caf-4b4c-b04a-44806bcf5e72@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296787-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jacob.e.keller@intel.com,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,nvidia.com,fb.com,cloudflare.com,tipi-net.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5D3865B3E3

On Mon, 8 Jun 2026 15:15:48 -0700 Jacob Keller wrote:
> > @@ -935,7 +935,13 @@ struct kernel_ethtool_ts_info {
> >   * these bits separate, per GET and SET. GET is much easier to "unlock".
> >   */
> >  #define ETHTOOL_OP_NEEDS_RTNL_LINKSETTINGS	BIT(0)
> > -#define ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM	BIT(1)
> > +#define ETHTOOL_OP_NEEDS_RTNL_SPFLAGS		BIT(1)
> > +#define ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM	BIT(2)
> > +#define ETHTOOL_OP_NEEDS_RTNL_SCHANNELS		BIT(3)
> > +#define ETHTOOL_OP_NEEDS_RTNL_SCOALESCE		BIT(4)
> > +#define ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM	BIT(5)
> > +#define ETHTOOL_OP_NEEDS_RTNL_SPAUSEPARAM	BIT(6)
> > +#define ETHTOOL_OP_NEEDS_RTNL_RSS		BIT(7)  
> 
> Whats the reasoning for changing order here? Is this sorted somehow?

I went back and forth on this a little but at the end I wanted the GET
and SET bits to be next to each other (PAUSE ones specifically, that's
the only case where phylink forces us to add a GET bit).

> Would it make more sense to use an enum to define the bits instead so
> that patches don't have to do a -/+ of the same NAME?

We'd need to add enum for bit ids and then defines for BIT(id)?
Dunno, personally I don't really like that. And we never switch
on the values here so enum buys us little. Maybe BTF, that's about it?


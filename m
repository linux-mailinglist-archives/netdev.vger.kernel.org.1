Return-Path: <netdev+bounces-253835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMSpOICseGl9rwEAu9opvQ
	(envelope-from <netdev+bounces-253835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:16:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56530941BC
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4120300E3BB
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490411DFFD;
	Tue, 27 Jan 2026 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="RRLfU6Tz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10699.protonmail.ch (mail-10699.protonmail.ch [79.135.106.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FD2310771
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769516112; cv=none; b=NQWiub7V9L14IZGG16YpT+Q1FKEyTf5VXQzE9T11oVJRn8WBuUJ6bfmYgtZuWEPYNCzqllFDVCBAADtyIu9CjyC6FSDrGzg8DAH4jhw0u/dMopoQXX8Q+RtxqvF6QKSxjG/2P2VPvParmVpjJdkXGTgv56bkcV8qd6EN2zDBIig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769516112; c=relaxed/simple;
	bh=8IvF9whHf7JnvqOc2epbzBtRNfsqvAVpMBTb5tkzRBU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F2nK7Z1lzJ0vn7n0j2MVh6YCzAfgRk5px5dgQCeOR3LyO3f/UmaSD4+muSBLtnU2olswZykg2fm/JRb6FHZ6QsQ0CeGEghwLdhOlgfjbzOqBgkkEBLCJNUemwvvnjInW3ijpkB5OvQqDlk53zuzzHOLXGfifL3/Ejv2bXcAL/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=RRLfU6Tz; arc=none smtp.client-ip=79.135.106.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1769516101; x=1769775301;
	bh=8IvF9whHf7JnvqOc2epbzBtRNfsqvAVpMBTb5tkzRBU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RRLfU6TzqRddRtzOJJiyeFVvLd7bBFXpWPTBuy+Qis3f54ni4Fbi/1F9hSI4xBis1
	 exblp0fIKZLrPwQ7ge86j4fqW9pmQ1V6FOSGfgvzkL5OXHw+b71bdd5CLQhIvHKtqn
	 jQg+vbRgbREMpMP9TLfivGwbKDRQW3sIp/R1MumzgkXWi1P6LuyNR+iPnmR/EKe2xl
	 k8yveUdvYnnYYVLq+zN9l7+Je5Y+a7bFj2l+bsgHIWo5qNeAAerh64yrP6FCNYOpuH
	 1ZXWuzljqiddfKJZk3471Ed4B8T0ZDJIQUYU0WvIORBQQEsDU+Dm46DyO+ncWzkwI7
	 NKSACjwMWmv0A==
Date: Tue, 27 Jan 2026 12:14:56 +0000
To: Florian Westphal <fw@strlen.de>
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH v6 5/6] doc/netlink: nftables: Add getcompat operation
Message-ID: <Y2VtJPFWA2Kgxe16KslviULQU9LRZsdYFsoUD6VZ9CH-49a2P2fwiQ9B03i3Rmfq6tUczD-oiGpWCCs9aPGwwD2N-vVzy4cFIZT7F7-83Fc=@protonmail.com>
In-Reply-To: <aXiiYOxuXVn5YhXG@strlen.de>
References: <20260121184621.198537-1-one-d-wide@protonmail.com> <20260121184621.198537-6-one-d-wide@protonmail.com> <aXiiYOxuXVn5YhXG@strlen.de>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: 204d2a215ee0497f9b11ffb164a21565a103ffe6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253835-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,netfilter.org,nwl.cc];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[one-d-wide@protonmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[protonmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[protonmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 56530941BC
X-Rspamd-Action: no action

On Tuesday, January 27th, 2026 at 11:32, Florian Westphal <fw@strlen.de> wr=
ote:

> Remy D. Farley one-d-wide@protonmail.com wrote:
>=20
> > Signed-off-by: Remy D. Farley one-d-wide@protonmail.com
> > ---
> > Documentation/netlink/specs/nftables.yaml | 25 +++++++++++++++++++++++
> > 1 file changed, 25 insertions(+)
> >=20
> > diff --git a/Documentation/netlink/specs/nftables.yaml b/Documentation/=
netlink/specs/nftables.yaml
> > index 4b1f5b107..ce11312b9 100644
> > --- a/Documentation/netlink/specs/nftables.yaml
> > +++ b/Documentation/netlink/specs/nftables.yaml
> > @@ -1509,6 +1509,31 @@ sub-messages:
> > operations:
> > enum-model: directional
> > list:
> > + -
> > + # Defined as nfnl_compat_subsys in net/netfilter/nft_compat.c
> > + name: getcompat
> > + attribute-set: compat-attrs
> > + fixed-header: nfgenmsg
> > + doc: Get / dump nft_compat info
>=20
>=20
> Whats the intent here? nft_compat isn't used by nftables, this
> is iptables-nft compatibility glue.

I noticed getcompat operation used by `nft list ruleset` command, and it
doesn't seem to be defined anywhere else. Should I re/move it?


Return-Path: <netdev+bounces-256559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MRzCYrHgml9awMAu9opvQ
	(envelope-from <netdev+bounces-256559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 05:14:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6901FE1817
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 05:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9986F300C018
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 04:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13A133065C;
	Wed,  4 Feb 2026 04:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZyRmr68"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B5D32F759
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 04:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770178437; cv=none; b=HK06QRkjOSZIS87vUnMNraJivujumEPmW26uCXcj5y6tCYgA8RPJcpjcKv0bs6KR5A0yxV55djgtStjvRskOtjpc2bd/jv0NBqqZwhrj4wkpXbWRZ9l5fCSX4VINcOnh8i9SWmmruu+78v8Bp9xbVhJO6wsWFmN4ngweX8wgjLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770178437; c=relaxed/simple;
	bh=KKxKic9bFydxriupw9qy85sFhl9TNgXLirXtszfLGTo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oljU2pKkbXgl5+MX82E4P87ZrWVAwE/enK7foeubB9nuFs67QYDXjYxy4h7G2Yet7GY/kxJeQVd17XQ72ceV+G6FCSOF66eyMnV3jNc0ILdWDjQoLoQYZOdaQT6CuGZ8sHgA59swYVlXUZ9MswypKGhrRS4SBjCYnzjiI3uoHDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZyRmr68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30A3C19425;
	Wed,  4 Feb 2026 04:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770178437;
	bh=KKxKic9bFydxriupw9qy85sFhl9TNgXLirXtszfLGTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GZyRmr68ONxuNJTR/ymLN+QtYyr0puoM1AQolgckMAboauiTtmshkf5NiCeZaOVcM
	 f8N1FUfixFHxP23ORcSb4gUU3Ji19effwfRqOQe3phEaJD5yqXp5xVVgp6xfHzXN1A
	 xgwTG/UUFWc02K8LHpLNDMLDMSOWQlTSq7lRv+UnqHr1sreTaE6mUMYMyMR1e2EC1/
	 NrLgS+oes2FHHxbMppQRN+MiyyhtAL2nB13Z2b01hU9nmTmTvPu+9JGg9w7CmruXbz
	 YENwJN2gS29LsZQhzoFnREgg6CPTD4CroKHKpnQ9+tlAW7dShI+3R9/o+Bp9vvTd2s
	 g37OiFHsPIH9w==
Date: Tue, 3 Feb 2026 20:13:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: xuanzhuo@linux.alibaba.com
Cc: lorenzo@kernel.org, andrew+netdev@lunn.ch, pabeni@redhat.com,
 vadim.fedorenko@linux.dev, davem@davemloft.net, guwen@linux.alibaba.com,
 lulie@linux.alibaba.com, hkallweit1@gmail.com, edumazet@google.com,
 lukas.bulwahn@redhat.com, andrew@lunn.ch, dong100@mucse.com,
 dust.li@linux.alibaba.com, netdev@vger.kernel.org
Subject: Re: [net-next,v25,6/6] eea: introduce callback for ndo_get_stats64
Message-ID: <20260203201355.675b99cb@kernel.org>
In-Reply-To: <20260204040841.1703575-1-kuba@kernel.org>
References: <20260202090638.46836-7-xuanzhuo@linux.alibaba.com>
	<20260204040841.1703575-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,redhat.com,linux.dev,davemloft.net,linux.alibaba.com,gmail.com,google.com,mucse.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-256559-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6901FE1817
X-Rspamd-Action: no action

On Tue,  3 Feb 2026 20:08:41 -0800 Jakub Kicinski wrote:
> > +static void eea_stats(struct net_device *netdev, struct rtnl_link_stats64 *tot)
> > +{
> > +	struct eea_net *enet = netdev_priv(netdev);
> > +	u64 packets, bytes;
> > +	u32 start;
> > +	int i;
> > +
> > +	spin_lock_bh(&enet->stats_lock);  
> 
> Can this cause a deadlock? The enet_bind_new_q_and_cfg() and
> eea_free_rxtx_q_mem() functions use spin_lock(&enet->stats_lock), but
> eea_stats() uses spin_lock_bh(&enet->stats_lock).
> 
> If a thread holds stats_lock via spin_lock() (softirqs still enabled) and a
> softirq fires that calls eea_stats() through ndo_get_stats64, the
> spin_lock_bh() will attempt to acquire the already-held lock.
> 
> Should all acquisition sites use spin_lock_bh()/spin_unlock_bh() for
> consistency?

AI suggestion is semi-right here, just remove the _bh()
I don't think we actually read stats from BH.
We read them under RCU, which is atomic context but not BH.


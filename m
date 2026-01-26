Return-Path: <netdev+bounces-253517-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OPwDvOCd2m9hgEAu9opvQ
	(envelope-from <netdev+bounces-253517-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 16:06:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA6B89E93
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 16:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 828F43004041
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDAA271471;
	Mon, 26 Jan 2026 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSzEVxWI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF4E23EA80
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769439982; cv=none; b=ZQPhvjxoLWCQqywGRfYnukmpAxDKpNK/NwguK5brjjzsZmXDzGJ4FDWtys+kuqx6gDWv7QabU3Brs3KMr7JbEOXCkK8baZQqC+5UWlyIMZopZFhpn0Egz6+UhWPJIM+Gc6DlzfTMlZIukFd97xIkL3tQUu41iTkOr+0S4l7Aiys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769439982; c=relaxed/simple;
	bh=2JFEPf30m7LKmwSZWiMJp7j9YWw9mkuejrrzYRdJNuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJ57oYhtNySeDQtm/SAsRu0UdyJHzwcwWlMFKpoZO+FL4b+KKLcBpy+TIKXw0K2Ib7ODLSflvx0RkYRy49teFh3NlcB23q+3z3SCznlFh60r378XW5S8h59N2vynayqZnbm5+QgoJDvg7Q249RYkXWfDEVbUY0RRyf3Ns1QnOW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSzEVxWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01952C16AAE;
	Mon, 26 Jan 2026 15:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769439981;
	bh=2JFEPf30m7LKmwSZWiMJp7j9YWw9mkuejrrzYRdJNuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TSzEVxWIk0EwkBCDGaRKPfuTakNt0uPZ/t3sKStQJOHV89uk1s8fMXqY7AUl7TDcx
	 OD8cBV6jamJ+JzOJGZurjWL2BAuUjBFACzSi2uqPsRzJ9OPnzFpqmV1BeqiUlP6olu
	 jJcyUAgiAASuziyzJUi9/HBuO+mxkOToPzIaqMtp+AQlQI2VPJ6U8adKGvgc5m/qmI
	 H1Giqkq/22x9zrkjhrM5SQbH2LY1RNBEgZuOr4I3tMf13b4UcOO4Os4TwWC+UqDpRE
	 dw8OJ3Xndlju07fWYlXEcb2j2A/dVUQWuwtgzGeRtfvdku3sraX8WMuvDeJJF55sXu
	 kgpXD6hnR4DCw==
Date: Mon, 26 Jan 2026 15:06:18 +0000
From: Simon Horman <horms@kernel.org>
To: Dmitry Skorodumov <dskr99@gmail.com>
Cc: netdev@vger.kernel.org,
	Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Subject: Re: [PATCH v2 net-next 0/3] ipvlan: Deduplicate ipv4/ipv6
 addr_validator_event code
Message-ID: <aXeC6hmPiaviXcIx@horms.kernel.org>
References: <20260123170412.906280-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123170412.906280-1-skorodumov.dmitry@huawei.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253517-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EA6B89E93
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 08:03:53PM +0300, Dmitry Skorodumov wrote:
> This is a bit stylish patches: The code to handle ipv4 and ipv6
> address change are exactly the same. We don't need separate
> functions for them. Just look whether we are called
> with ipvlan_addr4_notifier_block or with ipvlan_addr6_notifier_block
> 
> The changed functionality is already covered
> with existing selftests/net/ipvtap_test.sh

Hi Dmitry,

I'm somewhat ambivalent towards the trade-off between
reducing code duplication, and requiring run-time demuxing
between ipv4 and ipv4 code paths and the moderate increase in
code complexity that entails.

But assuming these paths are not performance sensitive I guess
that reducing duplication has the upper hand.

Reviewed-by: Simon Horman <horms@kernel.org>


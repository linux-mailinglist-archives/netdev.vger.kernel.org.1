Return-Path: <netdev+bounces-304520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uJUlK2mgR2oOcgAAu9opvQ
	(envelope-from <netdev+bounces-304520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 13:43:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3C9701F72
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 13:43:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=OQcirJKd;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304520-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304520-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13BC8307FC16
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 11:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86203C81B9;
	Fri,  3 Jul 2026 11:38:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA573C8C7C
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 11:38:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078722; cv=none; b=WJv3piP3fcDLFSarG8v8T7nOoTdxEFExcXmb22CJXVTQdzuzSWIMyczrGxCe0y2NlU1tEtb/L0jhZHkx8xaJkqKVfSxy6mmYPr2a4Nhxor6eOmwFbywLNo/WIEMtmPTn6btCRGpst4oP67b607iDNa/lFXUoPtHvLaJYh09nOk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078722; c=relaxed/simple;
	bh=F7h0usnQsuGtJCv5kXjbol3+qgJKG2AiZozjGMxt9gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upqYD7JBAKCG+P7pPnIxZxN/ED08TR+PvC5pPElmuPZPX7jPhNmxRQVBrlMPFGiFUBlkZU/nL4TyawQg0rcOBFCwOJIOhnc1fLn4NA4ETyXs/A0/ouhP1siw4oWA8vEjN5v69QNYtZvP+n7ih0QGw8B84mVUI8KQemT0LuCOv6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=OQcirJKd; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 813A560579;
	Fri,  3 Jul 2026 13:38:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783078719;
	bh=A3WsYqXQKspJYG5FBmk1Usbg+qmRCujBeq0O7Jg5Vso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OQcirJKdxHB+cJhwRFuU65a/jVa5is+Q2U6rYe7ey6NwM+l/1QM3aZNtKlf4KD2fm
	 MeWhfvpo6epJ0AZPZ6EwqNo+SbvbBPGg899GK2oiZRnW8nP6R2gtoND15vjVUgLgMv
	 do64JD8cNYRYBKf98zNBt6IA/E0Ky8/WmXAN1eMiPZjHqPcFKDKWDGpf6Yjrx6t4ne
	 +V73zGXYFcIPgOugZclimvMXNODYGh1JyWNDMSwNaDTudUYInuurNKFdfOJFWCJvn+
	 50BRAxX4XC/XAG1p5h7z8DixrvHc8Mve3ArJQH49aBOXE6g2/DFiRJn+wXhL/4RokQ
	 j2mQXHEHSQ+ww==
Date: Fri, 3 Jul 2026 13:38:36 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Zhixing Chen <running910@gmail.com>
Cc: Harald Welte <laforge@gnumonks.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] gtp: parse extension headers before reading inner
 protocol
Message-ID: <akefPJ5cCrsZcpRw@chamomile>
References: <20260703093708.18141-1-running910@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260703093708.18141-1-running910@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:running910@gmail.com,m:laforge@gnumonks.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:osmocom-net-gprs@lists.osmocom.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304520-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,chamomile:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:from_mime,netfilter.org:email,netfilter.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D3C9701F72

On Fri, Jul 03, 2026 at 05:37:08PM +0800, Zhixing Chen wrote:
> GTPv1-U packets may carry a chain of extension headers before the inner
> IP packet. The receive path already parses and skips these extension
> headers, but it currently reads the inner protocol before doing so.
> 
> As a result, the first extension header byte is interpreted as the inner
> IP version. Packets with extension headers are then dropped before PDP
> lookup.
> 
> Parse the extension header chain before calling gtp_inner_proto(), so the
> inner protocol is read from the actual inner IP header.
> 
> Fixes: c75fc0b9e5be ("gtp: identify tunnel via GTP device + GTP version + TEID + family")
> Signed-off-by: Zhixing Chen <running910@gmail.com>

Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>


Return-Path: <netdev+bounces-299655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CF8VJLGMMGpQUQUAu9opvQ
	(envelope-from <netdev+bounces-299655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:37:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D96BB68A988
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:37:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HNRBRDKO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299655-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299655-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 222223007232
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A0C33D51A;
	Mon, 15 Jun 2026 23:37:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F277E2F39AB
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 23:37:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781566635; cv=none; b=M+UMZoKG/fnry0DyC9v8emnby36Z1IMlruTsXl4N/BE7fjKcuEG+MnbHX+burPwxHoK59aFhmRqznPJY1JtutLtxZi3qTl4EA7L/FtRTJqIbdwko5BM6Z5oTollCm0kep3NTuQV1oVOMaNR+YyWKoMNx6hc+YWaxzLxt20n4Ifs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781566635; c=relaxed/simple;
	bh=M3uHz6S6dlPGpnLhYfNGPPHYfW5aJkasSCsiLVh+VIE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXsn3FVNi8UFYIt7luH3UfZm0nIVbi0Hbbqq/Qkc1RAch26S6ETnGXEfD3VOiOKmKMl8i0Z0esFxWnnH1ZcHvr4sHAb1xsrTUx/+KrEFsfIUErL52JTwkIBAY9JuirTKpCpnArD2QJInoGwLgr5MT9yQHhwui6YxJC9IniLpDQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNRBRDKO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137551F000E9;
	Mon, 15 Jun 2026 23:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781566634;
	bh=QyebWGkoDw0IMLgVd+AKwJCgIiDE52FQKr4Rqkznajk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HNRBRDKOOEc3w6UWCswmMwcS08k8VXC8ghVYfQr2saEu6CmfXrbaT9eu02xZvY4Mb
	 05hO7jVky7Yo2Q37OGLDJ0EF2U6/4NNoojmfdqo9IXmeRurxeRiq2kjvFJ+ul5ZAss
	 djADX5tBYXJLHfXf0+RmRqEjHETK7O0LwU3b/hqST27Ct2HUfsBNY2a5OArOoBDhBW
	 N1TEPRI89ijWa5pzTFWqsh7aDSs5a84Jni73Iu1wxh6vtYhEtXHLfKpCH1Z7SGZrmp
	 OXYH5p8Qe+3M2Y709/Y7D8l+9GxkBOZ2OEcWOFVGmq9Q0oftp15s6RPc403q1dkuDP
	 7F5V8C3k2mxhg==
Date: Mon, 15 Jun 2026 16:37:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, Madhur Agrawal
 <madhur.agrawal@airoha.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next v5 0/3] airoha: add the capability to configure
 GDM3/GDM4 as WAN/LAN on demand
Message-ID: <20260615163713.665271a2@kernel.org>
In-Reply-To: <20260611-airoha-ethtool-priv_flags-v5-0-c11de08486d1@kernel.org>
References: <20260611-airoha-ethtool-priv_flags-v5-0-c11de08486d1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299655-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:madhur.agrawal@airoha.com,m:aleksander.lobakin@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D96BB68A988

On Thu, 11 Jun 2026 23:55:50 +0200 Lorenzo Bianconi wrote:
>       net: airoha: use int instead of atomic_t for qdma users counter
>       net: airoha: refactor QDMA start/stop into reusable helpers
>       net: airoha: defer GDM3/GDM4 WAN mode and GDM2 loopback to QoS offload

only the first patch applies cleanly right now


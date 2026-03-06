Return-Path: <netdev+bounces-264928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKVxL6ZHq2lcbwEAu9opvQ
	(envelope-from <netdev+bounces-264928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:31:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA6F227F32
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 376E330292F8
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 21:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3AC2E7BD3;
	Fri,  6 Mar 2026 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj2Vp7UB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89267E0E4;
	Fri,  6 Mar 2026 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772832674; cv=none; b=GjYxt0vuiBwLj6qgUvfipbHK2DrpPAwYJ3A7LSYmobcYnwOHGm2bTZi9IriqiPsJlG/vXEMKzqMFjzHNobwrIzedoMfhK9A45p1aaAz+TkkYvKLq2g40LpTCkOS3Ul8phIGMmd5KkWGxskpFTVlH0BDp3SjhsyZQ6LgwD9YG2/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772832674; c=relaxed/simple;
	bh=A/oQiyCjXWJD6eJu0g0CFFsfO8I9NTo4vg/42nQBuhw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0EK+ktRcq/11YUphP25i5gZ+YoMgirq97sdZdWyf+3pxq84b/ntmfHS4OjDb3ZNBiajxHj2+wlHOm/gZdLlNRtv/S5AfrwdNTXwJtpKKGweNl9w5Kgitwu/WGYvlsKOY/YgP7HJoWC9iH3i606TdMtHUck8IvXZm5I3NQUIeOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gj2Vp7UB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E739BC4CEF7;
	Fri,  6 Mar 2026 21:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772832674;
	bh=A/oQiyCjXWJD6eJu0g0CFFsfO8I9NTo4vg/42nQBuhw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gj2Vp7UBeX8SqrAiseyqY1Tis4aja7P69sDOcHBk08T1K/xwMC0LfBuAmb7zjuRjA
	 hc5c0O3OzJ91e3b0YfwdrsEcI9DElOiZ1EMycmPatHFMK/kMwpjKfjleT1zsDNZX/v
	 xVQydXvhsH/XtnTw85z9WFqNbYNktVuNyUGR9NDT1IIOWncHzkHl/3FqbDBdrtuJZA
	 BqD+VcIefFy2sTHCmi0O3AjyzkIQka8EevDHe34qfXZxzc0MiY2WpLySRlYL34qCyj
	 UGH2eJ7T3ZzStDCkBgbz5eGzQImkTGYzM41nNH4D84zfjgD+ZkF6f+MHNM2SSTxxQh
	 KmMqLDzNk+hRw==
Date: Fri, 6 Mar 2026 13:31:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Ralf Lici <ralf@mandelbit.com>, Sabrina Dubroca
 <sd@queasysnail.net>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, horms@kernel.org
Subject: Re: [PATCH net-next 5/9] selftests: ovpn: add notification parsing
 and matching
Message-ID: <20260306133112.5896c7cf@kernel.org>
In-Reply-To: <8a22df80-824c-4711-9354-b0392220bbeb@openvpn.net>
References: <20260304230643.1014-1-antonio@openvpn.net>
	<20260304230643.1014-6-antonio@openvpn.net>
	<20260306130130.559d844f@kernel.org>
	<8a22df80-824c-4711-9354-b0392220bbeb@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3EA6F227F32
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264928-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, 6 Mar 2026 22:12:18 +0100 Antonio Quartulli wrote:
> > But unless you have a strong reason to use ngrep maybe
> > switch to a more standard tool?  
> 
> Any recommendation?
> 
> ngrep is used to make sure that received packets start with a specific 
> pattern (OpenVPN header with certain values in it).
> 
> I presume we can just replace ngrep with tcpdump, assuming it's "more 
> standard".

Right, tcpdump probably. FWIW tools/testing/selftests/net/forwarding/lib.sh
has some helpers to deal with tcpdump from bash. 

But no big deal, honestly. More of a general guidance to try to stick to
the tools which are already used by other tests.


Return-Path: <netdev+bounces-295998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2rdXJ1dfI2oOrgEAu9opvQ
	(envelope-from <netdev+bounces-295998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 01:44:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DD964BD84
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 01:44:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Ol/pozvI";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295998-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295998-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF4313014846
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 23:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9213E00A3;
	Fri,  5 Jun 2026 23:43:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C217D3B42FB
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 23:43:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780703000; cv=none; b=aY8WMXYEyfjSAFkI//UfBfVyMpdzIzgqAS+No72R1SC0ScmwHfHJZFLMoxccQDWvOJdL4wCXYFGb18qzGXh76iaW+TB4A4N4j2Afv1QG38vWmqF57fKOD6khGfKVYQauN2gnSKOu+S9sKAj2c+uGc8yRtroOVsotyh0vI9TgxUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780703000; c=relaxed/simple;
	bh=UMmaAY51oAGuQW93dfYJ/TQb6jQ5YkEz7jUeN5xl8Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXtIxMQAnbPVvHLxtkOV35p21LpJ1xGzItV8cWF03bvq2BalK0SkCn+6KPcXc1zwPsTxfG0n+GFi1SOrbvlle3BmVCTMGFWv1uvu4mOluELEHsFUlThyJsAO0fftYp9+pc7uOJRU8T9aDQk5naXs6ri7JVQYtnsv29SvSmfKez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ol/pozvI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EA11F00893;
	Fri,  5 Jun 2026 23:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780702999;
	bh=UMmaAY51oAGuQW93dfYJ/TQb6jQ5YkEz7jUeN5xl8Tg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ol/pozvI1QdQ9wBvJCAmSSqxzZSu5g/5MlgmQa2IYajj+teeZDev/cK/E1zaMKT3Z
	 9or0wcA/2N2DANsJ/604GD5Cyi/3ob5CgRFL2lQg/KS0PR0i4+JHyau0YR1qiiP6du
	 d5r+Z3YWjlJdmuTi1vXzsyiZ6umY7zNqsSSU2RgBNsIy1e/l9PCYYKQFvlgsdXOaU1
	 BJCSjOZkkyzbEHAoIhIibCwncDw+y3HOqvc5NYak6A/Gj7DwK+S4TrUH8ZrKDa0xOq
	 EDvrrpgovEgWqLCLhmHZ27BgADFoZWnu0UHrrRZpH07OAeASsVsEcpqIT3FHXERMCF
	 fV3dXmiB90hxQ==
Date: Fri, 5 Jun 2026 16:43:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alice Mikityanska <alice@isovalent.com>
Cc: alice.kernel@fastmail.im, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, lucien.xin@gmail.com,
 willemdebruijn.kernel@gmail.com, willemb@google.com, dsahern@kernel.org,
 razor@blackwall.org, shuah@kernel.org, stfomichev@gmail.com,
 andrew+netdev@lunn.ch, horms@kernel.org, fw@strlen.de,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 05/11] udp: Support gro_ipv4_max_size >
 65536
Message-ID: <20260605164316.366304d5@kernel.org>
In-Reply-To: <CAD0BsJVydUv30m+35nzbmdCcAx=PdW5ahH2iW6BhUyT+y-e=2A@mail.gmail.com>
References: <20260602093931.516281-6-alice.kernel@fastmail.im>
	<20260605023712.3627277-1-kuba@kernel.org>
	<CAD0BsJVydUv30m+35nzbmdCcAx=PdW5ahH2iW6BhUyT+y-e=2A@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-295998-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alice@isovalent.com,m:alice.kernel@fastmail.im,m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[fastmail.im,iogearbox.net,davemloft.net,google.com,redhat.com,gmail.com,kernel.org,blackwall.org,lunn.ch,strlen.de,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07DD964BD84

On Fri, 5 Jun 2026 12:30:55 +0200 Alice Mikityanska wrote:
> OK, so it can see that it's handled in a follow-up patch. I can swap
> them, so that the fix comes before the uh->len = 0 change. Would it
> solve the issue?

It's alright sorry, I think I just glanced at the report and whether
the series touches up conntrack. Should have read until the end :/


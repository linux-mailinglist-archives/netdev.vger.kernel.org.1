Return-Path: <netdev+bounces-297736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NZO7OW6DKWp6YQMAu9opvQ
	(envelope-from <netdev+bounces-297736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:31:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CD266ACDA
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:31:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RBWpsopu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297736-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297736-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91A2F306F50D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BB633A9D6;
	Wed, 10 Jun 2026 15:27:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D21033122D
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 15:27:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105270; cv=none; b=uQfJjCP2tHU595nePmkt40TGCNNRSaoWlRtfGrR97s5oy1SKk95h8HUOIKB/4plBifmsEO3EYx5TiCRcEAzHnoGl7dSkKJK42C8RWmatCjUc/WD1hWNrxQzzCdsW4IOoQrJ6CQt2bOdX0z7qAydB94Uj87vQHiwgRro9SGB89Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105270; c=relaxed/simple;
	bh=2wBI18RKi3tgHsjZdoHPQfO8F4AFN52wOJmPd2Jn1/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPiJ/rv2Dk7ZQv9ZNh+KGov70OybTH/AkkauxFaRkbAsn3f5wZaT2r2xVrhieyYSn22YEnQnsOdm44enadKgOa5KO4cHHKqs7Pb+cnKzCEQO4uTtsGuu/Mzc9yvxRCD+vupMsFttZOvrxYME7S5bOtATSjYfS6xGv9tzcS6cQCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBWpsopu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973DE1F00893;
	Wed, 10 Jun 2026 15:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781105268;
	bh=0YzqKqBQZ6GdTYQ2FA2Itp612d/HKEe3kIR9LcefOHs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RBWpsopu/1aiO+SWVVukY9WlYkHZJHybuCqJFKnjm7q6WaScXq4dE2/Mik+h5v/ps
	 Q5PO1zeEdJ8ciquQqpnf28Srtfs6jN6FbN250CDfQk4A5AYjR1r/dhEnlM/AvATgyx
	 C7NOQ413hhzplrMBUSPiZlP+rUqPadxDC3qJxomyaI1tBdXZQbLEUrsxo3EmTsM3yT
	 Fo4wrfQ93A1yz3IaOgTVf1B1RYqqME7CdsTsh5/VijR71cmA4lpMurDSjjlKUpUxy5
	 XRzZ+Qye7RLvs5V6GoeS+gOzGBQrpKtcB4uSsWD/49BFNZUmAWIZ1zffumpr+CrMZI
	 hufMKLSckKEWA==
Date: Wed, 10 Jun 2026 08:27:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marco Baffo <marco@mandelbit.com>
Cc: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org, Sabrina
 Dubroca <sd@queasysnail.net>, Ralf Lici <ralf@mandelbit.com>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net 6/6] ovpn: use monotonic clock for peer keepalive
 timeouts
Message-ID: <20260610082747.462dbf62@kernel.org>
In-Reply-To: <1932179615.53655.1781104032870@app.mailbox.org>
References: <20260608150741.3320919-1-antonio@openvpn.net>
	<20260608150741.3320919-7-antonio@openvpn.net>
	<20260609194246.23c66818@kernel.org>
	<1290464191.15539.1781081055969@app.mailbox.org>
	<20260610073111.6273e17a@kernel.org>
	<1932179615.53655.1781104032870@app.mailbox.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297736-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:marco@mandelbit.com,m:antonio@openvpn.net,m:netdev@vger.kernel.org,m:sd@queasysnail.net,m:ralf@mandelbit.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00CD266ACDA

On Wed, 10 Jun 2026 17:07:12 +0200 (CEST) Marco Baffo wrote:
> > On Wed, 10 Jun 2026 10:44:15 +0200 (CEST) Marco Baffo wrote:  
> > > ktime_get_boottime() is like ktime_get() but it does not stop when suspended.  
> > 
> > Worrying about keepalive timeout when system is suspended seems
> > quite silly, did some AI tool suggest this? Anyway, if you want
> > to keep this code please improve the commit message.  
> 
> Yes, it was suggested by Sashiko but it does not seems like a bad
> idea to me anyway, but please tell me if i'm missing something.
> Regarding the commit message i would be happy to improve it but it
> looks good to me, do you have any suggestion?

You can do it, I believe in you.


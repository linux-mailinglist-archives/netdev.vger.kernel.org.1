Return-Path: <netdev+bounces-297710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O2OaD7l1KWqrXAMAu9opvQ
	(envelope-from <netdev+bounces-297710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:33:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 692B166A3FE
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:33:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Qmzlzl9o;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297710-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297710-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B430300443F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E77233F590;
	Wed, 10 Jun 2026 14:31:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5C03E120D
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 14:31:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101878; cv=none; b=So5ObHW1TTas0LpUirPEb7kG+WeBlGvJ6jFV+yav55BIZS6R2TAoPy+hZRzY/r6+FvoXhArWTP24GhFQ9J6sjR7k3a95l8sP9n7iDjYsSI84YFnYHieEHOHx+WvKfk8btlikgGqYiXKUPYjyP/UODiRHQzbmOvPiaIc2F8k8+pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101878; c=relaxed/simple;
	bh=tRWCc0VGxYHHGzbMCnp3Wupf1eOzfKs+ALbDRS75O7c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k93Y9v2NK19GRBwHFaDA/JRsCz8hrJbT5O37rR/H8MNcr5TpE9QQfwJU/7CInRWCA3Sl2XmcZeMe+7A+a2RaVvU7NIKjsLLLETYC5oJzoR8CPNQDm9CSeSDFp2r38bW/cG2ngDdfTp0fb2rTVmaDlxVwitoUnHN9wLHSyagmalE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qmzlzl9o; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD641F00893;
	Wed, 10 Jun 2026 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781101872;
	bh=/zrnAFDsQiIgxF9TRP05xR9UguzkrzrtzioFKG2qt8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Qmzlzl9owzUlScCjmZJJaM7e1xKD3aeklnSDMC6UUM3mO6pm2sjGeK/qUMasv420L
	 D2v3xOqMvlk+oryzhj4eSQUw4Wo8t7gEAfvIWBfS4dD0DFEIuMjCqpV+5VtpCdvgjx
	 hmjRgpj5qN73yfWM5ifKg9AwW3ZpctJ2wNImWw2c3EPWCr6W9fIUZjuiVIIq/0VMXr
	 rvFcL3KLO868MvwttWQgZLA5RYNbX9Qp8o9phdHfpKttMVb3XYfQQXYM2WImofiGf1
	 GLlB1HbdNl6Slu9H3c9zPYeSlvxC6DKeaV1YQNfNH5HFT1iR+CUrzYIzUPlz4iLPBB
	 pGKKnTaNP6HPA==
Date: Wed, 10 Jun 2026 07:31:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marco Baffo <marco@mandelbit.com>
Cc: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org, Sabrina
 Dubroca <sd@queasysnail.net>, Ralf Lici <ralf@mandelbit.com>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net 6/6] ovpn: use monotonic clock for peer keepalive
 timeouts
Message-ID: <20260610073111.6273e17a@kernel.org>
In-Reply-To: <1290464191.15539.1781081055969@app.mailbox.org>
References: <20260608150741.3320919-1-antonio@openvpn.net>
	<20260608150741.3320919-7-antonio@openvpn.net>
	<20260609194246.23c66818@kernel.org>
	<1290464191.15539.1781081055969@app.mailbox.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297710-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:marco@mandelbit.com,m:antonio@openvpn.net,m:netdev@vger.kernel.org,m:sd@queasysnail.net,m:ralf@mandelbit.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 692B166A3FE

On Wed, 10 Jun 2026 10:44:15 +0200 (CEST) Marco Baffo wrote:
> > On Mon,  8 Jun 2026 17:07:37 +0200 Antonio Quartulli wrote:  
> > > Replace ktime_get_real_seconds() with the monotonic ktime_get_boottime_seconds()
> > > to ensure the keepalive mechanism is robust against system clock modifications.  
> > 
> > Why boottime? Unless there's a reason shouldn't we be using
> > plain ktime_get_seconds() which is CLOCK_MONOTONIC?
> > 
> > (if you decide to respin could you also drop the selftest change
> > from this PR and move it to net-next? memory leaks in selftests
> > are not important)  
> 
> Hi Jakub!
> ktime_get_boottime() is like ktime_get() but it does not stop when suspended.

Worrying about keepalive timeout when system is suspended seems
quite silly, did some AI tool suggest this? Anyway, if you want
to keep this code please improve the commit message.


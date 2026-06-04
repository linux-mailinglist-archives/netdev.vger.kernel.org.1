Return-Path: <netdev+bounces-295230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fn0wBm50IWroGgEAu9opvQ
	(envelope-from <netdev+bounces-295230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 14:49:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B116400CA
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 14:49:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YPXQ+2EU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295230-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295230-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D1D53033D34
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 12:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9E3423A64;
	Thu,  4 Jun 2026 12:41:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2EA290DBB;
	Thu,  4 Jun 2026 12:41:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576880; cv=none; b=rk6PC0BrKRQpSETQ59gNpNTtkzGdkC0RY0DMXLjdgk7KWELe3JzRa0nF3Uc7DMFZ3jLPFDFHbrOy6pkIopDpAmhtIcXYbUu1nqYPWnJNKRHzegxcfn9RMSwZrL/S8zpOxx4D7rxwhj/EzPfqlPNSs1ntObmWd702FM5FSImKZD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576880; c=relaxed/simple;
	bh=vABAeb5yoaxRMbPG08nIjYcYfU74s4T5Cze6J+kjrmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUjEIulqnOcCOIHLixomd+X88+sjGSeXjKtHdc+70F70CBOEytulGNUduf/7xjke4EbQxnqiysmnQMbYWkmuLIvDqRp3vih1ro7F+rHUyX4JShUru3b0He930i8fCyq0mXauAerj26JOcK61qUH1LTIA3lDjELA0By7TZFyFIJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPXQ+2EU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A81B1F00893;
	Thu,  4 Jun 2026 12:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780576879;
	bh=BD+C5VQV3yglYFve12LB8PO4uUYjRkvZHFWVbTESV8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YPXQ+2EUPtBa1bHPxwsJlZGhmIDVJbaGRURndYHAfLF3B3RiqGlyKFIRLWpXHFWGE
	 Rb9ztvhWj2uf+/evCfIQiy9wkOzuc3hxtFiLqxvouTm5NM6S2O9wH3ZCtTjTEG6Dtn
	 pMbT92Jaiyl/aDM71RD8KX3dbfZDItBjrKi3GsxBJ18gsw8efI5zAi1tUwssI2qc21
	 wy+IMjMsSAlYK1FHzj9TShzfno5lj4y2J4uF73awKcvQD6SIbVj/FIGHPK5wQRDLXP
	 cF7zJhGa3EpgFS07JcPSpHn3EbXsclY7WjQ5xUkWKzCQGdeHQgSZp5vaADYxm+xB6h
	 v+wuC3BSVaRew==
Date: Thu, 4 Jun 2026 13:41:14 +0100
From: Simon Horman <horms@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Tim Bird <tim.bird@sony.com>, Amir Goldstein <amir73il@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net/dns_resolver: use kasprintf +
 kmemdup_nul to simplify dns_query
Message-ID: <20260604124114.GA3920875@horms.kernel.org>
References: <20260602071343.962830-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602071343.962830-2-thorsten.blum@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,sony.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295230-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thorsten.blum@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:brauner@kernel.org,m:tim.bird@sony.com,m:amir73il@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87B116400CA

On Tue, Jun 02, 2026 at 09:13:41AM +0200, Thorsten Blum wrote:
> Use kasprintf() for descriptions with a query type and kmemdup_nul()
> otherwise to simplify dns_query().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Reverse xmas tree (Jakub)
> - v1: https://lore.kernel.org/lkml/20260528222030.1655010-2-thorsten.blum@linux.dev/

Reviewed-by: Simon Horman <horms@kernel.org>



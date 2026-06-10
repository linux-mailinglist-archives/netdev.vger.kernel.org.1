Return-Path: <netdev+bounces-297370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h5G6JBu3KGreIQMAu9opvQ
	(envelope-from <netdev+bounces-297370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:00:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE71266516F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:00:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CiOdeOtX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297370-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297370-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CBADC301AB4E
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDA8220F2A;
	Wed, 10 Jun 2026 01:00:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3AF21CA02;
	Wed, 10 Jun 2026 01:00:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053205; cv=none; b=hozShO+rrH/duMs4fcSEkQiUwJ8FWr4ONxxdUHttqTKOWmPZ+C0U7HRA0KO/rwpc+mBRhV4ZMCGeokOln2JI1T2rRD2wAVZrT+Xa9na7g6+P8n9ffwynDn0C5VDKn661Wv9yH/yoE5BL8PMePYrlVq0tRxGwIgdUKlW6RAAGdmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053205; c=relaxed/simple;
	bh=NY79jDaWT1YxXpLnGOEwpu5chz+h3gqwpbGSNXUahRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSFlWqwNTtJ6/JCD9OEzOpMJdCZ6ppPVx0jRrrgne3rKJx07x/Q6+8Uj3GzmhxdXVI+ZYMqcy0LWY/JncYABfYGIvc4Ce40qq1gqAvZjip8mIFWettQBPCVqPouAXxOHmXMq3OzMbEb0Nuicn5kwXk60N26yTgANtjrg+Qxc2fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiOdeOtX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D0E1F00893;
	Wed, 10 Jun 2026 01:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781053204;
	bh=dPkJYjzY5JPEmIZXonT3vNfcky0zjFEpdKWA2TGjF34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CiOdeOtXG/6zAlje9jVifaIYaoEePDRHvEZOF4mUquIi/dng7Fq+KTmEvAFQp6rGp
	 nHF5Py4OFrzi/jmziWozozsxv0D3I0NMH1P5BpGAYJ23rQfGsqatBsSlXPNXsOWCRx
	 KU2HaaW6edJzRIFXDkiWLPxLg4qNcnRcjTdSPbShWRBJyfMLk9cvux7Nse3zbDhMvM
	 q/BlM7HxXEI6L+0YEOwT0vo6LscT0ySO+FTqBrkODlpCv4A3nCPsYI3a8zkrZJ9t0V
	 bXXg6nQypuQ56BWvfifTDg9prMkYKBC7VWTQLe1yrhP9DAY7e4BW1a64AmxuYxFQfQ
	 OXJUIQ/fqIsFA==
Date: Tue, 9 Jun 2026 18:00:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, Arnd
 Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Ido Schimmel <idosch@nvidia.com>, Paolo
 Abeni <pabeni@redhat.com>, Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH net-next] net/ipv6/ip6_vti: Use strscpy() to copy device
 name
Message-ID: <20260609180003.31cf7ab0@kernel.org>
In-Reply-To: <20260606202633.5018-29-david.laight.linux@gmail.com>
References: <20260606202633.5018-29-david.laight.linux@gmail.com>
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
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-297370-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:arnd@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:herbert@gondor.apana.org.au,m:idosch@nvidia.com,m:pabeni@redhat.com,m:steffen.klassert@secunet.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE71266516F

On Sat,  6 Jun 2026 21:26:23 +0100 david.laight.linux@gmail.com wrote:
> Subject: [PATCH net-next] net/ipv6/ip6_vti: Use strscpy() to copy device name

Same comment as on the bonding patch goes for all the patches which
copy from dev->name. If dev->name is not properly terminated we have
more serious problems that this copy


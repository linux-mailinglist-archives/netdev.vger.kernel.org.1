Return-Path: <netdev+bounces-294385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PjBWJ6I2H2okiwAAu9opvQ
	(envelope-from <netdev+bounces-294385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:01:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DD0631986
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:01:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ERsIXOq3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294385-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294385-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ECD13025D27
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 19:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51479378826;
	Tue,  2 Jun 2026 19:59:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CEA376A13;
	Tue,  2 Jun 2026 19:59:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780430398; cv=none; b=lNQshrQ8jD36u61JxSZMFdL5XB8fAMByuYnAUSQDiMqoOSuXlnRc4lmKQoVdF7D2ngTSVBS48LmjkJmrx7YDZIu1qNyhzpNo0ulJr/sGbgYuTFye5+57wRjSxE3W+jh+wCaRLSS/tNZuAqLfkPpAw22h13c3EcWbHyTzCaSwk3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780430398; c=relaxed/simple;
	bh=ywSD0fPdkOV3PRi2wNsFq0uZ4W4kD8z3znRDzIGdc34=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbrYrsWZlU+mzRj+d4KvLj8HlGeF5sS6kFPOFnOeuy5J5UN1MYgLk1+ZWiackx8Jl3dsMRN0qQwfUXFkCfvciCRFHysqxd3DIaHF0yBCmwBAs/hZ+e7FQqaMc4UXMVoyoq7HkX2u3Z4Vt9lvKII4PGpZUUX8SEjxYDmYTFhqKs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERsIXOq3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7F21F00893;
	Tue,  2 Jun 2026 19:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780430396;
	bh=ywSD0fPdkOV3PRi2wNsFq0uZ4W4kD8z3znRDzIGdc34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ERsIXOq3+goH1skhNWCqoJdjeeyftXXtO2tXIn0yfN5hvK5dJhQm6YF6SZB1krrLJ
	 ZTogZGUaJpc9GqmjNLzCBrJErPh/fRCk+gBhV3qj8WWn5AOXYJBgKA93/GjnvGDDY8
	 aL4GeKKi8NBauFDtK8aoof5dQ8PxuSFQU9TlED2X4NAaW0L9+B5CGv3qzqzZCgplq7
	 lIGKpdqLP9L7/2upys2x72kOQZK7/xkgjCMC+BJ5s7x0QFR1Wz1zI+GK65AoEfH0pg
	 aExjWIk1Ryh94RGSOR8yZdudVPl747IeqPHyDkrQXyjS97xsYwO3cjLgBIDmH4wUTu
	 t2gE+0S9C50ug==
Date: Tue, 2 Jun 2026 12:59:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Matthew Maurer <mmaurer@google.com>, Miguel
 Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v6 1/3] rust: net: add rust/kernel/net to NETWORKING
 [GENERAL]
Message-ID: <20260602125954.2a1b09dc@kernel.org>
In-Reply-To: <20260529-binder-netlink-v6-1-92dd74b6a32e@google.com>
References: <20260529-binder-netlink-v6-0-92dd74b6a32e@google.com>
	<20260529-binder-netlink-v6-1-92dd74b6a32e@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294385-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[google.com,linuxfoundation.org,lunn.ch,gmail.com,davemloft.net,redhat.com,kernel.org,garyguo.net,protonmail.com,umich.edu,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:cmllamas@google.com,m:gregkh@linuxfoundation.org,m:andrew@lunn.ch,m:donald.hunter@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:mmaurer@google.com,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:dakr@kernel.org,m:brauner@kernel.org,m:linux-kernel@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:netdev@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0DD0631986

On Fri, 29 May 2026 13:28:38 +0000 Alice Ryhl wrote:
> To ensure that networking code can be found in a single shared place,
> add it to the relevant NETWORKING entry. The net.rs file is moved into
> the net/ directory so that it's included under the MAINTAINERS entry
> without needing a separate rust/kernel/net.rs entry.

Acked-by: Jakub Kicinski <kuba@kernel.org>


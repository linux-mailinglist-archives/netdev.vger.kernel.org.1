Return-Path: <netdev+bounces-265168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHdXDXlxrGnxpgEAu9opvQ
	(envelope-from <netdev+bounces-265168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 19:42:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6FA22D3FB
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 19:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AC5F3006135
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 18:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF8A38BF7D;
	Sat,  7 Mar 2026 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeJ6+6O5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC05375AAD;
	Sat,  7 Mar 2026 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772908917; cv=none; b=gLPMU+Pjav1VKi8Lm/1B9dw7rxl44QHbDM6xdKFHk8xAYDz+ADtXuhWJspwqRrAfjb3VKnPh4QPPDLAkOc7e2YpdpEi5OJ/xsF9m+/F2NnbJFGvGFzb4k2gM2MF7gNe6UfGaz6FF9uUIuU0L1SupfN/CUa/+EiuIPepz+UxK3vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772908917; c=relaxed/simple;
	bh=2fiHkABwZ9s1AmL3DexMvrp/1ZopKcunHgXRonl2fJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GsFo/kL/PMU+XHDtwlrszFNhGnk0nOgUwewOV7k/Fz/3PsrfNr7rZeZllGNZnmyR0A07yelPkRno6MrPNqis9hLt0epnif06rqULlaQjXjtwc54tLOwxP+DuLkKYzKKvonarQdErhuhlhJQrk70U0FARi+a+2oFIeEY/9fjuiio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeJ6+6O5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071D3C19422;
	Sat,  7 Mar 2026 18:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772908917;
	bh=2fiHkABwZ9s1AmL3DexMvrp/1ZopKcunHgXRonl2fJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FeJ6+6O52aZiLx547BjMcEe4zPEAqXUga7Q24BrqMT1HQSrNv9i/Qhpcb2+3VRnQH
	 MjxWVGD/NQh23QKf5M1Ckhdl88n8NrTnRK1JiA6O1BRNUCWUza8D0OR0IfHtd8PTvs
	 OZqbXUeFzpRxLwe4zza+pZmi/JNC2BhShdKzphE4EaLHpNA/89QHaX50iODxe2CT1n
	 XcPjvgAKHZ+h1OXQMhhdnp8FVgpXeltMjljOEIbAdn3mC2KV6I2nVY74bQOTo4cdrV
	 S5t0KHiU/GoL+JNrrOdvbMEyL2J77GISj2ZDYxjchlG8+U9IJIsh31BXJJ2miV6Ive
	 cIqTZQZ2YiMLQ==
Date: Sat, 7 Mar 2026 10:41:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Arve
 =?UTF-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos
 <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, Carlos Llamas
 <cmllamas@google.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/4] ynl_gen: generate Rust files from yaml files
Message-ID: <20260307104155.108d5d69@kernel.org>
In-Reply-To: <20260306-binder-netlink-v1-2-daceb5bc83f2@google.com>
References: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
	<20260306-binder-netlink-v1-2-daceb5bc83f2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CE6FA22D3FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265168-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,davemloft.net,google.com,redhat.com,linuxfoundation.org,android.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, 06 Mar 2026 15:12:14 +0000 Alice Ryhl wrote:
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py

The name of the file says gen_c ...


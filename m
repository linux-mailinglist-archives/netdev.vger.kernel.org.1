Return-Path: <netdev+bounces-294389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YaBSHl42H2ogiwAAu9opvQ
	(envelope-from <netdev+bounces-294389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:00:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A6C631970
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:00:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LeEIdTKY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294389-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294389-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68ECC3008275
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 20:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6A32E173B;
	Tue,  2 Jun 2026 20:00:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5334125B088;
	Tue,  2 Jun 2026 20:00:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780430428; cv=none; b=HjCYlfCiTIUchlRIjmY5QQcIe+sgiPeMDOohvfAaLz630njj8HHWe1RenFJ6dtzWLC2jUEj58p10kYOxOJxccNRFkkZpg8Xkuja50nqKr5NkM7NKKvM/WSe0BE09hnQ9wmJWFt0IVtWTISGJHTm9EzUD8+crnVV8oSdYWPLIAqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780430428; c=relaxed/simple;
	bh=YCXEpa08KnLDcAtvIVLebI1Fa6o34B4vWsrvIJpO+z8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Raf0LknIwhZ7PKptNi37uAe15PMk9VDw76s06Tc383sb/OOk+SMVBVICQ9w6HNwsgcysTcG+4Qm+ugXAKGI4iWWCvg69j5H981GN0zRmqpnjmhtpWBjR6Jn19lmxqOyvfAkLQQFprmMoU9SKSxhdCTf7VmRECLem/xiiotTjJIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeEIdTKY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2D11F00893;
	Tue,  2 Jun 2026 20:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780430427;
	bh=28uFiFaPz00034N6mbPxIg597Anz/KiVjczsmXdtiAU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LeEIdTKY/sRuBIGhNCn+pS2TNWw25Ld/g5eQxQCDyWFc+FNTxNMXfFaoQi8MlAjyd
	 B66U1MCiOZ0PKEiNE1SQxpRCmU+bL28cKfphN1KehuxXCYr3DcZNxqrFBgTIdfl9x3
	 8ULZYWYbF4zch7yZ8n3NIlSZsh2TTH+rze/qtz+l6g/lHdcWJmu4nQZe2s3CbmB5Qd
	 aNCY5f1trWFsIeOaA85aS9mQWxcJLOCkCqSZAA7glUk9FfTW2YXGKOJdUwBbSKycIs
	 GAhSCasKdJTNMz0bknZH7WluSY9R2gFNe71Iyyckyh9pK8P2JQxQsMRw9kU0s2IKX2
	 6c0PRvm1INsuA==
Date: Tue, 2 Jun 2026 13:00:25 -0700
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
Subject: Re: [PATCH v6 2/3] rust: netlink: add raw netlink abstraction
Message-ID: <20260602130025.4df4e5d3@kernel.org>
In-Reply-To: <20260529-binder-netlink-v6-2-92dd74b6a32e@google.com>
References: <20260529-binder-netlink-v6-0-92dd74b6a32e@google.com>
	<20260529-binder-netlink-v6-2-92dd74b6a32e@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294389-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09A6C631970

On Fri, 29 May 2026 13:28:39 +0000 Alice Ryhl wrote:
> This implements a safe and relatively simple API over the netlink API,
> that allows you to add different attributes to a netlink message and
> broadcast it. As the first user of this API only makes use of broadcast,
> only broadcast messages are supported here.
> 
> This API is intended to be safe and to be easy to use in *generated*
> code. This is because netlink is generally used with yaml files that
> describe the underlying API, and the python generator outputs C code
> (or, soon, Rust code) that lets you use the API more easily. So for
> example, if there is a string field, the code generator will output a
> method that internall calls `put_string()` with the right attr type.

Acked-by: Jakub Kicinski <kuba@kernel.org>


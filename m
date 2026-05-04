Return-Path: <netdev+bounces-284097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDHwEREz+WkG6gIAu9opvQ
	(envelope-from <netdev+bounces-284097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:00:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D4C4C50F2
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F0F4301465F
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0217C3FE67B;
	Mon,  4 May 2026 23:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJA2bxZs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CBD3FB7EB;
	Mon,  4 May 2026 23:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939140; cv=none; b=OAfv2Zi8MtCLjLKQy5Qkf0ao0M4fe3G6fipYTPEqFUiWw24Rqq16dpda38aPpsaWXN7df18cywIDrijPiy8OX2CPTIQo1ErjiFkIqR8TJ3lHhLJnGiGhbPzye14GO+oblNA1dOIp8HozcSN+wYC8FsagMFXrm+ZGS/kCejSXFrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939140; c=relaxed/simple;
	bh=G78gkkTB3+nUxbQ0sEh+cB10zCIPgt3BA3kgSBxBQN4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2wN5JxZ8rG+LYN7EexQIPhdUYy+gZYhcaGd6cjSLs8ckiwfsJ2P+6GJYbAEsbGYOmufmiHkLsP/X4dYypI+4u1yEuTom7fPULJLHaltXHwpc8Ii6wDK3DGoSVNkS0Ht5/6U72VsRhRzlN8iefvVaikH0UP1tzwIsnWByrVrAvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJA2bxZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFE4C2BCB8;
	Mon,  4 May 2026 23:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777939140;
	bh=G78gkkTB3+nUxbQ0sEh+cB10zCIPgt3BA3kgSBxBQN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eJA2bxZsbYEj8zvHRQYdifekgZDfjdBdbS0c2t9kJGGoH0YkBR8V1+DmrqR2fFDBW
	 SRzgB4W7puSJx+cZSCR82FShM3urezn53PrmPTIET8RFC928s0UBmBUqAQRdFraRIb
	 MPWTHICnQbpZSWN84PYcZ3bN4ebnyXNlVLhZMBrRHSiywDgix5qIexor1gR7Ech9NZ
	 X3jtTyLojQNYXixdwv6/yaUqfZ9zrNVprTO/tju9lNM9X6STCQa5p9/aIRTxkEWLJu
	 jor+dJmwXDUbokcaLACFAmwLgoVZLtHfinDcGsZZe9AXZX11iektKnq3P49sigcirl
	 G6/F8omOhx37Q==
Date: Mon, 4 May 2026 16:58:58 -0700
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
Subject: Re: [PATCH v4 2/4] ynl_gen: generate Rust files from yaml files
Message-ID: <20260504165858.4882730b@kernel.org>
In-Reply-To: <20260504-binder-netlink-v4-2-601b41cd25b2@google.com>
References: <20260504-binder-netlink-v4-0-601b41cd25b2@google.com>
	<20260504-binder-netlink-v4-2-601b41cd25b2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A6D4C4C50F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284097-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[google.com,linuxfoundation.org,lunn.ch,gmail.com,davemloft.net,redhat.com,kernel.org,garyguo.net,protonmail.com,umich.edu,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, 04 May 2026 09:04:55 +0000 Alice Ryhl wrote:
>  tools/net/ynl/pyynl/ynl_gen_c.py | 139 ++++++++++++++++++++++++++++++++++++++-

No. Rust. In. This. File.

Just commit the artifacts. I truly hope that this is the only Netlink
family we will have in Rust.
-- 
pw-bot: cr


Return-Path: <netdev+bounces-279089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP55Lj8K4WnoogAAu9opvQ
	(envelope-from <netdev+bounces-279089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:11:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB304116AB
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67960300DD4D
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 16:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C142BDC32;
	Thu, 16 Apr 2026 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldDKTs5u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3565222541C;
	Thu, 16 Apr 2026 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776355897; cv=none; b=Zb50AxlO4iPKwFbsqrnFx8Z/xyO+pqFSzCtZajlmk9QiIRKPtVPRI+PhuJeJVt0EVrHQOJD/oCgf9aksTfo9VAzJtVE6lvDhRCyyo1faYBcumM9SW9vZgHa9dasyCx9Vx+onmG+RKcyd/bGgdnfBsLYmMfO5ge/vdCQeqFp/e48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776355897; c=relaxed/simple;
	bh=QrHL4ZMGRyqA0HvFWyAQYVDKeMrdFAjdC8sTylw3ws0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXN+yMQ3D/eJWcssJFOXLxuf4P7nQVMSDRxzTzFugy0XPhillXayUZvvzzac7W3du+k/G6ZIIEgm5iaMc+OPXnngLFQAr6OzoCU5MrcXgl2J+zHwu7OxsxUMMCSK2BZcBPl/0I2dBK85zXt1cnPHq1QJf5x7FUN5jSwSKzL98D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldDKTs5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294EBC2BCB3;
	Thu, 16 Apr 2026 16:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776355896;
	bh=QrHL4ZMGRyqA0HvFWyAQYVDKeMrdFAjdC8sTylw3ws0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ldDKTs5uy/6ztmwZBNikxKQaOEo+Jg5hOQW5RKDKz31C/3XgqR4PeFaS7tEyaZ98F
	 C7+UWzfTI3v2ajQl+Kl5C2EKNtmhQhq0KBpPVTtdb+1EynjIqB0jDNlOfrxnKAMgqc
	 uHAoVBQLckdmqdpkfARfl5O4nU8yoTeTc8JRS7C0wPHCX2zxE/40/+lDlumkN7jmDl
	 1pLe5tDVBVl7MP4lzcD48AJt6sevNJFvMqTw8Hx39k8Gu9cKoAPjv+d6vA37cZ86Av
	 XNJULMF2PaAMKRd0zemhyUoMGc76neYJO7YbpVE0Ko9WbEqMqc3+IKYyNKmYI5NPwT
	 iQAzC7nyBgCZA==
Date: Thu, 16 Apr 2026 09:11:29 -0700
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
Subject: Re: [PATCH v3 0/4] Rust netlink support + use in Rust Binder
Message-ID: <20260416091129.6e20ca0f@kernel.org>
In-Reply-To: <20260415-binder-netlink-v3-0-84be9ba63ee2@google.com>
References: <20260415-binder-netlink-v3-0-84be9ba63ee2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279089-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,davemloft.net,google.com,redhat.com,linuxfoundation.org,android.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2BB304116AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 15 Apr 2026 09:37:50 +0000 Alice Ryhl wrote:
> The C Binder driver exposes messages over netlink when transactions
> fail, so that a userpace daemon can respond to processes with many
> failing transactions.

net-next is closed for the duration of the merge window, so that 
people can take a mental break and increasingly catch up on all 
the accumulated CI/AI backed work. Please come back in 2 weeks.


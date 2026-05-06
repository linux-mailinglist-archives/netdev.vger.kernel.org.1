Return-Path: <netdev+bounces-284623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YhkLO2qI+mmYPgMAu9opvQ
	(envelope-from <netdev+bounces-284623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:16:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C65F4D4F08
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1060303ACEC
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 00:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1671917F0;
	Wed,  6 May 2026 00:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XglWJqmZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897F34C97;
	Wed,  6 May 2026 00:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778026599; cv=none; b=oJQkTh4/uNMp1E8i/HrQ75zeX0GUXaH//Br9lDDwC1qY5UwE6SBPfdYACM8rQb/TprpuUflnedtwui9uhvIpdv71z/c6yUECilzC6Rf9J7eSmGfwJfVm8DOey5Dzh26EcHlqrubViyGaU3Qlr2Eon33w/chK+3Ag2ofo7pT+T44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778026599; c=relaxed/simple;
	bh=dvIk5huHsVcx4vNcUm/MtflXiy2orveWIsPJCGlqLsc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBNEn4KpjQHxyBHCutj/ydoBMgt+9zwA17eis/+0r+o1bJFlNNyQOkjnYB3DRT18/n/qloM2FUB5pQVBFn48HWJyadYC8k0CEbZJcN6G9WoyHdPHLZmZ48ELQTJMSdmkL5WjElxxtylFvm2wvsgyMEapKpqfAgY4RIFVTvjxpJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XglWJqmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60165C2BCB4;
	Wed,  6 May 2026 00:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778026599;
	bh=dvIk5huHsVcx4vNcUm/MtflXiy2orveWIsPJCGlqLsc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XglWJqmZd6Tp27XgkturLavhUn3s85nQlYdmjGmpqz7JUmPNrFh0Bk+wpCFN2VRuB
	 wDl36J4uSZS0tjFBBJ6wJZECKM7N9gr6CXkveox0o024wWxWTxqjNPhOYqayvVxRIq
	 lAJToHJ4dAr9qriYZFd28ZA+fpsoJuZdy/iiKwRTr+5RFA0L0fd5I4oSm+KPaCSfg7
	 tb8NSda7uIFJNQNv4TjkTWPgfaCS5nAV3bFuSrBJ8MsLWnXoLLLzKyEM0XsNjbpPlh
	 YJVx6d6vCRVqvtsy8b2Q6E5IsCrqr49kf6GUsHFPCBmluHXwYI752F665FhhpT1nTr
	 guZPtXMcT2uvQ==
Date: Tue, 5 May 2026 17:16:37 -0700
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
Message-ID: <20260505171637.17e20b98@kernel.org>
In-Reply-To: <afmz-dgqXjuIntRM@google.com>
References: <20260504-binder-netlink-v4-0-601b41cd25b2@google.com>
	<20260504-binder-netlink-v4-2-601b41cd25b2@google.com>
	<20260504165858.4882730b@kernel.org>
	<afmz-dgqXjuIntRM@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5C65F4D4F08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284623-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, 5 May 2026 09:10:17 +0000 Alice Ryhl wrote:
> On Mon, May 04, 2026 at 04:58:58PM -0700, Jakub Kicinski wrote:
> > On Mon, 04 May 2026 09:04:55 +0000 Alice Ryhl wrote:  
> > >  tools/net/ynl/pyynl/ynl_gen_c.py | 139 ++++++++++++++++++++++++++++++++++++++-  
> > 
> > No. Rust. In. This. File.
> > 
> > Just commit the artifacts. I truly hope that this is the only Netlink
> > family we will have in Rust.  
> 
> There's no reason to react like this. I have not ignored your concern.
> Last time we discussed this, the discussion ended on splitting the file
> into ynl_gen_c.py and ynl_gen_rust.py, which you did not reply to, and I
> actually spent some time working on that. However, I felt the change was
> non-trivial and I wanted to discuss whether that was the correct way
> forward before spending more time on it. Therefore, I kept this patch
> as-is for now and noted why it was non-trivial (sharing of CodeWriter)
> in the commit message, until we could discuss further.
> 
> I think you are probably right that just comitting the artifacts is the
> simplest way forward for now. Especially since Donald is apparently
> working on splitting up the file for strace [1]. On the off-chance that
> a second Netlink family is ever added, hopefully Donald's work has
> already completed and we can easily add this support in a new file when
> the time comes.
> 
> I guess another way forward is to commit a copy of the python script
> with the Rust support to drivers/android/binder/ and I can run it
> manually if the Binder yaml file is ever updated.

Could you _please_ do what I'm asking you to do instead inventing your
own solutions. Just commit the generated files and leave the script out.
We lived without Netlink code gen for 30 years.


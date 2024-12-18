Return-Path: <netdev+bounces-153125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0194D9F6EA1
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 20:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D1E188D75C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 19:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6270B1FA826;
	Wed, 18 Dec 2024 19:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mD8ts/MU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3849C157E82;
	Wed, 18 Dec 2024 19:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734551932; cv=none; b=KQ85BYm1OxoHJS3WmuikrAGd/EUpxu5FmWZ+i2hftDZiklgK3KIqnCZNcr4cKASdeMLrzIeyYtDIVHtNofVlQFj5sLQKN4CTi00I67dY5OEfI9za/PE6tLvw5v7A1ivJWI0hmFY9CkwGpJ86XS8SsvbbhxPQ34rmYKOwjkD36Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734551932; c=relaxed/simple;
	bh=64TEifuWzCtLWZ9wQ/LM35+YWk8+89ojp68myyOQLB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ECxipq8wjpVSi07L/RISIETjKgeOo3F9rz+ZcjWT3cPIpZtdZSwvKbttRjvYLp5BR0YEXh7j1MSPteQSMw7vvbueENKpQ8f2o2gAo++GSADRJ0SlaRe7cSMz1pHsdRZAmDPHSFjnULPc99GcivEK5eOznumikhW8GvYX6tSR+tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mD8ts/MU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404BDC4CECD;
	Wed, 18 Dec 2024 19:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734551931;
	bh=64TEifuWzCtLWZ9wQ/LM35+YWk8+89ojp68myyOQLB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mD8ts/MUKkYSzgN1rFvqQg+ow8GLBGzyr8Up6+/rBr/WCXhHbdxeh6YY9dpGTFoGh
	 J8OscPGLSpJDHWNbDlguHoa7BICahuHI3bd24KnfgmBwVn0KIFlhFMZrtJX+EWAFtW
	 nkbJoTcyoEiCp88CmV/orzz96MQSplFHxo3Qs0/MVFK+q8SuCKDCxTN4vW1hsZTE6N
	 FZsWH9zNgrJrFVx1WJtdpx5vlbJCqaGZmyA+ke3QDIPsYpZMWcpdJvGmOojWQTlCIQ
	 SVE98XkYddg1CRfgZqiB/fwQA08SjysVf3E5vt7E2dHVpuezM2edtsmAZ64c10sSGE
	 ccGV9Gid0/YqA==
Date: Wed, 18 Dec 2024 11:58:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, davem@davemloft.net,
 edumazet@google.com, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, aliceryhl@google.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] rust: net::phy fix module autoloading
Message-ID: <20241218115850.22cba4bc@kernel.org>
In-Reply-To: <da411dfa-3dac-4205-85f5-b99bc35f3333@redhat.com>
References: <20241212130015.238863-1-fujita.tomonori@gmail.com>
	<778db676-9719-4139-a9e3-8b64ffa87fd2@redhat.com>
	<20241217065439.25e383fe@kernel.org>
	<b701482d-760a-437b-b3fb-915dc3fc2296@redhat.com>
	<20241217074400.13c21e22@kernel.org>
	<20241217085124.761566e6@kernel.org>
	<da411dfa-3dac-4205-85f5-b99bc35f3333@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 11:04:25 +0100 Paolo Abeni wrote:
> >> I think I figured it out, you must have old clang. On Fedora 41
> >> CFI_CLANG defaults to y and prevents RUST from getting enabled.  
> > 
> > Still hitting a problem in module signing. 
> > Rust folks does this ring a bell?
> > 
> > make[4]: *** Deleting file 'certs/signing_key.pem'
> >   GENKEY  certs/signing_key.pem
> > ....+.........+++++
> > -----
> > 80728E46C07F0000:error:03000098:digital envelope routines:do_sigver_init:invalid digest:crypto/evp/m_sigver.c:342:
> > make[4]: *** [../certs/Makefile:53: certs/signing_key.pem] Error 1
> > make[4]: *** Waiting for unfinished jobs....
> > 
> > allmodconfig without Rust builds fine with both GCC and clang.  
> 
> FTR, I got a similar error (even without RUST) when I had
> 
> CONFIG_MODULE_SIG_HASH="sha1"
> 
> I moved to
> 
> CONFIG_MODULE_SIG_HASH="sha256"
> 
> since a while, and that fixed the issue for me (also
> CONFIG_MODULE_SIG_SHA256=y is needed).

Oh, some form of forced SHA1 deprecation in Fedora 41 possibly?
I switched to sha256 and that fixes the issue. We'll find out
if Rust is really fixed next time a Rust patch comes :)


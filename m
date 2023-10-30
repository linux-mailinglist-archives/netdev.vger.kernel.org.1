Return-Path: <netdev+bounces-45338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344467DC23C
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 23:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64FA91C20AAF
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 22:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE271D536;
	Mon, 30 Oct 2023 22:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvR5ETAi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8A11C6A0
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 22:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E14C433C8;
	Mon, 30 Oct 2023 22:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698703364;
	bh=hmXfhyRbFB4SPz5+yRItfsjgmm00F2inmvHFJjdkKno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RvR5ETAihQ5U2c7DCUaBHf5rLRTY7qPryACqOg949WLoqskyUaWZ/hZZNnkexHt8k
	 wtVkIuGSkB7Mn2QEayJQI5OxlQ3ussziOB8akYMqCBDaPvlhnbalpcfijwsS7U+XDL
	 A3tU0Bg7BibPrakvWPeWT9dTIywdyWQEZVnpWmYCIn4LBSdt2OOgjjN7VMf8ECXmoy
	 kZlrV7+5JL/bQW7qKACaLK8+u/w72NtV1WGscGxbB8ZrpnPVkX0opSyPM0tuvgJpfl
	 EO/XybBPox8uud+4Hox+NMgGZuIaQlsJLGc0+kYpC4vHSF3Fup/RT0gkTCsDWcamsY
	 7NcXIyqwx2s5g==
Date: Mon, 30 Oct 2023 15:02:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, David Miller
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Networking
 <netdev@vger.kernel.org>, Linux Crypto List <linux-crypto@vger.kernel.org>,
 Dmitry Safonov <0x7f454c46@gmail.com>, Dmitry Safonov <dima@arista.com>,
 Francesco Ruggeri <fruggeri@arista.com>, Salam Noureddine
 <noureddine@arista.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the crypto tree
Message-ID: <20231030150243.0e66ba73@kernel.org>
In-Reply-To: <ZT896a2j3hUI1NF+@gondor.apana.org.au>
References: <20231030155809.6b47288c@canb.auug.org.au>
	<20231030160953.28f2df61@canb.auug.org.au>
	<ZT896a2j3hUI1NF+@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Oct 2023 13:23:53 +0800 Herbert Xu wrote:
> If we simply apply this patch to the netdev tree then everything
> should work at the next merge window.  But perhaps you could change
> the patch description to say something like remove the obsolete
> crypto_hash_alignmask.  It's not important though.

I'm happy to massage the commit message and apply the fix to net.
But is it actually 100% correct to do that? IOW is calling
crypto_ahash_alignmask() already not necessary in net-next or does
it only become unnecessary after some prep work in crypto-next?

We can tell Linus to squash this fix into the merge of either
crypto-next or net-next, I'm pretty sure he'd be okay with that..


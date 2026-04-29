Return-Path: <netdev+bounces-282474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOxvEr1f8mnqqQEAu9opvQ
	(envelope-from <netdev+bounces-282474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 21:45:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F2B499DC9
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 21:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D9B830087E8
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3993835836B;
	Wed, 29 Apr 2026 19:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7gkKnUt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ECD346A08;
	Wed, 29 Apr 2026 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777491899; cv=none; b=BC01vI0b3TQxgty38GzTsQxMtd31VU1Ftwa6HvzdQHt/YOnY3ZXXFpHSD9j2/rQ4W+Q1cFlfOfQR7quf715Xt1a8XpmvqwrMKunZkddBm2SHUFji8Qbf96b4qr9TxDq/zX25OSW6Sv0towwmxAX0mYRJKnwTRseO9Hhg5srNGSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777491899; c=relaxed/simple;
	bh=s0/dTaIxNL0KrxhwLFFoQn+/ebIRYDw7l8AENrCVRw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJdFMSrXXoFodTP0LPZMMH+43EybQx/xLPd4q+qDVbG9WOcefhD+FY0KSYBWwfoHec/7KzmDFtMi4ssz/s2vNAbVkSjibOy1FsjhNzyLVwVUc+S4B3sGzTXixOV1WTeXltXPgbxAahDMOp8GVjkCvUp+47Ob+qUX0iyL3HZfN9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7gkKnUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1390DC19425;
	Wed, 29 Apr 2026 19:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777491898;
	bh=s0/dTaIxNL0KrxhwLFFoQn+/ebIRYDw7l8AENrCVRw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7gkKnUt3nxUjeHiJZAJs3IGsXePs+A8+VpGXMgx8GnHDX6FzWaefgDdM6W3Nbszk
	 hUo9nfkqfRdp8g5J/OX4RNRcyF32T4ktIflJ00gUDyWVA6CPEHKm+lFtHm9OGG9Wp3
	 auTF24QEgGX4dR2zZ7IIFZ7vMNnchCyI511ybCDwBVygM1x0v+eJKugtjGiV4pizJi
	 CLeR2ry8K3DCfQTSrWEU57CdhHPnFhYk1XLRR+OlZZlVqHHAhlGWNU/PoQnpt2TAwB
	 T56bJrR6Cdk/f2dJ9YVrxO7fMzTW7n1ulW1XwUv8ZGI9F6tjIlrc3EgzPSGOZuZUxL
	 muBh/zjQ/MLeg==
Date: Wed, 29 Apr 2026 19:44:56 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, edumazet@google.com,
	ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	ardb@kernel.org, Jason@zx2c4.com, herbert@gondor.apana.org.au,
	0x7f454c46@gmail.com
Subject: Re: [PATCH net-next v2 1/5] net/tcp-ao: Drop support for most
 non-RFC-specified algorithms
Message-ID: <20260429194456.GA621449@google.com>
References: <20260427172727.9310-2-ebiggers@kernel.org>
 <20260429185828.1539480-2-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429185828.1539480-2-horms@kernel.org>
X-Rspamd-Queue-Id: E1F2B499DC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282474-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,zx2c4.com,gondor.apana.org.au,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 07:58:29PM +0100, Simon Horman wrote:
> Is this a uAPI regression for existing users of TCP_AO_ADD_KEY?
> 
> Before this change, tcp_ao_add::alg_name accepted any crypto_ahash
> algorithm name.  The commit message itself notes "arbitrary HMAC algorithms
> probably do work", and the selftest prior to this patch exercised
> hmac(sha512), hmac(sha384), hmac(sha224), hmac(sha3-512), hmac(rmd160) and
> hmac(md5), which demonstrates those configurations were functional in
> practice.
> 
> A setsockopt call that previously succeeded with e.g. alg_name =
> "hmac(sha512)" now returns -ENOENT after a kernel upgrade, with no
> deprecation window, no Kconfig opt-in, and no runtime toggle.  HMAC-SHA512
> in particular seems like a plausible choice that a deployment may already
> rely on.
> 
> Would it make sense to keep hmac(sha512) (and possibly hmac(sha384)) in the
> accepted list, or to gate the removal behind a Kconfig/sysctl while warning
> for a few releases?

This is intentional and has already been explained and discussed
extensively.

> Also, -ENOENT is the same error returned when the crypto module for an
> otherwise-accepted algorithm is simply not built in.  Should a distinct
> errno (for example -EOPNOTSUPP) be used here so userspace can tell
> "algorithm rejected by policy" apart from "algorithm module missing"?

This review seems a bit inconsistent, as now it's advocating *for* a
UAPI change.  I suggest we just stay with ENOENT, as this patch does.

> > diff --git a/tools/testing/selftests/net/tcp_ao/config b/tools/testing/selftests/net/tcp_ao/config
> > index f22148512365..47228a7d0b90 100644
> > --- a/tools/testing/selftests/net/tcp_ao/config
> > +++ b/tools/testing/selftests/net/tcp_ao/config
> > @@ -1,6 +1,5 @@
> >  CONFIG_CRYPTO_CMAC=y
> >  CONFIG_CRYPTO_HMAC=y
> > -CONFIG_CRYPTO_RMD160=y
> >  CONFIG_CRYPTO_SHA1=y
> >  CONFIG_IPV6=y
> >  CONFIG_IPV6_MULTIPLE_TABLES=y
> 
> Should CONFIG_CRYPTO_SHA256=y (and possibly CONFIG_CRYPTO_AES=y) be added
> here?

This is an existing bug, which patch 2 fixes by making CONFIG_TCP_AO
select the algorithms it uses.

> > diff --git a/tools/testing/selftests/net/tcp_ao/key-management.c b/tools/testing/selftests/net/tcp_ao/key-management.c
> > index 69d9a7a05d5c..d86bb380b79f 100644
> > --- a/tools/testing/selftests/net/tcp_ao/key-management.c
> > +++ b/tools/testing/selftests/net/tcp_ao/key-management.c
> 
> [ ... ]
> 
> > -const char *test_algos[] = {
> > -	"cmac(aes128)",
> > -	"hmac(sha1)", "hmac(sha512)", "hmac(sha384)", "hmac(sha256)",
> > -	"hmac(sha224)", "hmac(sha3-512)",
> > -	/* only if !CONFIG_FIPS */
> > -#define TEST_NON_FIPS_ALGOS	2
> > -	"hmac(rmd160)", "hmac(md5)"
> > -};
> > +const char *test_algos[] = { "cmac(aes128)", "hmac(sha1)", "hmac(sha256)" };
> 
> With the FIPS/algorithm-probing logic removed and roughly one third of
> generated keys now using hmac(sha256), and with the kernel side now
> returning -ENOENT for non-whitelisted algorithms, tcp_sigpool_alloc_ahash()
> will fail for every hmac(sha256) key on a kernel built from this config
> unless CRYPTO_SHA256 is selected.
> 
> CRYPTO_SHA256 is not implied by CRYPTO_HMAC or TCP_AO, so on a kernel built
> strictly from tools/testing/selftests/net/tcp_ao/config the tests would
> appear to fail rather than be skipped.  Can the config fragment be updated
> to match the new required algorithm set?

Again, this is an existing bug, which patch 2 fixes by making
CONFIG_TCP_AO select the algorithms it uses.

> One more question, on the commit message and documentation rather than the
> diff: Documentation/networking/tcp_ao.rst still describes TCP-AO as "May
> support any hashing algorithm"

That "May support any hashing algorithm" statement has always been
incorrect, so I wouldn't pay much attention to it.  It also appears in a
table describing TCP-AO as a protocol, not the kernel's implementation.

> and does not mention the newly enforced
> whitelist or the -ENOENT failure mode.  Should tcp_ao.rst be updated in
> this patch to list the accepted algorithm strings and the rationale (e.g.
> the 20-byte TCP option MAC cap), so userspace has a documented contract?

As stated in the commit message, the list of MAC algorithms supported by
the kernel's implementation of TCP-AO has always been undocumented.  It
should be documented, but I would suggest documentation improvements
belong in a separate patch.

- Eric


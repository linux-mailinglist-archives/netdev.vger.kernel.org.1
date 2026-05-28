Return-Path: <netdev+bounces-292892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CK3QAUXPGGqunggAu9opvQ
	(envelope-from <netdev+bounces-292892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:27:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C75A25FB692
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A1E430D4A23
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FB336D9F1;
	Thu, 28 May 2026 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="HMvn/BAD"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8475736C0BD;
	Thu, 28 May 2026 23:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010652; cv=none; b=mxWGv9DEEQ07/vyurJaT2fhDxkZbpZ4Wp3onzWBBbQVWJRvp1U1kDXrSG30bGv7Pd8h+X1VlroKP7QgJyreXdr2SJa5PQ2LINIOFStGuArxYr2uOji2fFw0iHYjWBcEdLsuf4V+VSfj90cf1+kSYDkHPhDxyEFNMy3Tq1l9RCEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010652; c=relaxed/simple;
	bh=hXRI8pfr26o6q/3esmAA2MiquFHTg5G5hTsEehgBKrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaaOYgAfYtqzKnaEcLAszE/Hl1C6vzbVWpMVw7EJpVOy2FuFIGgXOO1emAfY/Jc+9oebWjAtaFb+OMBOC/pzf30z5p+ry/DH5flg4LCWZ687QXL2LRJ/DddT++ArbtHPYLvf1QqbExcg+9KaNqFzWt6E0VUS+6RCRoVJRBh4L1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=HMvn/BAD; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=aD/+6gFCYQh5HNcAXs9wYEDF3vBE3AuA9RB/SyyLfAA=; 
	b=HMvn/BADPsIDm9luuhFAVwZrm92JE01uHvyPY5ACtFqSGons4TDEckc19TkOKc6IYu4uol/MmrL
	yzzvCYeg273B1VTorRlWV8JZf9xCb5M/iqskusC4Kg6lL7JnjKSnxnVwaySVGMsTys4KLKhJ/o+nw
	vutgbd9IED0pCpXc5hLhsdCWfr9Ec2o7FpO/CPvL9N/P52QjadqpBZHBY1c3jWQ0UY8Tam+hPG5xC
	MLSBAtU7ft4fpNtxmxYECeZdN12k4f8SsyocU+RT9zS8VPQRNSSotIgCKEWcsGUf629/IzsnXaSwY
	iHTjIlnvCgoyN0wus8yQdlRo0wjCHzLgP7Cw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wSk4w-000Z2S-2v;
	Fri, 29 May 2026 07:23:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 29 May 2026 07:23:54 +0800
Date: Fri, 29 May 2026 07:23:54 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH net-next 0/6] Remove unused support for crypto tfm cloning
Message-ID: <ahjOivAIjKclB783@gondor.apana.org.au>
References: <20260522053028.91165-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522053028.91165-1-ebiggers@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,zx2c4.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-292892-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,apana.org.au:url,apana.org.au:email]
X-Rspamd-Queue-Id: C75A25FB692
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 12:30:22AM -0500, Eric Biggers wrote:
> This series is targeting net-next because it depends on
> "net/tcp: Remove tcp_sigpool".  So far no commits in cryptodev conflict
> with this, so I suggest that this be taken through net-next for 7.2.
> 
> This series removes support for transformation cloning from the crypto
> API.  Now that the TCP-AO and TCP-MD5 code no longer uses it, it no
> longer has a user.  And it's unlikely that a new one will appear, as the
> library API solves the problem in a much simpler and more efficient way.
> 
> This feature also regressed performance for all crypto API users, since
> it changed crypto transformation objects into reference-counted objects.
> That added expensive atomic operations.  The refcount is reverted by
> this series, thus fixing the performance regression.
> 
> A subset of this was previously sent in
> https://lore.kernel.org/r/20260307224341.5644-1-ebiggers@kernel.org
> Compared to that version, this version is a bit more comprehensive.
> 
> Eric Biggers (6):
>   crypto: hash - Remove support for cloning hash tfms
>   crypto: cipher - Remove crypto_clone_cipher()
>   crypto: api - Remove crypto_clone_tfm()
>   crypto: api - Remove per-tfm refcount
>   crypto: api - Fold __crypto_alloc_tfmgfp() into __crypto_alloc_tfm()
>   crypto: api - Fold crypto_alloc_tfmmem() into crypto_create_tfm_node()
> 
>  crypto/ahash.c                   | 70 -----------------------------
>  crypto/api.c                     | 76 +++++---------------------------
>  crypto/cipher.c                  | 28 ------------
>  crypto/cmac.c                    | 16 -------
>  crypto/cryptd.c                  | 16 -------
>  crypto/hmac.c                    | 31 -------------
>  crypto/internal.h                | 10 -----
>  crypto/shash.c                   | 37 ----------------
>  include/crypto/hash.h            |  8 ----
>  include/crypto/internal/cipher.h |  2 -
>  include/linux/crypto.h           |  1 -
>  11 files changed, 10 insertions(+), 285 deletions(-)
> 
> 
> base-commit: 1a1f055318d82e64485a6ff8420e5f70b4267998
> -- 
> 2.54.0

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


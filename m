Return-Path: <netdev+bounces-30768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2B078903A
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 23:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6AF2281883
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 21:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E1F193A9;
	Fri, 25 Aug 2023 21:13:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0549819386
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 21:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0ECC433C7;
	Fri, 25 Aug 2023 21:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692998035;
	bh=uiXkyRVOSV4tA0Dr9xfhgTNwejV2oZiBsqM/hZn5yPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UgSWvtl49FkDkaRYO3r0z4VzYK/yDU2hQmm5FUy/saN2DaYbzz5vuhxj+oTpq/YEz
	 6iPySb9lNptNeguxiheMPfLw58USp34CyI6yLgGfRUu28v0iNMZb16krVHW1DR7eer
	 X7/UJR9hvVw1WO8f9x3khDGmYa5/plHR8kM491NKMqEuNO4Pw9iZDNRrB6DqgVa63r
	 +IjWV8he6N0kCyEWrQbC5VfgXNT058QGjrBf2pO6OG6y8NaLAaMZTNAT4pmMeyQyKD
	 eh10XcSY2us9pZi/URLX1z5VvUzlXT9gvz7Jlc/CvSoA1f7ssDARtN21vNHvUsEQko
	 AuIIYRR5eP06A==
Date: Fri, 25 Aug 2023 14:13:52 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-fscrypt@vger.kernel.org,
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
	ceph-devel@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <martineau@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
	linux-nfs@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ayush Sawal <ayush.sawal@chelsio.com>
Subject: Re: [PATCH 1/12] fscrypt: Do not include crypto/algapi.h
Message-ID: <20230825211352.GB1366@sol.localdomain>
References: <ZOXf3JTIqhRLbn5j@gondor.apana.org.au>
 <E1qYl9q-006vDd-FJ@formenos.hmeau.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qYl9q-006vDd-FJ@formenos.hmeau.com>

On Wed, Aug 23, 2023 at 06:32:15PM +0800, Herbert Xu wrote:
> The header file crypto/algapi.h is for internal use only.  Use the
> header file crypto/utils.h instead.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> ---
> 
>  fs/crypto/keysetup_v1.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/crypto/keysetup_v1.c b/fs/crypto/keysetup_v1.c
> index 75dabd9b27f9..d698ecb9ad44 100644
> --- a/fs/crypto/keysetup_v1.c
> +++ b/fs/crypto/keysetup_v1.c
> @@ -20,8 +20,8 @@
>   *    managed alongside the master keys in the filesystem-level keyring)
>   */
>  
> -#include <crypto/algapi.h>
>  #include <crypto/skcipher.h>
> +#include <crypto/utils.h>
>  #include <keys/user-type.h>
>  #include <linux/hashtable.h>
>  #include <linux/scatterlist.h>

Acked-by: Eric Biggers <ebiggers@google.com>

- Eric


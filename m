Return-Path: <netdev+bounces-29962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A3E785586
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 12:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1343B1C20CB2
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 10:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AA28F77;
	Wed, 23 Aug 2023 10:35:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57E3A944
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 10:35:18 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB40CEF;
	Wed, 23 Aug 2023 03:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dWTFqHYz8fPSN7BLKAD0EIV85Zk+mX8TWHKPbvtc7n0=;
	t=1692786917; x=1693996517; b=L+/Je8um6pZekz0R2aUMLNlw6lkXDjK8P2amNLYDPSFXQns
	m0ZSQiwzlvARK6wkt4XtAR1YkgzFkCCZmCG4QwqHJ5pw+tlVoZvxVvecuTaZ/vec3x3Av1Du2zZwJ
	5MseqZuripf3RgxMFWaKrd2FRyu6CTcA20pBgFoT1+F0MFrZB3dmfDdCpYaOenEc9NZn1rXFlKwK3
	6C8Cui7eSiEfrO+PWqxg+KB66V22f3p+JyrFO/RXudYLy8G70Dvk0lNJU0vpP1pPZnxNcolMSDKHP
	zzIphQQjZcJeXY2aPGM0l9WH07NEgh5o0Rxg0E2X7O13hTiTLNbqXHH5I5qrLXSQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qYlCD-006xpQ-1Z;
	Wed, 23 Aug 2023 12:34:41 +0200
Message-ID: <d776152a79c9604f4f0743fe8d4ab16efd517926.camel@sipsolutions.net>
Subject: Re: [PATCH 6/12] wifi: mac80211: Do not include crypto/algapi.h
From: Johannes Berg <johannes@sipsolutions.net>
To: Herbert Xu <herbert@gondor.apana.org.au>, Linux Crypto Mailing List
 <linux-crypto@vger.kernel.org>, Eric Biggers <ebiggers@kernel.org>, 
 "Theodore Y.Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, 
 linux-fscrypt@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
 linux-mtd@lists.infradead.org, Marcel Holtmann <marcel@holtmann.org>, Johan
 Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>,  linux-bluetooth@vger.kernel.org, Ilya Dryomov
 <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, Jeff Layton
 <jlayton@kernel.org>,  ceph-devel@vger.kernel.org, Steffen Klassert
 <steffen.klassert@secunet.com>,  "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, Matthieu Baerts
 <matthieu.baerts@tessares.net>, Mat Martineau <martineau@kernel.org>, Chuck
 Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
 linux-nfs@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
 linux-integrity@vger.kernel.org, "Jason A.Donenfeld" <Jason@zx2c4.com>,
 Ayush Sawal <ayush.sawal@chelsio.com>
Date: Wed, 23 Aug 2023 12:34:35 +0200
In-Reply-To: <E1qYlA0-006vFr-Ts@formenos.hmeau.com>
References: <ZOXf3JTIqhRLbn5j@gondor.apana.org.au>
	 <E1qYlA0-006vFr-Ts@formenos.hmeau.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-08-23 at 18:32 +0800, Herbert Xu wrote:
> The header file crypto/algapi.h is for internal use only.  Use the
> header file crypto/utils.h instead.
>=20

No objection, of course, but I don't think it's necessarily clear that
it "is for internal use only", it literally says:

 * Cryptographic API for algorithms (i.e., low-level API).

which really isn't the same as "don't use this file".

Might want to clarify that, or even move it into crypto/ from
include/crypto/ or something?

johannes


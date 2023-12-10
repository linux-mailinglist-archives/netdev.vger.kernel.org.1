Return-Path: <netdev+bounces-55651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E2280BD3F
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 22:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB0C1C20363
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 21:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257861CAAA;
	Sun, 10 Dec 2023 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandelman.ca header.i=@sandelman.ca header.b="rcH1/kUy"
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 8315 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 10 Dec 2023 13:06:14 PST
Received: from tuna.sandelman.ca (tuna.sandelman.ca [IPv6:2607:f0b0:f:3:216:3eff:fe7c:d1f3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54152EA
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 13:06:14 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by tuna.sandelman.ca (Postfix) with ESMTP id 1341C1800F;
	Sun, 10 Dec 2023 16:06:13 -0500 (EST)
Received: from tuna.sandelman.ca ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3UotCyQNFfGZ; Sun, 10 Dec 2023 16:06:12 -0500 (EST)
Received: from sandelman.ca (obiwan.sandelman.ca [209.87.249.21])
	by tuna.sandelman.ca (Postfix) with ESMTP id 61CB81800C;
	Sun, 10 Dec 2023 16:06:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandelman.ca;
	s=mail; t=1702242372;
	bh=PdKNTHfjRVnW9XAcA0bNPI/5ArYNtMOoJkkrRJ+9A5o=;
	h=From:To:cc:Subject:In-Reply-To:References:Date:From;
	b=rcH1/kUyaNq7XELO12ln4fePa4MzAQ0DKLi1nFGjhToE1NFETi55e9JnP7y27Dcug
	 hoBiMmjNTXa4o4glYRP+RfLwSg04GwFa5h31YE7BK6Y0G3h0fY4G5WhOkbB1GRvfrA
	 OvftggGqBNhgYHYA3aDIwOFhFhYzFGoSqS1PjvCvbKg8bEqsO0crD21svotu0v7i/S
	 upweLZg4Z15ZSnBxf9C3aa92XSEfUUK98cD94JlEbTbZT+6G3gDlErjJo2OD+Xxhbs
	 qPW2MgguSjwNCo2GKjVqz8/BhUkDZYq7b8Z+JQ6BlpGu/ctYAfCawOJvX8g6Q6QbA+
	 +8MYRL1vZI0DQ==
Received: from localhost (localhost [IPv6:::1])
	by sandelman.ca (Postfix) with ESMTP id 5968637B;
	Sun, 10 Dec 2023 16:06:12 -0500 (EST)
From: Michael Richardson <mcr@sandelman.ca>
To: Eyal Birger <eyal.birger@gmail.com>
cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com,
    herbert@gondor.apana.org.au, pablo@netfilter.org, paul@nohats.ca,
    nharold@google.com, devel@linux-ipsec.org, netdev@vger.kernel.org
Subject: Re: [devel-ipsec] [PATCH ipsec-next, v2] xfrm: support sending NAT keepalives in ESP in UDP states
In-Reply-To: <CAHsH6GtmOjHK-504JSvGeTLxct3JQjzDGq5nr9GO8fm=pjmU-A@mail.gmail.com>
References: <20231210180116.1737411-1-eyal.birger@gmail.com> <15709.1702234055@localhost> <CAHsH6GtmOjHK-504JSvGeTLxct3JQjzDGq5nr9GO8fm=pjmU-A@mail.gmail.com>
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; GNU Emacs 28.2
X-Face: $\n1pF)h^`}$H>Hk{L"x@)JS7<%Az}5RyS@k9X%29-lHB$Ti.V>2bi.~ehC0;<'$9xN5Ub#
 z!G,p`nR&p7Fz@^UXIn156S8.~^@MJ*mMsD7=QFeq%AL4m<nPbLgmtKK-5dC@#:k
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sun, 10 Dec 2023 16:06:12 -0500
Message-ID: <9055.1702242372@localhost>

--=-=-=
Content-Type: text/plain


Eyal Birger <eyal.birger@gmail.com> wrote:
    >> As a general comment, until this work is RCU'ed I'm wondering how it
    >> will perform on systems with thousands of SAs. As you say: this is a
    >> place for improvement.  If no keepalives are set, does the code need
    >> to walk the xfrm states at all.  I wonder if that might mitigate the
    >> situation for bigger systems that have not yet adapted.  I don't see a
    >> way to not include this code.

    > The work isn't scheduled unless there are states with a defined
    > interval, so afaict this shouldn't affect systems not using this
    > feature. Or maybe I didn't understand your point?

That wasn't obvious to me from my review, but that certainly sounds ideal.
Thank you.





--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCgAvFiEEbsyLEzg/qUTA43uogItw+93Q3WUFAmV2KEQRHG1jckBzYW5k
ZWxtYW4uY2EACgkQgItw+93Q3WVXpQgAngIZGAUhDxAIPLmtl7N9OWR1ZS1rPIoF
TdG4DfxmznIyW5jSolCkQsSZaf6G6uCnfryPjaLQooiOLZN7blSJk7oz3WUxV6t1
TF3/CsoXwqZkJTh4cupg3IUXZUF3j4DrETLyCj3nrOmiJqxvSjW+D7Y7XzXdlhqy
QA8nvSCxJAQBP0KVwy1hK4JZhKLsOsikpJF/+pHrhiaUIbTyHpokRTlpMgkAbB0Q
D2kzqW4mvRDiu6Ch11vVkJTXgPSx2m5LNiOvFGanIx2V7z9icmvfyza1I/qLAm3A
Vu+gsZANAE7HjQgBrYeBHSAHo3bQOeAa9FLcRQp8Wl8VjpIdK9kfFw==
=xV68
-----END PGP SIGNATURE-----
--=-=-=--


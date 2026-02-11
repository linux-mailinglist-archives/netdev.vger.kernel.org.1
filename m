Return-Path: <netdev+bounces-258335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CmfKnzKjGlktAAAu9opvQ
	(envelope-from <netdev+bounces-258335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 19:29:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC43126DBF
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 19:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB96D300788A
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3FC352C37;
	Wed, 11 Feb 2026 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0U9Gq2h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A408534FF63
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770834553; cv=pass; b=FgqS+MWw0KxwmrbF6J3EMFI0ORu4BGlJTmsxp8a/4IuFdgsOk71Hh5Ef8om9fN0v01nJC2FHy/WaZXl2bHdZ+PoZqWOe3LTWWZWd8wUcYtheGEhOZOnncN5xLFYo4z8Z+HiD+gNcB320qBWXlrhdN29dv+fi+QvZItEwrdO/8lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770834553; c=relaxed/simple;
	bh=dDzGtvolRcT+mDdSSCyQ+GMVHlOOaeuElBzmTDizgZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u08W14dAsWf+lJ1LosNdaIgNYtO3ORjlMxv+QB1CEQ1RMYHydS66lA9klO9e6vh8w4438b3eklAa2v3L1qiD2s0ovzUvh8d8Sle8KIhDJM6tEkIaXEsyP2xHkdnRRW0hFpjaeElCEI5VwcmiqVs9VlOA0bQ8gY0xj3qFG4TQne0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0U9Gq2h; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso861619a91.1
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 10:29:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770834552; cv=none;
        d=google.com; s=arc-20240605;
        b=Z69SiiZTlTntsqtAZgDb2gesR3DQZEeuZ3jHkvhoxxaZiJwOcF9U1VoMes7E+VP/XF
         ie8WzGuiGagcFTIfhd8Mhd/MdQV7pmERf0ZuqRpitWItyt4OwyVtPGFZgfJ/zLbr14/L
         KZOOo/Qhi1z+6ZdFjL9MJN9K4n6dhjvigxTMGSxzINjvmTS3FRFSSsBuS1wbZ9QbjKAo
         EtKKNhYviUB5VkTK+0sc16A/ikq4aWKZaZx153RIA3BXO1DXPOdMyYAEhMUkgoG7NlYm
         KOjLwiTVOP1u9BFFkPozUXIcdz3MQs6Xiiekl0/yl/DFySKd4oYLfdWmiscRZkKi89Zb
         mpFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W/et8SsTsAieKZFKqvk+uM9q5eB1Cyn0GJnSaqg4nOo=;
        fh=7ydaQ9ymFSq3Qj7ComF7ttJTQSfmFe8O8iD2CDMmDc4=;
        b=VvyPkD015+9/Hll+A4MLaleX4ESnaPcTATlDVJefFW5O0ZXZyzCNeCcMy5HxzWyZgu
         X/m2Fz7Oma0K6BNlKddY6YLPO3n6dMD3HysZu1xNAcZry44rnXXyeFq7bAaFLf2fg50a
         77VJY39AWOnJfhu1OucJnpmOO6B+5Y6yqSlgvlaHGCPiOWHAyowxIar6zBkwevNYeXmJ
         RPGqdqD+j8an7BrmIVOOExSEMwyvKujmOF/FMWQ2GWuwTXXh/LKhDRAvk8NBiwzOUG+b
         yHFKkeiSNYfYAmGLKPe5q5xhbj/h7rKB5JD90ZA6yPnBUEKKvEIRa3LrA9Td8/m/E8Zf
         cubw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770834552; x=1771439352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/et8SsTsAieKZFKqvk+uM9q5eB1Cyn0GJnSaqg4nOo=;
        b=c0U9Gq2hhee53vPTYwaO+xyU66zvG+ozCs2hhRw0wi2/+pMwFR3+twSwH+7ottQbB3
         0iV1uEj+eRuyEZ61QkiE/3CKZGo40rbRBRkf8XNk8d9BVUEtAUnVc06oPzxogYeJV2vQ
         ay2ez4k5qlsy07tJlCtVO/B58iz1z3SOMYZ2+rZIdM2I7t6TSrkCOh1mjc2YhblL21B3
         /AKBhiZppF9ogpiZHSeMWiNq5G6HRNws547lqHhp7hnXXzZOrBW/0Erc9F0y7NKcdrsT
         AzigMBZl6c4YIO+qkyKzfI0Q8fbmnQ+OzvlKs3Zh+FH8PEdwggAGw+LmZfPKrsE8rqdT
         Tdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770834552; x=1771439352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W/et8SsTsAieKZFKqvk+uM9q5eB1Cyn0GJnSaqg4nOo=;
        b=COGOc1gAl7jpCJJoVHDsRiUwDt6EtaUVpzSX0aw2hsTY2U+/SLsPz0UlutQUAX5BeF
         11xu6QeBT1xT2KSXlxI8tD9pJDFg9acRE4H2TydRu1QtX4bQSkLezWe6FE86Yw/1KMGl
         547rWVFEBK/KRmPOPARKnaarzuDscB2QH/nk+MPs5dxfSgW80GvoMOwEvPeJaTcpvLNn
         lv1GRk6Lazp4UuYOgerk3LIZ+rha1bZMb0vBTlgy4AFpCt1km24q5l454NJCqmHbFOYe
         nmoPImSs7a7tL2ZRDYoZre2DQJsY7W/OiSKoiRX1a7k9R1VDlJAXhtwr1lIEfv3xxiAn
         qVCA==
X-Gm-Message-State: AOJu0YzFCBMfKxNRk9gZaI7T7n3YuXBoGk4WKNCnqsZvDYrJCSRPcD+4
	1dgQSTnmOIW3jzDAdx0b0dxV+uq5daTafWYfU90K0IY5jT1fG5+/WE7yaC2Ata1rinH0/SaLNg8
	XXtCAdW9eGSugoXROiZUxv/zesPk3M2272uf8
X-Gm-Gg: AZuq6aIRyNddLTGntXXnxdx04rYYfxMkgA2V4kcU9UeVswHqvMnyqIxxDK3h+DuzDc4
	tPTtatLO1BEFfuNziYzfPTpcQ1AdedS/g9bjUdAeaWyMBWXin+4A+tZuh3Vpsg8wVkFV17O5tOM
	Kt4Vu3itDrCaga2jk/PByiWXkftM2abvVsw0AR4ZoXg90nkIm0dzoYm5tfLj1AsvE3kjOG0ReNj
	JuAIv8n4qkNq+9QlbDBuw/a3Dm3GoBmMMiU13zuoz1JvofQqfBoXstVvlUVbG9CRlJtrWYtnSWi
	g5aDcUIDf2QfxbXwFXMhbhT/GKGmsRE3YRSER5K176HaSK9661kRiuHoAF6iVw8znRXi9Q==
X-Received: by 2002:a17:90b:4f8d:b0:354:57eb:c826 with SMTP id
 98e67ed59e1d1-3568f30b6c4mr260508a91.2.1770834551889; Wed, 11 Feb 2026
 10:29:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770399836.git.marcdevel@gmail.com> <19761bd8088ea7bab2b8c37461aa77be08082fc4.1770399836.git.marcdevel@gmail.com>
 <20260210181106.0f4a305a@kernel.org>
In-Reply-To: <20260210181106.0f4a305a@kernel.org>
From: Marc Sune <marcdevel@gmail.com>
Date: Wed, 11 Feb 2026 19:29:01 +0100
X-Gm-Features: AZwV_QhYdQrdU9Rstfhr1ZG6k4WhGTbHgj1QUT8hKdoXAHGhAMKk_NrPbIhVSgI
Message-ID: <CA+3n-TpV8pg9exk15vGpPX3OW1-k-pLSiixUZ2UEvbFOgcc0+g@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/4] selftests/net: add no ARP b/mcast,null
 poison test
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258335-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcdevel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,amt.sh:url,arp_ndisc_evict_nocarrier.sh:url]
X-Rspamd-Queue-Id: 4DC43126DBF
X-Rspamd-Action: no action

Missatge de Jakub Kicinski <kuba@kernel.org> del dia dc., 11 de febr.
2026 a les 3:11:
>
> On Sat,  7 Feb 2026 21:40:34 +0100 Marc Su=C3=B1=C3=A9 wrote:
> > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selft=
ests/net/Makefile
> > index afdea6d95bde..c6d571bf72be 100644
> > --- a/tools/testing/selftests/net/Makefile
> > +++ b/tools/testing/selftests/net/Makefile
> > @@ -11,6 +11,7 @@ TEST_PROGS :=3D \
> >       amt.sh \
> >       arp_ndisc_evict_nocarrier.sh \
> >       arp_ndisc_untracked_subnets.sh \
> > +     arp_no_invalid_sha_poision.sh \
> >       bareudp.sh \
> >       big_tcp.sh \
> >       bind_bhash.sh \
>
> Not sure why but we get:
>
> # selftests: net: arp_no_invalid_sha_poision.sh
> # Warning: file arp_no_invalid_sha_poision.sh is missing!
> not ok 1 selftests: net: arp_no_invalid_sha_poision.sh
>
> When we run
>         make TARGETS=3Dnet run_tests
>

It seems to work for me (typo already fixed):

sudo make TARGETS=3Dnet run_tests

[...]

# timeout set to 3600
# selftests: net: arp_no_invalid_sha_poison.sh
# TEST: 1.1  ARP no poisoning dmac=3Dbcast reply sha=3Dbcast              [=
 OK ]
# TEST: 1.2  ARP no poisoning dmac=3Dbcast reply sha=3Dnull               [=
 OK ]
# TEST: 1.3  ARP no poisoning dmac=3Dbcast req   sha=3Dbcast              [=
 OK ]
# TEST: 1.4  ARP no poisoning dmac=3Dbcast req   sha=3Dnull               [=
 OK ]
# TEST: 1.5  ARP no poisoning dmac=3Dbcast req   sha=3Dmcast              [=
 OK ]
# TEST: 1.6  ARP no poisoning dmac=3Dbcast reply sha=3Dmcast              [=
 OK ]
# TEST: 1.7  ARP no poisoning dmac=3Dveth0 reply sha=3Dbcast              [=
 OK ]
# TEST: 1.8  ARP no poisoning dmac=3Dveth0 reply sha=3Dnull               [=
 OK ]
# TEST: 1.9  ARP no poisoning dmac=3Dveth0 req   sha=3Dbcast              [=
 OK ]
# TEST: 1.10 ARP no poisoning dmac=3Dveth0 req   sha=3Dnull               [=
 OK ]
# TEST: 1.11 ARP no poisoning dmac=3Dveth0 req   sha=3Dmcast              [=
 OK ]
# TEST: 1.12 ARP no poisoning dmac=3Dveth0 reply sha=3Dmcast              [=
 OK ]
ok 25 selftests: net: arp_no_invalid_sha_poison.sh

Not sure why you are getting this error, and why selftests didn't fail
in any of the 4 versions in patchwork. I assume tests run there too.

> The word "poison" is misspelled but both in the file name and makefile.
> I guess there's another typo somewhere.

Sigh. Let me fix that, along with your comment on patch 4
(TEST_GEN_FILES vs. _PROGS) on the other thread. I will also fix some
AI review warnings (error traces) on patch 4 that AI reviews _now_
highlighted. It seems AI reviews are non deterministic, as
ndisc_send.c didn't change since v2, and the patch didn't even change
v3->v4.

I guess you'd like me to wait till net-next is open again, correct?

Thank you for the guidance Jakub.


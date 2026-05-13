Return-Path: <netdev+bounces-287469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFvcJEswBGo/FAIAu9opvQ
	(envelope-from <netdev+bounces-287469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:03:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B0452F444
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0A1030234C8
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 08:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7784E368D7F;
	Wed, 13 May 2026 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="avEvRrMQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB893EDE4C
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659395; cv=pass; b=mszkO19S+jpu95klNsYH4RrSYuLKKvKaOx3I58358UPN3Tq99hmvmiDPulheYrV4tnQcoeTGaEyt/M8WeF79iepCFdIiFRgozyYaNGlZnmGVDSewcCK/dXlTwKlpi9p7DRdWSxmLBKo5VxHlsB9b6L6vrspK7xvVgAVapdkXLRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659395; c=relaxed/simple;
	bh=1EHfeuMa3Db9m+t3jdLMFF//d5nn0OX97H+SeJpgQyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tr8mzq3jpWdGkjUkVW3am5TVqH2XxtP7415Mxv+U+bsx8QhGmU7bQeqI1kpMIZPGILvM0p/pludX4mIE33dIY6O6+6HgXSflCUBelJOc/+kflxeI4f+/P0++HN1qCIsjyfbmeQ0E+mVNJ6ddA63xixoJpvcFjXKrlwLinBKgkdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=avEvRrMQ; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8b6ea7716bfso70100896d6.0
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 01:03:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778659393; cv=none;
        d=google.com; s=arc-20240605;
        b=DDGze3C2PJ2RJRmSZUypJjNlsRtewUN7dF6YgkVygQtRQoJU8zOJr2xz+nMyzKtVuh
         RrO+QYN+ywfnliT7+nmd1xIlX2eMxKa6H+VNuypB+n2TWF8AJOtDOjI99G4IqOecs6/l
         dwUkLZO5ddMyLMNI4O3+Uc3THyUFzyUcIzxXGeGbVQumI0pGzsS5GTOriJ2O8X5c9ooC
         2DA4v8NMV25yscfwdmFVTURp6P/ygUxbxpMaSIJwfVDSBlBBcMHciOi7u8PP8xGbjs+F
         85wK74Rtoi1HehHlGM2PDRKLtWGLnrGM4HcbxrnYzrPt0NUfND/TJ+WMyUcOFEWXcIsc
         3uVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tc72CNmNkwvkSW1iaWQN9XjdiXKoqPVbY4p4w90gIX0=;
        fh=W6nrJ2EqRgLjPf2G2a+VHom5dBVLXphHIfJzlrng1nE=;
        b=XGnXaSfw+LuFkeFPa7Z9cTory1luIxhveaoXYaBoFVNV/mAoLIXra0qLWfjIHl3leG
         nPMq86Kyq7cKjB4XZN1iYHx+fRR6McgJSJFwyr7HiW2HXcZiBGVXoZ8jvO3T5CiigmgJ
         Wt1R2pIvdQcKuvcAkFHR9JibljrqEYpeSZgOq5FTEba7tbEecmEsOQ7p/BLHTJDq/je7
         PqjQO7TC3KHOY+hBgM+GsSIdyWfal4Nz3/Xnaj+14Eh0j+JyaQWYbPMggWM3wI4UhTZb
         1Um7uZCEsdWw3RaDR9SOl4cjZY7C/s/d0RJOrjTxsVxvIK8HskUJVQT34YPrxZVZeySx
         HOsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778659393; x=1779264193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tc72CNmNkwvkSW1iaWQN9XjdiXKoqPVbY4p4w90gIX0=;
        b=avEvRrMQs+4ZEzOOCfg1mnDnzLFkU35s3Y8lDUAlNJn9DkbmY1yX/U0vXXMj0+RQWb
         lcJTCGB9i6NfZkMdw0gTiEH6iEPCiy0tVKKXIp7gRMf8pGf/Kz50KB4VqTVWjpFpLizi
         anEivBHcvDgYzMmK08x2jdyNdDlPnyBuCKL6hihs4/zo7mdbT9LvUqVsDoZUBFkqf3OT
         Ue1z+H9pe74MzA3STV7TS7VpZvqucGN/4NTV0gTNHBqEjRB54i7rJF32JE9/u6mI7FuG
         dIXX0pli3ZCD6nzYkqNsjvZXVB6VGcHn2unZdG8bsw/3g1wszeLFoXFt6bpZY6b6jPe8
         /ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778659393; x=1779264193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tc72CNmNkwvkSW1iaWQN9XjdiXKoqPVbY4p4w90gIX0=;
        b=tBj9nbBU6Fg1oTBU3kfZWUACwGfS9qQ2hfq2nyJ93Kws/KKxVyoqDlGz8JoWeYUTNM
         1cEhYnIsta6Hhs6cZtvoCKyhHsea7wu+nqv+MegjTy2CrLkdwh+8XZqTmg1P9kUFfi8o
         TPWk6M9QhcJfewD/wwQbAG2n/tokf0yze67SmJnz7T/vJ3FOIIMGVD2qBtWyAv2SLxIJ
         kDThI64Fsb/woNazYCd3523J9Cbw++VkhRljCTSDUD0HX+B1a1IJwdPqDoCZYFJMLoC6
         prD1YevME4+X3RFN0+i7ohVUW6QIKRM7l4mereP7LQBXR/n0qaLEf9c12g9SA01A/1sJ
         NUnQ==
X-Gm-Message-State: AOJu0YzExXMDNFEmRIJcY2Bj3e3ZJcuVqclst7RTuYfvQHZ/9u7viCqQ
	2n4MNpsHS8JxHsE3nDeFqE3iMWO9D5sKZuufhKUx7t+QDX3vhAHOhI5uE1WT6mJ7w/opyrnI3PS
	bxMc6Gm9XLA1CqH7C0W65KqTyQR3iUsQrGz+0yNfY
X-Gm-Gg: Acq92OFCDJrkYdcxaweyH4MVKRFgz5dvrg8kTwk+Mmy5fGIULvOFvLC/eYbsHTRcs8Q
	6FMI2zCN5hIxbvOrdFS/OKppGqpmBdVKxcznS1Zs4l2H77gtvzr2oGO+0iAMKuhKVOmBe622JNe
	nXGpZJGDeG4VjAx4hRmsbuV4MXyvYAF815ZMvcRBrAxeC71Fwv3k+Nx5xs/EBdCMvRoGKToAfGE
	ryQFfztPicOjaVqtwCgLBp3Qy7NalEwFbM5A7q1OkgYx0Hpfm6n0tF6RLcvNm8nEOm4fkPGNYpG
	pGfKdlPm7VTHDYj04Gn6BEo/V2LOxsdGnxJYh4VA8U73ZjY0CPMyfLx9Qqw5pQ7n7IUqSc+8pQH
	F3p+wsogCmB+466qvADcxNoUQyrFdiNZFFfW8fQ==
X-Received: by 2002:a05:6214:5b05:b0:8bd:c5ca:3975 with SMTP id
 6a1803df08f44-8c7bc43c35bmr35127186d6.46.1778659392438; Wed, 13 May 2026
 01:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513041635.1289541-1-vakzz@zellic.io>
In-Reply-To: <20260513041635.1289541-1-vakzz@zellic.io>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 13 May 2026 01:03:00 -0700
X-Gm-Features: AVHnY4INQZdbNuwlZmQ2msUgLJZMF01ktYttfZy5_EdkwXX-XD2nWohJpLW_YCo
Message-ID: <CANn89i+NMVb5EyfsLEfcBu=R+hrD2NPhrNSUwK3hHBWav68KhQ@mail.gmail.com>
Subject: Re: [PATCH net] net: skbuff: preserve shared-frag marker during coalescing
To: William Bowling <vakzz@zellic.io>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 74B0452F444
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287469-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RBL_SEM_FAIL(0.00)[172.232.135.74:query timed out];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[zellic.io:query timed out];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,zellic.io:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 9:16=E2=80=AFPM William Bowling <vakzz@zellic.io> w=
rote:
>
> skb_try_coalesce() can attach paged frags from @from to @to.  If @from
> has SKBFL_SHARED_FRAG set, the resulting @to skb can contain the same
> externally-owned or page-cache-backed frags, but the shared-frag marker
> is currently lost.
>
> That breaks the invariant relied on by later in-place writers.  In
> particular, ESP input checks skb_has_shared_frag() before deciding
> whether an uncloned nonlinear skb can skip skb_cow_data().  If TCP
> receive coalescing has moved shared frags into an unmarked skb, ESP can
> see skb_has_shared_frag() as false and decrypt in place over page-cache
> backed frags.
>
> Propagate SKBFL_SHARED_FRAG when skb_try_coalesce() transfers paged
> frags.  The tailroom copy path does not need the marker because it copies
> bytes into @to's linear data rather than transferring frag descriptors.
>
> Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
> Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb fra=
gs")
> Signed-off-by: William Bowling <vakzz@zellic.io>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!


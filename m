Return-Path: <netdev+bounces-296314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pB6JMdPiJWqPNAIAu9opvQ
	(envelope-from <netdev+bounces-296314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 23:29:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31937651A25
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 23:29:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TTgFRFkp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296314-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296314-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 181BF30038C7
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 21:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EBA33262B;
	Sun,  7 Jun 2026 21:29:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B123264D0
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 21:29:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780867791; cv=pass; b=bxnTt0dhtYFVDs0SRy1rn8VM5+JQD43sZH7sNejEjaSog3lrtbru6MPv6LuFpx/JATt0F4pwBGEdmofKWima3kJbsMb1NLawlmiFa3LBNXqgS6l5mlyAfbn+binzoD/kWCWOwLCAy4zN/luDGP7a2N16A1K1TKPQM/WoXReYWIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780867791; c=relaxed/simple;
	bh=SfHTzSYOmQQIndLq5Z85edH+WHw8MejqpmILcdxWCvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUnych9tmrd25XpR+j0yb7MICuKnXjzu66yGxMmH0e7ur+6FC1gDgB0fkiQDsRA4ymJ3+GuS4UAbpeLQYUAI75jwOWcbXqUgYKoYadEKRUzpnbj1rrUHEoB/IR/2H/lf03NicFOWZXNc79kiEKRCQvg7eDXIXZSq3bCGMdFDOlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTgFRFkp; arc=pass smtp.client-ip=209.85.208.51
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-691956903abso1372201a12.2
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 14:29:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780867788; cv=none;
        d=google.com; s=arc-20240605;
        b=ZQrFaQSA2Iae8BR3jXhjYgQPUflNJ7fcS3/tJKVFoiPdpna5mIhN0tvectnjcvxLMu
         vy31wHCCKihqRbjieOOZ2n9U/GvREH9/z4ULZOT21RdN39DnOgSYcQetW6fTEdi6WOTV
         94FmpJ1dv6gHNyEchrG2CT8ApPQnbTFAeqfLGRirtKxEhEWPLNehwFQylXXU1ccLDwFI
         4+R8eVK0uRRtv56hEINmpKpXjQsCDk/PDpk2thvuAwjUOdG+9WqLgHrh9c1ieY6amGCj
         26byTcvYiX5BCUjvG2m7FQBLSqlitNYpsCiu2rn7BHqdI4lcCH1KenTNhSH5OTtLJj5S
         E97g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SfHTzSYOmQQIndLq5Z85edH+WHw8MejqpmILcdxWCvY=;
        fh=6P+ApML1ofaC0q+g/pTowog6wW6O23WdX4KXwaMl02Q=;
        b=dhArVyMnI2vC72aCheDEMzWdLi7RQURgsl5DRhx0UfMOJfkBdiCcSY56KphPkCunAe
         tyqk1vPGUZGC5PGcTVR7GUFKEMbQKFHsQ2kVTsjnKQjd6R0YeJg7W1cGrxLwrI7f4RiT
         jh/hG7tGmOpfPh6UcbY1EgDY3Z6Bp6wnlJM2MjEo8pO5XsB6yv21K2MWiWcIpHmnzwB1
         aYqWElZxdQVZxA9iQ5p/j9XVg1G+uh8uxLrKVoX5h9RcMUZT4eDTYFn6/9RLfZhrepY2
         Y2IsaLEOzh8HNjL05FSa4zp7rEe9CgtTDF8VRdbgybK+gYkrx1ZAgQlkmU+m05S81OYu
         hfHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780867788; x=1781472588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfHTzSYOmQQIndLq5Z85edH+WHw8MejqpmILcdxWCvY=;
        b=TTgFRFkpYnVfbYG2ZVNXPU72mmyGaCi9VEAVHm9pY6mhsh1smARdS7uc6OErXV0EQe
         eWU2RyxLEZGQu0oe79TQdeO20MDeV7hJLGyK/1Ht/2VEyUzZ3RzS3k6lkj9GT8MHE4DV
         zUCmvb71Qtn+T3eDzbHiBWfDoRTE3kE+Vh9NBRmcweuxq/fkwmeOh+7AFFKU89MnBTSm
         3d8M5o6waywVa4NNaeZquE5wvrzzXKSgjwtfwiaMpMHwsNEAuen2tFv2BSyQGGCVqhpZ
         kpEmFbX3Hl1xkitHFrEtw9+GqjuPC17lomMipDZpAWb8dEBo6rgWktXykjMqDWOSyn0y
         7J3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780867788; x=1781472588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SfHTzSYOmQQIndLq5Z85edH+WHw8MejqpmILcdxWCvY=;
        b=Rv5YHboDzH3ZypfOonroQ9Aw3U+ZJCRHsmo/y6reBQOpkXbDErpYXL56Cwv7Rteeqw
         Im9cMDKOdVPSQJDZ5cIPqbmEQV/+1Su114RYa70ZzgSzQ3h1hnPVp3lez0jBN7Bm/aME
         w9kR1Uk6U13RNFE+lKRtqnLSId+xwLbR+GpyIwADrA/bgzAMw45AccIVaN88ReAjRFFw
         cbILixdEcCjsImpfE36v2NVsWNzhn2iaREW4s13ygzQNvgHFrvXf6QtEVa99g1RS/KxS
         vru64n5m8GWXl5jg93esIFZbNLVe2TcF9IQKY5Kh71J9T0WZ2gft63l0Bh84Ig6nUu4L
         XOHQ==
X-Forwarded-Encrypted: i=1; AFNElJ+vn/+DdRAw/NST0MHkYCh0Z4hTHfdm7t7K6yCbqMG9M3n4CDsR9sy4jcZCnM53Pf6265c8icY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydsd6LkVqoNbRonKzT1X/1ndUcXalsbk1Lwo6LxbZCZL11Rt0r
	yHD3/ucnx5Xy6R7V0pLExRrrrndJEkMikeuKCwzPD/WpluBeglb6CjIIet19clfWCw0Cm7C4PJv
	Ld3bb8HuX3rGVUUcTCXjKI6DzwwxCkm0=
X-Gm-Gg: Acq92OHz+p3wL1teI5+vIBoYlDALz2sqNBrBrhr8x8jqCp+RM2oojLLHjNbYLK/eGqg
	9oq4+3ZcjwK3h0LVWncoezn9JzEsP1NiFRPWuLoeMYxkAh1SeyexNceE2BGCIbIWYotul3dOQUw
	KK8TbJykhS2l29+QRJsK2cuZ6hFyTHtxlrSjS7mdCTrFSxkgl5hnfaG2yDeSj4uwv5OoPoV0OKl
	bxSCHi2QEBGzbV9dpeYn/pZbeO16azA7yYFc9fK39wutrn0EHLR8JBBrwaEGRaYwa5G+oHTq1HB
	OO88WTeAtrUYI2fQWV0be8QoMw1GmgMB9z4mWwMFsApB2mEnMUxtZI23n1lTPV47j0Cjx0BZm8C
	XNyesbpvZA0kJxPQMfg8PXtshL522uPkTHtyHne5r2SI9QY4WbMVXXq3W/8mHkY/Ub5BM
X-Received: by 2002:a05:6402:5291:b0:691:706b:183a with SMTP id
 4fb4d7f45d1cf-691706b1de4mr2702719a12.6.1780867788402; Sun, 07 Jun 2026
 14:29:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607164447.39700-1-rosenp@gmail.com> <ab136215-157e-491a-b9cb-ba9c1d3c982d@suse.de>
In-Reply-To: <ab136215-157e-491a-b9cb-ba9c1d3c982d@suse.de>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 7 Jun 2026 14:29:37 -0700
X-Gm-Features: AVVi8Ce9fYWTiODFznvTrealT-vixadLgQb-5zzvM-_Iajy9bEIbkeCRTdx5oXE
Message-ID: <CAKxU2N_K5fV_ophrqOyp-0f6hh6opGz2V_BYN4JN2ABo4bwzdw@mail.gmail.com>
Subject: Re: [PATCH] netfilter: synproxy: fix unaligned access to TCP
 timestamp option
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netfilter-devel@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "open list:NETFILTER" <coreteam@netfilter.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296314-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31937651A25

On Sun, Jun 7, 2026 at 2:27=E2=80=AFPM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> On 6/7/26 6:44 PM, Rosen Penev wrote:
> > synproxy_tstamp_adjust() reads and writes the TSval and TSecr fields of
> > the TCP Timestamp option via direct __be32 pointer dereferences. These
> > fields are at byte offsets 2 and 6 within the option, which are only
> > 2-byte aligned =E2=80=94 not 4-byte aligned for __be32 access.
> >
> > Replace with get_unaligned_be32() / put_unaligned_be32() to safely
> > handle the unaligned access on strict-alignment architectures.
> >
> > Assisted-by: opencode:big-pickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Hi,
>
> as mentioned on [1] this was already fixed in [2]..
OK.
>
> [1]
> https://lore.kernel.org/netdev/a8cfeb06-6ffb-49f2-a14d-c5a50bc4e5be@suse.=
de/
>
> [2]
> https://lore.kernel.org/netfilter-devel/20260525124450.6043-4-fmancera@su=
se.de/
>
> Thanks,
> Fernando.


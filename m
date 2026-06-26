Return-Path: <netdev+bounces-302082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k7TmGuncPWoK7QgAu9opvQ
	(envelope-from <netdev+bounces-302082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 03:59:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0436C9A15
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 03:59:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=GRjsUeLQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302082-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302082-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3012E303816A
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 01:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A362F23BD1B;
	Fri, 26 Jun 2026 01:59:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4146B21CFEF
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 01:59:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782439142; cv=pass; b=u1AHDLrWPXiRc9ASvHQGxkAiQqIariV4KfGoIr6dhB2BlRpJGD6Hh4Xr2nslpmoETfsIXoVt/lOnnXmyAY7zT7+MFaf5x3HxXm6z+lp0JZoQD6tUF7fw69UoNEFCp4QnojRzDF4uORNG3tzlVg/excUpGomtIJSlUr9Bv5rjekk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782439142; c=relaxed/simple;
	bh=Iox+OCGcc/p+FeFAHnbUvjG1kwk2J1WgwsR8fEaRrpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTx8HJ9EDAmsinsBQa40wyWvsXsbSRkOnZUl1wF5GA9Abgbrojr9g0Jn0EtuVvKo4//E3WpA6+m8XiVeUGMmmU13tgbuBcHs7hYP6eyNIUBtNFiNsxZhC3w9+pJ7zx4vUCCghJzTzUgEeHzLJcaluDYufz2cDAc0FZu30U10zI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GRjsUeLQ; arc=pass smtp.client-ip=209.85.160.177
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51765531803so124051cf.0
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 18:59:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782439140; cv=none;
        d=google.com; s=arc-20260327;
        b=Vh4MFEjw88GiAOtu/TdOGyJR22wbfD/OT3h6ayMGpk/WbWT6BQoxmJaA6sNnZsKpUo
         gG7o9DEs1NG6EbZRQnePB4hrWodOFaFdSKeRn6s0YnmteXV+SEg3YjooSQyduVkgcbO2
         cxdJNYlESkBhduIbg0b/9KqIyKhKwUCpcolncPf7SrI1aw/mNzfpQETWI/+29qALn57T
         S1Zn41A/EfPaDPnw4jM6ORyRbX6u+/jYrw+Ailw5B5aamQTWzWhVlqvV1YMbtC0s5xe4
         k3wO4nZ8O6+b42KFGm8PrTseqGaa1MRigyvm691XgW2P6/Ax35+Dc7w2RzMEFcht+AQd
         Wk+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IoRNitbRAla94LtzULINzRejzdqBHTnOG/dbAKIYTdU=;
        fh=/gHupX3ZEZjN1wyfPh0QkuqTC24OC7X3iDmf35Ylii4=;
        b=KrUeuHmlw8CoU2FK+rZkYNLrY2flJwUxkT0knR4euUvDGwNUE50zs+HetrWZmmaFxU
         xmt52fIKVgkUf5sJEzyhHHGd3etolbrRG5FD17kujjP8B8ga3rGfFSYs6/5lWf6FR5Fh
         0esN7l2r15OsryYDa5CDybvVmy2s8w8MUTaUX7+ufjSYPeV/OzL23Rlqc4bWwM7kQ4oO
         mahRWT2G/mz9dOm6trAs8v2SW/dqN6NEMAztG75Ua1NPVnM0DBZl1VBcJWleOYZBm6C8
         pwgAqaV2QVjYp+tVpUJgGWvirEVaU97rP3yUTtOmXVd0ci8s8bPEhqdHMxj7JPoZxEc8
         leyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782439140; x=1783043940; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IoRNitbRAla94LtzULINzRejzdqBHTnOG/dbAKIYTdU=;
        b=GRjsUeLQtr3T4B1rTUJtDSn04VwZRgdgJFpjZnDEIMkIQQpDuqqIkp8wXtLFIfTcHt
         LbEAD2Kp668yl33qUpzb2tIH/0Qvo2Y41wQdBmCvJ4DaOHYG10NL/d+ieQ6sa1S90w+j
         F1kA0j7poNc/nAx3R4asRX7vDp+z0Np+Ju2bOeHuImMckJkksxciyk4/QfPJHghD9XLl
         n2n/V+RKN8Jac9NlzE12SKzlhDpJsqy0X7GHYz0kiuiVeqzUTMN+PUyVcHpqzWlyvo9i
         iUGazBudqVf+3S6TIeuifx4iHYl6LDlMCuEx2ArtoAk1djlhAJ3g6SQ/S4dNjov7SeU0
         P4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782439140; x=1783043940;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IoRNitbRAla94LtzULINzRejzdqBHTnOG/dbAKIYTdU=;
        b=Sl8X+UeoeAZSL9Kti+xJfTcpzo3Eb8XZg4e6hfiZG3zYKLc6scApznKlndtgjcAsr5
         mfPajs15KgoIx3LrAAdRJ9aPoAXO+/olOoqvGM2rSrzeJK58DRFEVohHqtSvSeaO56lu
         CytPqMau6yrzu01kMCxC9DfxHLrOCWkQNzx3XN6JJWS1xAF90Ycd6YqzYAnaOK13YQ/0
         oyDNXZ8f2lpYl6xe4yP8z2wLT7YSaMPAKxcik7W8R2iG9wLVSh69EO7lk/BkYU9Kmgs1
         oBpKXlJKpq+CzQmDrPKvl2Q+8kMqYjUnviP5o3ar0F/gOiKenZy7WUgm4U5rKTRaKjR2
         ctkQ==
X-Forwarded-Encrypted: i=1; AFNElJ+PrGtahoHMOHDrieZW7QUnzy6SJVesRmlj8H1igyG8fXTS+N60BobLz7J0qDrtnwFq6FcRdcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCuSffvq4FOBPIOITuWhwb8IR9Ktxtg9AWodm/+uIarfxZH107
	dLxBpAbSYsTbXRBGmJmfdzNVsE0CMQ5j86kniP32WW65+kbaVRSA9sDy15Ar7sWYVG3q/lZAbQn
	jyskkq29VaUdvyoX+TRInP0K03TsrLcx9v4Un9P+U
X-Gm-Gg: AfdE7cm1Z6oVCjyu3kUusdbMkVmAmsE5CbHV0Ew1MqdtUkeId7o4RFMf+wTUmtP280i
	OgfgsLY29qj7mTIPASuZ0lH7yA3HY6NyUDk32Qgcsq/9Ys7uXfLqfT/nUnzJAnyCDlfwpg0EeXD
	UmH2UZh92KbLqISpWlnJ8WygOeKqhlo+KcEh755jrB681bBz580298R7Y6VqeI++G9903wFMIee
	Jgzp96P0dD6K0woBz04NNJrHS1go2wZzV3r9XM5ouRH/SaX/9hhRTeIcfQL2Io3DxjlJTgj4EYR
	y9LGx3kSQk7sZtlZ7Tm8ftQv0N/Gwg==
X-Received: by 2002:a05:622a:4d4a:b0:50f:b69a:f4a8 with SMTP id
 d75a77b69052e-51a7d84d32amr4314321cf.7.1782439139667; Thu, 25 Jun 2026
 18:58:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612074725.1760473-1-steffen.klassert@secunet.com>
 <20260613131552.2562d433@kernel.org> <ajDlFUhMfJP36qA8@Antony2201.local>
 <ajvzbVLCce1p86i6@Antony2201.local> <CADHa2dAtGVsph3Kq0id7QqgNdJww0Q=Z1PK+=fomVxKE-Mmvjg@mail.gmail.com>
In-Reply-To: <CADHa2dAtGVsph3Kq0id7QqgNdJww0Q=Z1PK+=fomVxKE-Mmvjg@mail.gmail.com>
From: Yan Yan <evitayan@google.com>
Date: Thu, 25 Jun 2026 18:58:47 -0700
X-Gm-Features: AVVi8CfR34KMVBq1rk3A_S3LjtW8poRDI3-mq7xfRKb1opn-qB-eRFb7pCBxbIo
Message-ID: <CADHa2dB9e=O_thTEPo3Bwtj9qRxE0UJd_MBriC8qqrPFB+x9rw@mail.gmail.com>
Subject: Re: [PATCH 0/18] pull request (net-next): ipsec-next 2026-06-12
To: Antony Antony <antony@phenome.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Nathan Harold <nharold@google.com>, Antony Antony <antony.antony@secunet.com>, 
	David Miller <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>, 
	netdev@vger.kernel.org, Tobias Brunner <tobias@strongswan.org>, 
	Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302082-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[evitayan@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:antony@phenome.org,m:kuba@kernel.org,m:steffen.klassert@secunet.com,m:nharold@google.com,m:antony.antony@secunet.com,m:davem@davemloft.net,m:herbert@gondor.apana.org.au,m:netdev@vger.kernel.org,m:tobias@strongswan.org,m:sd@queasysnail.net,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[evitayan@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC0436C9A15

Hi Antony,

I ran the following test cases and two=E2=80=944.2 and 6=E2=80=94are worth =
disucssing:

1.  Mark Inheritance: Creates one SA and migrates it without
specifying a new mark. [PASSED]
2.  Mark Update: Creates one SA with a specific mark and migrates it
to a new specific mark. [PASSED]
3.  State Update Isolation: Creates two SAs differing only by mark and
verifies that migrating one does not affect the other. [PASSED]
4.  Mark Collision:
    4.1 [Specific Mark] Creates two SAs differing only by mark: SA
(mark_1) and an SA (mark_2). Verifies migrating SA (mark_1) to mark_2
fails with EEXIST and both SAs intact. [PASSED]
    4.2 [Wildcard Mark] Creates two SAs differing only by mark: SA
(mark_1) and an SA (mark_none). Migrate the mark_none to mark_1.
Expecting failure with EEXIST and both SAs intact. [FAILED: SA
(mark_none) ends up being deleted]
5.  Mark Mismatch:
    5.1 Creates only a wildcard SA and verifying migration using a
specific mark fails with ESRCH; SA intact [PASSED]
    5.2 Creates only one SA (mark_1) and verifying migration using a
mark_2 fails with ESRCH; SA intact [PASSED]
6.  Mark Shadowing Failure:: Creates two SAs differing only by mark:
the first SA (mark_1) and the second SA (mark None). Migrating the SA
(mark_1) fails with ESRCH, two SAs remain untouched [PASSED]

--------------------------------
My questions are as follows:

Regarding 4.2 I believe is a kernel bug. During the pre-migration
collision check, the lookup for the mark_1 matches the wildcard SA
itself first, causing the kernel to miss the collision with the
existing specific SA with mark_1

At https://github.com/antonyantony/linux/blob/migrate-state-fixes-v0/net/xf=
rm/xfrm_user.c#L3450

x_new =3D xfrm_state_lookup(net, new_mark_key, &m.new_daddr, ----> BUG:
We are looking for the existence of SA (mark_1) but SA (mark_none) is
returned.
um->id.spi, um->id.proto, m.new_family);
if (x_new) {
    xfrm_state_put(x_new);
    if (x_new !=3D x) { ----> BUG: We end up having x_new =3D=3D x
    NL_SET_ERR_MSG(extack, "New SA tuple already occupied");
    err =3D -EEXIST;
    goto out;
}
/* self-match via wide mark mask; not a collision */

Would it be possible to traverse the entire list or create a lookup
method for an exact match?

Regarding  6.  I wrote the tests as per the kernel implementation but
I'm not sure it is intended. Intuitively, this migration should
succeed by finding and updating the specific SA (mark_1) instead of
failing. Is this failure considered an acceptable limit, or should we
aim to support exact-match lookup here?



On Wed, Jun 24, 2026 at 6:45=E2=80=AFPM Yan Yan <evitayan@google.com> wrote=
:
>
> Hi Antony,
>
> Sure, I'm happy to write and run some tests. I should be able to have the=
 results by the end of the week.
>
>
>
> --
> --
> Best,
> Yan



--
--
Best,
Yan


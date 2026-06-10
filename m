Return-Path: <netdev+bounces-297805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mnHcB+e0KWracAMAu9opvQ
	(envelope-from <netdev+bounces-297805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:03:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BBA66C69D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:03:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=Afpk6dSD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297805-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297805-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24C2430465DA
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E60525B084;
	Wed, 10 Jun 2026 19:02:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2BE32BF41
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 19:02:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781118122; cv=pass; b=IIzek+rTvmv6oBjl2eD8liBCTuADDmcn3Hcsba8B4JQAPrK1JBtN2b72Vs4OBuACgcCvD295TKNuYqEi+o+X+K7gqbh+7Jeo37iw5O9WZ7BrVvcEoL5fbFQimKZ1W94M/E8/MHAoFGnB5JiNQkNWK5UWh/+Oo/ipWajgo0S5CXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781118122; c=relaxed/simple;
	bh=gZt+s/8+1mavGW2pulqo0yU4ISus6tUYsfLt2HJ2yXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOp77DdjXiuvj94ty+PrKwF0FfFZn839uMrkL2MVfQbdNWTU+9RIoMMRwv083bOVfVu+8nND5QrKNu97lnlK45TXNqbFIIpyyiLuDRIi94FvYgrJc8DylVILxAkDBLol32pF9YeKMamYxWccOXM9MaTvwQ0p3z938+1T9WwAl10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Afpk6dSD; arc=pass smtp.client-ip=209.85.167.42
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aa68e66128so7378342e87.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 12:02:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781118119; cv=none;
        d=google.com; s=arc-20240605;
        b=KHp2N51lCtUJlepO9jbUMg5OKKFpqsqbta+jVjYFV30zCxBPNClkqmIXuPRHJQ6yKE
         p6FtiwGVJthiGb3o7ZDLaNxdoEvyglib73STGZZ4ke7an5YOYtMt89zQkCJLoEKXN1sY
         upqudhRUHyVfmbb6gu/mVcZCTGpsKgf6zXxQHTitQ4b5CZEw29jOz/O8s+cpwfxokI0l
         acPVV92mGHMWfmfqnhu/KcLhmyCxOijETPZv7wTXgXKHztV1bGiSPIrVjzqsRlkIuryJ
         bSuEdZyasZv02WlpNPgxQLkHR1SWKIvTHMvtfLL2ooFJMDN66Oxr0P1lHGnd8tRwyVSp
         vvAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PWJJm+NM3b0ZMz455IDOHU+KsDy68J3qGpNf01331GA=;
        fh=v/csMx0eFCivUPV22yUWvBHuz5m35i1pzPQIgn6+0jw=;
        b=LDEfACjDxAT8rdT/hrjO6brleZkYCEgLfoE/1jRuBciG0z1O+34llF+1wWfuc7PpJI
         nNLh8Ymf44TO9glAU/Cj85qeFRNE1K1IJGdAYzuv+pjqDsFG6IdZUDlwEhJLwkHCYjp/
         kwEQaCDu3SHfEMSnwqmon1KuujDfCyVs0q2J5Gmw1xIL13tAnV7+vGOc6tPQEepILGwM
         +O9ia1/nJIS6sGB47Nc1lvhMqO/xVPmle2dxin5oAWkv7TMvszAj/T8YF9u38nfT/vfO
         75EC8vD38ljekzTwjW/zkkvzmjIcUHGxppnVNG5zSQ28HGIhJq21JV6szlNFwEJROnhi
         lc5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1781118119; x=1781722919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWJJm+NM3b0ZMz455IDOHU+KsDy68J3qGpNf01331GA=;
        b=Afpk6dSD9zmXMu9urPFwezuK3/cv9AfoUaOduXlwfb4qbI48K3U5eEt2j8E4cc3/Dy
         QqdsRdA8OzaEoG4DEzjvYyD1VCQ7FPmOFhyfDqpyfwK1OUWZYjbcA8yPI9Xpn2SLKkfQ
         zKYD6/JjaSyjbCaFWz0mTghC96WY6DxkmWaPXrwTxg243g4h6Z0h/n46K++CZhTiWeo8
         QEELXPoIfkH9pzzxJanox7QAvppILskNPIaJR95tpc0jZH3qCF4kKz9iGz4k5j9lggrN
         /nxthcO04eNBn1f6kLLCJCOwVZBa/rvwiEs834beQo5ScrUV3MB9y0yblNZLBR5rmmqK
         cAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781118119; x=1781722919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PWJJm+NM3b0ZMz455IDOHU+KsDy68J3qGpNf01331GA=;
        b=PQxl8eRLenfVOcR3sTvsIe7Wjzrz7bq47Tx9GujzlVmZmUfgpNI9ZsBlXfAKip4+5O
         q7ASNJMRJ2Da9zwTe7lmxNp+FfCgBw0StTc2glEQGf0wJML4WBRUwnwIe3dT6KE6a3l7
         pp43yza2nWmLDUviZ1BxHWCGOAFdPtXwBUCjxeDmePmPqq2LZxizJzDt59rSPGtFsLiI
         Ij5QAt7bIKsJWymB9M5eSyU7BgNtk78CP0VxcvpMsflK6wkMt7f110xVbGzfOZVFyvku
         izgqLbetX/rlOvVr2PNJWwMZPfxoCOsgcZSrqWUxBoflFNeFZKADSAkY2A7xd2ExD/H2
         hPjA==
X-Forwarded-Encrypted: i=1; AFNElJ9NCXAB5mObyf9wAoi/1iWE8n0EuoS0y1jLeqNpcwaXacJXveE2lkZOi7aVMWZQCm/77OUyfsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYik0hG/jkauWVbUCNZmB6rzBBA+z/Nu/I2YjEX4PYRCV9Efkw
	HD0vvbxe+g5DjCta05+G6bpcKFQyT8QhTNqbMNePjDjktSUU87aUasirOBdvG1ha91kVnF2jPc1
	lBD3AvAPAvl77mEAoneEM5r8IjYeoy0nFRu7NiJjT4g==
X-Gm-Gg: Acq92OEPmwknLvj1boW5KU53TUmX9Jw8SoQIsdbbZBF4pcoVvXCMzmu4ws56ojJXZdP
	GOgaRZgjy+AiiOJ0EZL1EurxnmWscE/v4IDPopbkizkqsErrdSOYxL1QLJmUXP3H5RI3jIw/kAD
	jwfI3Jfm1EcRabmXWmlPJaV9+T/MKtmJN62UKovgSIIm7rmACp75x7n11wnpEX+J2e4Gx/txqs6
	dHxmqgo2tPPRmrO/sjCMbfgS/9eARhdfyJp6TWiLeh9gINR2V+GA8O0Z8VG5Hrq3EozaY6+JjUw
	1jCSLQsTCKcB3pzM
X-Received: by 2002:a05:6512:a95:b0:5aa:6c57:32c6 with SMTP id
 2adb3069b0e04-5aa87bb9f53mr6700694e87.17.1781118119345; Wed, 10 Jun 2026
 12:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609232521.1602334.0764789957e4.dualpi2-filter-no-match@trailofbits.com>
 <CAM0EoMm5u9oWh8g1-TyrGvuAaCvfNBb8Jg8sWg1ZJu8kcrb0eA@mail.gmail.com>
In-Reply-To: <CAM0EoMm5u9oWh8g1-TyrGvuAaCvfNBb8Jg8sWg1ZJu8kcrb0eA@mail.gmail.com>
From: Samuel Moelius <sam.moelius@trailofbits.com>
Date: Wed, 10 Jun 2026 15:01:45 -0400
X-Gm-Features: AVVi8CelM130NA2iqrPmRBST9w_DHYfC21F2D-TxVonkYedmU3vNBoqw-6qGEcQ
Message-ID: <CAE+C+DYPUS2y7HVGQZU=jxyHBOmK=_=Fa_0BOpVcO4Q3YEMSBQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: dualpi2: clear stale classification on
 filter miss
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ij@kernel.org>, 
	Olga Albisser <olga@albisser.org>, "open list:TC subsystem" <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:koen.de_schepper@nokia-bell-labs.com,m:chia-yu.chang@nokia-bell-labs.com,m:ij@kernel.org,m:olga@albisser.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297805-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trailofbits.com:dkim,trailofbits.com:email,trailofbits.com:from_mime,vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70BBA66C69D

On Wed, Jun 10, 2026 at 6:06=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, Jun 9, 2026 at 7:26=E2=80=AFPM Samuel Moelius
> <sam.moelius@trailofbits.com> wrote:
> >
> > DualPI2 leaves previous classification state attached to an skb when
> > filter classification returns no match.  The enqueue path can then act
> > on stale state from an earlier classification attempt.
> >
> > A filter miss should fall back to the default path without reusing old
> > per-packet classification data.
> >
> > Clear the classification result when the filter lookup does not match.
> >
>
> Why not just initialize at the top of the function? Something like this:
>
> --- a/net/sched/sch_dualpi2.c
> +++ b/net/sched/sch_dualpi2.c
> @@ -346,6 +346,8 @@ static int dualpi2_skb_classify(struct
> dualpi2_sched_data *q,
>         struct tcf_proto *fl;
>         int result;
>
> +       cb->classified =3D DUALPI2_C_CLASSIC;
>
> Then you can even remove check around if (!fl)
>
> -       if (!fl) {
> -               cb->classified =3D DUALPI2_C_CLASSIC;
> +       if (!fl)
>                 return NET_XMIT_SUCCESS;
> -       }
>
> Would improve readability.

I am getting ready to travel and I will address this when I return in
about two weeks. Thank you for understanding.


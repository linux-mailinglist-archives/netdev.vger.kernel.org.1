Return-Path: <netdev+bounces-255492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id q4ejGQpOfmkJXAIAu9opvQ
	(envelope-from <netdev+bounces-255492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 19:46:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B34F3C3902
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 19:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D5F9300B44B
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6251367F24;
	Sat, 31 Jan 2026 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vc+M2eaV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB1435E53B
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769885182; cv=pass; b=C8NUpA66ctJN6ADEK6f6VXepdIp9FDOJV2DPW7sGULvoCcq8rqyJKBi+sDHdQFd5b0CPrriuY/y+08cD4bpPNdUY43/OQImKhWBCU83FoTpZSFch60s8Aelfp8i8UEMzccUHc7jX2P8OH7Pg2PYLjebHHhq7UzGEw7fQV3MIKUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769885182; c=relaxed/simple;
	bh=gjyoI+aqRNh9f6i4kHhtuIbw2jbHU9s631hyA+eBL44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/h70NIVfIV842VPVVs95ho+yoKGBZXjdF0z7Gc6OryMpv+yMsJw8Uu+avzkftdntDALaaGws2NdvcscCHdMGnITh7STdGw61cUpLYhlItJu4icLmcSd2ZHtKasjGB4v3j3D3Jxc3ozoFokrBxLqt7+FbKQNPZTBFPyjtIYssjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vc+M2eaV; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-649655f14d7so3194229d50.1
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 10:46:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769885180; cv=none;
        d=google.com; s=arc-20240605;
        b=Lxbnh4vjtG6qJ5lyA9iALRK1mvW4DactRDCi9MXkRgglNzwBwY+aABE4AnTSKZOZYE
         6NYe1IvOk3oBNu0HNEpoes2Ncf+kYtbB4yLEtC4p48t2r16uhXTzUrk4GUKPW6692uon
         pvzPzlFaH9iHSuB9UNuwbr67/2hLrM4XdbGDtJryI7M5SSpdbC9OO4BdHC6+PfsveQk9
         i1lHpUE47Uv3yVfRuxQ86RVgAwfOOtoB9peFzfUDJohgdPIQIAqavqmTXS7cwO49yphy
         vxMSclKLSb1W9IMpUpVi0n/gKtj27ncFhDEn+tS7PbVcgAZIAtiWY1hpA5DGRFR9ZRHN
         HiYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8fh4osU5Y3eXPnZOJ7E5U71ADiiPnVo958vEhF9Dljs=;
        fh=OglO3yZSuzSAUF+VMr1AvpBmzuPX1SYHr6ZKIKAM9+o=;
        b=aiZka0uskw2yKT9eax4Et734pCyput6SDHOZB4iIZS7EwS2T462ApycC+emslPcD8A
         SuYrzKq7QS/vGtHRwMBHI6x0B2cQXwBfDB1HnDUE48DiYzDA9qGlu7JRWs5vPdQXJNSA
         /H7Df0nVVTSqiUeA+EeiHrIvrvjM7tjdKu0a4ogj9ag8aOopk2hGd5Sbj9WhshGSWlRJ
         8JR8QMLsOPL7PtGWav6nosJTxyuRy7vgXJLFxm7SOJ+suKDs+1A58GlX83CRKBB+ulst
         veWWMnp3BI5MMbpnjfRjtmI9uSaBYsFkBDe9wNbwmmuoTYWNn0bmHS3yhJxSV8CyclW5
         +9Vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769885180; x=1770489980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fh4osU5Y3eXPnZOJ7E5U71ADiiPnVo958vEhF9Dljs=;
        b=Vc+M2eaVwY8XTqjvrsbBrqYLKl8Ftcpj6AEn2LBFxSg+sMcBNrvT1SQA6xOyaSQ9qa
         u0qFkKSqXa5BDXi7kWsiyHnnFwonqxIzLeBOEZiZWjgOPwlen2D4qWYZLv4xCZ0yj3yq
         QB9B10EEN8Iy7qZIkkUKzbcBoVwRKWY11/hOcAaw1rSzTXzvs2Zdbfq1tSsr43SBiN6b
         4twMBTs60tygb5AszdH60BiJfGOf+J9nLEJPqsn5Yf4GircqSyytM+j2FE3GqhSpCNTw
         OMAwoBT3wn7fK07vcoXhi6tE3UcsQHBkr/3vvTz4NEyFiNBC7U4OsHhIHFMHlwgfQbqn
         PDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769885180; x=1770489980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8fh4osU5Y3eXPnZOJ7E5U71ADiiPnVo958vEhF9Dljs=;
        b=Cn3Ag/cO8gsa/JyLoelc2uii6lmhs9I1pGODlkZ/pqypQiW0cMeDPoCmR/OAW8HiBz
         IijFrhZXPjPxac4A4lGHTefqCqFLBRkDPowRNqdFfEy4L6NPVMogpHjbe7Zq/0sz1WuY
         HI14YFza1LkPacixNZto2Iw+89SGWISklT90qlFNPcseh8aIWCK6iP/aihVtKarxHbPT
         qIg59nNgajAHkzSasqZt3RvEHHz7IhjppPSbL0UfL9O03tPeutB8ySzLnnGwXiVUAPBC
         Qn/mGW4EIJxy3bhAKt+tZURjQinE1JmkFpjPRsGKBuTbP6WUJzg86QWKZz151/9mfgkz
         k6eg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ01xKAOR2rcxuXLmZB9FPyNCQxVrhOCMbSWr558n/FITQm5Y79+hlZ9Q9qvgiw4MnFKpSnGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfydf2E6T21vl05D9Q6SaLuYVU9l2B1oqKwsn8l6EtY+POAlzp
	0LPHD4TRqJJsHmkKhB4N29mmtoze6L5Ptig416jfzQqSfrugMQnT5Q+ds6Xt5y2zW5TWH2qv8uy
	YTnW/Jr5lbUC4jHc0bGFvPJnaEHj3na8=
X-Gm-Gg: AZuq6aI9OhJcRzUS8BSYyGkkiyEDy/pl+kjBsT+eK4fz5LbKgnsWOp9njJHvmU+8bRy
	7aa/gYeU3KRwdxDPdMxmJzXAVRvylqFe5VrgVi0xWzOZr2AKkWM94GkQN3B+RpovF+j/l4wuUgS
	BCE2K9V2it2sZUVM2a8VbfM7CBpEX34hjw1Yiyl466vMTWJiqIW52XViiWb0TY5aZKjL+w+pT+O
	JW3lJA8qCYxrNUFvV5zrIFRbY2ptuZwvqRRkMjB/AwKJuruXyrBMJK1M7CqGdS7l7kOo8c=
X-Received: by 2002:a05:690e:1249:b0:63f:b952:dfef with SMTP id
 956f58d0204a3-649a825bc25mr5211366d50.0.1769885179889; Sat, 31 Jan 2026
 10:46:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131050920.2574084-6-ameryhung@gmail.com> <0a0eaa11c4b429d41ea2adfc36b56b75b61eacd777dffb2a25cd2857f72d5f2d@mail.kernel.org>
In-Reply-To: <0a0eaa11c4b429d41ea2adfc36b56b75b61eacd777dffb2a25cd2857f72d5f2d@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Sat, 31 Jan 2026 10:46:09 -0800
X-Gm-Features: AZwV_Qj4nDCbzN_Zy7806jAMA7hzx_7N4tuIi7HkMm7XEcf5sh35YEA-9k4xwGw
Message-ID: <CAMB2axPxujt7tUXcZrhQVf4BC6tM35GqTg00pSB7KyGs6ndohw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 05/16] bpf: Change local_storage->lock and
 b->lock to rqspinlock
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kpsingh@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, haoluo@google.com, kernel-team@meta.com, ast@kernel.org, 
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255492-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B34F3C3902
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 9:33=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_stor=
age.c
> > index 824d05325..7661319ad 100644
> > --- a/kernel/bpf/bpf_local_storage.c
> > +++ b/kernel/bpf/bpf_local_storage.c
>
> [ ... ]
>
> > @@ -572,7 +591,9 @@ bpf_local_storage_update(void *owner, struct bpf_lo=
cal_storage_map *smap,
> >       if (!alloc_selem)
> >               return ERR_PTR(-ENOMEM);
> >
> > -     raw_spin_lock_irqsave(&local_storage->lock, flags);
> > +     err =3D raw_res_spin_lock_irqsave(&local_storage->lock, flags);
> > +     if (err)
> > +             return ERR_PTR(err);
>
> If the lock acquisition fails here, doesn't this leak alloc_selem? The
> allocation at the top of this function succeeded:
>
>     alloc_selem =3D selem =3D bpf_selem_alloc(smap, owner, value, ...);
>     if (!alloc_selem)
>         return ERR_PTR(-ENOMEM);
>
> But on lock failure, the early return bypasses the cleanup at the end of
> the function:
>
>     if (alloc_selem) {
>         mem_uncharge(smap, owner, smap->elem_size);
>         bpf_selem_free(alloc_selem, true);
>     }
>
> Should this goto unlock instead of returning directly, or add explicit
> cleanup before returning?

Right. It should be "goto unlock".

>
> [ ... ]
>
> This isn't a bug, but the commit message has a minor wording issue:
>
> > Change bpf_local_storage::lock and bpf_local_storage_map_bucket::lock t=
o
> > from raw_spin_lock to rqspinlock.
>
> "to from" should be "from".
>
> > For, __bpf_local_storage_map_cache(), instead of handling the error,
> > skip updating the cache.
>
> There's an extra comma after "For".
>

Ack.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/215393=
40647
>
> AI-authorship-score: low
> AI-authorship-explanation: The commit follows standard kernel development=
 patterns with appropriate technical detail and no AI-typical phrasing or s=
tructure.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Memory leak on error path in bpf_local_storag=
e_update when rqspinlock times out; affects only rare lock failure scenario=
s.


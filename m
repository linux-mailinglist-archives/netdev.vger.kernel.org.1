Return-Path: <netdev+bounces-295965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i6PRB7YrI2q/jgEAu9opvQ
	(envelope-from <netdev+bounces-295965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 22:04:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B2D64B178
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 22:04:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Vimxz1A8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295965-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295965-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7A8E304B27D
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 20:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9729447D941;
	Fri,  5 Jun 2026 20:00:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4E9478842
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 20:00:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780689649; cv=pass; b=ZAHQVjokzJdEPNufPgmpij9LxWqpLzS9yxSbvGQx48DPmD9PUNSS/ao0PUFpco/e7fVdVaVRe5vAL11fXjP0+VdGQ1p1lemnWEmbIKq/8K4d9x72LpyzS/qLd7tdSK+S/xx/KwyQa8GCfNZPJJGyZHmOB19MchAgoPFwNsbJoPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780689649; c=relaxed/simple;
	bh=ektH2c5D33OuR/izjHIh6IA7RnYCMEtUMQ662f1cwVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqWWmnWvb4yFtv5r4NOSvTClYzuHznm8rdC384bbXUQ6l5wxxLWBHjh+f4jcBW5JVh21WTuWv4ZedZLGUUSaOob7RylCKi6maPHcsXJXJ+rozF7t0y22NHURXf2uyPqeeBbOk10PkswOZNxUrKhFesRGDAseYXx4ABPC24rMQZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vimxz1A8; arc=pass smtp.client-ip=209.85.128.176
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7dc6fbf3e86so26792997b3.3
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 13:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780689647; cv=none;
        d=google.com; s=arc-20240605;
        b=QI3onlUiqIbl32HslOEGJSf2l2a48fOAFZLys7alTH4QREqFMgHz+1HQR/uzYQECBi
         o6vqSkRt3aaFNBpFtq8zM/JfBQuHHC22TptLMhjYG/W/Zv8ArLmXTFcFy+tBHZj9/CEj
         P6c0stO+Xm3NfZ6mD3iAlHP6PfKUxb492YCVH2uXahohn6PuSRI9h2y6ZnRhyiTnoLXl
         zFJNQIPLdmjTk/HzvsgiLokO0q69HMZfFFMiGxCENb4PzwcKaVxduw8AuiKYuv6QCk79
         nkYlBbPDSzJZfIKCBxbDxZBguQa2bRUzgUNKhFh2FFfMJNGDKMfQvfkBmGPxbG+FlYZl
         NK+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=anKJ8pGmWaZxfuJHLMfCz6KAXzqmGVAH8Sm2THG/C5I=;
        fh=LbZaTy9Tyohrwq/7FMRAwizQn6yLL+ULhzq394rwHbw=;
        b=VSei/CclZkAy9qN/fsvOS2ppls/514DsdI5ggakLAk8zBg3+GZM8JKps34r6lhRjMJ
         UNK2BQMFmhCllWWXV7nlIZosxkQphd9Ka7OsuZvJsl2KTvoGNO+WaTZcS1uqWB+0N7Q7
         rlCCSvkJuyqPi2HvuWF88qDWlyZ/jcwMT4zeseUmti5xbrWOcjKdj6N6oIH/fXTxORBE
         L7rnT1NgNfaDR1JB5plTy1fZGqJRv1kAEDii4GtE/41ZhWqgAP+T+vJnoS19UORpDXrh
         bLt0/PfBqsw9bzBtsHYYpWkJpGujtVIlU3TSPkcyGdYWGbE2kIFYFAHlOT+xRtpiBH/C
         Pe5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780689647; x=1781294447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anKJ8pGmWaZxfuJHLMfCz6KAXzqmGVAH8Sm2THG/C5I=;
        b=Vimxz1A8w3BLGVA+d1BCEV4pcBDqwPcijrIx67kCCTSNVXjUoar//E0JZwVMt7pBIL
         vAQafVKFCt+AGcB5joJLZ7P4VdPTmgh7DE5DofucSph56oVMo4QBsD7t4Bp7q70UvzvA
         CgaJekO5MpYJJ5LPDibwsxluUE33fiWOAcEOemPVXL6Zsq2gdHuXsZqluWLQawJpbmbT
         8M2qq0YtF/HQ0w39WsIcdlDGvwLvTw9Aw3/NXo9Dd4aZrpdtMVWfEKu+gw03xhFkxt0z
         RciREOXz2ljs1jsY5jn9L9mjUFVxtbTG54Wl+An5hJRGXKJVz2+IvNDZxeE1W1tes6I0
         geZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780689647; x=1781294447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=anKJ8pGmWaZxfuJHLMfCz6KAXzqmGVAH8Sm2THG/C5I=;
        b=sLbhJK1CCNYCoDA/IwrV0bopkfphKjtHmWpt1E0K7+LuOaz3UFM+C8zJPIMm2+RgSA
         zgI4CThYj3vh4MYtgh0V+kCmzbM4/p5+mTw20btqf1PlfYtMvImLjyQmMxcnrKSRtcEx
         hqwwUZV1gh976GA8ZI7GQKw7BYsEVvRrrR8lupmwsQOcf2gK9B5de6YTIbCq/SP3LiI3
         HaPMdkk4/A8FYyW3wifaRmnTX7eOR31Rdjx+TQXk+FE0NRdUfbhF93mykA4myHz6IUMw
         nm6XVGeipzSvPLH5TdcP1mkJvM9E95bp3NkGV34DTzSUeNaorlql+zbabiQW0DrVpOW/
         AYmg==
X-Forwarded-Encrypted: i=1; AFNElJ94SkoGuIBnqkQ1hc+heo1IylYITM8+6gU2poL3rcugjKFSY71bdF/AQAUBf6YM/ywpEZNknNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVLD0BT2GHIU8p4uzBLv5FY1k1/UQ8wyUvzU6WBCBJPZ8v/xD0
	Sl0dKePKbv/UCOzXAXp1Fv8u080+cxfWYM32Wf/8r4M+5cfbH0K0+4BP7CKuyN1SilhthT6WBxj
	F8vB0HB9322DruD6MOAFgrFqNLkCw15U=
X-Gm-Gg: Acq92OE7rJ1bDhxcoQu66cHaEBbT9uroxO8KEHQN5S8n+MjjzrPINHGK1tOo/MwSfse
	5ZTvEfB9lk09UqxzhO9ZotRFKIT/f4kMv3rWmQe+09XLLI6DUC29brP4SPMHxhO5CcaH/HtoS7O
	9J5mQkX/a4gl7oBKn3cHIthfmrIJDpUtojpjjE5P3EFl+Adr/Y2lLeGhKonJBxA49oi9vXnR/BW
	5qcue1/emoeimD+WPV6QgxaRsrIzW+zmz2+GtKzKZ+H5x17JU7bF46k7T+raBUzPaTIr+zkxT4A
	EGgtRlRurcPYgYXL61+R15xB5+YXpe7vLw==
X-Received: by 2002:a05:690c:260c:b0:7ec:592a:a75c with SMTP id
 00721157ae682-7ed11387deemr54155907b3.39.1780689646661; Fri, 05 Jun 2026
 13:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605183551.969144-4-ameryhung@gmail.com> <5bc665c5db9a7007304ff3a428a05712c818dd9909feefa9cf72c1b30909ee66@mail.kernel.org>
In-Reply-To: <5bc665c5db9a7007304ff3a428a05712c818dd9909feefa9cf72c1b30909ee66@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 5 Jun 2026 13:00:33 -0700
X-Gm-Features: AVHnY4IPPBb1hFmWlzq8CwJBu7DDr9VcTmrkbL_hkArbssqCcYhMI20orHkNup4
Message-ID: <CAMB2axPLjHetacZK+nTRGvoE17+bgasPyhv9m1HkOQzJUM2Okw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com, 
	ast@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295965-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bot+bpf-ci@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:mykyta.yatsenko5@gmail.com,m:kernel-team@meta.com,m:ast@kernel.org,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:bot@kernel.org,m:alexeistarovoitov@gmail.com,m:mykytayatsenko5@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com,linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0B2D64B178

On Fri, Jun 5, 2026 at 12:27=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> > index 5945956a7573..06d9ae24f006 100644
> > --- a/kernel/bpf/states.c
> > +++ b/kernel/bpf/states.c
> > @@ -890,6 +890,9 @@ static bool refsafe(struct bpf_verifier_state *old,=
 struct bpf_verifier_state *c
> >                       return false;
> >               switch (old->refs[i].type) {
> >               case REF_TYPE_PTR:
> > +                     if (!check_ids(old->refs[i].parent_id, cur->refs[=
i].parent_id, idmap))
> > +                             return false;
> > +                     break;
> >               case REF_TYPE_IRQ:
> >                       break;
> >               case REF_TYPE_LOCK:
>
> This change now feeds parent_id values through check_ids() in addition to
> register and stack slot ids.
>
> In the v1 discussion, Eduard Zingerman noted that since not all ids
> correspond to register or stack slots anymore, the WARN_ON_ONCE(1) in
> check_ids() on idmap exhaustion should be removed:
>
> kernel/bpf/states.c:check_ids() {
>         ...
>         /* Reached the end of known mappings; haven't seen this id before=
 */
>         if (idmap->cnt < BPF_ID_MAP_SIZE) {
>                 map[idmap->cnt].old =3D old_id;
>                 map[idmap->cnt].cur =3D cur_id;
>                 idmap->cnt++;
>                 return true;
>         }
>
>         /* We ran out of idmap slots, which should be impossible */
>         WARN_ON_ONCE(1);
>         return false;
> }
>
> The concern raised by the CI and Sashiko bots was that a BPF program
> leaking many references could exhaust BPF_ID_MAP_SIZE and trigger this
> warning, which under panic_on_warn becomes a denial of service. Returning
> false on exhaustion was agreed to be acceptable; only the warning was
> questioned.
>
> The reply on the thread acknowledged this ("Ack. I will drop
> WARN_ON_ONCE(1)."), but the WARN_ON_ONCE(1) is still present in this comm=
it.
>
> Was the WARN_ON_ONCE(1) removal intended for a separate patch in the
> series, or should it be folded in here?

This is dropped in patch 4

>
> Reference:
> https://lore.kernel.org/bpf/6d86c2fae9be63eb110ebd5b3fc19bc4cf1de2dc.came=
l@gmail.com/
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/270340=
08594


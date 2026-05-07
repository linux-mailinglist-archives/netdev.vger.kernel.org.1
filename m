Return-Path: <netdev+bounces-285305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJnIB72D/GmOQwAAu9opvQ
	(envelope-from <netdev+bounces-285305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:21:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 886E24E8204
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54AAA3028E84
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 12:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D763B6BF0;
	Thu,  7 May 2026 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWZxTSN+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F99D36A008
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156468; cv=pass; b=XtEEDhjuTsnaTypAQpuojXSDwkB0kwoKbcBibpY8d6F4h3MvZacM/tHR7tqlXQWMX+Gg8nXQ90b2FMCS4dxhf5W750k8u7X2dXye1R8HIwj0xhEjCIVSBFb0CkkU/iqUgx8UgbLM3oAv84UkRYxdt39WAuuMv1po7l7hm9qQabA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156468; c=relaxed/simple;
	bh=uLcjLVv+qWPSR5ICTOjPYBPL7zWto8pcAWObjXNGHpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kajCl39tO+8wkMybN8EA/LGNfDWenkmu8gH6tKjOa/FJc9E88E7Ff2eC9fEn1qdyiNXsHaP4wn/QqlsyEMLr/alqe428WtmTTpFlffzYtQxa50dHLNO/bg7bXtlnKClJVMxjcWxjQ3ndzHTYA29PvOMQPHxNwYO90GrW5rB60cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWZxTSN+; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7bd5e373d07so7360797b3.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 05:21:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778156464; cv=none;
        d=google.com; s=arc-20240605;
        b=hOy9lmktkDJu9RcMs2Qq3E9yUiVQ29/7BA1gPtN8SBRFi5Pir6Nqh1NCKCYiEXWi0R
         FCqRK+KrgBMmkH4l9Rg6EBOM+mv8y0TicMC0SUN8TmgRFvsprtojoZEUlblWRU2AIz5p
         /BnGj3Z+OfYF0S+YjOo9M3UCfw0bVZHdjV2UA3i5ES+Q/v8rRHBsy76bggdY/pgbeXbf
         zunJLLvatYvmsB7dyChJRUfrl1gcMDf6yJODC+Av+oPY9kPHgt5Fxc2sEANb88Yt66g6
         5x/fc4ZAMnX8Dt0qpyAUlFccm1J4qfFT9Db6D8PTdIBjmPBH8Et4IZAIfcvtSSk8c7Wf
         Wp8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J8j96orVQ/ckOv/5hosOw0K8Ur7DOqe9Q4uzoByj5jw=;
        fh=v2iNWhtLdEIftK5DccmE1Cza+DoeeAddGXNgiUFJl8M=;
        b=RLeBMZCm8Pku+61VDGhFzh8y62vZWc/qcDoY1Wfn38ii/BAkdgfYe2eFsdDy0TYmCQ
         0HW6yg/W9uNdfJIdeAO8N8Ln8UnuKolJxm/W2IIjXBPJmd7DImsUja4SFuaJ3eIOWuuX
         GDLW14XDbXsjn01qSXzXhthpIo8pAnmDNmZFv4hoTLpXschhITL8RKO0RCdyralfofQc
         SyuUJfxnsGm/vppki0eldIHvwC76iX1f5b4NDoBC2isIfqUugQqegasnBk//zizxeKtK
         FJWIU73rwy1x2akppId/Pa6kFRSMlHWJTFLuxJOvw/DehmkLmTkCps+dWOGFjJxShh8R
         hC6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778156464; x=1778761264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8j96orVQ/ckOv/5hosOw0K8Ur7DOqe9Q4uzoByj5jw=;
        b=NWZxTSN+bxSyw1hGZwXru1FYRvpJVa86plY4BhMZlT7AhJmK1gzZVa9HLn5Zgw0ihE
         vqRr32MhJJKaAPiYEAYWUP84Yudpbd9EEs8UQ9Hyd1f0PWYeQOrJOIcSM3ODAS775xPm
         94d/05/jIEbGN3Ed5cxtunT/8WZfaRW8PTXhCtC+sJdo/NYhPrxCDpk+P10p9ITrEY88
         FK5rr0jJDhFNiktNiFxOyNdOwSPP5/LCCNs+2RE3F+QLLq1V71P/o9Pk+XCy9dUkCG6u
         Kx1516bElSqXL3GVbs97+RuERNYG1HvDTx31lZV5RVIlSDSP4abr9ZoBaRzVdc1dNxyN
         5bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778156464; x=1778761264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J8j96orVQ/ckOv/5hosOw0K8Ur7DOqe9Q4uzoByj5jw=;
        b=LLvnv0HUaeNJePaKC8ohQM1v9+VecpvRf0I+Pe2Dbwh1XkKx4bvRpSSh0QlwkRLfHZ
         3acuWOGCi7VmBgPNkKUYSLczBsux0Mtlva9N1mp4v8cMs97ASDzQ07C5y3Cv3lx9lEQU
         /LqaUhqZolvVLl7Qp+48vhFomZi7OPeOIWT/mZi9AdrhgkhPG4FjrZVFqdZlGPqWH/mV
         a0cMFWAEMJ3dHrMb6Q7FMg0lrJbsi3ScDqmooQmPBXuItTEvJnc3hjcIOnAkn2LG2CH0
         4a9ngnaBnPfdjof64B3hVfpfcDSfT8DQMrh/0eiCbE9jhUtk7M76jLwyAGig7GNKeVPq
         dtzw==
X-Forwarded-Encrypted: i=1; AFNElJ/J+yY9PeSYchMUpGsGZsXJVyLuTgFOzi0fi6NqzZZUpcuFbl4A9xvoHqm9Q2+nOs0GQG0cnfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRYnCHJVh71LmI9Xt1mJjwS7YzevbRULigCUJhjI30GZl0ZY0b
	jyMUtJHQwMTUCrSZr/OeYW/RQOXAAqdUyO+vQbhQ7SXqhqJ5tv8/v4eZS/dONQ3NYBM63HMdBVK
	4Jbqf/7NAbvmdtdqBFESoJ7l3kX092ZY=
X-Gm-Gg: Acq92OFk/NtGafK69BqTXISUU9OjBbcBr3tC/MQYgGWDK7fVjXF7tQcUEfTiaSxf287
	kuDQGVTJZrC7GcW8p7rZPMJl6gvkwvN5iX+ODHUllFy43x/+pPRUgCiJXLB0koSjkTFOSasnLjt
	YhGOwDhhIrOhnFMJLT0rivKunr0dPRhtQLjoEN2qnwvZfLTv8zx0qjkmbc16LUuozmkFmxJTn9U
	GMo+AOTP76B3z/gZp21BMcoofiB1thrpzW7ccEh9QKDeONL2ZLnbTrTGVRAYGzkhY0dIyR077fI
	US4odaBsTkN9muGKDAuR0nk1SRXJJA==
X-Received: by 2002:a05:690c:c511:b0:7ba:f784:57a2 with SMTP id
 00721157ae682-7bdf5e91f70mr83830267b3.33.1778156464224; Thu, 07 May 2026
 05:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506142709.2298255-6-ameryhung@gmail.com> <755de35ed30756cc0f8c3f1dae3cf6d6b82be6f066353b8421d38f9605f64ff1@mail.kernel.org>
In-Reply-To: <755de35ed30756cc0f8c3f1dae3cf6d6b82be6f066353b8421d38f9605f64ff1@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 7 May 2026 14:20:52 +0200
X-Gm-Features: AVHnY4Kh8Z5M2NprGbWaJKaOziopAMmlDagS0Mw0TVgN2MNVvJLW50ZAkE6GRm0
Message-ID: <CAMB2axOoARisR8EuFng_XSE5Nx74ZagFuQU71PdF-66rMtUwuQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 05/12] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com, 
	ast@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 886E24E8204
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com,linux.dev];
	TAGGED_FROM(0.00)[bounces-285305-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 6, 2026 at 4:27=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index f330e9cf297e..51d5f5dd6e5b 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
>
> [ ... ]
>
> > @@ -1381,6 +1394,7 @@ struct bpf_dynptr_desc {
> >       enum bpf_dynptr_type type;
> >       u32 id;
> >       u32 ref_obj_id;
> > +     u32 parent_id;
> >  };
>
> Eduard Zingerman raised a suggestion in v3 about adding documentation
> comments to struct bpf_dynptr_desc. The structure still lacks comments
> explaining when the id, ref_obj_id, and parent_id fields are populated.
> Would it help readers to document when these fields are set?
>
> >
> >  struct bpf_kfunc_call_arg_meta {
> > @@ -1392,6 +1406,7 @@ struct bpf_kfunc_call_arg_meta {
> >       const char *func_name;
> >       /* Out parameters */
> >       u32 ref_obj_id;
> > +     u32 id;
> >       u8 release_regno;
> >       bool r0_rdonly;
> >       u32 ret_btf_id;
>
> Eduard Zingerman suggested in v3 adding a comment for the new id field
> in struct bpf_kfunc_call_arg_meta. The field remains undocumented. Would
> a comment clarifying its purpose improve code readability?

The readability should be improved in patch 7 where ref_obj_id and id
are moved into ref_obj_desc.

For the meaning of id and ref_obj_id, we should keep it in where they
are defined: bpf_verifier.h

>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/254424=
56702


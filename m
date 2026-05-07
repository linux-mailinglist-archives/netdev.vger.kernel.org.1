Return-Path: <netdev+bounces-285306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mA3rI/mD/GmOQwAAu9opvQ
	(envelope-from <netdev+bounces-285306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:22:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F31CC4E8223
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7ED3B300E3DD
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 12:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADADD3264C2;
	Thu,  7 May 2026 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koVOEb/+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27B731AA8F
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156534; cv=pass; b=GBnjw00BlLfRRkvXn8IPT4Q93tg+9qC9zkigVX+FGxsS8IV3yT2C3Ijc6x1dZPA0Ic/qlVK+F4DCvvrD2/Efs029c+DMIJQqq3Fs8z0i/cHO0gcqJeZkNfPG7epO94V+Vd091geXAHeIyQFWwLmaLhFWQsQoJozrNLRvWtba2fY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156534; c=relaxed/simple;
	bh=wBCXvaC9j2yg7DoEd2kvgUs5d80TdpoB6a28GCmXr0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHw1FiyuZsz75IKD2eGDM5HI7GVnSHO4Bxx+KKd7piuRosI2Z6UZEdi+eVZgav1OkE4DkA0dAZWWYHeAm28rGimWJa6efxTBIVUWAF5/pB2nliPLZztr/fYZhiGREpi/VBIjIBdT1Vi/TTQO0QFmcwtbGAv2d56ooGodKz+U+mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koVOEb/+; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7bd6f65c781so6916107b3.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 05:22:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778156532; cv=none;
        d=google.com; s=arc-20240605;
        b=HQxN8gOnPcwjBYeUMUzfMGMF9zR67o3jUrEKFuwlp5UWLnNksxaAryIsYiDVBDHeBx
         AI8e56Iw0ktTYrYBzJ6ORx74VWi+YDFvlHJpa3PnwO0S21ten+6grm4euxhjTef7CEgG
         1GUysT+9v7ZM3DrT6x+ZsvKP2XJbbeVhOteXJXEOpixR3clODb9BWKQOr9fG+4ouK85Z
         l3kHMsjVv5Lu4e08yRSiugOtcLL2iZ19slEGNHAdQz/otZPe2CPlgCUkXtHEtdMnuuoN
         QDexc6mdrNfMEYo0OJv2bNoxAfJd57cH4v7tmJGMXWQyqy8jAt036TgAnudlDWhsTE0L
         j6Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eqVrUrpja/dD28nHYBQb9LLVSkiT4AuuC+bBJBpxEs4=;
        fh=NcyDknHxq98KdK1p1a3/RS4qy69YOqJvNAQtyjxC6Ws=;
        b=BxKpryOHVnaUvuDd1IxNJ+UHJwy6AHhF+rcvfFaQsJpx+PND52VSAL7cGg0yfiMKUd
         sJFp53WRGM5l7n+vROhgQM3XaHd5rgoXIHj3BLgxu+oW7cGgZGh9vs5G9/LNjPvBdNNo
         RXS1WDmkDvqZhh2qpQ5Ohzr492IsnpXpLCVoy0tgpo6J7jJ80Do5H1sNBbnUfPKIdLWR
         CU++QomsWo03YLw/iAI0fJcykGwlaZilx9kBV0BLqDk2O1r/Di9dsX+5L9CV/AF7eL3l
         vw8laqxoF6BG9WR38SNaTwIe/gZZV/g4p+nNMtkdyybUKMkQF6JDhSpOWYPs3SRdGEdE
         OWow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778156532; x=1778761332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqVrUrpja/dD28nHYBQb9LLVSkiT4AuuC+bBJBpxEs4=;
        b=koVOEb/+uC8o5LsXjLLxbQTf46NAwXrUQB4aWluKL3an/ZUZi2zhjCU5QbnP8CrmuE
         rp8NsSPzRMRteZO29xJLFtDH1XLSPSwH0bd2U0aD12idq9/iqmxOc+XB7d5hpcGi/w4z
         ZeT4iaiV1p/f8sZUUXq4tprhB4Vb/GUexx7msgSw8kTig6Wo922XYfmK5x4+Hw7m1i3u
         E4E67TiVSz3Y8IIjCNbzvqU7BTfM7/TBgBeTJmfL1yPnBdhP+bLtKQb4NmgMUMKWOiMU
         qy4dxBk5ONoEe6vmOysL6MgOSOqsseCtevvjldLMBWtkfaFrY3ggKn9RT4TRIhxahNMv
         i9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778156532; x=1778761332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eqVrUrpja/dD28nHYBQb9LLVSkiT4AuuC+bBJBpxEs4=;
        b=KGYcU+rWhBvdCDn4y/mE80XZMsysNhXvlNlbzGWQb4K0HiIasyaDj8oJEtcCvbrCrO
         NVvG8b9BRHRJzSzpa8uh2BUS7j9E6KUZ22ae6MkM7AebXKZCfrIJBaRk4JgfswTJRInu
         dH1ebopZ9Jyhl61OEM02o8MX1oxhT/EvcuFXlEXTib4iYJxmjaAfiDDD+b0r/KW/fXKZ
         kBPlh+dimwB3w5W4GKEV3Ni2CsRwMRjB++S7eIOhvZPKi7oYMvQVHfoIMMopTzeQsS7g
         gowcQGfzN8buK3nu7tgQ+YjHVkwlF/AmUpASYo2qMkuX+FRpUTmFSqEbiNbj/vft+Tbj
         T0YQ==
X-Forwarded-Encrypted: i=1; AFNElJ9pU6PojaysNJ0ZB5Cpnb0d52jbI+oVehbQm78mFdCOzhw7tPPDAIRIiYUCxECOLO3vNUrU9Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSHw6n+38Cl7ETxUsfaVDxl5eVcbuo6bJH6K61Ngf3+EYHod4G
	UQ+OEjuTH1TF+RhIlQYJlzu4mj5WGm5Sqt/sLSP5WNBOnjg6uRkL3lXGF1nNBpCQegqz6ssXqXW
	ZuC4rlwcuaSvFPFsFMNIdCbhcGAa4oCI=
X-Gm-Gg: Acq92OHOChr35Fvwwt7sLfIEDTG6kga66LnbF5x4W/iqDlt/ebA215/05R0NOJSLVf4
	o3lfpArvB7GO6fKJchZq9HCEPVrNDjeYGyQcx3Irj/x4anrC5nWimtUaSWGeZks4Ky8YMXLbZWV
	+hKUTWqgm9mb7cHbZ4dNtXlFHD9Z2Ch7RLFfQj6cXn6qgTILGdM0wKfjkf8Re0iewnmiOaa0yXi
	BZLWMGSu0urdSK4eQ7EN8OXdKLJSpZJpTPToOHD6dExt/Ii8Cv/xKmpiSXHBqNtfRI1uQJFFZWZ
	tDAjSwXBv3/SkJLEAFw=
X-Received: by 2002:a05:690c:e:b0:79a:b49a:cb4e with SMTP id
 00721157ae682-7bf04b521ccmr20042847b3.6.1778156531553; Thu, 07 May 2026
 05:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506142709.2298255-3-ameryhung@gmail.com> <6083c00dc3cc6e72f6a4d0d2ad6632f0950bf12b5c09e873d614128db8758cd9@mail.kernel.org>
In-Reply-To: <6083c00dc3cc6e72f6a4d0d2ad6632f0950bf12b5c09e873d614128db8758cd9@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 7 May 2026 14:22:00 +0200
X-Gm-Features: AVHnY4KRzprocfoIf_8o5-0HrTPDqtdJopWL7Wzb2Cy4Qo-gmzSBtTTtTpSDNgw
Message-ID: <CAMB2axOg2CzkQxeJ5D7Q5YKji9sJYL6c16ODa4Y5nh1FNBfAwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 02/12] bpf: Unify dynptr handling in the verifier
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com, 
	ast@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F31CC4E8223
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
	TAGGED_FROM(0.00)[bounces-285306-lists,netdev=lfdr.de];
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
> > index 976e2b2f40e8..f330e9cf297e 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -1376,6 +1376,13 @@ struct bpf_map_desc {
> >       int uid;
> >  };
> >
> > +/* The last initialized dynptr; Populated by process_dynptr_func() */
> > +struct bpf_dynptr_desc {
> > +     enum bpf_dynptr_type type;
> > +     u32 id;
> > +     u32 ref_obj_id;
> > +};
> > +
>
> A review comment from Mykyta Yatsenko requested that a comment be added
> to the ref_obj_id field explaining what it's for:
>
>   https://lore.kernel.org/bpf/87ikb2tkta.fsf@gmail.com/
>
> The author mentioned in v3 that comments for id, ref_obj_id, and parent_i=
d
> would be added in a later refactor patch. However, should this struct hav=
e
> inline documentation now for clarity, particularly for the ref_obj_id fie=
ld?

For the meaning of id, ref_obj_id and parent_id, keep the
documentation in where they are defined: bpf_verifier.h

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


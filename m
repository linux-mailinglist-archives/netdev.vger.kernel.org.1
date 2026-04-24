Return-Path: <netdev+bounces-280895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNCdJxm06mnACgAAu9opvQ
	(envelope-from <netdev+bounces-280895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 02:06:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3BD4587EA
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 02:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94660302836E
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 00:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316BF625;
	Fri, 24 Apr 2026 00:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4SpdDL/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029C81E515
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 00:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776989075; cv=pass; b=Um+aAQklEDbzKbJkUM9Qzofmv9FcYkXJhZEsg0Z01G0Dai3nVqwsTKuvQ1mWGjANiSPxZjwEQPigbNNHtQBS7GYjTri5GphJqbnPAFeUlwVoDJxP/NGKSo0g6SXI/5fTFjt71kxyFShxD+rxOaL9+VQQ5znm0PVvEnVSY61uH+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776989075; c=relaxed/simple;
	bh=rR7yJkVeAU+bU7zDCIhoy1g4AE0IgeCxaWBV/S19lxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAAmhwoy2eJYbpmjBh+MfKnphHlQKUYSV20AM0DyyEDRZ6mPSVqagYuMRqPyoOwKl7u6sud5OsqveJjcDr4toEdSOPV0QCgMlJ0b52odKfip3JzfiUJepMJjaEA2sWywfA75uHT4NdIcGIGGHVlIwT64qydzbHkUgeuINBi6Ais=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4SpdDL/; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3614826eca4so6555754a91.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 17:04:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776989073; cv=none;
        d=google.com; s=arc-20240605;
        b=cuid+EOho/ggjqJVg/jffjAxu67NANdysHGMzpDjwueLa04u/IgDhB50UZv4INRjYl
         UgvUqWHdJxD1A6O0mJsMMEYWxSV0+L2SE3jVBOPi6g1xyDaTrwplGpl+gO2xqP9QcsiS
         VUeXdsLyWDSPTeNRC7dXUqy4ZDWgaFv/p/F3ngH7qGFv0qe+o28wvFk4o8NvCXVoDjTf
         ux4i41f3U1i1UHltk9pU5+i0nYZWsfLwzSNvx5cBrR9LxZpsJJP+PBWr1SbIyHJtWs1i
         KBLpYz3X1I8kChtsLUZfxw60+25NjJEs5l1xy2exGGwsrjJ5cRFoYqIH2k3lmdnKSgej
         Jnbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FAB5UxHLGkfqH3aRKTWSgh4XaJyzbZFNomio95Cy/qQ=;
        fh=sNq+DJ3jTt3GISc4Vs2Q+SasLg7Yj5z/PPhhsnBBsvc=;
        b=EoIHkgEC/kyCjBlrmAycMuj5PPc2LYtFfqHu/tyB2HVU+jUYw+VeXejGqmZfqEOxSb
         pwXA8re4E7jwKu05WDcd6jOvKDqsFO0lsx6Jqy19nrQsXebQrW8UxafKppgini3HZaSa
         62tpFRJTavsYuOsqQpQL5pd8fty2wV+q9+QE3RKmALOdRx4wrUcDfE+mfvvbkMYCFR1I
         JVb17bJIoxhXfN23v6S7YsEwtO5U/YbPno2U4d3dzrkzT/z9jlCh7giWRd+h1xW+ISz+
         VZpu+Qmn+7krm17+LGbNvdVatnmQwCrQq08G3ksvRLA1U7U+6xwaQdQb82sbhByrTDa/
         zXKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776989073; x=1777593873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAB5UxHLGkfqH3aRKTWSgh4XaJyzbZFNomio95Cy/qQ=;
        b=d4SpdDL/OevtWmUXPEdI9Ke22c+/+ixlMX2mYOgbhr/tlVUq1x0vBimLXtE7NqM0ZU
         gBF3dEhR/jKSWhci2XHx2P4CTC0UE8mLnneznBUWklcekQQNMTNGaoYp1iqoDL58SwmS
         5ZXIqB6dbxMSLCiI40eCBCcdDUXS+Kx/9jToQyqETEhfmbSRDugL1er/lHYvqeHnRkRv
         KrhD3fxnudKzNv7wM5XfILjuATcXhNLsBbeOfrp+HZ1K1isWka2RQ29TyJ6oojc4zybi
         Jul+W6zXdU6QP5YCHi+KbY+G/JAxd98wet04kocHDV0YrUjpK6fPU31nrZiL/+Q2Gl1q
         vEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776989073; x=1777593873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FAB5UxHLGkfqH3aRKTWSgh4XaJyzbZFNomio95Cy/qQ=;
        b=R1AEFTZurh3MkwUaodgXDNzVxieXTFZExVbNJai3bczBd7RRKUUkZauqeIanae7I1L
         3bcgQngPqfOhRjBD4JvgHb8GDnF0E7T/oLa0dC4tGnwgExKAqHsqiuYPt3F3ReKP26dA
         JrHdXWtfGy5DOOmfeiTx7nBdurgidJQ/WNmhP8elgEVYHhv14/TLfY6Rf09i9uRuBzoN
         sV7rx6aMJ1Xty0k5rkK+Vvj4Oic8By5BmlZlV2tz5z5nAkijjGvzVLNtHiJiWVJUgBTc
         0WfkdPn/JRfrGUnn62+Qtj0OWS4VJxfSlALXk0WtMTrlDfGdW+5qmsgkqLOVGNIhMd8y
         BebQ==
X-Forwarded-Encrypted: i=1; AFNElJ+6kzbmrV91WcfA3iMArI2jEVgS7DJcHRRjrnhGDRSjaktjL8iJP9PtOUAO16lqHXKId0oOoKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyErzzugivLI+nByzvFHjeElpyCDyX5qg/YO32ud5TbklaPPDs
	iAAjkBSvXGpLBSXWMzY9vo7AEWy6ueZVmxzEgtVYEqOo1bjiTg33u1mk0d1nFIFIknXmdILtwXT
	UOPeNBNxjoPV0Yf0Igr0SeZ5yMsklnYQ=
X-Gm-Gg: AeBDieuCcp9nx67F8Y0Da0pT0z/ccrY25ps1FReNPJlN+Kc4du9STzTEcSj+kMJMosV
	LjvtkeGDKfXTtapQ03BrpfiBH6qgp8hA3DISDzcgwGb/IfsO3/BJaRWb/aGc7jmXdKZk1AuGdHa
	MRa2aGTWkQF8aISnulBDolSxgpaHTjzw8tQDAf6x5N9cjMI8/C7X+Hfpwozy7iZBeWEd7kVCyoQ
	d5o15n3LzeNKv2MbrWnJzevZlLBOvPqR+RmEhtlleymV6IPkBpudHjG9USxncO6azrbOFf2Vqts
	Mvh3HP0/B3FDrSzryLYLEXNoaKyjWHJ4xEXvXYI8SkSA
X-Received: by 2002:a17:90b:562b:b0:35b:929f:7e95 with SMTP id
 98e67ed59e1d1-361403bdcfcmr30802961a91.4.1776989073332; Thu, 23 Apr 2026
 17:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com> <20260421221016.2967924-3-ameryhung@gmail.com>
In-Reply-To: <20260421221016.2967924-3-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 23 Apr 2026 17:04:16 -0700
X-Gm-Features: AQROBzBCc5pqEFftVacWlfESInl23hSRMNeIxUTHFTaCSQoHlqvOHxidBSCmDd0
Message-ID: <CAEf4BzaPi0jTQM5Nuv4nGY2R19D+ZfR_WbgMzqGPvbG7GqEQGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] bpf: Assign reg->id when getting
 referenced kptr from ctx
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3F3BD4587EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280895-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, Apr 21, 2026 at 3:10=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Assign reg->id when getting referenced kptr from read program context
> to be consistent with R0 of KF_ACQUIRE kfunc. skb dynptr will track the
> referenced skb in qdisc programs using a new field reg->parent_id in
> a later patch.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  kernel/bpf/verifier.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 41e4ea41c72e..93003a2a96b0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6448,8 +6448,6 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
>                         } else {
>                                 mark_reg_known_zero(env, regs,
>                                                     value_regno);
> -                               if (type_may_be_null(info.reg_type))
> -                                       regs[value_regno].id =3D ++env->i=
d_gen;
>                                 /* A load of ctx field could have differe=
nt
>                                  * actual load size with the one encoded =
in the
>                                  * insn. When the dst is PTR, it is for s=
ure not
> @@ -6459,8 +6457,11 @@ static int check_mem_access(struct bpf_verifier_en=
v *env, int insn_idx, u32 regn
>                                 if (base_type(info.reg_type) =3D=3D PTR_T=
O_BTF_ID) {
>                                         regs[value_regno].btf =3D info.bt=
f;
>                                         regs[value_regno].btf_id =3D info=
.btf_id;
> +                                       regs[value_regno].id =3D info.ref=
_obj_id;
>                                         regs[value_regno].ref_obj_id =3D =
info.ref_obj_id;
>                                 }
> +                               if (type_may_be_null(info.reg_type) && !r=
egs[value_regno].id)
> +                                       regs[value_regno].id =3D ++env->i=
d_gen;
>                         }
>                         regs[value_regno].type =3D info.reg_type;
>                 }
> --
> 2.52.0
>


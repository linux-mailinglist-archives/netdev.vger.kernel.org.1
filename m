Return-Path: <netdev+bounces-252108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AQMFHJqcWmaGgAAu9opvQ
	(envelope-from <netdev+bounces-252108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:08:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFFF5FD18
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D4AE4E129E
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 00:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6255A1B394F;
	Thu, 22 Jan 2026 00:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHml28c1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABAE3A1B5
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 00:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769040492; cv=pass; b=hrne3AnOd00ZLe3YzEnJPhHlc7lWdsTOcOOCzZI7DhdR5XuhuY7Y748l/qhHq96Ri8HS1XjJu6IsPJynjqmUmoYZqHKJdrb23wV29sIs4RXUa8DVzVpbvkhOV1TKVoVP/eW0+tdyziJIBJg1QiSlL2AH/qGBNKOZCPlnJA+oizY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769040492; c=relaxed/simple;
	bh=rcDFV/jb5AFZGAv5ko2hhsutnZLwDbzbWS7PyUYRzm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ja3O5oJJykrCYwCAapCMA4GSkWLaPSq1tu3F98HMMduEenLsYCji0DrUwpXkh9K5uouns3LpE6EaMh9nRXTHWazPzVkYrThwsMiN7Pb7EP9i6yXHKWOtzPQUcabAg0dzyJDzUvbjhTHtt3otDO618fd+K+vSAy7EChex3BGe1kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHml28c1; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34c24f4dfb7so258467a91.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:08:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769040490; cv=none;
        d=google.com; s=arc-20240605;
        b=YZEOtTSl+BXb3lGI3zAASUn7UmjbKvX76iohr52uVQxP82d8eL40c+gj0PJzaYFPfN
         5lr0j4uR472iE3AjSjkOHEJig46mIiJx40r6FhvQdv/QKRIroTyTUNVYQrEyTsVQRj5D
         GONfI4UtcwiHAJKVO8n19pYM2ExecEaBDNIUkE2V1trHtq+akR+DR5KreK/KL8yxjmpD
         mM5p+FeUYtSPCvfc5vNBIL9Knx6WiQD43jhe0lXSdwvpmc8mZse35vGoGReL9UoeNH28
         FZOkWFQMxs6ti7M1sAe1xUxdb8whdXUMIakERoU6IVsv/Rz6OxtiH5JWuCUctCl38jiM
         jmNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CEq2XLfImnI9UEC9IsU1TUIK3ENSgE7y7e+S18vk1RM=;
        fh=GezImQrP+Vp4pjh17oHk4smk8wSzpaChsprlebvWddo=;
        b=ITlj4+Qyd+AumyV4HcK4Tc3S1vrko9O3oEGESA4/CvOwSmi3sCey8I4PEv2plsgsqQ
         o7y+twLyZpZmMa4rRVnIPqw4rtHnoS/DluJ/w9H/7/nVXboUzrjPwGJimNsLU8HNDXyf
         JCOTUKNYXYub1dcyeNcmCqpJUaTYBRq6vPyCmloPKgjWPVtDe7ouOqRhLmPnGKWsHu2g
         ViTtA2SB8nmgOxYdvTcHVGGa8qDTuqGRGND+uZBi371D5L6YVVEQjUaR9SWwDCCLy4gE
         RPgJS2G2y4yJ6RL+KenKIywWgANi9ctAVt9fCAiRgwWaXuDF+XBad8oypjjZTrQQ33yK
         /Jww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769040490; x=1769645290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEq2XLfImnI9UEC9IsU1TUIK3ENSgE7y7e+S18vk1RM=;
        b=nHml28c1FdgbO3YOkCGuXVzQn72JQPBQKTQqY20Nx7bcjSWdzfAu2lYzleEwkSGj27
         jSRE4lqwk+n14Gv13vC6FI5rbqempf/GMebUz0X1Am3fHg/4AXlcyuyj50Rf000fzjwc
         ZPzENOaj6u0NeAG9eEBK8HfdNyvV591x7G6Sik6nuJkvOkCHrw+CpXiQvsFbrroowXLr
         zd8Ymwa+i6ua/+hb8WRAn1ohcStC6SDysXRQCD04ln6/3i65mmT7rWVE2fjLPxzRYf1g
         MrTTFIYIcq1cRiIuodLjjZFjp+i9e9dXfxL5zGUrUuS5KTnaBAC3FPkQgphBDmsKrGZg
         YMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769040490; x=1769645290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CEq2XLfImnI9UEC9IsU1TUIK3ENSgE7y7e+S18vk1RM=;
        b=QDoKv8EnVlOfBgspi72+sy38S3Lgsm6W9et3hVZfuYIMGP9Zh3yFu+b/myEe/aewEW
         H6zSiWy7AwK0/6FnAhQdpIWYX7BHxbkgmgGzRX+3GHOozepBYWj5gFWUARx+Sti/nRcl
         1SN94yNCbFpx2ySrGK2094vJPeVz02FoOoKigdymZLrt02KBI9zlBjSze/GLl1Oo6bBD
         s443VhNd659FAnPyqCDtAIH7vKMRe9WGyzs/7ILVxluEzToqLKs/6LIejg1xgROoctzI
         JScLOOcEYBJrQ2HTBeBknF2QV3Rxsqs0orZ+gY+adKExGcnnHjNmEtCU+q7Beirj0vJ4
         RJNA==
X-Forwarded-Encrypted: i=1; AJvYcCV8VteJJiE5BP2SkgpUNDB0Dk4mx+oxiD6/ViLcwmYjYvJOmfJ56f3Uz0EsJYLqokxmqlxResU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvbf0FUZhLtb4i+I0qgX0zX6EHC8CkL6NN45UyK1kBB9wMnFSy
	h0UcnkMMzPoAIGxYTf+O7zF9NRkBznecr6u4RWsC+UNq7wapBZig3/ZlmvaqBcnuT77/tRUECwA
	uZuagJO0kwQc/cI9lcGeyZKJwpxfsQCBOSw==
X-Gm-Gg: AZuq6aJz9qj29Vg3WDZ1mKixVzvpVHn0p5fYgLFASX4PdBqPtLYG2Mu+Q74azLVhZll
	VJVMDY50lFIdszCM8zrRXdDx2tU1KQZYFjan4oJwYXIqWNu8+pqRXcJJQGyaqeyGiM1595H3u71
	D8QVTKKV6kMfckJ+waUCKfvKOvE0JvkN2JlJTZOGQqDT19ppGLZJ7Ilnc+Lmpfa6KCsy3PKBhcV
	zkkMGRMmnZtqv8uF8mXGHRrGyCrGl9ASKrAnfOf1sM+KXQ7HrpOp8jY8Vr9hRA8ZVrgb4rSXJ96
	4KMH90w/Hf5HkdhDYBI=
X-Received: by 2002:a17:90b:5344:b0:34c:cb3c:f544 with SMTP id
 98e67ed59e1d1-35273179d01mr16388848a91.14.1769040490112; Wed, 21 Jan 2026
 16:08:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115112246.221082-1-dongml2@chinatelecom.cn> <20260115112246.221082-12-dongml2@chinatelecom.cn>
In-Reply-To: <20260115112246.221082-12-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 Jan 2026 16:07:58 -0800
X-Gm-Features: AZwV_QhgBqz09ws2ewKfqsUbDO_vJyCn2syHCxdPXgnk8kXxYqJ1jNQI5JIHhoY
Message-ID: <CAEf4BzYbzSf_jXwFxni0viHRHhYQ=k=Ggq79S=FRNmxQGdcS1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 11/12] selftests/bpf: add testcases for
 fsession cookie
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252108-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BAFFF5FD18
X-Rspamd-Action: no action

On Thu, Jan 15, 2026 at 3:24=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Test session cookie for fsession. Multiple fsession BPF progs is attached
> to bpf_fentry_test1() and session cookie is read and write in the
> testcase.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v3:
> - restructure the testcase by combine the testcases for session cookie an=
d
>   get_func_ip into one patch
> ---
>  .../selftests/bpf/progs/fsession_test.c       | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/te=
sting/selftests/bpf/progs/fsession_test.c
> index f504984d42f2..4e55ca67db46 100644
> --- a/tools/testing/selftests/bpf/progs/fsession_test.c
> +++ b/tools/testing/selftests/bpf/progs/fsession_test.c
> @@ -108,3 +108,56 @@ int BPF_PROG(test6, int a)
>                 test6_entry_result =3D (const void *) addr =3D=3D &bpf_fe=
ntry_test1;
>         return 0;
>  }
> +
> +__u64 test7_entry_ok =3D 0;
> +__u64 test7_exit_ok =3D 0;
> +SEC("fsession/bpf_fentry_test1")
> +int BPF_PROG(test7, int a)
> +{
> +       __u64 *cookie =3D bpf_session_cookie(ctx);
> +
> +       if (!bpf_session_is_return(ctx)) {
> +               *cookie =3D 0xAAAABBBBCCCCDDDDull;
> +               test7_entry_ok =3D *cookie =3D=3D 0xAAAABBBBCCCCDDDDull;

you are trying to double-check that writing into *cookie preserves the
written value, is that right? Do we need volatile read here to ensure
that compiler doesn't optimize this?

> +               return 0;
> +       }
> +
> +       test7_exit_ok =3D *cookie =3D=3D 0xAAAABBBBCCCCDDDDull;
> +       return 0;
> +}
> +
> +__u64 test8_entry_ok =3D 0;
> +__u64 test8_exit_ok =3D 0;
> +
> +SEC("fsession/bpf_fentry_test1")
> +int BPF_PROG(test8, int a)
> +{
> +       __u64 *cookie =3D bpf_session_cookie(ctx);
> +
> +       if (!bpf_session_is_return(ctx)) {
> +               *cookie =3D 0x1111222233334444ull;
> +               test8_entry_ok =3D *cookie =3D=3D 0x1111222233334444ull;
> +               return 0;
> +       }
> +
> +       test8_exit_ok =3D *cookie =3D=3D 0x1111222233334444ull;
> +       return 0;
> +}
> +
> +__u64 test9_entry_result =3D 0;
> +__u64 test9_exit_result =3D 0;
> +
> +SEC("fsession/bpf_fentry_test1")
> +int BPF_PROG(test9, int a, int ret)
> +{
> +       __u64 *cookie =3D bpf_session_cookie(ctx);
> +
> +       if (!bpf_session_is_return(ctx)) {
> +               test9_entry_result =3D a =3D=3D 1 && ret =3D=3D 0;
> +               *cookie =3D 0x123456ULL;
> +               return 0;
> +       }
> +
> +       test9_exit_result =3D a =3D=3D 1 && ret =3D=3D 2 && *cookie =3D=
=3D 0x123456ULL;
> +       return 0;
> +}
> --
> 2.52.0
>


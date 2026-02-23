Return-Path: <netdev+bounces-260123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHvEC0WHnGm7IwQAu9opvQ
	(envelope-from <netdev+bounces-260123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:58:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4774517A3C3
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D0133005179
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47B73191B5;
	Mon, 23 Feb 2026 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReOT2Foh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB59314A84
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771865909; cv=pass; b=p0VvtjSL6xGxD2vk3shD1O7zo3BAVfb27AlrPMxo4QnsJZlLsO4qM8vstp4q1/k5ymJn8uk4KXRUxsIibyBRgo1XYypL4oYN9LdPrBAIepZc5kqlXN2znjflyaQJeaQ9MPN2VEk3xDWyqgLV33/VFEdqTa3NpOuhuDujEa/TV1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771865909; c=relaxed/simple;
	bh=8O35ywf3frONs/mR3sh+Q3y4PGU/DxQ4aRR+Ww+VwB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8NcL3VTVC/NYgOgfBvXnevon5D+O4P6bvRmLMGnwvvZm7RNGn1hgpw6juaBS3TsNiDOxfchL4SjsxgHn+oD2HgGkw5eHInD+VK0KhNqKTiJWYJjbX1nA1v2ZWQfiQDNok4428M6L4waXhGTwRm3wu9zeUwJ9Dc3RgQqNXlcB9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReOT2Foh; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48373a4bca3so27397355e9.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 08:58:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771865907; cv=none;
        d=google.com; s=arc-20240605;
        b=RtRMqkhsB9zKDByBUAsWJoUtz42BHsAifoXwDMJlvxqhbAimpCw3bIibYOno3K13fx
         I+3tKgKdg64WhgUlf3GCOjuGc8ktYjXhmXL1cegPv5TYUyfnbcndGWiE9kWvuqW3O1wq
         qCCFhQmkT9BYt4gCSEdpOKkqJGAveL3trKJwIpqL1YEtDGa7Dskz7kQYf4bYbzt+KDln
         qEPnowd4g+/pCY7DUcGal163yEF6RQ81ZCc4WQFEN4z+NQV0r+AV9vsFLJxnXyFRdABL
         WzMkcL6nyRXLwWQpVUyr8zebhV9ptvYInCMfpzv5jtIeHFpFS2IP04W5+MuaUJRDuvg9
         HZ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2/TWRW3byuvHDEl1Ok9W0sAe5kheK+6oFHQAV5r5ghw=;
        fh=MOhK3SvBamVXFCRmgjZBOaqpgHfSwwQNkLLSdcwqixI=;
        b=V9k9joRrfBBHuRPe2QDY6IUdqkebjXclah4KyfGPJBk3f8UtzATAxadkOjPgyPNuKc
         4nh16BPCrJ1jKsKo4vGZ82w4SSXL6jDk571z/q+6bDnJnNbQZd92HFE0NQTBEik/VUxy
         yYcCzqRrKKxX6vGsPjg/s16dD09KOb9mryfHEv3DY53rwweF8/qbWVH+1KRrQYnEq2mm
         Oxzbnsk1rlwMX6HIZgscBQUvT7Kay0YU3cJyfpBQFzcg0buijQl3QSOx4OLJP3X6j8Si
         SLV7eHKIWjBHkk3t8f2zlA4WGXEnmvs8PRF4v2rTSr+PHlO0R1MqVy5vvNdEKTZJtR0P
         rmzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771865907; x=1772470707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/TWRW3byuvHDEl1Ok9W0sAe5kheK+6oFHQAV5r5ghw=;
        b=ReOT2Fohn+NNBBbUJpNuYk384nuMXyiNFHVPkouNela1ImQm4WI0vsXiu/VNIdP6kD
         J7zbFeV4UpXHLousND1iqZaEXqe2OhDCBiKP2hwdHCwglau583RVveXojmoNacSCTSgg
         ZO94CAlMcp5+NTKBV46d1C7X0HXfTisdBfXxhXbmsz2f6J56rMF41e0IBOw3uio2OqDs
         Y7lh77oFr7d9wjKEiiren2rJNRHlWDpzGIxplX76MbVhCIwSxuXXXVI62qJg103EPqDG
         aEboVMp0zMDHAPCj4Zefd6zEJ6AWFRPjMVdc8LREdbMEmcphSQEHPfJvAkQk1LmVgffc
         LrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771865907; x=1772470707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2/TWRW3byuvHDEl1Ok9W0sAe5kheK+6oFHQAV5r5ghw=;
        b=QdKOFJPKWkGW4j3EhAIBcZAY/KO/m2D/g+qnqMhggnhUGUTPSNhCdthJPnRFy5yK04
         +kXc0N3T2XXvwqjKPnpV9f5fSq9SALgyl9UiMNCIUlzKatdiYwuoa4AIO3yuFj6U2Z33
         0YO/6jP9Jhcs6TIS7imaRkD/iC4ND21V92A/J0lQrHy7Oa9rpqGh7v2bSr4vXB5f9kqZ
         PLYaqkYpX9wvwVjxlDZrrvc30iSEYg7karr078z/yxXsmWFjUFvcJ9xTR59o1Uocxh3a
         wqTVhcK7cYg/rcnud7Z86HyD30vlB5Kz8R9p35CUpg2WhXKt7sAClA+Y1BLZXWiZEuqc
         jbWw==
X-Forwarded-Encrypted: i=1; AJvYcCX/FzpspIls/a4928+FSTZ2BfeK3L6D6apy68Ttazyn3/W1hRlLtyjXohKWpeCeZODxQSymU9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEpGbFU0ksdKtYfG8EfZd+HF/MByG3VE9YsvcTt/WP0EQARbX0
	TQWf7SN3twNCtpsuhUr02Vvi8/RjKkhdTpfiKXP4/1i93bAM9V7Bi8mll4FQX9U1r4GZ4Fxq8W1
	H+xgmO8WCnjRrF7srmYTKfhY+l2rVfLg=
X-Gm-Gg: AZuq6aIRwf/dnXRzt+bY7e+Dmw0jj8INeKp2XrkjO+QMmWdH1V7unxILKBpzO9NgzFn
	wg9/ByPfrk/s2sSzJutj/wZtVSZGtsooXBuFVcG39WzwgMPSVACKmU3QPlWf/sur6mOdIeEMXe+
	cPm6hbQJ1G7fHDVOI/T72ADa1ADaM7M0KXnl39v8SfJog7ydcYwc6Dokd/wJbS134UR3uO7744t
	r1kBb29ggHJj3aoEi3b3FV5MSqQTMkoaV0N6U7CZZahu+o5rofk4hxGPRsrujSf+UX9UxmMbEbU
	0XUjD1yHp8rOwIlOPKOeGvksoft3OKnEFx0PjliIi+8GGtLxFIo6UxLSuYJcpYrbW2XJ2+HOFf/
	eUjion8ttUCD35SWpEhs=
X-Received: by 2002:a05:600c:3484:b0:483:7f4e:fef6 with SMTP id
 5b1f17b1804b1-483a95fa4e7mr119430205e9.26.1771865906614; Mon, 23 Feb 2026
 08:58:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <692c1f3c4b95e9b8a2bbaf333f4618f1ca1c3cc36fc8b0246b094cd67ed62dbd@mail.kernel.org>
 <20260223104743.37713-1-slava.imameev@crowdstrike.com>
In-Reply-To: <20260223104743.37713-1-slava.imameev@crowdstrike.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 23 Feb 2026 08:58:14 -0800
X-Gm-Features: AaiRm53gF6QRXkPAEJJjxdjdGlfFi_H0IJde1Ne6TGCB64Ct4fuwj2XfM2Yoyyg
Message-ID: <CAADnVQ+okfKHvKzCy9vLQkpevhvHMFXhincqmFOQX9zN_vtQyA@mail.gmail.com>
Subject: Re: Re: [PATCH bpf-next v3 1/2] bpf: Support multi-level pointer
 params via SCALAR_VALUE for trampolines
To: Slava Imameev <slava.imameev@crowdstrike.com>
Cc: bot+bpf-ci@kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, Chris Mason <clm@meta.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Eduard <eddyz87@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>, Simon Horman <horms@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	DL Linux Open Source Team <linux-open-source@crowdstrike.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Network Development <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260123-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,meta.com,iogearbox.net,davemloft.net,gmail.com,google.com,linux.dev,crowdstrike.com,redhat.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,crowdstrike.com:email]
X-Rspamd-Queue-Id: 4774517A3C3
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 2:48=E2=80=AFAM Slava Imameev
<slava.imameev@crowdstrike.com> wrote:
>
> I think support for broader types can be provided in a compatible way
> with future annotated support, as I explained in my reply to the v2
> review:
>
> "
>   > so I suggest treating 'void **' as a scalar as Eduard suggested.
>   > This particular sb_eat_lsm_opts() hook
>   > doesn't have a useful type behind it anyway.
>   > I'm less certain about 'char **'. If we make it scalar too
>   > it will be harder to make it a pointer to nul terminated string later=
.
>
>   > So I would do 'void **' -> scalar for now only.
>
>   I changed to scalar in v3, keeping broader scope for pointer types.
>
>   We encountered double pointers of various types that required
>   workarounds, such as:
>
>   int __posix_acl_chmod(struct posix_acl **acl, gfp_t gfp, umode_t mode)
>
>   Adding support for void** alone doesn't address the broader issue
>   with other double pointer types.
>
>   When annotated array support (including char**) is added in the
>   future, it should remain compatible with the scalar approach for
>   legacy (unannotated) parameters. Unannotated parameters will
>   continue using scalar handling.
> "

but then there is no need to relax it for double pointers only.

-       if (is_void_or_int_ptr(btf, t))
+       if (is_void_or_int_ptr(btf, t) || !btf_type_is_struct_ptr(btf, t))

would make 'scalar' a fallback for anything unrecognized,
and we can argue that making it smarter in the future
maybe hopefully won't break progs.


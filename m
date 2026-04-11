Return-Path: <netdev+bounces-277713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Za+yDIiO2mll3wgAu9opvQ
	(envelope-from <netdev+bounces-277713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 20:10:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EA93E1396
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 20:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2575A301829E
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 18:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243CD2F363E;
	Sat, 11 Apr 2026 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kz4XlJxn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD82181334
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775931011; cv=pass; b=pYXbeY74mA9IYwa+ZTwE5UNZoJLU9ln6nrxQW00KzQlxpBOgDf7fMlhq0f/lZDeFfMRw3iOiv/VO6CpkdLKnbT+xglMuRDfDWX6gL3jH4+zEZhzwxE+qbe8LlGzrHh/GFp5PuOFszhmdDj3OFz/TxbRNFowXMJHA214u5NrXpQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775931011; c=relaxed/simple;
	bh=yvcW02x1KNbc8+q/RDgH4lZx+kL+dYQn2iR7/553JiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6qkoZ4/YCwdXLLQiinnXk0tDkZaFcL/YYIfPGK6efkBKpc8ruu//Fvwdsbvjtdcd3AsmP7DAOCg6TupYucGyvUMbjCR3DuJ6orYMj+P46tTCg0Uqo6oTSkzZ5SicrWsCD05Z30ZszOG3mnShgm8z2WUwfHAGeDUGgx9HgNRnao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kz4XlJxn; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43ccda008cdso1729448f8f.0
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 11:10:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775931008; cv=none;
        d=google.com; s=arc-20240605;
        b=Wy+DsJQFQp1m5aLp2G9QZQJU/pxFfBnt396tOS6faZCAAqh3vBP3Zdymc6tNSI8M3T
         hIdoDxey27jC5KvJzKQ0bEOm1xEo98tVlL5dHygyLmfGApRoeMrqTnW8rEj45UNqnlzx
         IKwag29BbcafGsgdruelAW68HGNDcAu+ZDT/2XJ8uwH3yNlMCLHzRiVNKSxIU7uM53Gc
         VsfhowlRz7ZWd5WjgQO9joQldLQ78zV/oEJ/p16eS3XoZdCIlfKUeeN+3uN9rZkBXfBl
         OJ5nonUYYikPCxUdB6fTD8J2nQ8Qe1UfZJB/KWmVc/uD1tEa1c0tb7XyRJREAuTAt1zN
         0RUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R/7dYnA2K4xT6LPd1w0Mqp4/PRNYQI3twve+b/J/BZA=;
        fh=GXQwVnpVmpiuFvKnlzZDRz45BbZJegj0AyBnNfDhn0s=;
        b=dzqz0rjeHo9/4PMaN3qvis5FQZBay5caOx2eD/dYPNFhw+cOcTKcdHG4rH7+BviXou
         AI3cc3seglyuUoNg29xDixBJzO7vmLe4jrZwOTSTcK0wHRxsVYdtEqfw+aFJIEMDZlMm
         o0fy57LtLqd4ZoA4v24aq7R49YB9mXgresJHVHvr9UvoiXslCN+41kYAugrtxwHp1OQb
         Ldc6HJbyMhdE3PI7RLgQBosNv3dSGof+awK+Z8WmoWVBgHpbm6E+/ku0u6qvLVXa6dfh
         kK6S12//Nv8LrO/DaBbO7c7Yn2Gk9sO8jLRIsDZtnVrYkz7cYoDfgmXlHAfn8i5hCyA3
         4cbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775931008; x=1776535808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/7dYnA2K4xT6LPd1w0Mqp4/PRNYQI3twve+b/J/BZA=;
        b=Kz4XlJxnybR9zYLKc9uHx2nKfgOZ7H4Ow6eYj9Zj8YG2okH1pibUCaPgvRp/CiGJOp
         S9Cx/dX9pHvA3+yp0xQfmHpKeSNlxwozlMD7cyDh5fuc08OfTrvSKBFt5i3vKNdELc+X
         QxzsmedcugLCfARokQAhRxOqxiaUw9nTfunzN2X4K2JOl79wtpYJjzP4C0OUWZSYgzp6
         6NcWTG8DYWOku4bRoGMx7M+OE72FyMhelWPlM09vTKz76dtAOehdVltq+0sM6W5yc3gM
         LhnoVn9k/3ygd6hgKoLs6bnmbMelL7rkTgQnViCWka8iGuzJMh0dZ81YQ9C34Cd6OSFD
         SaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775931008; x=1776535808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R/7dYnA2K4xT6LPd1w0Mqp4/PRNYQI3twve+b/J/BZA=;
        b=Mx5iOgpeBWjobey9LllDGFln/7PVae7Rta4ztTbajZHRKnlwtF7oWMXNkg/XYRGuaj
         uS6vi49c++FsTzCVSQR8UM60k4IElZU3FRd82777rPAvgG6xoFMz/eKaf8hNpT9vcUYX
         P3cykvK2TFQD0ztjhdkyRGB1DeEMMNO7zhHoGmEkkBXknqW02oisnXAYtDKtaKCzQmHT
         PzYntNxsPATiFb7QYqwvK3dR7lx6hpvXsHUj2IaJlFnSE/vv4unRCaOBe0kFQyw5NxcE
         eCSptm69/0Bmrs07rtBrHzLIZPeLFXljMutMlfxLbmkVoRw1shHfScg3/IYgj8KLX9jj
         WO9A==
X-Forwarded-Encrypted: i=1; AFNElJ/PADtqx+ydwOB/HUAdpEhoVZlRNE4kWXlTg5qAjUIjG3WPSVNRdLscdU8Yu92ojIFsM4w0VFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDpXdV6jOlMvARmtRl6uXCx8s3lAfkNaGbyK428jT59abWY2Lk
	tLJ71thBDkIB9SJW0VOEX5uDq6VnU3EDrTKQl12qYyFLiSVwH+OzWATpnph6HFfhR1KXvHV+3aD
	SCAAie4qN91x5F09ZKX7EKyBZ5Y+AOKM=
X-Gm-Gg: AeBDietb+64FXuci8cWszjdXB9G+rlKcJvPYVEbPT7lF8smlWN78pdsCQXJyTb+a13J
	PwYbVfFe06/3RR1zgExV91anNTEfv1/bq1QwGTryFA2SxfloaWnizavk0IgW63aYUzIVLwBOS4z
	aF0KgZ0kI0U+oLih/60HO+F7URrwqQenbqf0at26WpvfDRXMbd8wsOP6bTgKlra8MiZTUbOzaip
	oXCVb5owhNMA/pgQjlw+AurFUAciB+P+6UF4d6h9fxYtel4F5f+/RMeqtHsY6COWhVvBboJYT/3
	yfs3m6JShW2+BhF16qGljVZF6/y1Dxhmhmd6SunH72fqImGo0P7xFu0peez4W5cy2/UhBVUig4y
	MjFFz6boytgcGppxN98RZfAfjLQ==
X-Received: by 2002:a05:6000:4b0a:b0:43b:a16b:ee69 with SMTP id
 ffacd0b85a97d-43d595cf8c2mr16086425f8f.24.1775931007845; Sat, 11 Apr 2026
 11:10:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411175134.771552-1-azpijr@gmail.com>
In-Reply-To: <20260411175134.771552-1-azpijr@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 11 Apr 2026 11:09:56 -0700
X-Gm-Features: AQROBzDujJvl5xUrRjTM_VNS1HlF3KROSrKOJXIZiSQeN29h2QIoJ69GUdo-T7o
Message-ID: <CAADnVQJOKc0zP4=-STEX0szgzUeS7RaxQTtre=P92R0UStug8A@mail.gmail.com>
Subject: Re: [RFC PATCH] bpf: cpumap: report queue_index to xdp_rxq_info
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277713-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linux.dev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rxq.dev:url,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86EA93E1396
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 11, 2026 at 10:51=E2=80=AFAM Jose A. Perez de Azpillaga
<azpijr@gmail.com> wrote:
>
> When a packet is redirected to a CPU map entry,
> cpu_map_bpf_prog_run_xdp() reconstructs a minimal xdp_rxq_info from
> xdp_frame fields (dev_rx and mem_type) before re-running the BPF program
> on the target CPU. However, queue_index was never preserved across the
> CPU boundary, so BPF programs running in cpumap context always observe
> ctx->rx_queue_index =3D=3D 0, regardless of which hardware queue original=
ly
> received the packet.
>
> Fix this by storing the originating queue_index in struct xdp_frame,
> following the same pattern already established for dev_rx and mem_type.
> The field is populated from rxq->queue_index in
> xdp_convert_buff_to_frame() during NAPI context, when the rxq_info is
> still valid, and restored into the reconstructed rxq_info in
> cpu_map_bpf_prog_run_xdp().
>
> Also use xdpf->queue_index in __xdp_build_skb_from_frame() to call
> skb_record_rx_queue(), which was previously listed as missing
> information in that function's comment.
>
> Also propagate queue_index in dpaa_a050385_wa_xdpf(), which manually
> constructs a new xdp_frame from an uninitialized page. Without this,
> queue_index would contain stale data from the page allocator.
>
> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> ---
> Note: this patch was only compiled, not tested.
>
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 1 +
>  include/net/xdp.h                              | 4 +++-
>  kernel/bpf/cpumap.c                            | 2 +-
>  net/core/xdp.c                                 | 2 +-
>  4 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net=
/ethernet/freescale/dpaa/dpaa_eth.c
> index 3edc8d142dd5..00e36b0ac74d 100644
> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> @@ -2281,6 +2281,7 @@ static int dpaa_a050385_wa_xdpf(struct dpaa_priv *p=
riv,
>         new_xdpf->headroom =3D priv->tx_headroom;
>         new_xdpf->frame_sz =3D DPAA_BP_RAW_SIZE;
>         new_xdpf->mem_type =3D MEM_TYPE_PAGE_ORDER0;
> +       new_xdpf->queue_index =3D xdpf->queue_index;
>
>         /* Release the initial buffer */
>         xdp_return_frame_rx_napi(xdpf);
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index aa742f413c35..6db10e6a8864 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -297,10 +297,11 @@ struct xdp_frame {
>         u32 headroom;
>         u32 metasize; /* uses lower 8-bits */
>         /* Lifetime of xdp_rxq_info is limited to NAPI/enqueue time,
> -        * while mem_type is valid on remote CPU.
> +        * while mem_type and queue_index are valid on remote CPU.
>          */
>         enum xdp_mem_type mem_type:32;
>         struct net_device *dev_rx; /* used by cpumap */
> +       u32 queue_index; /* used by cpumap */
>         u32 frame_sz;
>         u32 flags; /* supported values defined in xdp_buff_flags */
>  };
> @@ -441,6 +442,7 @@ struct xdp_frame *xdp_convert_buff_to_frame(struct xd=
p_buff *xdp)
>
>         /* rxq only valid until napi_schedule ends, convert to xdp_mem_ty=
pe */
>         xdp_frame->mem_type =3D xdp->rxq->mem.type;
> +       xdp_frame->queue_index =3D xdp->rxq->queue_index;
>
>         return xdp_frame;
>  }
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 5e59ab896f05..448da572de9a 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -197,7 +197,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_ma=
p_entry *rcpu,
>
>                 rxq.dev =3D xdpf->dev_rx;
>                 rxq.mem.type =3D xdpf->mem_type;
> -               /* TODO: report queue_index to xdp_rxq_info */
> +               rxq.queue_index =3D xdpf->queue_index;

This is like 5th time people attempt to address this TODO.

Just remove that comment. Don't send broken patches.

pw-bot: cr


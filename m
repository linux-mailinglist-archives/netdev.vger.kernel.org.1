Return-Path: <netdev+bounces-285343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGFTEQia/Gk6RwAAu9opvQ
	(envelope-from <netdev+bounces-285343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:56:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAAB4E9B0B
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F35C13012C87
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 13:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37AA3FB074;
	Thu,  7 May 2026 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVYCFLir"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6964F280037
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778162018; cv=pass; b=ExVUWZCB8D4eoO2h3nQcSePNVkAV7GdLaUP1LJdOaN71w9YPqgsz9mXH3rGEdDfUORfSV2z+2Kldj1GyIAdWI+hyMPWxJHvbLagHxTxFQX+VH05QEsT+EzaEB4QqxQimmi14wI8N9C9Q4N536IS1Y7xvJ7Q+tUdjULuRIvr429A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778162018; c=relaxed/simple;
	bh=QUOVF58orNIzbap3jmAonthzrZhQjZnQOV9FX2z8+Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmAOwvT3MFRv8PBaQ6sEpDLQ6qrW+TjaDU7EolRTAQOpZXmrBnvIQgZso1VQw2Rx+0SqflxAhd0mxSDt5GFJI+jsILkNYqYu8LIP1ZXIOqEVWbq5EpkLzkF7PNvP+X4OhAr8a3B2/TgfmaPTlhkQA+95PXeNzdlDnJfSyxBLKPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVYCFLir; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7bd5c582c6cso8899707b3.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 06:53:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778162015; cv=none;
        d=google.com; s=arc-20240605;
        b=GIhsRRRotPptJxi38QWd3R6E5lGxg+xlDWAa6EBOHZRjXt2HfXkOwv3TQBS0Se3Q0i
         xlLtFbguR84GBj3S4daCK3jCV+QF7+fInOMhNAKss7Z14r0QJfDCPtdbinj/POH8PV5p
         /OOpbaneBpw+0wzGzeOS2KWkHpYItGZwsdzgjtwZg+Z9XSH956OC+AfTf1gmGcpa8rc+
         F8EQts+kjSxxFIKETl7UAKfs2DxZZJL0rw5t6V4kPS4LxrDpm+1FfgcZXFRyleY+xTS7
         9+X8Nc6OnYkX94roOmTXuNybasRLVVuRrxs/RgjR+RFZAnCiwFLR0/Tg0SJt1xBhbyqg
         FSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2UqAGYVwxx8g720PgR4EoCQGsE47vpJLPP3a4vKzw1s=;
        fh=ITAQvOnW9SRpB90ic92UhaiJSumPVH6rKWbQQ01EdAo=;
        b=PCJBWIpqasIbUgP/5SZbz3g9TQMFAWkCyPMyQbILMobmUknUzffcKxVS9zPNZP6tf6
         i6wru+nn+ADNES9zLmJLnQD7qjhPKZq4xS6NJGUk+lpM7mzu4eVpktGODlohWp9MtLpy
         1rxMOVi27g7UWcEAlK3N9Yta1RUCkGWME9tI3rfky8h4akq0XDymnfGIhy1AO/RZeZYR
         ggv8y2G7V3p/HO2BSoFB9SJsochb4EZahOV1MVtNGRPjDa25GLlr2t339fisIrRKbPf5
         mrXR8A35avgQg8KYaDp9Yl8zX2nMNeY4ul7sQeo967o5VxAc/kaG7XvGlzp32gqo9IS6
         ZEdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778162015; x=1778766815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UqAGYVwxx8g720PgR4EoCQGsE47vpJLPP3a4vKzw1s=;
        b=hVYCFLirrJWCD5Y4RSvGek4T5FbDwBtYKD+y/633CN/uPI8rSCsDqy1faBsQ1JjRpV
         QXLmX7YZHie1caW4f9Q9wBtcdKO9B05KJb3g7jgxkhjf5JWv460U60rPOmElaHtq5l4C
         lhhzCgQIA8aratgYahmBUTHmZhBjzbvj7/dr0GATRGTRgHaU+h0DBOU0vgyb/Eov38mr
         YIkar3lw3pdPHTM7r9ubJc6B0JQdzIGTRCeh7FFltGCnRHniQkjBj8HgLsS+vPIoHIcA
         Rgd2OGljNlkjuq8M2oWVtBx1BHBtvceTwmmQle3WgZ83A/nhM/JWQUptrsvWROjjLFeb
         in4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778162015; x=1778766815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2UqAGYVwxx8g720PgR4EoCQGsE47vpJLPP3a4vKzw1s=;
        b=UafvWACB9zHSjGKNFnjO0tqv74l8tvWduDJauU4ynL+TNTWNWVcvfLnEW0NTmPnoy6
         hC0GrSQBxtI31u6daR8ko3XA6CGdxvn9YURpr+3YPIxyyYC33rK6KgYyCffGqE4bcMkS
         0+cItncXlCXKCgIgVLKCWuyQ+NmlcXa0knnx0N5NQ0bUijmxCbAeOKytVKcH8DnTB7rC
         ihWQXL81QbZqpiZlJxGOc+OX8VJHHVkzKZCvlnhgO8z8B1myxyqb+dvQmBeYrPJTVESI
         CMd88jsCnArWsKenSUq1Bbz+4Kanw3lefYeF54tg77s5ir0/uJhmGi6O8+D118HTdFsq
         Hbmg==
X-Forwarded-Encrypted: i=1; AFNElJ9Pe9eOvSC8P2ZAAKHSUZMIPODO0PWMMQK7A+SwL+16rZo5x7wcUo5anMYqkjVAPoejsAwTel8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6dnvQNOjWVhftyyge9AvpMIePrqOpBXa+nlXoWbWtb32Otlkx
	0TYV8ga2CaqRG9BzwZeMryTeWe+wSbSZ/0oZswSry8X0+HzYWCUtgysspB1s+IVYQePA74ZPHje
	vgX6XVTmMboP5qPgsm7Ndstno6PSKVpI=
X-Gm-Gg: Acq92OFxTIqOgV8RNGgIK3f7mBoeZDgyCegmKROKNa5EAD/T8P7lmuqs7kEcpvigTVg
	WsDXuYp/zUUcKxK5WNiqeHEiMBcBi0YHq8jyupj0HHUToKIcbUcvfCKKSjt5/V0S0ZsBitxSKbe
	9+2Y+mutoBNP5LAkEBBEHbQRvLHeWcnDK9wTWIA3ac1e+c/ehuxVCzwUOn6X8DuLRsWdQh2TSCr
	PR/m1wQg8LLmlkefB1ptTkkqDP42cFns7PusxJGoHcx0WP0ZOUX0kKWajoyoOSStue1OjaxxcDl
	qTqqHKnbCOsfyga5CAM=
X-Received: by 2002:a05:690c:6b01:b0:7bd:d4f4:261e with SMTP id
 00721157ae682-7bdf5e65d97mr83478287b3.31.1778162014408; Thu, 07 May 2026
 06:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507095330.318892-1-tariqt@nvidia.com> <20260507095330.318892-3-tariqt@nvidia.com>
In-Reply-To: <20260507095330.318892-3-tariqt@nvidia.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 7 May 2026 15:53:23 +0200
X-Gm-Features: AVHnY4Lb8J0kuDFjKRP6NISwMX2khi2ZT2JxvUh-epEwthNyT24xcZ-TVmlu8Os
Message-ID: <CAMB2axOFQN2f=veYgeJs+4tbZmb9PuNHk03TH_bmE8UL_REd7w@mail.gmail.com>
Subject: Re: [PATCH net-next V6 2/3] net/mlx5e: Avoid copying payload to the
 skb's linear part
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Christoph Paasch <cpaasch@openai.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AAAAB4E9B0B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285343-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[openai.com,google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,nvidia.com,vger.kernel.org,iogearbox.net,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,openai.com:email]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 10:54=E2=80=AFAM Tariq Toukan <tariqt@nvidia.com> wr=
ote:
>
> From: Christoph Paasch <cpaasch@openai.com>
>
> mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
> bytes from the page-pool to the skb's linear part. Those 256 bytes
> include part of the payload.
>
> When attempting to do GRO in skb_gro_receive, if headlen > data_offset
> (and skb->head_frag is not set), we end up aggregating packets in the
> frag_list.
>
> This is of course not good when we are CPU-limited. Also causes a worse
> skb->len/truesize ratio,...
>
> So, let's avoid copying parts of the payload to the linear part. We use
> eth_get_headlen() to parse the headers and compute the length of the
> protocol headers, which will be used to copy the relevant bits of the
> skb's linear part.
>
> We still allocate MLX5E_RX_MAX_HEAD for the skb so that if the networking
> stack needs to call pskb_may_pull() later on, we don't need to reallocate
> memory.
>
> This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC and
> LRO enabled):
>
> BEFORE:
> =3D=3D=3D=3D=3D=3D=3D
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.01    32547.82
>
> (netserver pinned to adjacent core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    52531.67
>
> AFTER:
> =3D=3D=3D=3D=3D=3D
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    52896.06
>
> (netserver pinned to adjacent core receiving interrupts)
>  $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    85094.90
>
> Additional tests across a larger range of parameters w/ and w/o LRO, w/
> and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), different
> TCP read/write-sizes as well as UDP benchmarks, all have shown equal or
> better performance with this patch.
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/ne=
t/ethernet/mellanox/mlx5/core/en_rx.c
> index 75ccf40a7f17..301b33419207 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1976,6 +1976,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq =
*rq, struct mlx5e_mpw_info *w
>                                         ALIGN(headlen, sizeof(long)),
>                                         rq->buff.map_dir);
>
> +               headlen =3D eth_get_headlen(rq->netdev, head_addr, headle=
n);
> +
>                 frag_offset +=3D headlen;
>                 byte_cnt -=3D headlen;
>                 linear_hr =3D skb_headroom(skb);
> @@ -2012,9 +2014,13 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq=
 *rq, struct mlx5e_mpw_info *w
>
>         if (prog) {
>                 u8 nr_frags_free, old_nr_frags =3D sinfo->nr_frags;
> +               skb_frag_t *frag =3D &sinfo->frags[0];
>                 u8 new_nr_frags;
>                 u32 len;
>
> +               headlen =3D eth_get_headlen(rq->netdev, skb_frag_address(=
frag),
> +                                         skb_frag_size(frag));
> +
>                 if (mlx5e_xdp_handle(rq, prog, mxbuf)) {

Hello,

Am I understanding correctly that the better performance comes with
the assumption that the XDP does not change headers?

headlen is determined before the XDP program runs. If it push/pop
headers, there could be headers in frags or data in the linear region
after __pskb_pull_tail().

>                         if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, =
rq->flags)) {
>                                 struct mlx5e_frag_page *pfp;
> @@ -2060,8 +2066,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq =
*rq, struct mlx5e_mpw_info *w
>                                 pagep->frags++;
>                         while (++pagep < frag_page);
>
> -                       headlen =3D min_t(u16, MLX5E_RX_MAX_HEAD - len,
> -                                       skb->data_len);
> +                       headlen =3D min_t(u16, headlen - len, skb->data_l=
en);

headlen - len can underflow but will be capped by skb->data_len, so
this should be okay, right?

>                         __pskb_pull_tail(skb, headlen);
>                 }
>         } else {
> --
> 2.44.0
>


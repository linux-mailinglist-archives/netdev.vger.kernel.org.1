Return-Path: <netdev+bounces-259634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEPzLNCzl2lq6gIAu9opvQ
	(envelope-from <netdev+bounces-259634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 02:07:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 572D0164133
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 02:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17203300BDB5
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 01:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FBB18E02A;
	Fri, 20 Feb 2026 01:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7Y1Ryfc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01992AD3D
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 01:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771549638; cv=pass; b=uXjuB70er/H0VCUwRe1OmUi8z1H1rXN7jqUed2Ll/uzor99icJ41Tyi1LppTjIXIucKXGQnfg9RdvDu5SyRtHZiD1+998iC0DRYGjjzuGKgXuy4HBbRcxs/mNQAIpa6UF/D053zrIBmABfPdEupKsTfRYtl7AKMnBEcJWU+ZITQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771549638; c=relaxed/simple;
	bh=4Du0OQoVDfLifz3GYSC+YkUNdNJ2Et5vb/FwjYsvS+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nqY3p//krQ837FW02zqGBJ2fTKuFKVOSrXm7bpo+2u7OLalzD5qTm8Bhs8AE01VkX3Y9AFrhbQbDdjApwr10gTGr+HOwzCcPuZ61RJZIuWmNr3HwU+abbKDt8XEemv4X4XOMIEaOn1FkFtA0Yaj7sCrC+QxHXFisVmEZ5y3sbac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7Y1Ryfc; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59de0b7c28aso1879056e87.1
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 17:07:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771549634; cv=none;
        d=google.com; s=arc-20240605;
        b=e3KfGO1diF/T7AiTrKj+1Xbci+Knc5PRigCRwa1fduSSNk87PdC/MeGtVUc86mITac
         HC+goQm/3GyBGe1o8r/1i/vmLBGOabGiVFGCC87cCgCkbsVDDFyNVa6DHg+E7dPvaf69
         1I2j62IMr+74CIb5F6tjXJjlRNnOj97h0A6PlisL46Va/DN+eZBEwSYYSA0OkHm8SvgU
         gaKXKlkPC4e8CINDytB7KcyJbEQzDePdlz5frzEeMI6rg1KIaOrEA1mcqVZO4OMmzynk
         41d2fSMVU6kD8HDrpGBqbQtbSN+a1cR/1E9EOzSxcrtx8oOR0xE4sXC3FguonIKR2SoS
         XC9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZmIxyr54D/I58TGB2aA1a9CohmKJ72f48z84M3gqW7U=;
        fh=KNmxO7YaiNkefmsJt/F3GPDtxlqat5ve1E4cG6pLvJE=;
        b=M3s+fhQGFov4MiCywtr3v7c18pwpk/oiVtYT5gO2oZ1+rfYQWAq4I9oWbmRtkcxy2e
         FQlGoddPwHIr5+iwGBf2ZmMRKcdMjejIzees4jRCx2VIY+6hV1mcNlGpcFAb57p4GDQG
         HNJI6ksSHzyYhTrSQX/5aJkkQ5xBSo6mT08lb3yObwr7ZNjo80+JKRxGLnyAccc+Kvmb
         K/NIsSpt1XvfkeaNZVWt+IqV4fenhFaCDsBZds+jijkWFzPzk/l5xaX7PYXxYlrxerGJ
         KX1/NmOUAQEceeDPJw7a4GGfjhKW7EoHibx7LKElrfBMB1DofjzXC95/mA/VRJ+96Y/X
         hPug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771549634; x=1772154434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmIxyr54D/I58TGB2aA1a9CohmKJ72f48z84M3gqW7U=;
        b=X7Y1RyfcJ62vtQeELeBpgIsqIwySUL3qfTkhS6exJ8wW/Tx5Bw6aWPvFRVq0FnHJeQ
         oy5zlKhBqqIU/VFinM6b00Z1+3r4bYLRjM2UcyK5wwhY8BsJi+0q2T/m+9rchldlgd3u
         jjyOZHrursfa+h7/GoeiBuFmGY3KSqQTael0bByPDHARXiRKEmEZqLZHSiZT5ylPGxS2
         YAxYsPSlPli03X1L1dbLmjNM87EfSdS5oBhErJRGRtkYvE7dCfsj6jXYX04xIIMAb09d
         /Icrhq2+lOYdO7kKHlcCeCeYj4Y3Rcu5VwhR8Jt4VdmHrk8UsOFzbn3zMTnmmOO/nzS2
         qlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771549634; x=1772154434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZmIxyr54D/I58TGB2aA1a9CohmKJ72f48z84M3gqW7U=;
        b=H+gTgq7OcxMKbikzgdpqsUrWBbqxLbiVsZY+xj4Nv9l9KEXAmkcv/IYf4uDVDm8hNK
         DsWIvr1fI9O3TEkbnWcZzdc+7N9rKsQ1amFvZaBEXDVeySb+fdmVszNfoIch+dt61TAL
         7geS9Z3ldOiqKQdIqa0Z0X6HBk9Lbe3OdT0IpFSq/JB6rNR0miLwUQNlpd8UVQvRL6Vq
         MYgn4zsA6CgjTcnLfG3rit10oSlp+uQ3F9BHaKHaF1oqkjLa/qGR+sSgOzkk+PLyCZGv
         ooguZu1LfpClmuWtziRWtrRb1PPJb+KFyvB39p00Pu5ngTCgOpSx4nm/Y2SdiitNMrkT
         VFcg==
X-Forwarded-Encrypted: i=1; AJvYcCVLqGHTAIA9+14TzAwQmpxEb+yS03xrGy1/wQ5azgAHvBj2vvNw0Y0QhUF+TylfCHuKgMGx8Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGTiPWPdtJJjAH+HbKeqZW1D4MEUpIfHQeLka28TOQozWj+99u
	sII/EqZ5CD8meUSdUmgrq1xzLJhoGgh3hPyyuO8u2IAOnaLmJRNJJYksNE9IsjWthnAw/uh2BbZ
	mIupPa+OQ4cMBHWfIvvDQCxgX9lArYB0=
X-Gm-Gg: AZuq6aKd+l8sQp34cwWCATJhMIALEywFQCwKryrF1iCsOr8td548WJl7Cs+c1yEB39R
	4cmvheIB/QA6Tl2MGKWLUr6neeSbOAE1iaMuBHDcRRFrGrumHU9HRAx31zx2Gb3jQcT8s7CGvun
	rST/CZljdgGCDXPrFCAWGUBKaYTJS6l+fsto94DC5Kz6Bhah9kqj0jOllszu5eFuK1pG1wJZrrm
	qRPWaKcukhEDAi9Ckj7KKLxj6+mvAp726vlzKjxq65p9FJYLuXx5JUU3dW9ksdAm7li7UEdgBzd
	u3tPan8=
X-Received: by 2002:a05:6512:3087:b0:59d:e9df:6dcd with SMTP id
 2adb3069b0e04-59f83b9da63mr2099271e87.15.1771549633590; Thu, 19 Feb 2026
 17:07:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218150000.301176-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260218150000.301176-1-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 20 Feb 2026 09:06:36 +0800
X-Gm-Features: AaiRm52_xb6kFQorOBbTSas6w9BZ_ZFswXRYRYP9SzorGa659iuDtN-NAWW3y58
Message-ID: <CAL+tcoCYMzNtAqgrdOHVNPBO4H5mCtvwhYj5kGdhJ5CCRgRd5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] xsk: avoid double checking against rx queue
 being full
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259634-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,intel.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 572D0164133
X-Rspamd-Action: no action

Hi Maciej,

On Wed, Feb 18, 2026 at 11:03=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Currently non-zc xsk rx path for multi-buffer case checks twice if xsk
> rx queue has enough space for producing descriptors:
> 1.
>         if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
>                 xs->rx_queue_full++;
>                 return -ENOBUFS;
>         }
> 2.
>         __xsk_rcv_zc(xs, xskb, copied - meta_len, rem ? XDP_PKT_CONTD : 0=
);
>         -> err =3D xskq_prod_reserve_desc(xs->rx, addr, len, flags);
>           -> if (xskq_prod_is_full(q))
>
> Second part is redundant as in 1. we already peeked onto rx queue and
> checked that there is enough space to produce given amount of
> descriptors.
>
> Provide helper functions that will skip it and therefore optimize code.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

> ---
>  net/xdp/xsk.c       | 14 +++++++++++++-
>  net/xdp/xsk_queue.h | 16 +++++++++++-----
>  2 files changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f093c3453f64..aaadc13649e1 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -160,6 +160,17 @@ static int __xsk_rcv_zc(struct xdp_sock *xs, struct =
xdp_buff_xsk *xskb, u32 len,
>         return 0;
>  }
>
> +static void __xsk_rcv_zc_safe(struct xdp_sock *xs, struct xdp_buff_xsk *=
xskb,
> +                             u32 len, u32 flags)

This helper is used only here, so I wonder what the need of it is?

Thanks,
Jason


> +{
> +       u64 addr;
> +
> +       addr =3D xp_get_handle(xskb, xskb->pool);
> +       __xskq_prod_reserve_desc(xs->rx, addr, len, flags);
> +
> +       xp_release(xskb);
> +}
> +
>  static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len=
)
>  {
>         struct xdp_buff_xsk *xskb =3D container_of(xdp, struct xdp_buff_x=
sk, xdp);
> @@ -292,7 +303,8 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_=
buff *xdp, u32 len)
>                 rem -=3D copied;
>
>                 xskb =3D container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
> -               __xsk_rcv_zc(xs, xskb, copied - meta_len, rem ? XDP_PKT_C=
ONTD : 0);
> +               __xsk_rcv_zc_safe(xs, xskb, copied - meta_len,
> +                                 rem ? XDP_PKT_CONTD : 0);
>                 meta_len =3D 0;
>         } while (rem);
>
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 1eb8d9f8b104..4f764b5748d2 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -440,20 +440,26 @@ static inline void xskq_prod_write_addr_batch(struc=
t xsk_queue *q, struct xdp_de
>         q->cached_prod =3D cached_prod;
>  }
>
> -static inline int xskq_prod_reserve_desc(struct xsk_queue *q,
> -                                        u64 addr, u32 len, u32 flags)
> +static inline void __xskq_prod_reserve_desc(struct xsk_queue *q,
> +                                           u64 addr, u32 len, u32 flags)
>  {
>         struct xdp_rxtx_ring *ring =3D (struct xdp_rxtx_ring *)q->ring;
>         u32 idx;
>
> -       if (xskq_prod_is_full(q))
> -               return -ENOBUFS;
> -
>         /* A, matches D */
>         idx =3D q->cached_prod++ & q->ring_mask;
>         ring->desc[idx].addr =3D addr;
>         ring->desc[idx].len =3D len;
>         ring->desc[idx].options =3D flags;
> +}
> +
> +static inline int xskq_prod_reserve_desc(struct xsk_queue *q,
> +                                        u64 addr, u32 len, u32 flags)
> +{
> +       if (xskq_prod_is_full(q))
> +               return -ENOBUFS;
> +
> +       __xskq_prod_reserve_desc(q, addr, len, flags);
>
>         return 0;
>  }
> --
> 2.43.0
>
>


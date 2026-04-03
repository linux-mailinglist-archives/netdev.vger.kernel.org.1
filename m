Return-Path: <netdev+bounces-274853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGYMHRIpz2mmtQYAu9opvQ
	(envelope-from <netdev+bounces-274853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 04:42:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7542D3906D6
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 04:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63B4F301C8EF
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 02:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8375D33D511;
	Fri,  3 Apr 2026 02:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fZk/q8nD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289C52C325C
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 02:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775184139; cv=pass; b=QMrSYdJlWri615gRk97T4YbC9H6tYUYdCUjVSzdezq4m7FXmESS9ee/YDdG676odnQ7ujM2lQARgqCsnaAkiUYT41TEFYlgtI7Ha5AivzCpzYQ0QpMnY+2H2IkEE5kj2VRAAiMzdsadSkAfnclNW9LoTyvxo9VTwImZjS694zYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775184139; c=relaxed/simple;
	bh=UeachB2j6pLo6eNgKCGjFpmNusN3p1LFsDmWL7xU2MA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/FMykWO1wzbRTsKFrPXlAjCbnVbwOT+LVZn4FwVU58+2DpFKJ0fThYfSz85SzII0S0HYtkZ/rPJSa1T8igb+fPw02kqvmdqrKzneZKKBX6Gj6uimjJlAKY7iAGIrrTJ/OAIlIaWcLyQoreRm3AeDRoKJysNJPoungSdsZlvrHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fZk/q8nD; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79c20063a32so16102907b3.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 19:42:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775184137; cv=none;
        d=google.com; s=arc-20240605;
        b=U1xj3iwwGMTS+Y6QsheZ8WeRXWj0aPnG3x43SF4zpr1DOtSOzLYEOkocOLKDKt2Jtq
         t9wfY8epwa5fHcdDxpbaw/ceVBjLUfMJHeyoTWrOdfdmgQJXFI0CI0tdR4tYAAY0LtR5
         xP00bWVSwc9eE228jTNXSCNHdw3KvCITGWjAvZL5ucTwwi9dr3xbZ9ioXXNV9lwaMcZu
         dzYtuWU3BF+5yzg3xgaWXFDbnMEtd98/IbMhVAdTt+5uu4qbzoGZcI0kAl2Fcfcd6uM/
         kdblBZXKwP450ut322wZEmGpuvnrBVHIoe+1Z7RZuN7GtdorYexg8BvahWj8Aimb/cYF
         bPWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F7ypjviA7o91EG0ytVKFGPlLqM44PLzS4cGJrxrdO2k=;
        fh=C+Z57gxiWTsU5/i6ra8N3IJPAbxIm3tCjsDz34hH+Ug=;
        b=ZUjzOaaOeWep/F0DVY7piFRovtUIdIC/aZX4O/q4xJ1gMwypIVpIkbZgdzRuvxfnpZ
         btXv52VRKMSGloWgzsh0GpizZNQeAp26LQdr+K6XrBh5dF/ImbIcXCwLtqe06F3fc0XU
         +y7Q0LJGS40Hwx7u6XV7+Nz25MPSPyZu52j+ZRGJOIAtwrNvNoBrU3Xbn63dR4Q/Kkub
         j1q2NwQQ0w5seCpZgelRmsN8y6TPRxl+7dVykQs2PCnItg++2m91fi06w6TMxZ8AULvT
         i3AbT9mPK6aFgYievwGMt80J6mug5sevkgEfE415a+zaZLuxfVKOZyce+uGkJDfTnlgl
         XNkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775184137; x=1775788937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7ypjviA7o91EG0ytVKFGPlLqM44PLzS4cGJrxrdO2k=;
        b=fZk/q8nDnuCE9IxGmEzBEWERRvmycABMVnuF/MsLxm+eP5g/o8VUXC522tRXPtbA4F
         VYKQJdG35/mBaINcdIKuq1CtVaSNMfvXfsjfPXXx+6yPbpnOF4zpip44BgS79ihBCX/M
         R46fQdSSBGBQKvajrr6Z2NctB4kUBifkDBftlNy5jMqkHsl/OA9MqAuDxSf7BALriehI
         t7LxhgUgYFF8DiiQNtTRsmmqgjAxFqbtTW344qGpHHBK6jZa2FMLzDxHm6P262S4pVbj
         YQ1r3vqgwkDyrBvhHjTt42Ow0G4LdaeZDMJWI1It5xTyD/8vdiR8+SWSmyQevAGCU7gM
         sVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775184137; x=1775788937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F7ypjviA7o91EG0ytVKFGPlLqM44PLzS4cGJrxrdO2k=;
        b=YaDPthfCeombT/YYQtqyc6GnIRkgUfUSCabnkLurGJQ2rKb18jIfkwmDY7l475mOhs
         l/yVIFsrN20WZ1DQeFVbcdU9d6LReMFKfdMcIz7nfWN8SmSJ9ehCcu3dNMGDwU/3kwjj
         Fadi1yWCQB75Bbi1L112/uUTLFlHuVb2pBtc/v04OCWsLMU/18+vf5YCFk/QFIFdco+X
         p58dw5DAepZOPMe3rXbIHTWOp8wlMZv153kC1q3Ojucks6ZPJl+Bf3psYM6blOqAkDeM
         fD/lfkdI8GmhnZvH/XYK3DyG3bSP5uUS1tHfDFNUpV48D0sVLKvRBCjIt8BczDllVgOf
         7+yA==
X-Gm-Message-State: AOJu0Yxc4vJVA7w757mgadfRN/j+PG8gVl58N+Ii31Q/o+jXejXH0Uwz
	+Vo79/BdrlyUuU6+qzPnIBugE+c2kbzoEW8ZDk5fYdbzyN+LmAz0zdw1swiIEZ0JfigX/RUk5zO
	fv6o0buaxeu5Lvk429ulpK/AhsKs3C2Dy0BSrzXhJ
X-Gm-Gg: AeBDieuxxfsFdQr84ta+1QC+ZoeSLSzci7gkTvABfVN87La1GSrNebRc6t9OVA8IkLb
	PBxX1Ek8JKi+0Tggi67T5GuPB/yfpzQZaPnUIJc7mZLfs2gN9jHIXeXTk1+Y94CC7OgqIT59Dof
	gp4muDz7+/Bz8CNifb3rcU9PlzekMEH+xmMxc3n6mhVreGneVAkH5UhHQQMeIKrgE9Cys9UB9Fd
	epfJjdupiuirr7zhbTs/oxhW4duw64tg7H6+YdxiRNd4r+qTNUC6k+G+agrCL5sKFTu7SBGJiWZ
	RjNVoHzd0qTYFqC+0Q==
X-Received: by 2002:a05:690c:660e:b0:79c:3750:48b0 with SMTP id
 00721157ae682-7a3be949d69mr39250727b3.31.1775184136801; Thu, 02 Apr 2026
 19:42:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403003524.2564973-1-joe@dama.to> <20260403003524.2564973-8-joe@dama.to>
In-Reply-To: <20260403003524.2564973-8-joe@dama.to>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 Apr 2026 19:42:05 -0700
X-Gm-Features: AQROBzA8v5E2r9v7HpvTI_gaJ2gr3fRBYlQoCqSukj-YJVqDlE1gS-cS-PG03QU
Message-ID: <CANn89iLH92YCwciSirzGY2wyQg-zK7AKEMfDf-166utkBS4HNQ@mail.gmail.com>
Subject: Re: [net-next v8 07/10] net: bnxt: Implement software USO
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	horms@kernel.org, linux-kernel@vger.kernel.org, leon@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274853-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7542D3906D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 5:36=E2=80=AFPM Joe Damato <joe@dama.to> wrote:
>
> Implement bnxt_sw_udp_gso_xmit() using the core tso_dma_map API and
> the pre-allocated TX inline buffer for per-segment headers.
>
> The xmit path:
> 1. Calls tso_start() to initialize TSO state
> 2. Stack-allocates a tso_dma_map and calls tso_dma_map_init() to
>    DMA-map the linear payload and all frags upfront.
> 3. For each segment:
>    - Copies and patches headers via tso_build_hdr() into the
>      pre-allocated tx_inline_buf (DMA-synced per segment)
>    - Counts payload BDs via tso_dma_map_count()
>    - Emits long BD (header) + ext BD + payload BDs
>    - Payload BDs use tso_dma_map_next() which yields (dma_addr,
>      chunk_len, mapping_len) tuples.
>
> Header BDs set dma_unmap_len=3D0 since the inline buffer is pre-allocated
> and unmapped only at ring teardown.
>
> Completion state is updated by calling tso_dma_map_completion_save() for
> the last segment.
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Joe Damato <joe@dama.to>
> ---
>


> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.h
> index 6b38b84924e0..fe50576ae525 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -11,6 +11,8 @@
>  #ifndef BNXT_H
>  #define BNXT_H
>
> +#include <net/tso.h>
> +
>  #define DRV_MODULE_NAME                "bnxt_en"
>
>  /* DO NOT CHANGE DRV_VER_* defines
> @@ -899,6 +901,7 @@ struct bnxt_sw_tx_bd {
>                 u16                     rx_prod;
>                 u16                     txts_prod;
>         };
> +       struct tso_dma_map_completion_state sw_gso_cstate;
>  };
>
>  #define BNXT_SW_GSO_MID                1
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_gso.c
> index b296769ee4fe..7a7d40e36cea 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> @@ -19,11 +19,213 @@
>  #include "bnxt.h"
>  #include "bnxt_gso.h"
>
> +static u32 bnxt_sw_gso_lhint(unsigned int len)
> +{
> +       if (len <=3D 512)
> +               return TX_BD_FLAGS_LHINT_512_AND_SMALLER;
> +       else if (len <=3D 1023)
> +               return TX_BD_FLAGS_LHINT_512_TO_1023;
> +       else if (len <=3D 2047)
> +               return TX_BD_FLAGS_LHINT_1024_TO_2047;
> +       else
> +               return TX_BD_FLAGS_LHINT_2048_AND_LARGER;
> +}
> +
>  netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
>                                  struct bnxt_tx_ring_info *txr,
>                                  struct netdev_queue *txq,
>                                  struct sk_buff *skb)
>  {
> +       unsigned int last_unmap_len __maybe_unused =3D 0;
> +       dma_addr_t last_unmap_addr __maybe_unused =3D 0;
> +       struct bnxt_sw_tx_bd *last_unmap_buf =3D NULL;
> +       unsigned int hdr_len, mss, num_segs;
> +       struct pci_dev *pdev =3D bp->pdev;
> +       unsigned int total_payload;
> +       struct tso_dma_map map;
> +       u32 vlan_tag_flags =3D 0;
> +       int i, bds_needed;
> +       struct tso_t tso;
> +       u16 cfa_action;
> +       u16 prod;
> +
> +       hdr_len =3D tso_start(skb, &tso);

Orthogonal to your patch:

It seems that tso_start() users do not really check if hdr_len could
be bigger than
their expectations ( TSO_HEADER_SIZE for many of them).

Presumably these drivers should have an ndo_features_check() to detect
this and fallback to GSO.

I can send a series to fix this.


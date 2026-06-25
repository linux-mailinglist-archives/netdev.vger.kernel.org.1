Return-Path: <netdev+bounces-302077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kmTDHM+yPWoL5wgAu9opvQ
	(envelope-from <netdev+bounces-302077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 00:59:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D48136C915A
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 00:59:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=lAOGMDN8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302077-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302077-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF6943033AF8
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 22:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5E026A08F;
	Thu, 25 Jun 2026 22:59:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B9620E023
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 22:59:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782428365; cv=pass; b=J0GeXLkP1+dDvJVnMlDg8Z8WovRqmOsBf6bM9729ihkNIf20PTKlB46FCegl1NiN2L0rVkwK0eDJIzVRS4ImZWW5y0H3Hfb7zYPgzaVzhUlwob0xHe9StitdFHW1is7faKKfd704zTVyC3BQSEcXOxj1iEILoKWDKQA6yS7nHWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782428365; c=relaxed/simple;
	bh=oYKlnirB3SN6iJnr9X9rSaE7esSFAc4YDY/wagy3y8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfpehJAYbjkubQbKN/Z4GJJXo005S2bzwc9yFy/tHKtfbUU/HAZxguOylGpBo2PFRkx+aGetdbErEC6q4kSjWXnu4ZojTvqm9wPDjIvK6k3U0YqCLDAbtQ/bNBZ5PBMOqf0fOrNS7eh0ZnfZx4BmE1cxf8dZBdUzJwgbt4cnQAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lAOGMDN8; arc=pass smtp.client-ip=209.85.214.173
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c6b7bd4e8dso22855ad.0
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 15:59:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782428363; cv=none;
        d=google.com; s=arc-20260327;
        b=egOattn+IRDhVGsYbDVjYUvzqdwVlFT5BPH0VxxSbhdR8z7h9gSDOhIwCutpuAdgRo
         L37KnD66kN4AiGnM9wLyK53zpspur2uY/mze6ppOFCmL7d1rubU1b3/bww7XuBPK0/wH
         icOX4X1wcTTNs6jMuuf/OnskWU/tvAh9ono5R+ZI7G1G4gT/aXrqYTBaQLXlvooeVFPy
         O7m23Pe3Mu+5KhesAqxwfzgjt2/1R2YDn/hUwG3sDmpmmfrSHnNeRytGwu/mBS8rC5VI
         xcJc0Ac4Vlg73YQSOTQCuUWm/wBW2ZzM1hMUGJaBeH8KTi6J5qcoOkKFn4mbPaqyeAuv
         ve8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/gX7hQHyvfb4Ci0nY3Fxsfc2Doou++pLUQ8Pual9WtQ=;
        fh=M3q6RMsTp+DCTUTIR9Mo7raai0gJUsOyeuXOgYZbw9M=;
        b=TXJpbEb0z8NnFa+hHGKo6sfJB4QqVeP5cEd8VizsjIdnQ1rgh9y9eomG3weMmKNqMi
         NDRSpa/2uJ91F2X6ocvvbbcRouxMOksQSkapi2GUl4LeYK/PtPjUubqaoI78SbwjD+K9
         MRB4ir0RCeWyGUSRQSn63Cnz8UF3wbmdE8SMdZTBg8s/szqxP6H+R18ynTrvFDTQCh4o
         W3zvG1NSCOmgcpQ6y0AKbDbRuGFrdeBe+1upQGoNCRl/QQSg2kulQXfaYdNnmAXcNv8i
         1xfkeldzvLcrPtXQfo8YrXKF0P+flcjNmpjXU9YqqewGDsdlPuY86NQLN86CnCIPzANi
         Cipw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782428363; x=1783033163; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/gX7hQHyvfb4Ci0nY3Fxsfc2Doou++pLUQ8Pual9WtQ=;
        b=lAOGMDN8ynA5eQbM/WGC+EL201uY/Lb4gU2KWo1zLJE9CbJnR1eY/BnMg3SK2/0+Z9
         Rj6ZQfNpYaq3RAKzLU2gt2C9AscYYvkMZZ5X1C21/oo+jvHR4v7bxmUXifgpifSVPrZK
         ALWQiCgGy2uGwT02OSE/vPJtjhWvno7/OLHh/mywcPeH3QdDivVJLCz5jzd+eARI/ncM
         MWv2gVmbJNh752QrXSgR+R8LDqoXhrbkqaI3hW4ru6AbsAzTPQ21S7pRAa1gx9oJFAkP
         kY7UIyHEeJKL6dM4ghxlILO4evpzCM0Ixy2gQGHipM5/1oQNy6so6wHheXVev9FFXM0y
         s3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782428363; x=1783033163;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/gX7hQHyvfb4Ci0nY3Fxsfc2Doou++pLUQ8Pual9WtQ=;
        b=d/ALqnkyr9WcmYrXdOoas+SyiZPZ7qjFTBrBbaGqlEbQzkTbwp3G1dKHeHrgNq/com
         GGbq27+7MOe7Xlmg0aOK3WPKKBXkw7VcX1y8OlXi6VvKmLUOesf/jx8Bni6Cek51yJM/
         FMsJv+mK6GQ50FDINn4HsNLcvlkF0bhVL3ciVwDGI6PYdWDRDnq6Tkw6+rBtosdnZucH
         bYyc/3aiCqo2PDgbOER5QRSK26oUG7mPX7eZRTmvGGdUW6J0f8dtJUiDaozdrwxYq4O7
         O2AgfEW+mbtj05q/oHzxWBZ3AECIlPpSKqVovgaFyV7vMTQNc2txhFYmOv2+3UBTkGCj
         bKyA==
X-Forwarded-Encrypted: i=1; AHgh+Rr2Ndtx86c2jIi8ZicjGHuCCa5wGixAV9S910Y7gsRG/KTGanmauOzywLUdTYin78dIbJ2DSQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNQ7cMdtLl0nyWc8kmaYX0mOGcW+H4Ty6+paalDjLSNGDd+TBx
	r8koRfXE5yFcCTAg4UZou3AFokGPcakMEV8/jJJdx0MjtxzXBJkjEwUYDL1XD01/qg5G6c3DMNc
	9lSaTi4lsLVvlk1QXqj/j65f5hZogkaK5h+jJS1el
X-Gm-Gg: AfdE7cnOv9O21SPtfms3YwWeEY+NhObfhBbFCOx7HU1lcBFPv+JZcketCtZmb2+3sGe
	wOXjt0mdX2U5uQKydlbiiFi3f9g9VdS7Rdb/Dg6uTcE6v00iMTN5VXM/xFSOcJg8k6atS7iH58g
	oNfcvkvAMLw0oLieR+QftXF/uybUtsAdXrE3RtyPJMiAdJX4Igb13nAELRpJl+bhiiUiUofw0gW
	djVl72Q5AD066Xy/82oWQRmbwD6s9GecjNhLKLZJ9mGJ9wiEBHA2Cie9Uj2teAUwuE+ftcnKOhZ
	+cI05C4NJ2jLND/9zD97ue3my2MRZdV4SHnunoUp9+9rkOCfdmr+9ahaUkHZ7WstQVjaQgo=
X-Received: by 2002:a17:902:fc4d:b0:2bf:193b:a195 with SMTP id
 d9443c01a7336-2c813e4f6c6mr855945ad.11.1782428362363; Thu, 25 Jun 2026
 15:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625-airoha-eth-skb_frag_dma_map-v1-1-31d9e460aae6@kernel.org>
In-Reply-To: <20260625-airoha-eth-skb_frag_dma_map-v1-1-31d9e460aae6@kernel.org>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Thu, 25 Jun 2026 15:59:10 -0700
X-Gm-Features: AVVi8CeiefQknrcxxwnBcBr19FhEdmLlZYqiKgArFjpWRrvJ_M8y2FZe1GT04Ic
Message-ID: <CAEAWyHfyWrSdKziDg3SOnx3QRfd6uu6YXtJV85OgqWEQSJykmQ@mail.gmail.com>
Subject: Re: [PATCH net] net: airoha: dma map xmit frags with skb_frag_dma_map()
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-302077-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D48136C915A

On Thu, Jun 25, 2026 at 2:43=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
>
> Map xmit skb fragments using skb_frag_dma_map() instead of
> dma_map_single(skb_frag_address()). skb_frag_address() relies on
> page_address() to obtain a kernel virtual address, which is not
> guaranteed to work for all page types (e.g. highmem pages or
> user-pinned pages from MSG_ZEROCOPY).
> skb_frag_dma_map() maps the fragment directly via its struct page and
> offset through dma_map_page(), avoiding the need for a kernel virtual
> address entirely.
> Introduce an enum airoha_dma_map_type to track how each queue entry was
> mapped (single vs page), so that the matching unmap function is called
> on completion and in error paths.
>
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 =
SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>

> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 61 ++++++++++++++++++++------=
------
>  drivers/net/ethernet/airoha/airoha_eth.h |  7 ++++
>  2 files changed, 45 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 932b3a3df2e5..1caf6766f2c0 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -944,6 +944,25 @@ static void airoha_qdma_wake_netdev_txqs(struct airo=
ha_queue *q)
>         q->txq_stopped =3D false;
>  }
>
> +static void airoha_unmap_xmit_buf(struct airoha_eth *eth,
> +                                 struct airoha_queue_entry *e)
> +{
> +       switch (e->dma_type) {
> +       case AIROHA_DMA_MAP_PAGE:
> +               dma_unmap_page(eth->dev, e->dma_addr, e->dma_len,
> +                              DMA_TO_DEVICE);
> +               break;
> +       case AIROHA_DMA_MAP_SINGLE:
> +               dma_unmap_single(eth->dev, e->dma_addr, e->dma_len,
> +                                DMA_TO_DEVICE);
> +               break;
> +       case AIROHA_DMA_UNMAPPED:
> +       default:
> +               break;
> +       }
> +       e->dma_type =3D AIROHA_DMA_UNMAPPED;
> +}
> +
>  static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget=
)
>  {
>         struct airoha_tx_irq_queue *irq_q;
> @@ -1006,9 +1025,7 @@ static int airoha_qdma_tx_napi_poll(struct napi_str=
uct *napi, int budget)
>                 skb =3D e->skb;
>                 e->skb =3D NULL;
>
> -               dma_unmap_single(eth->dev, e->dma_addr, e->dma_len,
> -                                DMA_TO_DEVICE);
> -               e->dma_addr =3D 0;
> +               airoha_unmap_xmit_buf(eth, e);
>                 list_add_tail(&e->list, &q->tx_list);
>
>                 WRITE_ONCE(desc->msg0, 0);
> @@ -1177,12 +1194,10 @@ static void airoha_qdma_tx_cleanup(struct airoha_=
qdma *qdma)
>                         struct airoha_qdma_desc *desc =3D &q->desc[j];
>                         struct sk_buff *skb =3D e->skb;
>
> -                       if (!e->dma_addr)
> +                       if (e->dma_type =3D=3D AIROHA_DMA_UNMAPPED)
>                                 continue;
>
> -                       dma_unmap_single(qdma->eth->dev, e->dma_addr,
> -                                        e->dma_len, DMA_TO_DEVICE);
> -                       e->dma_addr =3D 0;
> +                       airoha_unmap_xmit_buf(qdma->eth, e);
>                         list_add_tail(&e->list, &q->tx_list);
>
>                         WRITE_ONCE(desc->ctrl, 0);
> @@ -2193,8 +2208,8 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *=
skb,
>         struct netdev_queue *txq;
>         struct airoha_queue *q;
>         LIST_HEAD(tx_list);
> +       dma_addr_t addr;
>         int i =3D 0, qid;
> -       void *data;
>         u16 index;
>         u8 fport;
>
> @@ -2250,24 +2265,22 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff=
 *skb,
>                 return NETDEV_TX_BUSY;
>         }
>
> -       len =3D skb_headlen(skb);
> -       data =3D skb->data;
> -
>         e =3D list_first_entry(&q->tx_list, struct airoha_queue_entry,
>                              list);
> +       len =3D skb_headlen(skb);
> +       addr =3D dma_map_single(netdev->dev.parent, skb->data, len,
> +                             DMA_TO_DEVICE);
> +       if (unlikely(dma_mapping_error(netdev->dev.parent, addr)))
> +               goto error_unlock;
> +
> +       e->dma_type =3D AIROHA_DMA_MAP_SINGLE;
>         index =3D e - q->entry;
>
>         while (true) {
>                 struct airoha_qdma_desc *desc =3D &q->desc[index];
>                 skb_frag_t *frag =3D &skb_shinfo(skb)->frags[i];
> -               dma_addr_t addr;
>                 u32 val;
>
> -               addr =3D dma_map_single(netdev->dev.parent, data, len,
> -                                     DMA_TO_DEVICE);
> -               if (unlikely(dma_mapping_error(netdev->dev.parent, addr))=
)
> -                       goto error_unmap;
> -
>                 list_move_tail(&e->list, &tx_list);
>                 e->skb =3D i =3D=3D nr_frags - 1 ? skb : NULL;
>                 e->dma_addr =3D addr;
> @@ -2291,8 +2304,13 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff =
*skb,
>                 if (++i =3D=3D nr_frags)
>                         break;
>
> -               data =3D skb_frag_address(frag);
>                 len =3D skb_frag_size(frag);
> +               addr =3D skb_frag_dma_map(netdev->dev.parent, frag, 0, le=
n,
> +                                       DMA_TO_DEVICE);
> +               if (unlikely(dma_mapping_error(netdev->dev.parent, addr))=
)
> +                       goto error_unmap;
> +
> +               e->dma_type =3D AIROHA_DMA_MAP_PAGE;
>         }
>         q->queued +=3D i;
>
> @@ -2313,11 +2331,8 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff =
*skb,
>         return NETDEV_TX_OK;
>
>  error_unmap:
> -       list_for_each_entry(e, &tx_list, list) {
> -               dma_unmap_single(netdev->dev.parent, e->dma_addr, e->dma_=
len,
> -                                DMA_TO_DEVICE);
> -               e->dma_addr =3D 0;
> -       }
> +       list_for_each_entry(e, &tx_list, list)
> +               airoha_unmap_xmit_buf(dev->eth, e);
>         list_splice(&tx_list, &q->tx_list);
>  error_unlock:
>         spin_unlock_bh(&q->lock);
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index d7ff8c5200e2..2765244d937c 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -170,12 +170,19 @@ enum trtcm_param {
>  #define TRTCM_TOKEN_RATE_MASK                  GENMASK(23, 6)
>  #define TRTCM_TOKEN_RATE_FRACTION_MASK         GENMASK(5, 0)
>
> +enum airoha_dma_map_type {
> +       AIROHA_DMA_UNMAPPED,
> +       AIROHA_DMA_MAP_SINGLE,
> +       AIROHA_DMA_MAP_PAGE,
> +};
> +
>  struct airoha_queue_entry {
>         union {
>                 void *buf;
>                 struct {
>                         struct list_head list;
>                         struct sk_buff *skb;
> +                       enum airoha_dma_map_type dma_type;
>                 };
>         };
>         dma_addr_t dma_addr;
>
> ---
> base-commit: 232c4ca2343d1181cbfc061f9856d9591e397579
> change-id: 20260625-airoha-eth-skb_frag_dma_map-bcccd5d6e4b1
>
> Best regards,
> --
> Lorenzo Bianconi <lorenzo@kernel.org>
>
>


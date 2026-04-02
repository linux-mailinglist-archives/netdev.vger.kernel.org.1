Return-Path: <netdev+bounces-274296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMU5G2y6zWnqgAYAu9opvQ
	(envelope-from <netdev+bounces-274296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 02:38:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A41382087
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 02:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0DEB301C580
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 00:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367E020F08C;
	Thu,  2 Apr 2026 00:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="urWDrqy1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D25B220698
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 00:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775090131; cv=pass; b=FEEMckjMzBUNJlXC7JnJjn2hJl0U+uq2ZuwC8b9DpciKASkkfUQh6BXOMRpxkDTuH9fjSkBbQRrjSaNMv9/LIEaT0U23ybwtqKsCdtQp2Ab9NQQj+pq5x3X/pGOfjrb0E4vbFthZLvqBZTaIq200HmS4IudhZNxm8Mldyl45888=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775090131; c=relaxed/simple;
	bh=znCwjHPvWBL0PWQ1QXV0IqDl5OVHXFKpPzJEjCEfdqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3Y2Tw1gaUIPLrKIaWB5GYNmn2PQa1bDqRavbmZxREDgPCILpQR1eP4M96xftrPyH01G08d4nqPLRcJv71DYmZr8cyRb4iEhEdoiJZYPn4yKlBCI4VlsWdSN+9pmgVXC56h3d2J0t/OxuXx4xNpcL/zLru+cWVT/B/4VWH5oUqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=urWDrqy1; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8a154cc6a48so4774556d6.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 17:35:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775090127; cv=none;
        d=google.com; s=arc-20240605;
        b=UGwm4Zm8PwTRX1s3hDROy32Rv/PbPKqFufZrx+lnu+lCHv/AFyAdR7+oxRzmdaHzCf
         DbUItAtD90WxYgkgIaKW6nmQpQePMjQ4ZrRUqNWCkFgMiqDP7TICeSgx+DDNWFIkmOn+
         uARSIZCVc7nrR9F09aTbRrU6ijady6dU29EGn49oPEfbM0H6oN8woZdRkc6Ls0EWRHO2
         DE3SEX2Tc00TaQflR5SKGUbqiTujL+MSbrgsMRT2pObK360h3FzbOvnI76wCNj1obdom
         dfg7CG+G+bQHRp5Z9yFCnUls1BQILONeqlI7nHOwM30KUa0v7sTk/dR34q+8lHeOx3Ax
         PZpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mbvWjYnxtKFNfwHRRjgzTNPGwHkzf36oAI86aEBbJbA=;
        fh=C+Z57gxiWTsU5/i6ra8N3IJPAbxIm3tCjsDz34hH+Ug=;
        b=ZU1Ji+O5hH7a9Fz1LKwPsOrBci8Vjbcv8lxKo4nRslSkTxpAXau9Hc/diiJoP1e4xz
         hIUAckQs/RXNU2pxezhwekz/DYsFh8pxkzuhaxJcqs4fuSSLxmXfk80lllj+ksTak7SA
         pLwSW8wdRWNmjmLYUGEsi6Qf4Rr67sruqpxiUZ54DKjVJUj/S/3uT6k2Uum8gNfIwmiB
         HTdjBYut73InoQGrk+wepJ09lazBXLRqfKfkD2uwzw/4QMbQ4a9J5XiT0FTY8c86WaL+
         M048up2vbFGFdLFBOtTT7eThaHN4LOzQMRnLVTBbZNErSeF2rYT98VQTFO48plzZ1XRX
         ZxpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775090127; x=1775694927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbvWjYnxtKFNfwHRRjgzTNPGwHkzf36oAI86aEBbJbA=;
        b=urWDrqy1+nCoJwxzPCLuxF/bY7IvLD2X7dqtixbJj2wWVD2HFJM1P4bxiZvUhXWksx
         slfGsQMJfnNOQt0SvlNTXlVKkZQR4/XUocGPqHx4m8hL5M7JAhktLDmWBwtzwuCx49Br
         rVIm7f6G4k87rJV/VLRcUb8B1/2sw/TVcCbLVYK5HLH74GBrPsWlSHb6GcYQtUiH3vX6
         0axcnUZBdE1jrhVzQ1nCLC5NJQjWqHqFmS5TkAFYKI+/kkQhPsEkTpD/qruowrUvXHP3
         qmqAqz8BpByXbeBeUn621Uh56CDLnQmO0Vsei5IHMmyloSZ323lqkmCU6cTfIwMYeIaY
         d8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775090127; x=1775694927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mbvWjYnxtKFNfwHRRjgzTNPGwHkzf36oAI86aEBbJbA=;
        b=AIdQtCNiPkd5RaaxasWzyIx1IIyp0xucF69kaC5x/lQMJFs0XIoUxZDJkhqfhVkePb
         HgKdEP6BSmbo/tFCuvExnlKsJvjWAGG3ufx33CJw8pjX3ExKym5XzeXDCkBwSIk52vWY
         CD4I1Ee19TkqOdsHilAGLmLH143WIUE0PFAyt2kJ/PU+CZnQhX3OL3XwsP3W5kRaiQRV
         aRY6zPQ8OB9RUSOc5LBricZVa+NGO0rtXNRAHitRk5ikYmorXRuB2aSZPhs6/4mka5Zr
         qrmWFN33cueU1veFneHedJU5FYhkJ/5OKGy9QHJ8sgp75oQlDZA80vXwX67/m0yQ2GCM
         533g==
X-Gm-Message-State: AOJu0Yzz8Tv5TTxjWuqYyA7st29l14nCX+b2+33PuyueLbh/bfXRGD26
	weJf5pPb/GthOrcbpjGh5xM2DVy0y1Jt8KlCqJ+z3SYW109E8wsQcupDidu7j4M2nq6113cgRlY
	K7VLvkta/BGq2bxcDpcRoX3lmfHcEuqbE+FrwGvt+
X-Gm-Gg: ATEYQzzlIR1VDuFVbvcbwwnWC3ybw1VxgQT5u9k8Jo+yxfyGT6gIv3qtLIxTC44wbgg
	OUmWV/V/mPED4O8kYUzvqTfVLAbfMMyMA5PIvuXI/E3sNDy8mlAIKdUZg3fJGbvR+sTZXAeQskI
	N27InnGoNXnyzbuwVwxI/VpMZVxqMk4vEnGtfJmsWzwWOjOiQWJsT8MepbJSOt7MsqbK6qp3bV0
	TnJS4AUIliMP25jQv+5nE38tLPQcqbGn8pqFn+Qy+jwrWxw4Wo2hRmSCe0oMTSgYDwpox5gqFZe
	XCmdXow+
X-Received: by 2002:a05:6214:509a:b0:89a:9ef:1922 with SMTP id
 6a1803df08f44-8a439f8be5cmr81525446d6.40.1775090126466; Wed, 01 Apr 2026
 17:35:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401233745.2333858-1-joe@dama.to> <20260401233745.2333858-8-joe@dama.to>
In-Reply-To: <20260401233745.2333858-8-joe@dama.to>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Apr 2026 17:35:14 -0700
X-Gm-Features: AQROBzA72T01YF4osaZT0JQX-LX2eD65ne8awpA0K75b_xCL3zstcHGGf2b6HPM
Message-ID: <CANn89i+dWeUvZW-sLU5ozZM5rHgDY1mXKOXM=EjdhJanumqVsw@mail.gmail.com>
Subject: Re: [net-next v7 07/10] net: bnxt: Implement software USO
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274296-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,dama.to:email]
X-Rspamd-Queue-Id: C5A41382087
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 4:38=E2=80=AFPM Joe Damato <joe@dama.to> wrote:
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
>  v7:
>    - Dropped Pavan's Reviewed-by as some changes were made.
>    - Updated struct bnxt_sw_tx_bd to embed a tso_dma_map_completion_state
>      struct for tracking completion state.
>    - Dropped an unnecessary slot check.
>    - Eliminated an ugly looking ternary to simplify the code.
>    - Call tso_dma_map_completion_save to update completion state.
>
>  v6:
>    - Addressed Paolo's feedback where the IOVA API could fail transiently=
,
>      leaving stale state in iova_state. Fix this by always copying the st=
ate,
>      noting that dma_iova_try_alloc is called unconditionally in the
>      tso_dma_map_init function (via tso_dma_iova_try), which zeroes the s=
tate
>      even if the API can't be used.
>    - Since this was a very minor change, I retained Pavan's Reviewed-by.
>
>  v5:
>    - Added __maybe_unused to last_unmap_len and last_unmap_addr to silenc=
e a
>      build warning when CONFIG_NEED_DMA_MAP_STATE is disabled. No functio=
nal
>      changes.
>    - Added Pavan's Reviewed-by.
>
>  v4:
>    - Fixed the early return issue Pavan pointed out when num_segs <=3D 1;=
 use the
>      drop label instead of returning.
>
>  v3:
>    - Added iova_state and iova_total_len to struct bnxt_sw_tx_bd.
>    - Stores iova_state on the last segment's tx_buf during xmit.
>
>  rfcv2:
>    - set the unmap len on the last descriptor, so that when completions f=
ire
>      only the last completion unmaps the region.
>
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   3 +
>  drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 197 ++++++++++++++++++
>  2 files changed, 200 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.h
> index b5b84d1e5217..993b215413c7 100644
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
> index b296769ee4fe..b0f8126b6903 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> @@ -19,11 +19,208 @@
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
> +       mss =3D skb_shinfo(skb)->gso_size;
> +       total_payload =3D skb->len - hdr_len;
> +       num_segs =3D DIV_ROUND_UP(total_payload, mss);
> +
> +       /* Zero the csum fields so tso_build_hdr will propagate zeroes in=
to
> +        * every segment header. HW csum offload will recompute from scra=
tch.
> +        */

We might need a call to skb_cow_head(skb, 0) before changing ->check
(or anything in skb->head)

Alternative would be to perform the clears after each tso_build_hdr()
and leave skb->head untouched.


> +       udp_hdr(skb)->check =3D 0;
> +       if (!tso.ipv6)
> +               ip_hdr(skb)->check =3D 0;
> +
> +       if (unlikely(num_segs <=3D 1))
> +               goto drop;
> +
> +       /* Upper bound on the number of descriptors needed.
> +        *
> +        * Each segment uses 1 long BD + 1 ext BD + payload BDs, which is
> +        * at most num_segs + nr_frags (each frag boundary crossing adds =
at
> +        * most 1 extra BD).
> +        */
> +       bds_needed =3D 3 * num_segs + skb_shinfo(skb)->nr_frags + 1;
> +
> +       if (unlikely(bnxt_tx_avail(bp, txr) < bds_needed)) {
> +               netif_txq_try_stop(txq, bnxt_tx_avail(bp, txr),
> +                                  bp->tx_wake_thresh);
> +               return NETDEV_TX_BUSY;
> +       }
> +
> +       if (unlikely(tso_dma_map_init(&map, &pdev->dev, skb, hdr_len)))
> +               goto drop;
> +
> +       cfa_action =3D bnxt_xmit_get_cfa_action(skb);
> +       if (skb_vlan_tag_present(skb)) {
> +               vlan_tag_flags =3D TX_BD_CFA_META_KEY_VLAN |
> +                                skb_vlan_tag_get(skb);
> +               if (skb->vlan_proto =3D=3D htons(ETH_P_8021Q))
> +                       vlan_tag_flags |=3D 1 << TX_BD_CFA_META_TPID_SHIF=
T;
> +       }
> +
> +       prod =3D txr->tx_prod;
> +
> +       for (i =3D 0; i < num_segs; i++) {
> +               unsigned int seg_payload =3D min_t(unsigned int, mss,
> +                                                total_payload - i * mss)=
;
> +               u16 slot =3D (txr->tx_inline_prod + i) &
> +                          (BNXT_SW_USO_MAX_SEGS - 1);
> +               struct bnxt_sw_tx_bd *tx_buf;
> +               unsigned int mapping_len;
> +               dma_addr_t this_hdr_dma;
> +               unsigned int chunk_len;
> +               unsigned int offset;
> +               dma_addr_t dma_addr;
> +               struct tx_bd *txbd;
> +               void *this_hdr;
> +               int bd_count;
> +               __le32 csum;
> +               bool last;
> +               u32 flags;
> +
> +               last =3D (i =3D=3D num_segs - 1);
> +               offset =3D slot * TSO_HEADER_SIZE;
> +               this_hdr =3D txr->tx_inline_buf + offset;
> +               this_hdr_dma =3D txr->tx_inline_dma + offset;
> +
> +               tso_build_hdr(skb, this_hdr, &tso, seg_payload, last);
> +
> +               dma_sync_single_for_device(&pdev->dev, this_hdr_dma,
> +                                          hdr_len, DMA_TO_DEVICE);
> +
> +               bd_count =3D tso_dma_map_count(&map, seg_payload);
> +
> +               tx_buf =3D &txr->tx_buf_ring[RING_TX(bp, prod)];
> +               txbd =3D &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(pro=
d)];
> +
> +               tx_buf->skb =3D skb;
> +               tx_buf->nr_frags =3D bd_count;
> +               tx_buf->is_push =3D 0;
> +               tx_buf->is_ts_pkt =3D 0;
> +
> +               dma_unmap_addr_set(tx_buf, mapping, this_hdr_dma);
> +               dma_unmap_len_set(tx_buf, len, 0);
> +
> +               if (last) {
> +                       tx_buf->is_sw_gso =3D BNXT_SW_GSO_LAST;
> +                       tso_dma_map_completion_save(&map, &tx_buf->sw_gso=
_cstate);
> +               } else {
> +                       tx_buf->is_sw_gso =3D BNXT_SW_GSO_MID;
> +               }
> +
> +               flags =3D (hdr_len << TX_BD_LEN_SHIFT) |
> +                       TX_BD_TYPE_LONG_TX_BD |
> +                       TX_BD_CNT(2 + bd_count);
> +
> +               flags |=3D bnxt_sw_gso_lhint(hdr_len + seg_payload);
> +
> +               txbd->tx_bd_len_flags_type =3D cpu_to_le32(flags);
> +               txbd->tx_bd_haddr =3D cpu_to_le64(this_hdr_dma);
> +               txbd->tx_bd_opaque =3D SET_TX_OPAQUE(bp, txr, prod,
> +                                                  2 + bd_count);
> +
> +               csum =3D cpu_to_le32(TX_BD_FLAGS_TCP_UDP_CHKSUM |
> +                                  TX_BD_FLAGS_IP_CKSUM);
> +
> +               prod =3D NEXT_TX(prod);
> +               bnxt_init_ext_bd(bp, txr, prod, csum,
> +                                vlan_tag_flags, cfa_action);
> +
> +               /* set dma_unmap_len on the LAST BD touching each
> +                * region. Since completions are in-order, the last segme=
nt
> +                * completes after all earlier ones, so the unmap is safe=
.
> +                */
> +               while (tso_dma_map_next(&map, &dma_addr, &chunk_len,
> +                                       &mapping_len, seg_payload)) {
> +                       prod =3D NEXT_TX(prod);
> +                       txbd =3D &txr->tx_desc_ring[TX_RING(bp, prod)][TX=
_IDX(prod)];
> +                       tx_buf =3D &txr->tx_buf_ring[RING_TX(bp, prod)];
> +
> +                       txbd->tx_bd_haddr =3D cpu_to_le64(dma_addr);
> +                       dma_unmap_addr_set(tx_buf, mapping, dma_addr);
> +                       dma_unmap_len_set(tx_buf, len, 0);
> +                       tx_buf->skb =3D NULL;
> +                       tx_buf->is_sw_gso =3D 0;
> +
> +                       if (mapping_len) {
> +                               if (last_unmap_buf) {
> +                                       dma_unmap_addr_set(last_unmap_buf=
,
> +                                                          mapping,
> +                                                          last_unmap_add=
r);
> +                                       dma_unmap_len_set(last_unmap_buf,
> +                                                         len,
> +                                                         last_unmap_len)=
;
> +                               }
> +                               last_unmap_addr =3D dma_addr;
> +                               last_unmap_len =3D mapping_len;
> +                       }
> +                       last_unmap_buf =3D tx_buf;
> +
> +                       flags =3D chunk_len << TX_BD_LEN_SHIFT;
> +                       txbd->tx_bd_len_flags_type =3D cpu_to_le32(flags)=
;
> +                       txbd->tx_bd_opaque =3D 0;
> +
> +                       seg_payload -=3D chunk_len;
> +               }
> +
> +               txbd->tx_bd_len_flags_type |=3D
> +                       cpu_to_le32(TX_BD_FLAGS_PACKET_END);
> +
> +               prod =3D NEXT_TX(prod);
> +       }
> +
> +       if (last_unmap_buf) {
> +               dma_unmap_addr_set(last_unmap_buf, mapping, last_unmap_ad=
dr);
> +               dma_unmap_len_set(last_unmap_buf, len, last_unmap_len);
> +       }
> +
> +       txr->tx_inline_prod +=3D num_segs;
> +
> +       netdev_tx_sent_queue(txq, skb->len);
> +
> +       WRITE_ONCE(txr->tx_prod, prod);
> +       /* Sync BDs before doorbell */
> +       wmb();
> +       bnxt_db_write(bp, &txr->tx_db, prod);
> +
> +       if (unlikely(bnxt_tx_avail(bp, txr) <=3D bp->tx_wake_thresh))
> +               netif_txq_try_stop(txq, bnxt_tx_avail(bp, txr),
> +                                  bp->tx_wake_thresh);
> +
> +       return NETDEV_TX_OK;
> +
> +drop:
>         dev_kfree_skb_any(skb);
>         dev_core_stats_tx_dropped_inc(bp->dev);
>         return NETDEV_TX_OK;
> --
> 2.52.0
>


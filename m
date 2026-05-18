Return-Path: <netdev+bounces-289183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLw6KJSJC2p1IwUAu9opvQ
	(envelope-from <netdev+bounces-289183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 23:50:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D785741B3
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 23:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8E66300BCA0
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 21:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9647739A7E1;
	Mon, 18 May 2026 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pR7a8EmB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B84B39A052
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 21:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779141004; cv=pass; b=ajrl9mED6j5oFKpTZIH/DiKcDHiKFugYzXw1MtkqURn6zWpbenxvPIslHwDbFALf0HTnw4SflUWhQ1HqSb7qnE3/qsNQ9EURmxZcVmAejJzrIWqDPTl6UfhxrADwjssUPyFj5toDahGM6UA2ZBNvjV17ef66VjScNlExEieUQxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779141004; c=relaxed/simple;
	bh=VkJcVq88PZ051GeKnLPd8Ml2ZKh5BjaQJaJRp7q6aDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U342dHptHhrTbFMCNaVLr9qce5UCjjbvdt7bDduqeVahnB+VhLd4R7dgAIwqrQyx+Wdo70an/ppeLQsq6lqmaT+bad+nQMxV50TGO6wf6xPkt2GWAeg56xQOSjXV51caZIP6Nx+bH7YuQB/ls1dPNhn5lZGq2QsXN6VVnoP3vHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pR7a8EmB; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba180a022dso1095ad.1
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 14:50:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779141002; cv=none;
        d=google.com; s=arc-20240605;
        b=dg+12W1pdGYYLOyoE/dGxeOKGT7zulFSs+Q3navoh4k/dt99FMjnLbtytU8NC5l59z
         USIgOyavil6EK2BeOJD/hdHhiIjyDf+iIfffntOVDn9FQBjd4nwsL3NS3nDJGpoDMau2
         FAWgzNFYGD5m9d79SX3P2Zpfiy20Y/X1pihoD3fXGJNU1zKEwe5AhGxt7S+TAwPHsyMQ
         /hjFGgsIWrAcNVmx6lx8YQ+ZOLvT0094fYp8S3XrLZGfEcWfg4Ra6qNf50K6aD5V4qDu
         dR7kfz9coS4XKTKSKKkJW3M4+rdiZ9Rh038RcocnpIYFrO5m+ejGAZZR16szXVH6gKQh
         KkEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6JbypSeXnACgLDxcb5qtpEO/b70xrtWk27xe3ssqhmA=;
        fh=jo+JZ2BvVBCOuLa0fNkuB3R6YQPA7I6h2ONz/0JPs7w=;
        b=Z4ybniB97IkyT/iCJqbcds7pZlR0SLD7TVqCbi4/D19j1in+SNlfc6/00G10p6mYEd
         RT53ZJIlFHdOofTcP+MIi/sl5zSmer/q/vVHQ+4WXURqy9lMYXejdyr50HjREKLE3qR6
         lhz9PKXLa2sw2YvZl1HbT1V9bNpHE1ZkJ8z6ZW6nH5UviRIMCi/zA0A3fKctwl/KJmCM
         rlGTHaRSPObqnk65j4b2dpD5xnpiAzvcTLrtrHBvT1YyqElo8Uiue2YST5oMo5xnG3cC
         /ZBMPXBWYnGzmuylJJYxnNpY7ifigJt+lk+JVZOgoMdO7Zswcjx5hHNBvub/JfGvToxe
         aKog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779141002; x=1779745802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JbypSeXnACgLDxcb5qtpEO/b70xrtWk27xe3ssqhmA=;
        b=pR7a8EmBPVhtgoI+iG1VPzFORXXBx15tpSmrwe8xs+DN6OwRvuST6qoTu/bminXVa0
         MRDXOUz8E5xc9sf3YPgPgTwNuGEIEKHitQ9ysyFhjfqnrPhBl78GpGwEfbS6wmbMNplv
         V06l+xrqnc3BHcmhkaXmEL/IUuKLrAuiBEQ3THI0IO0F6VHOXyzSlOUHrje95ZqjYAUI
         rFx+F0sc9GGw3Fkv0CovlxhYyIsCEIayzRIEzoKdp24HXkdaIHBKm0OTN/uo6BvE7r8y
         w2e0heo0RJLFkXkFjNCvVMt7Fcjc2G0J+gPs6rvi/VohEMuKipuldrZ5eBbZEx6Ftzmi
         XnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779141002; x=1779745802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6JbypSeXnACgLDxcb5qtpEO/b70xrtWk27xe3ssqhmA=;
        b=OKbfNeejlM2fhryvAobN56hqmLIQ6yyPnGREEvzzXBaW9Lv2EfeGj3iZXjBQw5ZSQH
         NgDP4TnnGK+K1TxtbaFAOOmpfkBhLgQdvxq3bx44mtxI6zJbzEnz18tslF8ZIw4TNuB9
         gBuCKvVwJ19pHiVRtaFGiAZ/piuPvaFnrfQCfsyturjljJWrfm9fIB3Z+lhIc3xS2F5L
         dAj5Th7xJnLJBZvm718CzQZcpW56HkDuBuus61gMVGw6gk/UCUhGFHfpLLdDsEwHpSYw
         lczFSEddRK9KFZYy+ixAFmEhNqJoytzL3cYzZsWy+8Zf3v7/pvZ628tS9FgSED+OPQYF
         mM8w==
X-Forwarded-Encrypted: i=1; AFNElJ+3/XxA60oi/eSZIwzOaOnDOrunhvXEP5nDzU1OfGgRNkEeEEKXkuDYrVSmqqxojpBjczDOEgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJdkmwFddXJRdQD7aQNmVAzonuwxubmqjmWIF1USfaX0hfyPY0
	H+rd3SqstY2LegzDLA/ebl5ko80dRP97Mney8l8U/2g4+Y/TdbeX0y1wlQn6zjUlO4oZlqgZQcr
	hhxkM5/6DOw/nGU7O3esjFYN3mvFAlAYn66a1A/pD
X-Gm-Gg: Acq92OHiFjVSustz3lwNGEYKm7DzXN2u17eW5aDxr4YnjViClBEIf4ET4Cak/54IBu4
	dnJYJFgR2O5AFyptAZC2TvDugxDz5k9GoundWDpaUtt4gg3rwphS8C9tquv3XldS7Qwz3/VZjYj
	80YHe6kSL21jl/yw7B+QAlicVDLwQx2ufSJB5+dhA2EtAMjK7sU5eZUMq4V2G/I6idGsyUPlKPa
	XIeMEQWjiOOgaVRIne9NsqmSgD4XFDjC5oEbBgHbihtjdWGA166vGVJ7waJ90G2GWyRxm2R8DD8
	vSiZAuTYBV78T2vndBwQrh37xJuxGZZe5x1+jqxN0dxJSTzek+lKT9UHAIftNyV96CqIlsrk769
	3q+fmI4Fn3vLP+3d2
X-Received: by 2002:a17:903:2b0e:b0:2bd:7bec:f0e6 with SMTP id
 d9443c01a7336-2bdb3039f44mr4031835ad.1.1779141001688; Mon, 18 May 2026
 14:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518194654.735580-1-dipayanroy@linux.microsoft.com> <20260518194654.735580-2-dipayanroy@linux.microsoft.com>
In-Reply-To: <20260518194654.735580-2-dipayanroy@linux.microsoft.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Mon, 18 May 2026 14:49:49 -0700
X-Gm-Features: AVHnY4K_8GpyBqIYGQp4SgXCG1-y0gChQxakRF0W6U_iz8zjhZO9jcW9YHuJGe4
Message-ID: <CAEAWyHcFE5kUPthnRHQJS5s=YBRhdaOP9mYNsxkMt-Pm1U_1+A@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: mana: Add NULL guards in teardown path to
 prevent panic on attach failure
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, leon@kernel.org, 
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org, 
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com, 
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com, 
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	stephen@networkplumber.org, jacob.e.keller@intel.com, 
	dipayanroy@microsoft.com, leitao@debian.org, kees@kernel.org, 
	john.fastabend@gmail.com, hawk@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me, yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289183-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A1D785741B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 12:52=E2=80=AFPM Dipayaan Roy
<dipayanroy@linux.microsoft.com> wrote:
>
> When queue allocation fails partway through, the error cleanup frees
> and NULLs apc->tx_qp and apc->rxqs. Multiple teardown paths such as
> mana_remove(), mana_change_mtu() recovery, and internal error handling
> in mana_alloc_queues() can subsequently call into functions that
> dereference these pointers without NULL checks:
>
> - mana_chn_setxdp() dereferences apc->rxqs[0], causing a NULL pointer
>   dereference panic (CR2: 0000000000000000 at mana_chn_setxdp+0x26).
> - mana_destroy_vport() iterates apc->rxqs without a NULL check.
> - mana_fence_rqs() iterates apc->rxqs without a NULL check.
> - mana_dealloc_queues() iterates apc->tx_qp without a NULL check.
>
> Add NULL guards for apc->rxqs in mana_fence_rqs(),
> mana_destroy_vport(), and before the mana_chn_setxdp() call. Add a
> NULL guard for apc->tx_qp in mana_dealloc_queues() to skip TX queue
> draining when TX queues were never allocated or already freed.
>
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network=
 Adapter (MANA)")
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 70 +++++++++++--------
>  1 file changed, 41 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index 9afc786b297a..0582803907a8 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1727,6 +1727,9 @@ static void mana_fence_rqs(struct mana_port_context=
 *apc)
>         struct mana_rxq *rxq;
>         int err;
>
> +       if (!apc->rxqs)
> +               return;
> +
>         for (rxq_idx =3D 0; rxq_idx < apc->num_queues; rxq_idx++) {
>                 rxq =3D apc->rxqs[rxq_idx];
>                 err =3D mana_fence_rq(apc, rxq);
> @@ -2858,13 +2861,16 @@ static void mana_destroy_vport(struct mana_port_c=
ontext *apc)
>         struct mana_rxq *rxq;
>         u32 rxq_idx;
>
> -       for (rxq_idx =3D 0; rxq_idx < apc->num_queues; rxq_idx++) {
> -               rxq =3D apc->rxqs[rxq_idx];
> -               if (!rxq)
> -                       continue;
> +       if (apc->rxqs) {
>
> -               mana_destroy_rxq(apc, rxq, true);
> -               apc->rxqs[rxq_idx] =3D NULL;
> +               for (rxq_idx =3D 0; rxq_idx < apc->num_queues; rxq_idx++)=
 {
> +                       rxq =3D apc->rxqs[rxq_idx];
> +                       if (!rxq)
> +                               continue;
> +
> +                       mana_destroy_rxq(apc, rxq, true);
> +                       apc->rxqs[rxq_idx] =3D NULL;
> +               }
>         }
>
>         mana_destroy_txq(apc);
> @@ -3269,7 +3275,8 @@ static int mana_dealloc_queues(struct net_device *n=
dev)
>         if (apc->port_is_up)
>                 return -EINVAL;
>
> -       mana_chn_setxdp(apc, NULL);
> +       if (apc->rxqs)
> +               mana_chn_setxdp(apc, NULL);

Is this check required? mana_dealloc_queues() is only called by
mana_detach(). And mana_detach() calls `mana_dealloc_queues()` only if
the port state was previously up. apc->port_is_up seems to be set to
true only on successful queue allocation. Can apc->rxqs be NULL here?

>
>         if (gd->gdma_context->is_pf && !apc->ac->bm_hostmode)
>                 mana_pf_deregister_filter(apc);
> @@ -3287,33 +3294,38 @@ static int mana_dealloc_queues(struct net_device =
*ndev)
>          * number of queues.
>          */
>
> -       for (i =3D 0; i < apc->num_queues; i++) {
> -               txq =3D &apc->tx_qp[i].txq;
> -               tsleep =3D 1000;
> -               while (atomic_read(&txq->pending_sends) > 0 &&
> -                      time_before(jiffies, timeout)) {
> -                       usleep_range(tsleep, tsleep + 1000);
> -                       tsleep <<=3D 1;
> -               }
> -               if (atomic_read(&txq->pending_sends)) {
> -                       err =3D pcie_flr(to_pci_dev(gd->gdma_context->dev=
));
> -                       if (err) {
> -                               netdev_err(ndev, "flr failed %d with %d p=
kts pending in txq %u\n",
> -                                          err, atomic_read(&txq->pending=
_sends),
> -                                          txq->gdma_txq_id);
> +       if (apc->tx_qp) {

And same as above, is it possible for apc->tx_qp to be NULL here?

> +               for (i =3D 0; i < apc->num_queues; i++) {
> +                       txq =3D &apc->tx_qp[i].txq;
> +                       tsleep =3D 1000;
> +                       while (atomic_read(&txq->pending_sends) > 0 &&
> +                              time_before(jiffies, timeout)) {
> +                               usleep_range(tsleep, tsleep + 1000);
> +                               tsleep <<=3D 1;
> +                       }
> +                       if (atomic_read(&txq->pending_sends)) {
> +                               err =3D
> +                                   pcie_flr(to_pci_dev(gd->gdma_context-=
>dev));
> +                               if (err) {
> +                                       netdev_err(ndev, "flr failed %d w=
ith %d pkts pending in txq %u\n",
> +                                                  err,
> +                                           atomic_read(&txq->pending_sen=
ds),
> +                                           txq->gdma_txq_id);
> +                               }
> +                               break;
>                         }
> -                       break;
>                 }
> -       }
>
> -       for (i =3D 0; i < apc->num_queues; i++) {
> -               txq =3D &apc->tx_qp[i].txq;
> -               while ((skb =3D skb_dequeue(&txq->pending_skbs))) {
> -                       mana_unmap_skb(skb, apc);
> -                       dev_kfree_skb_any(skb);
> +               for (i =3D 0; i < apc->num_queues; i++) {
> +                       txq =3D &apc->tx_qp[i].txq;
> +                       while ((skb =3D skb_dequeue(&txq->pending_skbs)))=
 {
> +                               mana_unmap_skb(skb, apc);
> +                               dev_kfree_skb_any(skb);
> +                       }
> +                       atomic_set(&txq->pending_sends, 0);
>                 }
> -               atomic_set(&txq->pending_sends, 0);
>         }
> +
>         /* We're 100% sure the queues can no longer be woken up, because
>          * we're sure now mana_poll_tx_cq() can't be running.
>          */
> --
> 2.43.0
>
>


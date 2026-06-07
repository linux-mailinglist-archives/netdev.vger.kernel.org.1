Return-Path: <netdev+bounces-296255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YQ5vJBiSJWoCJQIAu9opvQ
	(envelope-from <netdev+bounces-296255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 17:45:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F1C650E62
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 17:45:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UnxbW4Fd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296255-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296255-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 953303010380
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 15:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7DF2DF6E9;
	Sun,  7 Jun 2026 15:45:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADC0283FF5
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 15:45:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780847126; cv=pass; b=hcwtfKnVV2m04MSC4lRMIhXdiqoyUhTfoWM8hlrx8guqPVEuGVwh4IjZTq1unetH8TWEaDv+AyKS9oZO8gD1UPhOusN/HJsWBYMVeQQcYgitJxIM1Qnh33cecgel34TfG6ATpZ8nQNXCIDPy963udwE8qsFR9R7b3XswE9GJBhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780847126; c=relaxed/simple;
	bh=pLV8jV7hklDSB01P/rnfhLSZYgR8gFqSdLAXyj5xtJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GVjbx05dTn7N7c5C++rck24LiH+7fk3O0rXCM7NwiZkdxYRLeewiubf3nHKIunIVSBQ1dqjJBSZVy45RQWc9tcVw4EbNiuSd1zLu7SwTMyUnom1+ktHBEJipKzw9IvrZlLrEiuKtl94UGD9CBjPMESy5iimoRgGCBNYczPw/UO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnxbW4Fd; arc=pass smtp.client-ip=209.85.160.54
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-43ccdc20e67so1588686fac.1
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 08:45:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780847123; cv=none;
        d=google.com; s=arc-20240605;
        b=gdUsZLu7LjFeip0zFCzYMk/B4PiJiwqieenFrmgFObLYQvXmC7tWWfA/61X4vsBn//
         WEo9DLsvdoyujjGx/7GxPlfr6KO1r20HHvlfWD44xkgAgtdnVALJGglZCPCG0NC9eD7M
         qHKw7RrugF35A8asdDBNorwCCxFfCaRiSLZvjQrS5kptCdvaiq+UbKUaEXCPmortYI7C
         AnbD7sXMCnibmFg7738IOStrt7hQAgKVrTb0Z1o3h6HA1M3CyBwck0uxsm+MRoRctUh5
         mN3Lwuz+LfZGMh4/Ywej/dYFK7WQQNfcUi9vhoNLEEhdc/CAl8MpEIeElH8JXz+hAFA8
         MPiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9wfBsAbCYwCC2GqYSny2LRPTg6nVEL/SrB7w99G8/W4=;
        fh=jAtyPCvbU3j7hpnzeXoyPcIq/K7R68dGsy04WKPLeU4=;
        b=AuZRDmzMdnykoc/W52VAhQp4M304WZKC2Jt2aD2ULwOYXtsTE7NhPsOqOtyuurTq6a
         ORULLdMWXknV0Xk5GLhEeR75oSKmsqvc4MeKR83VnKgC5twuYNzxhhwcnZT8LGvjZmq4
         gXmz9XA6OZUpG/FVZUyEztoaXs/I8sradUDAT8CKZm9Nj3YNGSjoVcTcN6j+5equHhyf
         bbrTkCI4xGwVMqrcyPoo/QPGBxpMPqyo8vCyJ6qeKYdl3bgK+ykVtarhWcCZw1Z0k0if
         XXa56ZmjMNwqs83epQx35zoUxiurswgbFK8b5a8WxXilReb2hr5I1RI8u85eICqNbzKo
         dPLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780847123; x=1781451923; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9wfBsAbCYwCC2GqYSny2LRPTg6nVEL/SrB7w99G8/W4=;
        b=UnxbW4Fd1sPOojgcS6audDCi+j/KdBqj1fWcz4sSNofmtIyq+TAfBCu+YLfyIJ9l5W
         CBBw3AtElUaQrKI6stbRdv2CVpR6qXYh5z/FugHjb+U31sy/wxcCiJjNA42E1al9zF+c
         fMaI6BLMRUrvHTZljFDdq9L99aeB7ENiy85B7UD8ueGy1QQJckGuqREzWh8C6kK6Vbpk
         8TEztiXVn2fFBHEnJEy+7uyIHQa5X3q4sPMqKFTT159KSBgxrGJzo3sDpDRp/z7CB+O4
         fx8d5IQmG+1M9nxWsYHWZGztzhvpIbRL2hHNVVaq7yBf3HchZTl/MXnHG1ia5CY8lXOP
         wy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780847123; x=1781451923;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wfBsAbCYwCC2GqYSny2LRPTg6nVEL/SrB7w99G8/W4=;
        b=pB9rgLaP1D82EAbtDW76keRoalf81lWnb75AxiUTKZinhNB/mybE6LE68fSiKIIomx
         lWedAziP6Ih2rT32qUJDYXd8Srn6KHD5XWqFVacm48wkiVKh2pzUuZD0RlKRXOH1QC1V
         Mx58W1Oa3D2QglP7fc14ysBF6mIIlXOmXG8JU+UjfckPJdcrI/SX5x36Bu49WfPza2xl
         u+t/hPiWoFkgwpN0JeYNUih9NzaYvKZFWznqwdmWUYSw4qaayQv5NIuShtv87NKhJMNG
         3BgtUsKME2WJBbW0KGL6W2+iQWNt6TPVe+svAwnKleBNu7YrFZ2cuGX0QjSwnxVyGnOI
         9oeg==
X-Forwarded-Encrypted: i=1; AFNElJ++DPCKK+8WVzba6ffwfzcn2t6+vmXyls6jFtp0suKNEaAD1iTVG6GluYq8KobP2DJjOLEHTNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6J99cqRdHWVpfCMygaWEXeSniUuK7pFxWhaayYcOR96Se1Tjm
	FNs4p+Q385Wp9DQ8/iywG315oxzdRq7VFFbNSttvIn6thD/j9ErDjBPN+Fa0zUqyaPLGn2dyuR2
	gb/xYSdN1UNa01kwEEy35ir+FUbLWF1E=
X-Gm-Gg: Acq92OHI9WGiiK8wRAjHhnWDpzZPbmPAa8egVm+8wZ1se7UqNQKSb4V2nOphVY/dkjj
	t5+JRqwhHb+oLXU5m8qkFLt+oZa60p2MNPHMjeAETf/2IhW0XsRIDIosdkFawvm0Zd8kd9R7Juo
	1alLDEuLysZLCOInHIWZjoODgaQwTpwkNgKjd8wI/hq8V4OXq4VPd/uM/j86l+pIwqvcCdPyDrO
	0wuXyALPxEKEcuNljE8RwkZ771HGg0OeR5F+LUzeToTzSNM+qDzLdgpF5JSEFNwkVQK2vUvhiNH
	qZV4haaRPtH2gmNRqmornm8lN+PuyB7EJNPLgd7sSK/8AlOp
X-Received: by 2002:a05:6870:d69b:b0:42c:ecc9:58b5 with SMTP id
 586e51a60fabf-4413d6437b6mr6270670fac.11.1780847123432; Sun, 07 Jun 2026
 08:45:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607145747.1494514-1-lgs201920130244@gmail.com>
In-Reply-To: <20260607145747.1494514-1-lgs201920130244@gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Sun, 7 Jun 2026 16:45:12 +0100
X-Gm-Features: AVVi8CdY2BXFYwyALCEu97p932ccl-6BhYKrBK8BkYsba51UqnUMNPOIBGeL_ww
Message-ID: <CA+XhMqx+q53AwRekMD0T-92maOizqGFEgcBRCNvChWQ3JBAg2A@mail.gmail.com>
Subject: Re: [PATCH v2] net: lan966x: restore RX state on reload failure
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:lgs201920130244@gmail.com,m:horatiu.vultur@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-296255-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5F1C650E62

ACK on the code part at least, maintainers might disagree with this:
changelog could also note the subject rename ("restore XDP RXQ page
pool" -> "restore RX state"), so the scope change from v1 is obvious
but that s a very minor nit IMO.

Reviewed-by: David Carlier <devnexen@gmail.com>

On Sun, 7 Jun 2026 at 15:58, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> lan966x_fdma_reload() backs up rx->page_pool and rx->fdma before
> reallocating the RX resources for the new MTU. If the allocation fails,
> the restore path puts these fields back before restarting RX.
>
> However, the reload path also updates rx->page_order and rx->max_mtu
> before calling lan966x_fdma_rx_alloc(). These fields are not restored on
> failure, so RX can be restarted with the old pages, old FDMA state and
> old page pool, but with the page geometry from the failed new MTU.
>
> This can make the XDP path advertise a frame size derived from the new
> page_order while the actual RX pages still come from the old allocation.
> For example, after a failed reload to a jumbo MTU, xdp_init_buff() may be
> called with a frame size larger than the restored RX pages.
>
> lan966x_fdma_rx_alloc_page_pool() also registers the newly allocated page
> pool with each port's XDP RXQ before fdma_alloc_coherent() is called. If
> fdma_alloc_coherent() fails, the new page pool is destroyed, but the
> rollback path does not restore the per-port XDP RXQ mem model
> registration either.
>
> Save and restore rx->page_order and rx->max_mtu, and restore the old page
> pool registration for each port's XDP RXQ before RX is started again.
> This keeps the restored RX state consistent after a failed reload.
>
> Fixes: 59c3d55a946c ("net: lan966x: fix use-after-free and leak in lan966x_fdma_reload()")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v2:
>   - Save and restore rx->page_order and rx->max_mtu in the reload rollback
>     path.
>   - Keep the XDP RXQ page-pool registration restore from v1.
>
>  .../ethernet/microchip/lan966x/lan966x_fdma.c | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index f8ce735a7fc0..8272ad085150 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> @@ -815,6 +815,7 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
>         struct page *(*old_pages)[FDMA_RX_DCB_MAX_DBS];
>         struct page_pool *page_pool;
>         struct fdma fdma_rx_old;
> +       int page_order, max_mtu;
>         int err, i, j;
>
>         old_pages = kmemdup(lan966x->rx.page, sizeof(lan966x->rx.page),
> @@ -825,6 +826,8 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
>         /* Store these for later to free them */
>         memcpy(&fdma_rx_old, &lan966x->rx.fdma, sizeof(struct fdma));
>         page_pool = lan966x->rx.page_pool;
> +       page_order = lan966x->rx.page_order;
> +       max_mtu = lan966x->rx.max_mtu;
>
>         napi_synchronize(&lan966x->napi);
>         napi_disable(&lan966x->napi);
> @@ -854,7 +857,24 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
>         return 0;
>  restore:
>         lan966x->rx.page_pool = page_pool;
> +       lan966x->rx.page_order = page_order;
> +       lan966x->rx.max_mtu = max_mtu;
>         memcpy(&lan966x->rx.fdma, &fdma_rx_old, sizeof(struct fdma));
> +       /*
> +        * lan966x_fdma_rx_alloc_page_pool() registered the new pool with
> +        * each port's XDP RXQ before the allocation failed. The new pool is
> +        * destroyed by lan966x_fdma_rx_alloc(), so restore the old pool's
> +        * registration before restarting RX.
> +        */
> +       for (i = 0; i < lan966x->num_phys_ports; i++) {
> +               if (!lan966x->ports[i])
> +                       continue;
> +
> +               xdp_rxq_info_unreg_mem_model(&lan966x->ports[i]->xdp_rxq);
> +               xdp_rxq_info_reg_mem_model(&lan966x->ports[i]->xdp_rxq,
> +                                          MEM_TYPE_PAGE_POOL, page_pool);
> +       }
> +
>         lan966x_fdma_rx_start(&lan966x->rx);
>
>         lan966x_fdma_wakeup_netdev(lan966x);
> --
> 2.43.0
>


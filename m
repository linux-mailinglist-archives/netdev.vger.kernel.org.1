Return-Path: <netdev+bounces-275912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEjPEILI1GlbxQcAu9opvQ
	(envelope-from <netdev+bounces-275912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:04:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B70A3ABB7F
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC1D2300531C
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 09:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E053290D1;
	Tue,  7 Apr 2026 09:03:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16281399002
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775552635; cv=none; b=NsKmTK4vCN8xZHbCG7iQ3flY84ab6JhUad9wg3grNOY5hF1/WZm5JUf0PY6Yt3ccXRL+dwFhSRXtDUEFJ3UsEKs1Cb1Rzf2oXGdkprcnabkmOVaUv837vy6yWnC3v+0/gm3pI97jmC9VkZU2S54k5lLwdTAFOO0N+jA6g4cKnAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775552635; c=relaxed/simple;
	bh=vR/OD3mUKC8xpJtZllM5WnO0SI3rvXcz9b+Z3xpwwk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+jjdyLYruzUwQh2cd6OkIkYFbXMry3rI8wk+CNF5eW0HGXU0VQjo8FeU8b/ofh70eiFc2FubU7P0RPsuqOxfpmG/Fl9pXYsWSARYIXaK55xD/G3Tu/xZbZYagIEpPcqjB3hr2YrIfJA4+h1zHOwmO3Ft8JsbsHG0N2BT7ZsUi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56dfd007d31so2139094e0c.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 02:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775552631; x=1776157431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y0vl46NKGRyiCl8U/M/6ud6IWg1EyGptt9/bHQKZ9ec=;
        b=Lu/Bqnc+x0eauoHO2Bvi2I1Y2xIIpVI+HCrK7gCDkc2KWIM+Rd5YYpTgaijBIzXrkx
         fDnOLt3loMS9HR01HhmdZrVD7RMakv8MM2YJ0V/EiY864Cpf5aWRA4NKlnos29sYXyjQ
         6qejHr8GASIXH9lW3zLwX8xwAg+F2FA+x4JZ57JcSHAzbARUcMrUwndCsBYzpKSvT8IR
         mWTsLSf/5ib87eRRsBvhGkGRP9qznj0qK0Ao5NLY9nao0eOzona7FO7Qym7uKa+T2vhp
         Tzd6xQIkSGdyCbDR4nGtoTJ0TE8ZpjkQa3Ld++e/y+IKwcibZ7/GhfxPSfIDfctXvrYB
         86hA==
X-Forwarded-Encrypted: i=1; AJvYcCXnCGCHfLGOQ8VOt1nmvxpjT2xwUi1w9Jt6bG8Eg8JSYqGFU60HWczKP+TLAvn09v6i5wce1B0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRchTRuA65CEJlBoQ7NiFL9g+qfsEheg/xb/cn+xbCbKzGcxxr
	LwQgV1nGn/kkwKc4/w6BX/EfL3ip1jRfTkSqsVVpzeHfKgKYSex/9r08sWeYe5s9
X-Gm-Gg: AeBDieu65kKYmEfUnXjE0aoK/56YyqZ75IsQX4dQL3LI6IS8NT2Q+UTBLU4GRBRxP55
	SwsQhhf14UFDhkpbCksmZHMYxsbmp1ZQNRSuOVj6Z743Z5DJ468+XrJkDBMm4rdoq2KKU6CQg+0
	lvcyVDpfkJ27bVdma+wuk9vaMIhE6lzQGHxr4yAilohOmdsJ9hlrv2bXmDizwhVqtHTF3hIhMPW
	gErl4nSkbVnD33CSB6cFVv40Qb/LHYgRQnj5Y1mkZuW90rUctsnBnVo1Clf9joJOgAoJxiuEJpt
	7kHGvK3Y3/+JkU8ZBptzxJQJJwjaH7AJuLgEG3XvBF2kZKP031DHqUB3lOmYQNPQuRgbIpjSAd/
	Jpv/ZnZF63c8lr5ftg3cDd0NOBF097RKIBWLUgyVH925mW0zLy53TA3mYwlRVZHG2r7Llgmmxj7
	0p+F2mPvp2hspBVrMR/A1NyqFaosZBc4SR5j2LbWgkwgjH+LxItA2DedGkMNMCr8rE
X-Received: by 2002:a67:e7cb:0:b0:5fe:12c9:6e5a with SMTP id ada2fe7eead31-605a4e668aemr6834423137.12.1775552630842;
        Tue, 07 Apr 2026 02:03:50 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60583098fa7sm18769024137.10.2026.04.07.02.03.50
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 02:03:50 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56739adfa1aso3735987e0c.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 02:03:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQ+HhssEUdwxZdL2N8eF+wwKTZ7e98Enga8myG2C9ymByTBBADwcJCEIcy6KbFW48+hO3DInc=@vger.kernel.org
X-Received: by 2002:a05:6122:83d3:b0:56d:451b:e4dd with SMTP id
 71dfb90a1353d-56dab9c582amr5571250e0c.12.1775552630186; Tue, 07 Apr 2026
 02:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401183608.1852225-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20260401183608.1852225-1-niklas.soderlund+renesas@ragnatech.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 7 Apr 2026 11:03:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWnjV=HGE1o08zLhUfTgOSene5fYx1J5GG10mB+Toq8qg@mail.gmail.com>
X-Gm-Features: AQROBzCmpfqi0EhIW62xO0TmPSVfhgL94wc_gDMbxOuCcTOVB0k3yzyfQ0rPbgc
Message-ID: <CAMuHMdWnjV=HGE1o08zLhUfTgOSene5fYx1J5GG10mB+Toq8qg@mail.gmail.com>
Subject: Re: [net-next] net: ethernet: ravb: Suspend and resume the
 transmission flow
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Paul Barker <paul@pbarker.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	TAGGED_FROM(0.00)[bounces-275912-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.335];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ragnatech.se:email,renesas.com:email,mail.gmail.com:mid,linux-m68k.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B70A3ABB7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Niklas, Shimoda-san,

On Wed, 1 Apr 2026 at 20:39, Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
>
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>
> The current driver does not follow the latest datasheet and does not
> suspend the flow when stopping DMA and resume it when starting. Update
> the driver to do so.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> [Niklas: Rebase from BSP and reword commit message]
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>

Thanks for your patch, which is now commit 353d8e7989b6babe ("net:
ethernet: ravb: Suspend and resume the transmission flow") in
linux-next/master net-next.

> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -694,6 +694,9 @@ static int ravb_dmac_init(struct net_device *ndev)
>         const struct ravb_hw_info *info =3D priv->info;
>         int error;
>
> +       /* Clear transmission suspension */
> +       ravb_modify(ndev, CCC, CCC_DTSR, 0);
> +
>         /* Set CONFIG mode */
>         error =3D ravb_set_opmode(ndev, CCC_OPC_CONFIG);
>         if (error)
> @@ -1103,6 +1106,12 @@ static int ravb_stop_dma(struct net_device *ndev)
>         if (error)
>                 return error;
>
> +       /* Request for transmission suspension */
> +       ravb_modify(ndev, CCC, CCC_DTSR, CCC_DTSR);
> +       error =3D ravb_wait(ndev, CSR, CSR_DTS, CSR_DTS);
> +       if (error)
> +               netdev_err(ndev, "failed to stop AXI BUS\n");

This error message is printed during resume from s2idle or s2ram on
e.g. Salvator-XS and Gray Hawk Single.  Ethernet (nfsroot) still works
fine, though.

> +
>         /* Stop AVB-DMAC process */
>         return ravb_set_opmode(ndev, CCC_OPC_CONFIG);
>  }

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


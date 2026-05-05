Return-Path: <netdev+bounces-284538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PJvFNIs+mlXKgMAu9opvQ
	(envelope-from <netdev+bounces-284538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:45:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 987A44D2467
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FA97301D33F
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 17:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64934A33EF;
	Tue,  5 May 2026 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/3uD/85"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69DD49550A
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002926; cv=pass; b=o5a/8SClThuqBoQRkO8v225YY6pFTBwvCsay+SXhDc1bZR42OZCKjJKfiYKxPDG6vi8BfyMoIuA+3bH/cQrsqzZoa74rjMCbu6Y3bP0eCRZDG3yqFw9bpNiFMhM18x18+kBvlMGZwp6IMB8Ai6fUuHmgGSCwbAkMPEIa+30ybFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002926; c=relaxed/simple;
	bh=6j/IDrdL+PvT/1eb7cvJPKzLra2WDu8IW8sjkzp3LNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5ZQbNEd5eLOVGGNybuVfIVNo6qwhr4EcGtkXNgQO/tZerpJ7lDpQJX1GwBvXeY8At++aa/+zC6/RZRbE7p0rXlBRLPm2hczwgT+JYDmxyMYYPoH4HBvFM9vSL5OSfMneRDyWNi5HFQAPsfo+hz2lEMahogI/1isPF+RvuuRCj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S/3uD/85; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso11535ad.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 10:42:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778002924; cv=none;
        d=google.com; s=arc-20240605;
        b=Tdji4Nf6f09neVBkF7iOOmJK0DDB7IIDRhTm5jhJ3NS53sndukcSo7+JPG5YDDS8S3
         /WAiBvBu52syhTajx+OhGEIuBLDVey2MqCnVg7TzHvzhNYDNJk2uQzYQaveDKyUSac6b
         pzCxcXGPjsHp1BW4XkXlfj3YQmQE9BIqfgYZzcp9QYzIoCqRpPyTyZFPKCL/pCBY4gp5
         b3wxIHVGWVZYdU1WDwD12Fx8O6fKve0wIqjQZEWT3js753xJq25c1eXJ2FAOSJUsr1k9
         b7DQuVNLevvnWAyeIzZhKgQMPajWllt/THplyRmYHISb+Hl/OMZyushl4rPGdLkvD+Ua
         SgmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=54klkLtO1z981HVzGmd4prOw9eXZMZmqAEmK52seTfw=;
        fh=gl0Ze4NrTg/03IiI7Byj4kA36svD0JS1a4rLpZKotd8=;
        b=ZjFDDTPrmGMO4bnpvVqBnc9apA6PCuF5/hG1Gvvu0AIWGeAN/HpUT6buWmFZEBk6kH
         yNtXTZoV0eIIwZLCCy7PoxoynTAmw/+LUyMZopxPfHo6eBmNvHqbkLCeIO1skukuuTRb
         tUbHTgArDbZTLcokkrFg9FBxqnSuLTiVMHvodkUwF3ccXUxm23FQ56LeEFBm00egIWcV
         xS1StvUSpLaRXkWagupxq7j+Nq6NPAwoTehduEyum27TdBwkkuSBYi2jqyq81NnUKPrT
         2czutF/LZyQaesEeJprYBS+UQDfFCNAfKUW4qm1uBDUQ8gzMawn232TL6z+WnDVuihuB
         L45g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778002924; x=1778607724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54klkLtO1z981HVzGmd4prOw9eXZMZmqAEmK52seTfw=;
        b=S/3uD/85381H66y+E8HCR19b5oNB7jhq7sSh1aX61ydfYNC+kYTz+yYlySkXdZFXQc
         Pvun9WRo/5OPe7mNVhzB0BFGt0Wt+woUvAfCjELIaPW3Vm8drQCqjQbXv91XyaswMMlD
         MNT6fje3WvY6y6YogWhaRQsYLV7znflRcbe/llFYep/V82BYnNUiKbk62Ey4BdKhYSCf
         yOYLMvz2MsKdHvKyvLONEsMws4UwqC/8/eAJzBLJIAsz+orJ8g196flnyELZ2l+zRzq4
         upTEcMUbd2gpo+01y7+4giCwRpbakIXsivd+YQYSbT3y+vuSL6VlJrHj0OIDdQLni6jm
         bikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002924; x=1778607724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=54klkLtO1z981HVzGmd4prOw9eXZMZmqAEmK52seTfw=;
        b=eTyxACElWukNNRfTISzup/F7aw65C5zeoaCWAtyWEw6UeGCTFh7mBBmcWwEXSa12DY
         j3EfxkNlZJAGy1c0NCJPQNbspmVoCmbsOkiU/NdtUqOBvczfuIA2JqI9Tfo5G1GzRzTv
         hfUMMwcZfnLgliEC0gQAgyzUzLtLs6Uf141NeNcyGWV7LrThp4ZBbOm5Ffpjo+N+lYfu
         /MziD7sFWCz5dOnaoQOZ5uF3ZrJcyfmEV+EIcttBcfkDjsbSg9lbTpNwbwUfCqR3+sLU
         DhwTIE/1kyf2LWTuX2RBfppiVKE8cqQyOHLMr+tMAcQ+0ChP5LKv69OG3R1Pe3C2Sscm
         y27A==
X-Forwarded-Encrypted: i=1; AFNElJ+YXl8Zr81qcsZluFXGXT4mO85N1MnDicYqVY1G4Pe8hLPxuqeyCHdP1C6DidcfKguBkgm7+4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHSasr3O6iuuXIA5QbJKjiB7TLicfr/PiZIuMREqGjWWGPixms
	vdvAe8IJXFYxMaJYPOsxhfyYw8rUGkw/XI1ubXnvalK8/OJ67iRctmni/3yA6seyZetyYeJHcF4
	D2in+mtL23WVKYYo9tIhpnWBN2do/koaZy7xIi4EC
X-Gm-Gg: AeBDietzmcPdLCImKZ6l8DedbzCRuF/flc10vPxXl4xEDL3YIuOfz5GCoe6+87MDoht
	NU/0f5EPpBHcEmkNAU0Ds4cyeIc8uX7MlyiRcHQ5bTEBRB2rkrEPz/TKp1sS7C5SF8UCXAkUZgd
	dyXrWmFgBcc7YEkgnambffxbNik2gLm4qVelWFo8wmQpdg3fJi1JXYRSR0AXDcz+1C7LEX0GZqa
	PlatpLtfSidxH7K2Rpu025cqtqJQ4GzR3aG4MgXVOu9y5d/OsnHg04301zMZlC6HKHR6uRIH105
	n3XNLVEg/raryrikziUC9YekHjtTXlhkTe3NcsExlrVVS29cOS2ldgEeeaB/pG8L6tS0n8ffi4H
	kBHqSCjtKONT8mRueoM9z9V90Yd0=
X-Received: by 2002:a17:902:74c2:b0:294:ecba:c8e with SMTP id
 d9443c01a7336-2ba780a1488mr111905ad.3.1778002923640; Tue, 05 May 2026
 10:42:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504-tcp-dm-netkit-v2-0-56d52ac72fd4@meta.com> <20260504-tcp-dm-netkit-v2-1-56d52ac72fd4@meta.com>
In-Reply-To: <20260504-tcp-dm-netkit-v2-1-56d52ac72fd4@meta.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Tue, 5 May 2026 10:41:52 -0700
X-Gm-Features: AVHnY4JVYQoMkZPle2iQADTNvkeoWF6dMpqpqNjmlqRgreICUU5dyZus5I1HOgw
Message-ID: <CAEAWyHcLSE8YJXrjRx+fxjGPY=vL=C4fC44MiFwdUyRiDx1a3w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/6] net: add netmem_tx modes that indicate
 dma capability
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Joshua Washington <joshwash@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
	Mina Almasry <almasrymina@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 987A44D2467
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284538-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,meta.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Mon, May 4, 2026 at 5:27=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail.=
com> wrote:
>
> From: Bobby Eshleman <bobbyeshleman@meta.com>
>
> Devices that support netmem TX previously set dev->netmem_tx =3D true.
> This was checked in validate_xmit_unreadable_skb() to drop unreadable
> skbs (skbs with dmabuf-backed frags) before they reach drivers that
> would mishandle them or devices that would not have the iommu mappings
> for them.
>
> Some virtual devices like netkit (or ifb) never DMA and never touch frag
> contents, as they essentially just forward the skb to another device.
> They are unable to forward unreadable skbs, however, because they fail
> to pass TX validation checks on dev->netmem_tx. This single bit flag
> doesn't give the TX validator enough information to differentiate
> devices that will attempt DMA on the unreadable skb and those that will
> simply route it untouched.
>
> This patch fixes this issue by adding an additional bit to netmem_tx, so
> that drivers can indicate 1) if they have netmem support, and 2) if they
> do, are they DMA-capable or not?
>
> Replace the boolean with a 2-bit enum:
>
> NETMEM_TX_NONE   - no netmem TX support (drop unreadable skbs)
> NETMEM_TX_DMA    - full support, device does DMA
> NETMEM_TX_NO_DMA - pass-through, device never DMAs
>
> Update drivers to reflect these definitions. NIC drivers use
> NETMEM_TX_DMA, and netkit uses NETMEM_TX_NO_DMA.
>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
> Changes in v2:
> - Squash driver conversion patches (2-5) into patch 1 (Jakub)
> ---
>  Documentation/networking/net_cachelines/net_device.rst |  2 +-
>  Documentation/networking/netmem.rst                    |  8 +++++++-
>  Documentation/translations/zh_CN/networking/netmem.rst |  7 ++++++-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c              |  2 +-
>  drivers/net/ethernet/google/gve/gve_main.c             |  2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c      |  2 +-
>  drivers/net/ethernet/meta/fbnic/fbnic_netdev.c         |  2 +-
>  drivers/net/netkit.c                                   |  1 +
>  include/linux/netdevice.h                              | 11 +++++++++--
>  9 files changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Doc=
umentation/networking/net_cachelines/net_device.rst
> index 1c19bb7705df..c85784259544 100644
> --- a/Documentation/networking/net_cachelines/net_device.rst
> +++ b/Documentation/networking/net_cachelines/net_device.rst
> @@ -10,7 +10,7 @@ Type                                Name               =
         fastpath_tx_acce
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  unsigned_long:32                    priv_flags                  read_mos=
tly                             __dev_queue_xmit(tx)
>  unsigned_long:1                     lltx                        read_mos=
tly                             HARD_TX_LOCK,HARD_TX_TRYLOCK,HARD_TX_UNLOCK=
(tx)
> -unsigned long:1                     netmem_tx:1;                read_mos=
tly
> +unsigned long:2                     netmem_tx:2;                read_mos=
tly
>  char                                name[16]
>  struct netdev_name_node*            name_node
>  struct dev_ifalias*                 ifalias
> diff --git a/Documentation/networking/netmem.rst b/Documentation/networki=
ng/netmem.rst
> index b63aded46337..217869d1108d 100644
> --- a/Documentation/networking/netmem.rst
> +++ b/Documentation/networking/netmem.rst
> @@ -95,4 +95,10 @@ Driver TX Requirements
>     netdev@, or reach out to the maintainers and/or almasrymina@google.co=
m for
>     help adding the netmem API.
>
> -2. Driver should declare support by setting `netdev->netmem_tx =3D true`
> +2. Driver should declare support by setting `netdev->netmem_tx` to the
> +   appropriate mode:
> +
> +   - `NETMEM_TX_DMA`: for physical devices that perform DMA.
> +
> +   - `NETMEM_TX_NO_DMA`: for virtual or passthrough devices that do
> +     not DMA, but still support handling of netmem-backed skbs.
> diff --git a/Documentation/translations/zh_CN/networking/netmem.rst b/Doc=
umentation/translations/zh_CN/networking/netmem.rst
> index fe351a240f02..320f3eacf51b 100644
> --- a/Documentation/translations/zh_CN/networking/netmem.rst
> +++ b/Documentation/translations/zh_CN/networking/netmem.rst
> @@ -89,4 +89,9 @@ dma-mapping API =E5=8E=BB=E5=A4=84=E7=90=86=E3=80=82
>  =E4=BD=BF=E7=94=A8=E6=9F=90=E4=B8=AA=E8=BF=98=E4=B8=8D=E5=AD=98=E5=9C=A8=
=E7=9A=84 netmem API=EF=BC=8C=E4=BD=A0=E5=8F=AF=E4=BB=A5=E8=87=AA=E8=A1=8C=
=E6=B7=BB=E5=8A=A0=E5=B9=B6=E6=8F=90=E4=BA=A4=E5=88=B0 netdev@=EF=BC=8C=E4=
=B9=9F=E5=8F=AF=E4=BB=A5=E8=81=94=E7=B3=BB=E7=BB=B4=E6=8A=A4
>  =E4=BA=BA=E5=91=98=E6=88=96=E8=80=85=E5=8F=91=E9=80=81=E9=82=AE=E4=BB=B6=
=E8=87=B3 almasrymina@google.com =E5=AF=BB=E6=B1=82=E5=B8=AE=E5=8A=A9=E3=80=
=82
>
> -2. =E9=A9=B1=E5=8A=A8=E7=A8=8B=E5=BA=8F=E5=BA=94=E9=80=9A=E8=BF=87=E8=AE=
=BE=E7=BD=AE netdev->netmem_tx =3D true =E6=9D=A5=E8=A1=A8=E6=98=8E=E8=87=
=AA=E8=BA=AB=E6=94=AF=E6=8C=81 netmem =E5=8A=9F=E8=83=BD=E3=80=82
> +2. =E9=A9=B1=E5=8A=A8=E7=A8=8B=E5=BA=8F=E5=BA=94=E5=B0=86 `netdev->netme=
m_tx` =E8=AE=BE=E7=BD=AE=E4=B8=BA=E9=80=82=E5=BD=93=E7=9A=84=E6=A8=A1=E5=BC=
=8F=EF=BC=9A
> +
> +   - `NETMEM_TX_DMA`=EF=BC=9A=E9=80=82=E7=94=A8=E4=BA=8E=E6=89=A7=E8=A1=
=8C DMA =E7=9A=84=E7=89=A9=E7=90=86=E8=AE=BE=E5=A4=87=E3=80=82
> +
> +   - `NETMEM_TX_NO_DMA`=EF=BC=9A=E9=80=82=E7=94=A8=E4=BA=8E=E4=B8=8D=E6=
=89=A7=E8=A1=8C DMA =E7=9A=84=E8=99=9A=E6=8B=9F=E6=88=96=E9=80=8F=E4=BC=A0=
=E8=AE=BE=E5=A4=87=EF=BC=8C=E4=BD=86=E4=BB=8D=E6=94=AF=E6=8C=81
> +     =E5=A4=84=E7=90=86 netmem =E6=94=AF=E6=8C=81=E7=9A=84 skb=E3=80=82
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 8c55874f44ca..ed9c22dc4a5a 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -17120,7 +17120,7 @@ static int bnxt_init_one(struct pci_dev *pdev, co=
nst struct pci_device_id *ent)
>         dev->queue_mgmt_ops =3D &bnxt_queue_mgmt_ops_unsupp;
>         if (BNXT_SUPPORTS_QUEUE_API(bp))
>                 dev->queue_mgmt_ops =3D &bnxt_queue_mgmt_ops;
> -       dev->netmem_tx =3D true;
> +       dev->netmem_tx =3D NETMEM_TX_DMA;
>
>         rc =3D register_netdev(dev);
>         if (rc)
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 424d973c97f2..dd2b8f087163 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -2894,7 +2894,7 @@ static int gve_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *ent)
>                 goto abort_with_wq;
>
>         if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
> -               dev->netmem_tx =3D true;
> +               dev->netmem_tx =3D NETMEM_TX_DMA;

Acked-by: Harshitha Ramamurthy <hramamurthy@google.com>

>
>         err =3D register_netdev(dev);
>         if (err)
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_main.c
> index 5a46870c4b74..fc49aae38807 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -5924,7 +5924,7 @@ static void mlx5e_build_nic_netdev(struct net_devic=
e *netdev)
>
>         netdev->priv_flags       |=3D IFF_UNICAST_FLT;
>
> -       netdev->netmem_tx =3D true;
> +       netdev->netmem_tx =3D NETMEM_TX_DMA;
>
>         netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
>         mlx5e_set_xdp_feature(priv);
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net=
/ethernet/meta/fbnic/fbnic_netdev.c
> index c406a3b56b37..138e522ef9b9 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> @@ -752,7 +752,7 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_de=
v *fbd)
>         netdev->netdev_ops =3D &fbnic_netdev_ops;
>         netdev->stat_ops =3D &fbnic_stat_ops;
>         netdev->queue_mgmt_ops =3D &fbnic_queue_mgmt_ops;
> -       netdev->netmem_tx =3D true;
> +       netdev->netmem_tx =3D NETMEM_TX_DMA;
>
>         fbnic_set_ethtool_ops(netdev);
>
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index 5e2eecc3165d..0ad6a806d7d5 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -466,6 +466,7 @@ static void netkit_setup(struct net_device *dev)
>         dev->priv_flags |=3D IFF_NO_QUEUE;
>         dev->priv_flags |=3D IFF_DISABLE_NETPOLL;
>         dev->lltx =3D true;
> +       dev->netmem_tx =3D NETMEM_TX_NO_DMA;
>
>         dev->netdev_ops     =3D &netkit_netdev_ops;
>         dev->ethtool_ops    =3D &netkit_ethtool_ops;
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0e1e581efc5a..11d68e75eb4f 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1788,6 +1788,12 @@ enum netdev_stat_type {
>         NETDEV_PCPU_STAT_DSTATS, /* struct pcpu_dstats */
>  };
>
> +enum netmem_tx_mode {
> +       NETMEM_TX_NONE,         /* no netmem TX support */
> +       NETMEM_TX_DMA,          /* DMA-capable netmem TX (real HW) */
> +       NETMEM_TX_NO_DMA,       /* no DMA, e.g. passthrough for virtual d=
evs */
> +};
> +
>  enum netdev_reg_state {
>         NETREG_UNINITIALIZED =3D 0,
>         NETREG_REGISTERED,      /* completed register_netdevice */
> @@ -1809,7 +1815,8 @@ enum netdev_reg_state {
>   *     @lltx:          device supports lockless Tx. Deprecated for real =
HW
>   *                     drivers. Mainly used by logical interfaces, such =
as
>   *                     bonding and tunnels
> - *     @netmem_tx:     device support netmem_tx.
> + *     @netmem_tx:     device netmem TX mode (NETMEM_TX_NONE, NETMEM_TX_=
DMA,
> + *                     or NETMEM_TX_NO_DMA).
>   *
>   *     @name:  This is the first field of the "visible" part of this str=
ucture
>   *             (i.e. as seen by users in the "Space.c" file).  It is the=
 name
> @@ -2132,7 +2139,7 @@ struct net_device {
>         struct_group(priv_flags_fast,
>                 unsigned long           priv_flags:32;
>                 unsigned long           lltx:1;
> -               unsigned long           netmem_tx:1;
> +               unsigned long           netmem_tx:2;
>         );
>         const struct net_device_ops *netdev_ops;
>         const struct header_ops *header_ops;
>
> --
> 2.52.0
>


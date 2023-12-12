Return-Path: <netdev+bounces-56286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F11F80E6A3
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 09:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78A3EB20EA7
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 08:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EAC22338;
	Tue, 12 Dec 2023 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bPzrye0A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275F4AC
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 00:49:45 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50bf1e32571so6353906e87.2
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 00:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1702370983; x=1702975783; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t23bo+wqyqR9zWT24pzOL1SMzsSHVUAk+MEyaVnCdbM=;
        b=bPzrye0AhzeVUriBSrV4E8mDlHOkyzoOL5h/9fXUNr1LLVV2tyD/4GzQqBzvGRIQmV
         e2yvNLqMkW94InVWarQaB55KfpSLxg4tPiijJRbFrKQACh+GmdKNB7Kvt8iZ3ootAq+r
         aOSXIuJaBojM37jOTCvOMO85RUULW3e5hBkww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702370983; x=1702975783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t23bo+wqyqR9zWT24pzOL1SMzsSHVUAk+MEyaVnCdbM=;
        b=Wbsf+KTcV+U6rSDKJwPy8kJ+Gfwqjj/Mrx1Pws5/JtXRavzRIpzR8IwT5Wf0oUqpG4
         dtTeNiUoV1c2ZX3Hv3cR2qB8N6w7TbN9ooQQh9onVN4Pfh9sxmJ2w2l/GaKnqWDaR/MV
         iHOE4EM/3A5SfMdQ2t/6IspjEATdqn5zNz5RQw9vr+XCuz48zCT3bS9hLWWMUERuVWs1
         da1oXhgDWgMAWMhcUQfCizeCEBm6w5NAa7cpuNw+w1kI/nmS9XujzEm4KQn3SzlMO0C0
         4qiZv8suhcKMgETHnG/oTRrpTSsoDzkDyf0RGp5DuA19vKMivKk/0UC0Jz1KZuMMkWW9
         Jvqg==
X-Gm-Message-State: AOJu0YztqUTXTcKKMHZ1HBvGe4lSyc4jEH+0WzPLgFE9m1sSiu/Utiu7
	R8es4bB1ROQrNrtD6mQ/wN1M89VjEgxGfULgcfKRN9o8uYw5AxAR
X-Google-Smtp-Source: AGHT+IH/rhN6UnK2mX3WIM8hfkXJKxSQzviCwQtTrtuV+MdVikl4Ap55CBkq6e5TDCBSZvbxuGXHN9hC//6q4tHKzrQ=
X-Received: by 2002:a05:6512:15a0:b0:50b:f05b:3e0c with SMTP id
 bp32-20020a05651215a000b0050bf05b3e0cmr2948225lfb.79.1702370983294; Tue, 12
 Dec 2023 00:49:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212053723.443772-1-Raju.Rangoju@amd.com> <20231212053723.443772-2-Raju.Rangoju@amd.com>
In-Reply-To: <20231212053723.443772-2-Raju.Rangoju@amd.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 12 Dec 2023 14:19:28 +0530
Message-ID: <CAH-L+nNibQiJhXUF74Q_r=GTgWin1Uv6RB=MuTAAwkpJABbyCg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/3] amd-xgbe: reorganize the code of XPCS access
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Shyam-sundar.S-k@amd.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c1f53a060c4c218d"

--000000000000c1f53a060c4c218d
Content-Type: multipart/alternative; boundary="000000000000bc8c08060c4c2133"

--000000000000bc8c08060c4c2133
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 11:08=E2=80=AFAM Raju Rangoju <Raju.Rangoju@amd.com=
> wrote:

> The xgbe_{read/write}_mmd_regs_v* functions have common code which can
> be moved to helper functions. Also, the xgbe_pci_probe() needs
> reorganization.
>
> Add new helper functions to calculate the mmd_address for v1/v2 of xpcs
> access. And, convert if/else statements in xgbe_pci_probe() to switch
> case. This helps code look cleaner.
>
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 43 ++++++++++++------------
>  drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 18 +++++++---
>  2 files changed, 34 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> index f393228d41c7..6cd003c24a64 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> @@ -1150,6 +1150,21 @@ static int xgbe_set_gpio(struct xgbe_prv_data
> *pdata, unsigned int gpio)
>         return 0;
>  }
>
> +static unsigned int get_mmd_address(struct xgbe_prv_data *pdata, int
> mmd_reg)
> +{
> +       return (mmd_reg & XGBE_ADDR_C45) ?
> +               mmd_reg & ~XGBE_ADDR_C45 :
> +               (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
> +}
> +
> +static unsigned int get_index_offset(struct xgbe_prv_data *pdata,
> unsigned int mmd_address,
> +                                    unsigned int *index)
> +{
> +       mmd_address <<=3D 1;
> +       *index =3D mmd_address & ~pdata->xpcs_window_mask;
> +       return pdata->xpcs_window + (mmd_address &
> pdata->xpcs_window_mask);
> +}
> +
>  static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>                                  int mmd_reg)
>  {
> @@ -1157,10 +1172,7 @@ static int xgbe_read_mmd_regs_v2(struct
> xgbe_prv_data *pdata, int prtad,
>         unsigned int mmd_address, index, offset;
>         int mmd_data;
>
> -       if (mmd_reg & XGBE_ADDR_C45)
> -               mmd_address =3D mmd_reg & ~XGBE_ADDR_C45;
> -       else
> -               mmd_address =3D (pdata->mdio_mmd << 16) | (mmd_reg & 0xff=
ff);
> +       mmd_address =3D get_mmd_address(pdata, mmd_reg);
>
>         /* The PCS registers are accessed using mmio. The underlying
>          * management interface uses indirect addressing to access the MM=
D
> @@ -1171,9 +1183,7 @@ static int xgbe_read_mmd_regs_v2(struct
> xgbe_prv_data *pdata, int prtad,
>          * register offsets must therefore be adjusted by left shifting t=
he
>          * offset 1 bit and reading 16 bits of data.
>          */
> -       mmd_address <<=3D 1;
> -       index =3D mmd_address & ~pdata->xpcs_window_mask;
> -       offset =3D pdata->xpcs_window + (mmd_address &
> pdata->xpcs_window_mask);
> +       offset =3D get_index_offset(pdata, mmd_address, &index);
>
>         spin_lock_irqsave(&pdata->xpcs_lock, flags);
>         XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
> @@ -1189,10 +1199,7 @@ static void xgbe_write_mmd_regs_v2(struct
> xgbe_prv_data *pdata, int prtad,
>         unsigned long flags;
>         unsigned int mmd_address, index, offset;
>
> -       if (mmd_reg & XGBE_ADDR_C45)
> -               mmd_address =3D mmd_reg & ~XGBE_ADDR_C45;
> -       else
> -               mmd_address =3D (pdata->mdio_mmd << 16) | (mmd_reg & 0xff=
ff);
> +       mmd_address =3D get_mmd_address(pdata, mmd_reg);
>
>         /* The PCS registers are accessed using mmio. The underlying
>          * management interface uses indirect addressing to access the MM=
D
> @@ -1203,9 +1210,7 @@ static void xgbe_write_mmd_regs_v2(struct
> xgbe_prv_data *pdata, int prtad,
>          * register offsets must therefore be adjusted by left shifting t=
he
>          * offset 1 bit and writing 16 bits of data.
>          */
> -       mmd_address <<=3D 1;
> -       index =3D mmd_address & ~pdata->xpcs_window_mask;
> -       offset =3D pdata->xpcs_window + (mmd_address &
> pdata->xpcs_window_mask);
> +       offset =3D get_index_offset(pdata, mmd_address, &index);
>
>         spin_lock_irqsave(&pdata->xpcs_lock, flags);
>         XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
> @@ -1220,10 +1225,7 @@ static int xgbe_read_mmd_regs_v1(struct
> xgbe_prv_data *pdata, int prtad,
>         unsigned int mmd_address;
>         int mmd_data;
>
> -       if (mmd_reg & XGBE_ADDR_C45)
> -               mmd_address =3D mmd_reg & ~XGBE_ADDR_C45;
> -       else
> -               mmd_address =3D (pdata->mdio_mmd << 16) | (mmd_reg & 0xff=
ff);
> +       mmd_address =3D get_mmd_address(pdata, mmd_reg);
>
>         /* The PCS registers are accessed using mmio. The underlying APB3
>          * management interface uses indirect addressing to access the MM=
D
> @@ -1248,10 +1250,7 @@ static void xgbe_write_mmd_regs_v1(struct
> xgbe_prv_data *pdata, int prtad,
>         unsigned int mmd_address;
>         unsigned long flags;
>
> -       if (mmd_reg & XGBE_ADDR_C45)
> -               mmd_address =3D mmd_reg & ~XGBE_ADDR_C45;
> -       else
> -               mmd_address =3D (pdata->mdio_mmd << 16) | (mmd_reg & 0xff=
ff);
> +       mmd_address =3D get_mmd_address(pdata, mmd_reg);
>
>         /* The PCS registers are accessed using mmio. The underlying APB3
>          * management interface uses indirect addressing to access the MM=
D
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> index f409d7bd1f1e..8b0c1e450b7e 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> @@ -274,12 +274,18 @@ static int xgbe_pci_probe(struct pci_dev *pdev,
> const struct pci_device_id *id)
>
>         /* Set the PCS indirect addressing definition registers */
>         rdev =3D pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> -       if (rdev &&
> -           (rdev->vendor =3D=3D PCI_VENDOR_ID_AMD) && (rdev->device =3D=
=3D
> 0x15d0)) {
> +
> +       if (!(rdev && rdev->vendor =3D=3D PCI_VENDOR_ID_AMD)) {
> +               ret =3D -ENODEV;
> +               goto err_pci_enable;
> +       }
> +
> +       switch (rdev->device) {
> +       case 0x15d0:
>                 pdata->xpcs_window_def_reg =3D PCS_V2_RV_WINDOW_DEF;
>                 pdata->xpcs_window_sel_reg =3D PCS_V2_RV_WINDOW_SELECT;
> -       } else if (rdev && (rdev->vendor =3D=3D PCI_VENDOR_ID_AMD) &&
> -                  (rdev->device =3D=3D 0x14b5)) {
> +               break;
> +       case 0x14b5:
>
[Kalesh]: Can you use macros for 0x15d0 and 0x14b5

>                 pdata->xpcs_window_def_reg =3D PCS_V2_YC_WINDOW_DEF;
>                 pdata->xpcs_window_sel_reg =3D PCS_V2_YC_WINDOW_SELECT;
>
> @@ -288,9 +294,11 @@ static int xgbe_pci_probe(struct pci_dev *pdev, cons=
t
> struct pci_device_id *id)
>
>                 /* Yellow Carp devices do not need rrc */
>                 pdata->vdata->enable_rrc =3D 0;
> -       } else {
> +               break;
> +       default:
>                 pdata->xpcs_window_def_reg =3D PCS_V2_WINDOW_DEF;
>                 pdata->xpcs_window_sel_reg =3D PCS_V2_WINDOW_SELECT;
> +               break;
>         }
>         pci_dev_put(rdev);
>
> --
> 2.34.1
>
>
>

--=20
Regards,
Kalesh A P

--000000000000bc8c08060c4c2133
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 12, 2023 at 11:08=E2=80=
=AFAM Raju Rangoju &lt;<a href=3D"mailto:Raju.Rangoju@amd.com">Raju.Rangoju=
@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">The xgbe_{read/write}_mmd_regs_v* functions have common code which =
can<br>
be moved to helper functions. Also, the xgbe_pci_probe() needs<br>
reorganization.<br>
<br>
Add new helper functions to calculate the mmd_address for v1/v2 of xpcs<br>
access. And, convert if/else statements in xgbe_pci_probe() to switch<br>
case. This helps code look cleaner.<br>
<br>
Signed-off-by: Raju Rangoju &lt;<a href=3D"mailto:Raju.Rangoju@amd.com" tar=
get=3D"_blank">Raju.Rangoju@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 43 ++++++++++++-----------=
-<br>
=C2=A0drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 18 +++++++---<br>
=C2=A02 files changed, 34 insertions(+), 27 deletions(-)<br>
<br>
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/etherne=
t/amd/xgbe/xgbe-dev.c<br>
index f393228d41c7..6cd003c24a64 100644<br>
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c<br>
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c<br>
@@ -1150,6 +1150,21 @@ static int xgbe_set_gpio(struct xgbe_prv_data *pdata=
, unsigned int gpio)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
+static unsigned int get_mmd_address(struct xgbe_prv_data *pdata, int mmd_r=
eg)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return (mmd_reg &amp; XGBE_ADDR_C45) ?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmd_reg &amp; ~XGBE=
_ADDR_C45 :<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(pdata-&gt;mdio_mmd=
 &lt;&lt; 16) | (mmd_reg &amp; 0xffff);<br>
+}<br>
+<br>
+static unsigned int get_index_offset(struct xgbe_prv_data *pdata, unsigned=
 int mmd_address,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int *index)<b=
r>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mmd_address &lt;&lt;=3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*index =3D mmd_address &amp; ~pdata-&gt;xpcs_wi=
ndow_mask;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return pdata-&gt;xpcs_window + (mmd_address &am=
p; pdata-&gt;xpcs_window_mask);<br>
+}<br>
+<br>
=C2=A0static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prt=
ad,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int mmd_reg)<br>
=C2=A0{<br>
@@ -1157,10 +1172,7 @@ static int xgbe_read_mmd_regs_v2(struct xgbe_prv_dat=
a *pdata, int prtad,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int mmd_address, index, offset;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int mmd_data;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mmd_reg &amp; XGBE_ADDR_C45)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmd_address =3D mmd=
_reg &amp; ~XGBE_ADDR_C45;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmd_address =3D (pd=
ata-&gt;mdio_mmd &lt;&lt; 16) | (mmd_reg &amp; 0xffff);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mmd_address =3D get_mmd_address(pdata, mmd_reg)=
;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The PCS registers are accessed using mmio. T=
he underlying<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* management interface uses indirect addr=
essing to access the MMD<br>
@@ -1171,9 +1183,7 @@ static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data=
 *pdata, int prtad,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* register offsets must therefore be adju=
sted by left shifting the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* offset 1 bit and reading 16 bits of dat=
a.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0mmd_address &lt;&lt;=3D 1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0index =3D mmd_address &amp; ~pdata-&gt;xpcs_win=
dow_mask;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0offset =3D pdata-&gt;xpcs_window + (mmd_address=
 &amp; pdata-&gt;xpcs_window_mask);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0offset =3D get_index_offset(pdata, mmd_address,=
 &amp;index);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock_irqsave(&amp;pdata-&gt;xpcs_lock, fla=
gs);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 XPCS32_IOWRITE(pdata, pdata-&gt;xpcs_window_sel=
_reg, index);<br>
@@ -1189,10 +1199,7 @@ static void xgbe_write_mmd_regs_v2(struct xgbe_prv_d=
ata *pdata, int prtad,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long flags;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int mmd_address, index, offset;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mmd_reg &amp; XGBE_ADDR_C45)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmd_address =3D mmd=
_reg &amp; ~XGBE_ADDR_C45;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmd_address =3D (pd=
ata-&gt;mdio_mmd &lt;&lt; 16) | (mmd_reg &amp; 0xffff);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mmd_address =3D get_mmd_address(pdata, mmd_reg)=
;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The PCS registers are accessed using mmio. T=
he underlying<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* management interface uses indirect addr=
essing to access the MMD<br>
@@ -1203,9 +1210,7 @@ static void xgbe_write_mmd_regs_v2(struct xgbe_prv_da=
ta *pdata, int prtad,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* register offsets must therefore be adju=
sted by left shifting the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* offset 1 bit and writing 16 bits of dat=
a.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0mmd_address &lt;&lt;=3D 1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0index =3D mmd_address &amp; ~pdata-&gt;xpcs_win=
dow_mask;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0offset =3D pdata-&gt;xpcs_window + (mmd_address=
 &amp; pdata-&gt;xpcs_window_mask);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0offset =3D get_index_offset(pdata, mmd_address,=
 &amp;index);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock_irqsave(&amp;pdata-&gt;xpcs_lock, fla=
gs);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 XPCS32_IOWRITE(pdata, pdata-&gt;xpcs_window_sel=
_reg, index);<br>
@@ -1220,10 +1225,7 @@ static int xgbe_read_mmd_regs_v1(struct xgbe_prv_dat=
a *pdata, int prtad,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int mmd_address;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int mmd_data;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mmd_reg &amp; XGBE_ADDR_C45)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmd_address =3D mmd=
_reg &amp; ~XGBE_ADDR_C45;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmd_address =3D (pd=
ata-&gt;mdio_mmd &lt;&lt; 16) | (mmd_reg &amp; 0xffff);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mmd_address =3D get_mmd_address(pdata, mmd_reg)=
;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The PCS registers are accessed using mmio. T=
he underlying APB3<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* management interface uses indirect addr=
essing to access the MMD<br>
@@ -1248,10 +1250,7 @@ static void xgbe_write_mmd_regs_v1(struct xgbe_prv_d=
ata *pdata, int prtad,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int mmd_address;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long flags;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mmd_reg &amp; XGBE_ADDR_C45)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmd_address =3D mmd=
_reg &amp; ~XGBE_ADDR_C45;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmd_address =3D (pd=
ata-&gt;mdio_mmd &lt;&lt; 16) | (mmd_reg &amp; 0xffff);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mmd_address =3D get_mmd_address(pdata, mmd_reg)=
;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The PCS registers are accessed using mmio. T=
he underlying APB3<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* management interface uses indirect addr=
essing to access the MMD<br>
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/etherne=
t/amd/xgbe/xgbe-pci.c<br>
index f409d7bd1f1e..8b0c1e450b7e 100644<br>
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c<br>
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c<br>
@@ -274,12 +274,18 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const=
 struct pci_device_id *id)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set the PCS indirect addressing definition r=
egisters */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rdev =3D pci_get_domain_bus_and_slot(0, 0, PCI_=
DEVFN(0, 0));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rdev &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(rdev-&gt;vendor =3D=3D PCI_VENDO=
R_ID_AMD) &amp;&amp; (rdev-&gt;device =3D=3D 0x15d0)) {<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(rdev &amp;&amp; rdev-&gt;vendor =3D=3D PC=
I_VENDOR_ID_AMD)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -ENODEV;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_pci_enable=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (rdev-&gt;device) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x15d0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdata-&gt;xpcs_wind=
ow_def_reg =3D PCS_V2_RV_WINDOW_DEF;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdata-&gt;xpcs_wind=
ow_sel_reg =3D PCS_V2_RV_WINDOW_SELECT;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (rdev &amp;&amp; (rdev-&gt;vendor =3D=
=3D PCI_VENDOR_ID_AMD) &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (rdev-&gt;d=
evice =3D=3D 0x14b5)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x14b5:<br></blockquote><div>[Kalesh]: Can=
 you use macros for 0x15d0 and 0x14b5=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdata-&gt;xpcs_wind=
ow_def_reg =3D PCS_V2_YC_WINDOW_DEF;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdata-&gt;xpcs_wind=
ow_sel_reg =3D PCS_V2_YC_WINDOW_SELECT;<br>
<br>
@@ -288,9 +294,11 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const =
struct pci_device_id *id)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Yellow Carp devi=
ces do not need rrc */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdata-&gt;vdata-&gt=
;enable_rrc =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdata-&gt;xpcs_wind=
ow_def_reg =3D PCS_V2_WINDOW_DEF;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdata-&gt;xpcs_wind=
ow_sel_reg =3D PCS_V2_WINDOW_SELECT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_dev_put(rdev);<br>
<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Regards,<div>Kalesh A P</div></div></div></div>

--000000000000bc8c08060c4c2133--

--000000000000c1f53a060c4c218d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIJDJTJXRajCg8X1P9JR5irIETSFI/y4AGvpECYBwPNQpMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIxMjA4NDk0M1owaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCftCTNtrKj
k64bZdZzhigG4SWBUmrzBerqM+EA+2Iuy0ghs1yXTWtdiGyp4eiznMck/+aHmVa0q/5fQtLZ0YZM
oJytPaSfFP1Stj9Rx9lL3CWXXcMEkZUpQpaZ+jhAtqhpH2yT3PbFUXYXo7Qn+vcReBzko0aOXAPr
uSHi2CISPCzD4QeFgd5YMu4GyzxUVVpGuf4JdqXnn79lw7a79J2Z8SI2YTAcgtySpIx21CJU+QjX
sr94l/kk4TwfzOKHRnn9BfN9Qc0NsbcZnlq98lU16OQarh+KIUinikKNV7oDN8POFoQ9R86u3fvn
u0AizwZaQCpj/rGJF2QSJkv199dD
--000000000000c1f53a060c4c218d--


Return-Path: <netdev+bounces-277170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAjPAFQx2GmqZggAu9opvQ
	(envelope-from <netdev+bounces-277170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 01:08:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4B73D06F0
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 01:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10C29300FC4F
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 23:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E733039E6F1;
	Thu,  9 Apr 2026 23:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UbCc1IDn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E3A39E182
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 23:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775776080; cv=pass; b=kNxTIEOrS4q2SxB4zitgN8P8T8HSmF/P+t7VHdxGUe6h3xg7cNMNvGpycGzosL7PNkUPkMRj/6QQw0Hb//NqPBYJQLgr/aSXb7g66pAfm7GlutAm2t0dVXkv4gYO0A5OzrChu48xRap18eg/9ipeHuhoWkDLaGS4s4zA1Az6zcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775776080; c=relaxed/simple;
	bh=acTimuHBNxPCfsyA6p9BACQIbGLSHBBJA9MF4dPk2O8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHt6eoOupKNuztL/grf64wvrjqzb0xQfLC+FnRPPxu1qUnS65Ksh1snJZv7ryIeXrw0Vqeh2limDdxxmdFnntwrK+m0PmqtHMnIK6ayI3kPTik03ooxdKBsrVMb5+bTKvuQE5ELTNueRPSuYOD7D9HuxZ8dhRFgkph5Av41HRcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UbCc1IDn; arc=pass smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-82cf636dac8so768652b3a.3
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 16:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775776078; x=1776380878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2yiJPXFfC1Hk+2wpY/NCaVKKYqGAEcjqa+CF9HNvoo=;
        b=Zykp9VXEdP6l2w3QVBSUslRVqLbBr/XnaGRTmjLJBV6jzGtEoM6vPZFlaDl13bzbF1
         dAbmGdXJX/p+ixam0ZfocO/dwslf60QgMDiKlEVuiI53fPKttLPTXpTTY32jZmIu/z8w
         nVAGd/wspvWEXQXGbA2pGS66JTThd3soTyoWz7zSlmnDJfn0zVOhZLxRvj22a2HhO/oW
         8vT/Iq6pSI3JjagU/ypOKUOs2j0xuEVl2AlKKpj7GZ3DU1vE6TaBBewAUvKB6julsXgX
         jS4JAPN6xHYb5ojtCfLq+aWZqezQEuXk91KE3dvje1RUdn1/iX7q8AiWoBst4AH9WBX7
         0Uhw==
X-Forwarded-Encrypted: i=2; AJvYcCXBPgxhPS3eYrO+PH1+i9XtusbpusB1GePvybIgx/CkjKDcIUDH0mn7A1uyXm+8j+NR2lOa6wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ59QH630081ozvFoBqFgdteny6J+uQJU01DpuuwTGageVM7Ne
	V6e4ePNADx3SJ4S2pe1lQFuL/Ouv5L4vI1i/ssyYtDb+WeeKAFs5+dWFujIXbj68DPVQY4E0uqb
	i//KgbWRq4+BhoFawFBf5hr1DtjtZ1wE3lpAxyk1HTy1SEvq83+cYV8v4NAVC5twRsyHy4kCV4j
	AB8K0yns8mQK1HYSkH/Gdj1v5p+tr686dc29kVIQZtt0NCKAjISC4x5Ckh4r1/2+gzZL8nxeHvs
	WOnJGC3alXVahQSeg==
X-Gm-Gg: AeBDies5BHUMe81AgEWAGDefVV47/Hz050bdhfe61rwja3zJ7nbch9u3irjdwvaDewd
	CncBdHV8pM/05rQ4CmBZg+fLBYNAMHV7xfbkm224EscTxzbCk84lSwjeu7buMT5Qo37RaMX873h
	cLRK8WSO1Nx3nWNfi+CQjSjhaVMM6prCaCKqK7xyITeoWbw9LRA/9Y0BzMw+4OYUes6k4y+/8nR
	VbPVxNKu/bbZG97PkhzzUpXwnFfPgoJIPO2lsCABcrIRBJs7/Yw6q3HqtEIrEf7qEvW/N25qALa
	Dc58E4Ib+iWWZaO/qaS9rQHZTr84yM4nQUMbSY0E3WkJ01YTOrNLBXIrmvi5p+lhWpXPwhJLRJJ
	OBfxr6+h9dqWNtjNb6bF0EtTr7zQ9bRBGq/+Rp52dz/v2ota/8ZyDSkDnLp+Y07UtCcVLGVrDGi
	MYz30KxTlKi4Qb2PSndEyPwymhCynIyb/zycKfSNdsp67GJmYK1xSpNWYJayzZu+A=
X-Received: by 2002:a05:6a21:6d86:b0:39c:1f90:2866 with SMTP id adf61e73a8af0-39fe4093018mr737685637.54.1775776077999;
        Thu, 09 Apr 2026 16:07:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c792192dddfsm47283a12.3.2026.04.09.16.07.57
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2026 16:07:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d177fb157so1403156f8f.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 16:07:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775776076; cv=none;
        d=google.com; s=arc-20240605;
        b=EUM1THH8PF4+AAp+zFzwZjj7cG88iF5H/pT678F3ODmHyqAaVRSZAD/sgWDxnsuwwI
         g/iMKr80sFIKrBgBW2NP/AlEgID98m4pFTBIenHLZMpYFAYwECagKVRgHyQRIMranMqU
         2xqNd4lAUmp9JKsv7S03MLMmbKh3EsiqcOU0Y7A6a/W+Z56hTrexiAFSvgIz6a9HKsAf
         PfaptXKCho4USkM6GA6B0jIgMIukQGQ+W8ovp1iWCI5FS5/X1Bd8d5r/a+UJhrmko6dx
         5HGA+vxHUb9IV554SGIsezUxaSPkhLqI2qvIas/PIBYhAff6X5gxOZxh6EYioRRv058t
         I8qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+2yiJPXFfC1Hk+2wpY/NCaVKKYqGAEcjqa+CF9HNvoo=;
        fh=F4pl+Zp68582Sv1aIGyuw8BixIqRcVkjLRRCg1hrpWU=;
        b=cuGLDp+UupCEloijn0s5ePtqmaMex0D3reGda40VZZ6vKJvH524gCW1rw2lR9fdMQZ
         pi4QyK7BFeaDF0SkJTEWWZOyYxurP32dQA5ojmgEuCkZT79TQcUY7wWoss0tV1A7EtLy
         OsEMaHvrrwPQDXQUwdz1bP1qraT6N57D7k6mtXY4RvE0NSxVP1C7OcsRYN9BNMTk7fpB
         TjAii1lS0Oprc/zv2uv8kSGRnUqw8h+hTDTcTjTo3AvesRSYr2qmo5ICp58AyexWr/JZ
         HrKLENA0cb1YpbTEEN3fWaRxUsYcXTg571RzqMlFb2LP/pCN/K4zdR7r9kzMATZvChXm
         aIGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775776076; x=1776380876; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+2yiJPXFfC1Hk+2wpY/NCaVKKYqGAEcjqa+CF9HNvoo=;
        b=UbCc1IDnnwkAJeQnCCpFsbeV6m8TQmIqcn9zw60k3xcmi1C5iU6EnyS3peuEjatHJW
         E1RLBnIAzaSCexNdIAhVYVZUklG8muoNjAStoo+TkbbCQHYaixmM1Xma2eADrFvd5gU+
         CmLJ5CBdbcSlAcWF8iZLfNSdTKZdv5ipMRPls=
X-Forwarded-Encrypted: i=1; AJvYcCWZ4aMRYpbedtGxwLBNRrXk7sTCcyDngx/vwZaRmNRmE/Kg/aDVB3Obnl8F0ovvRyelrvMY18w=@vger.kernel.org
X-Received: by 2002:a05:6000:2408:b0:43d:1c75:db70 with SMTP id ffacd0b85a97d-43d642537a8mr1160267f8f.15.1775776075725;
        Thu, 09 Apr 2026 16:07:55 -0700 (PDT)
X-Received: by 2002:a05:6000:2408:b0:43d:1c75:db70 with SMTP id
 ffacd0b85a97d-43d642537a8mr1160236f8f.15.1775776075250; Thu, 09 Apr 2026
 16:07:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adYfPBHsXxQUsMyr@shell.armlinux.org.uk> <E1wAPBR-0000000F7ju-1fD9@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1wAPBR-0000000F7ju-1fD9@rmk-PC.armlinux.org.uk>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Thu, 9 Apr 2026 16:07:42 -0700
X-Gm-Features: AQROBzCWB9VUvQ4RpL1EJYfajIJ7yfPJs9yk-WkOxw3bptp81Ttc8d621uiKtaQ
Message-ID: <CAMdnO-+TK65AxjTsDd017Mhop+VC3Xf8jtfaTXYpE6wBNZOt4g@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 02/10] net: stmmac: rename dev_id to userver
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Chen-Yu Tsai <wens@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, 
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Samuel Holland <samuel@sholland.org>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000037b2b8064f0f1663"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277170-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jitendra.vegiraju@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 5E4B73D06F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000037b2b8064f0f1663
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Russell,

On Wed, Apr 8, 2026 at 2:27=E2=80=AFAM Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:
>
> The Synopsys Databook and several implementation TRMs identify bits
> 15:8 of the version register in dwmac v3.xx and v4.xx as "userver".
> We even print its value with "User ID". Rather than using "dev_id",
> use "userver" instead.
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/hwif.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/eth=
ernet/stmicro/stmmac/hwif.c
> index 3774af66db48..830ff816ab4f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> @@ -15,7 +15,7 @@
>
>  struct stmmac_version {
>         u8 snpsver;
> -       u8 dev_id;
> +       u8 userver;
>  };
From the XGMAC databook that I have access to bits(15:8) identify the
DEVID field of MAC_version register.
The userver field is from bits(23:16) of the same register. This is a
customer defined field (configured with coreConsultant).
Currently stmmac doesn't care about bits(23:16).

I think the confusion is coming from macro name in common.h
#define DWMAC_USERVER   GENMASK_U32(15, 8)
This should be named
#define DWMAC_DEVID   GENMASK_U32(15, 8)
Hope someone with access to another databook can confirm this.

>
>  static void stmmac_get_version(struct stmmac_priv *priv,
> @@ -26,7 +26,7 @@ static void stmmac_get_version(struct stmmac_priv *priv=
,
>         u32 version;
>
>         ver->snpsver =3D 0;
> -       ver->dev_id =3D 0;
> +       ver->userver =3D 0;
>
>         if (core_type =3D=3D DWMAC_CORE_MAC100)
>                 return;
> @@ -48,7 +48,7 @@ static void stmmac_get_version(struct stmmac_priv *priv=
,
>
>         ver->snpsver =3D FIELD_GET(DWMAC_SNPSVER, version);
>         if (core_type =3D=3D DWMAC_CORE_XGMAC)
> -               ver->dev_id =3D FIELD_GET(DWMAC_USERVER, version);
> +               ver->userver =3D FIELD_GET(DWMAC_USERVER, version);
>  }
>
>  static void stmmac_dwmac_mode_quirk(struct stmmac_priv *priv)
> @@ -111,7 +111,7 @@ int stmmac_reset(struct stmmac_priv *priv)
>  static const struct stmmac_hwif_entry {
>         enum dwmac_core_type core_type;
>         u32 min_snpsver;
> -       u32 dev_id;
> +       u32 userver;
>         const struct stmmac_regs_off regs;
>         const void *desc;
>         const void *dma;
> @@ -247,7 +247,7 @@ static const struct stmmac_hwif_entry {
>         }, {
>                 .core_type =3D DWMAC_CORE_XGMAC,
>                 .min_snpsver =3D DWXGMAC_CORE_2_10,
> -               .dev_id =3D DWXGMAC_ID,
> +               .userver =3D DWXGMAC_ID,
>                 .regs =3D {
>                         .ptp_off =3D PTP_XGMAC_OFFSET,
>                         .mmc_off =3D MMC_XGMAC_OFFSET,
> @@ -269,7 +269,7 @@ static const struct stmmac_hwif_entry {
>         }, {
>                 .core_type =3D DWMAC_CORE_XGMAC,
>                 .min_snpsver =3D DWXLGMAC_CORE_2_00,
> -               .dev_id =3D DWXLGMAC_ID,
> +               .userver =3D DWXLGMAC_ID,
>                 .regs =3D {
>                         .ptp_off =3D PTP_XGMAC_OFFSET,
>                         .mmc_off =3D MMC_XGMAC_OFFSET,
> @@ -291,7 +291,7 @@ static const struct stmmac_hwif_entry {
>  };
>
>  static const struct stmmac_hwif_entry *
> -stmmac_hwif_find(enum dwmac_core_type core_type, u8 snpsver, u8 dev_id)
> +stmmac_hwif_find(enum dwmac_core_type core_type, u8 snpsver, u8 userver)
>  {
>         const struct stmmac_hwif_entry *entry;
>         int i;
> @@ -305,7 +305,7 @@ stmmac_hwif_find(enum dwmac_core_type core_type, u8 s=
npsver, u8 dev_id)
>                 if (snpsver < entry->min_snpsver)
>                         continue;
>                 if (core_type =3D=3D DWMAC_CORE_XGMAC &&
> -                   dev_id !=3D entry->dev_id)
> +                   userver !=3D entry->userver)
>                         continue;
>
>                 return entry;
> @@ -358,7 +358,7 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
>         /* Fallback to generic HW */
>
>         /* Use synopsys_id var because some setups can override this */
> -       entry =3D stmmac_hwif_find(core_type, priv->synopsys_id, version.=
dev_id);
> +       entry =3D stmmac_hwif_find(core_type, priv->synopsys_id, version.=
userver);
>         if (!entry) {
>                 dev_err(priv->device,
>                         "Failed to find HW IF (id=3D0x%x, gmac=3D%d/%d)\n=
",
> --
> 2.47.3
>

--00000000000037b2b8064f0f1663
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGbTCCBFWg
AwIBAgIMGHX6KxYK3WW2YyprMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MDkyNTEzNTAzMVoXDTI2MDkyNjEzNTAzMVowgbMxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjEaMBgGA1UEAxMRSml0ZW5kcmEgVmVnaXJhanUx
LTArBgkqhkiG9w0BCQEWHmppdGVuZHJhLnZlZ2lyYWp1QGJyb2FkY29tLmNvbTCCASIwDQYJKoZI
hvcNAQEBBQADggEPADCCAQoCggEBAKWV+9PYvG4njqRsbQas79f8Q46VL7b1ZxvWT6ik6VMbdRZx
tfpfZalVXksqcb02/N1H7UA9V04cV2q97FkSr/KxeFLMetPb3cVJZICg23IRO2NTPdmgPFzwkPTo
35h9h/OYLgh3/9a1nTsC2xqJa8GtohD5+42rsskGcI57U4n1r1L4R5IL9ypSqDxX/xVEAdGI5FTj
VgvoZC6iuEbnez+yO8TT3wun9b/PQowOB5P0CwIFv7ERW0S1s6B8yrbsoaTrz0vQaEA786k1pZkg
ykC1+zXq/iTyZuPP4B4RkzFd43Pw+GAH0Tt2nx5V4rNisJHeAVNU92Gj01cEg0I+FnsCAwEAAaOC
Ad8wggHbMA4GA1UdDwEB/wQEAwIFoDCBkwYIKwYBBQUHAQEEgYYwgYMwRgYIKwYBBQUHMAKGOmh0
dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZzbWltZWNhMjAyMy5jcnQw
OQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAy
MzBlBgNVHSAEXjBcMAkGB2eBDAEFAwEwCwYJKwYBBAGgMgEoMEIGCisGAQQBoDIKAwIwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIw
ADBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWlt
ZWNhMjAyMy5jcmwwKQYDVR0RBCIwIIEeaml0ZW5kcmEudmVnaXJhanVAYnJvYWRjb20uY29tMBMG
A1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1Ud
DgQWBBRq5Jlxz3MqC+zEgUxK566xEc2g3DANBgkqhkiG9w0BAQsFAAOCAgEARXrmeeWA31pp9Tr0
M6mOlMv+Pr2raES4GzPSyftvxf6tBQCBNaqi6LSbyusDYOj3mG9bp6VeVn+68OxNY9iNAk+ujtId
f3+30BlZOQ1v8z9u2peUOUtWI60y2MxhdH0X0n2H+BCGvUOFqs5z440jqqy1HsscZTXHB7FEZmVP
fyD+0Z6cxyh7WNC6+BgLiFwf8iqmAbu7Yb1sGTUGyS5gfYEjJbF2PJfwNUcJDd7eS4w5Ju5mK5y7
spgjH2/JmDgbkpSk9JyuWfjGZIg4ah/q2nb6UMd1XJb6gLQZuzPOI3SgXPvd8MHGjKZrX2BHOBSC
bJJ8rp4w4a9QMS6dde2MFObusxkZAft4tUnwo+ProchHs7iA85sL7sWEZhAmjmKKCpECpEfZm0+/
hpvKQV3AZp5vBstb4IVL8QmLj8beDVHYnNhEicsSiG1wW7zSYyBnmGbFRrFQIJnJDWPjTZOlVEyp
T1ShrXRCtqJpOt6rgg+rFEY3D8j6/bAkJXnmKnE2LZ0YyrrKk7eC6UfNNimx38w3NWchtcGY8zJn
Y/1/C9Jv/mWm/2lK8nvusOFxhKmbG83Hx8toQdZ5F1kYk6zAWjfB7lwXr/En9mCmLieJ18hen9EK
qbYyUkmCmuoLi5GXFMJy+iQv6DgMVQ7CACagybU6FUrmL9lVa+A6caBEEh4xggJXMIICUwIBATBi
MFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9i
YWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgwYdforFgrdZbZjKmswDQYJYIZIAWUDBAIBBQCg
gccwLwYJKoZIhvcNAQkEMSIEIKWQy2mXIISkzcYEPlbdhtpPqkM/JUwZeydB13GuGHztMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDQwOTIzMDc1NlowXAYJKoZI
hvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAEE2b2zWJhSn
m11bQ8aBW6C9td4QBvPDmIdoV6rE+Y9H5jn/1fXAaPSdu3AoC3/79TkDGBpd3bg84S/rA7I1MmU2
5eooWq3dKlgWLSwIsY8FT5Uuv5X03b8U5zCch+kX9I1LvJzPA4C1OWJYuJcM712tNQt8drk2I2Ye
HajTx4I1gih4m/44YEUukvny325l2cxanNzopdMx24RkDEwcFfgjEjvsHYHDIFDCATl8g1yhMiyH
1Qgq/8TDjrLVlXolQasoLRXfb8s+lEV55fQREW2D0zztsCabp5v8eBKmQPICfv1CTNa7t0haWdN0
9M2LRyQbKpPprmWCMW2UncOAjjw=
--00000000000037b2b8064f0f1663--


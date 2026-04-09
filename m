Return-Path: <netdev+bounces-277154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL1DKBgl2Gm9YggAu9opvQ
	(envelope-from <netdev+bounces-277154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 00:15:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E613D02ED
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 00:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E8A13018281
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 22:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44983387594;
	Thu,  9 Apr 2026 22:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GegxRqih"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5B1387374
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 22:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775772896; cv=pass; b=s072VQYEvD3XGz/Rksk1+XrWWspRXC8W3IRFm4JtC8EMQaW14tSpuQLGmOFjXa69doHYK/kAyWcHW3pbN5MMBlJuAMvNs/XPNcd2XNX3oGmkvx4zgrl2LW05cjbupr+9yvAdZh6jwoeR26GLYoJSxXvB199cWFRQ4QdT7dI+jUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775772896; c=relaxed/simple;
	bh=iAukSHTeczzlDlXpN0NMXEJEyyk0a1K5IozX8fHl/1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1mKVGNAR+CWa4v2sTSO6zG0hxKkw93p6HQMHJFTAt9uDXX00tii3gev9+wq9sCNjwxDuT53QKSVjD/uYHyMdpbhex3YzA5aupFsDGCDOdjSAnHRd/UdsYX6FkanwW5XqiRP9wpkc+7sNG9Nf07igMi1bA4ZOi86LT5NNcY4XLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GegxRqih; arc=pass smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-c76af79f029so567843a12.3
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 15:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775772894; x=1776377694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkWFjeEq0nPwwdmq6cnIWYqV5lFL53+zcznk1ja4eDY=;
        b=dexk5YvSomHCVaen4EasnFs2w24sBlnyLRSD8iyB7yfRfVAGFVCEMDIjbnY++2vTwW
         gN6zhu83HLsUXsBZOMtRtBMuciXeMaKzRBk6LeQrRliYM6msrgEi5XbL9BdhaItV2N6N
         HlM9e+aSrULdTh2Ut7Do+CH6OKZHdGaZeoBNQni88ugvg5aFslKxt1hrU2HhUqNnvoBR
         kfQkAj0rdJwKbZxTfx8jp2vdAb2UnW2i/xAFnXzERSctyPw9Kkf4weOtTVWp7Cy2iHLy
         w+agE6A0hU+adcxmiCET7JL6ENS0ep/G7o1csEV8XA0bxoubr9zVqbMhCyFMh+yFGp+2
         v0+A==
X-Gm-Message-State: AOJu0Yx41VGhReLk36quqGOmwnTLU69d+ksyX2F5EXgTa0ZdEwxtHPFl
	t5MzX2Ik2xoP2D46obyVDcaJfRNOys+Y1/KD7kKEJ7ySqq8Fsv3S56zeyLhrFY9fi65by83wyBm
	tzIaXPPCPFxZCimjghGf0PCK07DyrpbWFB4oK8fBwMqO/SM9Wlq3cLI9BIWmqMTrOjtcc3mPxTW
	rB5VyNFF1odaOy6pUY9Y51mtI+J+44bwAs8ttGQVIjiL57uqvHg4pGxt2Ysxo2+lmdOYX+80IKm
	qUj+LErJbgUhIs0Ag==
X-Gm-Gg: AeBDies7N/qRVGVEkD9kCZZZW4O1KHShzMf6LR0Hciv5iFff5utdTypr5r8xjcmtFFp
	V7b7wWaGoyjAf2gjjS+vtQ3KNAdzbtRFLv9hW4vgB0/xwmnwWC1B+ejgyKIO1DZe7QzBvauE+XE
	rGG2SiVEVIU+2bhxVrIfkE0EI9zNsIatNlpBzInWlRssLj7QPD4sooltfhF1P/LXqS8ZV9OPwFs
	eKhxLm+dAHJdIiG1SJk2TLfmh9AZ9CXEPdOq7tno3p53Qj/DDikhkmyv8kLCIKoh4Dh8YIelixb
	sWu0rJhIUsGoURalFnexurtFgIDFAiR1KuiwfcH0LmxicP+cIAAS8kWdrZTgvYcCyVtaixQVcUf
	HXUOweCGiz5H9wc8Gr9yLwtMHX0PXlO8vG/Ksk84i9k6aPHUG8k9W8eblTGFqyS3WcaApRWq/Ce
	/3RC35vozqeGOyJavxTcIJkuTg8sKWmdR1KlXVxUR2jGKsfJwmTalCYEzCL/jNE14=
X-Received: by 2002:a05:6a20:8d07:b0:398:840d:39aa with SMTP id adf61e73a8af0-39fe3f3f127mr455018637.29.1775772894085;
        Thu, 09 Apr 2026 15:14:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c7921a6b5a1sm43991a12.10.2026.04.09.15.14.53
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2026 15:14:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43cf5b4dac8so1382430f8f.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 15:14:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775772892; cv=none;
        d=google.com; s=arc-20240605;
        b=dIehjzm9FNt/lF83S6H6FtHwowGLHE1N8RFFQFcoW2TnEiNfZHIHrZL+mSuMmsf6n3
         rY5Bw227bRHDGjU9h2K+H9OgSZXFQ8dWLHpJ0I93AjtjbFWK+7y+4ft/rwlInZy1mVXY
         SqVv4MCy4vNkp25LB1LH0CRbryYx/1Gd91NOZjShwJUJsAFYTc4oJAMlR4cF9bRvz3zD
         H6/i4nYC04uvJt18hN6E2ohxBQl+lIMsSfxH/SO0R+uRnOEFlLwVQah0qfhh0DuzGU7f
         JeurlAPDNcvR4XFROZbsLiJJaShx0N6VOXMbqb8osBsWFEgo2lxKqm5q9jrAM1iitHkx
         muZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EkWFjeEq0nPwwdmq6cnIWYqV5lFL53+zcznk1ja4eDY=;
        fh=CwGdb7DkuNVe+ud5/m2e4z3yxP3pm/t1nL0PzdDz5no=;
        b=ZNE/YiNvq1wHNbNDdOD3Jh3Q6WInxw6VdJlx1Gd73v85yycLsmgXveFccMPC4Eq7/U
         soMKYbn3MCoT48EL0FPIqjoiSfK5CV6VBwxWQo/0jXHTF8NXVkspJw2k+kr2Kv0xs+FS
         zUkCs+tJIxrP5WN1v4EcE3hu/5QjYZ0QxVPAvmAAIuGmllvtT5qM8AUTHWxX6HO2DwrJ
         u7La8wlezNHmLh8xkyTPSoi3DgYEpyeMyhfEJcApjnfSAO2kQV/DJt4O/qkc5N3x3ssI
         v1+4nsgvU5wQ3bTqC3Kh02MkdWAKhmN3OKOedRt2rPuVCkLLg31Dg0rp/oroh5ihT4Ym
         hbvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775772892; x=1776377692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EkWFjeEq0nPwwdmq6cnIWYqV5lFL53+zcznk1ja4eDY=;
        b=GegxRqih6toO7NjtILoBiTiUWR+h8a01Rmjz2Fnq1pm47ePZYmE7yID1Y/z3zZX6zq
         Xt5eQemlN+bRJJiZ0DokK7mJPMOVnLdnXv8w5WUmLQ8wO/b8r4impDe2K0CWZH8NxPkw
         ESEOXZjK069Xw4s6+dZhnVfoIvB92/5aJ3Lsw=
X-Received: by 2002:a05:6000:2010:b0:43c:f7e5:817a with SMTP id ffacd0b85a97d-43d64292b01mr916415f8f.19.1775772891670;
        Thu, 09 Apr 2026 15:14:51 -0700 (PDT)
X-Received: by 2002:a05:6000:2010:b0:43c:f7e5:817a with SMTP id
 ffacd0b85a97d-43d64292b01mr916355f8f.19.1775772891127; Thu, 09 Apr 2026
 15:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402213629.1996133-2-jitendra.vegiraju@broadcom.com> <20260407020954.3674529-1-kuba@kernel.org>
In-Reply-To: <20260407020954.3674529-1-kuba@kernel.org>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Thu, 9 Apr 2026 15:14:37 -0700
X-Gm-Features: AQROBzDIrVBrq9a8N-kCZj3is_dHAtUZh7lT-03nRSlBMuTVHnIsC_ZMyZ5jrJ4
Message-ID: <CAMdnO-KHq273kkC2wBou7oEK1BAHbYYW4u9iRV9nfe0dNk_61A@mail.gmail.com>
Subject: Re: [PATCH net-next v9 1/4] net: stmmac: Add DW25GMAC support in
 stmmac core driver
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, mcoquelin.stm32@gmail.com, 
	bcm-kernel-feedback-list@broadcom.com, richardcochran@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, rmk+kernel@armlinux.org.uk, 
	rohan.g.thomas@altera.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me, 
	siyanteng@cqsoftware.com.cn, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	weishangjuan@eswincomputing.com, wens@kernel.org, vladimir.oltean@nxp.com, 
	lizhi2@eswincomputing.com, boon.khai.ng@altera.com, 
	maxime.chevallier@bootlin.com, chenchuangyu@xiaomi.com, 
	yangtiezhu@loongson.cn, ovidiu.panait.rb@renesas.com, chenhuacai@kernel.org, 
	florian.fainelli@broadcom.com, quic_abchauha@quicinc.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000072e8e3064f0e5887"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277154-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FREEMAIL_CC(0.00)[vger.kernel.org,foss.st.com,davemloft.net,google.com,redhat.com,gmail.com,broadcom.com,kernel.org,iogearbox.net,armlinux.org.uk,altera.com,st-md-mailman.stormreply.com,lists.infradead.org,lunn.ch,fomichev.me,cqsoftware.com.cn,bp.renesas.com,eswincomputing.com,nxp.com,bootlin.com,xiaomi.com,loongson.cn,renesas.com,quicinc.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jitendra.vegiraju@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 01E613D02ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000072e8e3064f0e5887
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 7:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> Subject: net: stmmac: Add DW25GMAC support in stmmac core driver
>
> This commit introduces support for the DW25GMAC hardware in the stmmac
> core driver, which uses a new Hyper-DMA (HDMA) architecture. It adds a
> new DMA ops instance mapping virtual DMA channels to physical DMA
> channels and sets up the basic device configurations.
>
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dw25gmac.c b/drivers/n=
et/ethernet/stmicro/stmmac/dw25gmac.c
> > new file mode 100644
> > index 0000000000000..82eb22bff73e0
> > --- /dev/null
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dw25gmac.c
>
> [ ... ]
>
> > +static int rd_dma_ch_ind(void __iomem *ioaddr, u8 mode, u32 channel)
> > +{
> > +     u32 reg_val =3D 0;
> > +
> > +     reg_val |=3D FIELD_PREP(XXVGMAC_MODE_SELECT, mode);
> > +     reg_val |=3D FIELD_PREP(XXVGMAC_ADDR_OFFSET, channel);
> > +     reg_val |=3D XXVGMAC_CMD_TYPE | XXVGMAC_OB;
> > +     writel(reg_val, ioaddr + XXVGMAC_DMA_CH_IND_CONTROL);
> > +     return readl(ioaddr + XXVGMAC_DMA_CH_IND_DATA);
> > +}
>
> Does this readl() need to wait for the hardware to clear the XXVGMAC_OB
> (Operation Busy) bit? Returning immediately might read uninitialized or
> stale data if the hardware hasn't finished the fetch.
>
This is an issue. We will fix it.
> > +
> > +static void wr_dma_ch_ind(void __iomem *ioaddr, u8 mode, u32 channel, =
u32 val)
> > +{
> > +     u32 reg_val =3D 0;
> > +
> > +     writel(val, ioaddr + XXVGMAC_DMA_CH_IND_DATA);
> > +     reg_val |=3D FIELD_PREP(XXVGMAC_MODE_SELECT, mode);
> > +     reg_val |=3D FIELD_PREP(XXVGMAC_ADDR_OFFSET, channel);
> > +     reg_val |=3D XGMAC_OB;
>
> This isn't a bug, but should this use the XXVGMAC_OB macro instead of
> XGMAC_OB here for consistency?
>
> > +     writel(reg_val, ioaddr + XXVGMAC_DMA_CH_IND_CONTROL);
> > +}
>
> Similarly, does this function need to poll for the busy bit to clear afte=
r
> the writel()? If back-to-back operations occur, the next indirect write
> might overwrite the control and data registers while the hardware is stil=
l
> processing this request.
>
Agreed. This is bug, we will fix it.
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/driv=
ers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > index f02b434bbd505..64c38de294da2 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
>
> [ ... ]
>
> > -int dwxgmac2_setup(struct stmmac_priv *priv)
> > +static void dwxgmac2_common_setup(struct stmmac_priv *priv, char *mac_=
name)
> >  {
>
> This isn't a bug, but should mac_name be declared as const char * since i=
t
> is passed string literals like "XGMAC2" and "DW25GMAC"? This avoids
> discarded-qualifiers compiler warnings.
>
> >       struct mac_device_info *mac =3D priv->hw;
> >
> > -     dev_info(priv->device, "\tXGMAC2\n");
> > +     dev_info(priv->device, "\t%s\n", mac_name);
>
Ack
> [ ... ]
> --
> pw-bot: cr

--00000000000072e8e3064f0e5887
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
gccwLwYJKoZIhvcNAQkEMSIEIGwoVXYTb7jIt4pZrqv7oj7W19W19KkcepsmKqv6JpsJMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDQwOTIyMTQ1MlowXAYJKoZI
hvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAAZLX4DO4Cov
kQIFrRc07yuLHnUiFw6Zy57h25q9VBipyCFcX1t+qvtoZWuRRC34DLZB5+TL5jSkWkcypzrGbJL1
a9ywfeNdACY6ZTGC1dzVICDIM4gdYlCBwXyly5bwm+/+rf+yKQS2wRFhZ0sWOrVpsTcglCi3F/UT
plCuAp8w71I5vtcxJiWUmU5+BXXMQFdLdoSPO4hFp7aOW8hO87mQ0LIzTwtt3sn5Vu9mFCmbWw3b
swspQ85xb5Ra9j5Do1TcVaB4HHXojqjB1a4dxXEhLjIxfb+NJHxYAE9e3RZHwwrJFmVXW/JduMra
502KfFM/YwnlfaghhO75Mp8TqQ8=
--00000000000072e8e3064f0e5887--


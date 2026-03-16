Return-Path: <netdev+bounces-268273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qABTImFpuGlEdgEAu9opvQ
	(envelope-from <netdev+bounces-268273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 21:34:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CFF2A0432
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 21:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2B5C31B9BA3
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1543EF64F;
	Mon, 16 Mar 2026 20:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aINYCfZK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50B13F54D9
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692875; cv=pass; b=PRy/u8s4BlnFvQ6NiEjz9mNpHJCt5dfil40PbSVWHsKZcfCykk+77LQ4DTBvH8QBz20bYmDVBxcY+Pnx43Bfh4AhfK23sFhfQgkkK2zJh3kRZiBcZvbvw/9nwlce+8gyM/cjHdk+HGekITy6C5Cfr5Co/AOO+gmc06ApJINFxaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692875; c=relaxed/simple;
	bh=EFWPhMQF7D9Y4uLWlTVeq50HQ1WT/ZRuIUP9FH5T/qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGZhXFaVvBeKhstVpWTUgXqgH4/KM57FpJrZnCOPi7U0OisrcSsQUI6ZnHsIqa9PTtv3Ta03fYS4LMV9FYw9dOoA0jCzcGC3ZxIYZeiQQhcjQ8SRmNd1Jm7zwZIRGLYx9NsZH1/zxMTgzs5yy9XWozrhrTU25pUirfYMLET+24E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aINYCfZK; arc=pass smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-79a51edef1fso1690017b3.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 13:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773692868; x=1774297668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSm0SI8wDEVphLG992Lz8xcJhsbpy962xvT0PxDLY+k=;
        b=Ii4Qcce9rD4CO9het/bYyiala52JFdrm5N7iTALXspV+ZJRHK5rveDSxLVgczK3gUV
         QRHr8v6GbMj65M6jywZzabRln+PuRbRxVWe6i6kG4Bd9kj6R5SnhAHXNEAWR9yP9rc7u
         5X+SzIbtz7HGsTo7cAuJ8xNHNlG6k5gEp+qfKITKe0NG/KdYMjwBcDkSzleXcRgf2WkH
         /7kBDF3a3tm/o3Zn9pQSNwEZLUg/yvOJC4NVd3YMzTB0AZGmqogHGs6rQa0Bnxa8sIch
         7NeJkLsGBpR2HanqGlL4Fg+E1gRc4jx2taaZwoRoTbuzNVXrJdDABYQy7YfMCV+9upD7
         4lmw==
X-Gm-Message-State: AOJu0YyKcM/mfo+7PlOVZOzUCd/ZefzFM9j22EZ/rc1TZQZ0S9IqRN5R
	B9H8NPMSZw+eeRo0cKT8Ii8nHtHPH4VMiemTtZT2aER0mPtB/LhI+teW+FP6eB4nbFobxu9S3Mk
	Fe586g3efZRX/ds0bJAGA+aDGcjR3K/eq06E3mtVg/LSdZTvfIxL9meaykRytnT5ta4ptJQhCiy
	loSYuo/dxWj4jK81DjbVtFG0LJt7uJ1OvbAXToMJx8u920krE5F0NOZN2lNGz6b7vwO3e68zZYh
	LTBXPJwvpixH8S3kg==
X-Gm-Gg: ATEYQzygMqV6RVxXNKdwkgIqhqQHtJHYYMdTI1MMmTXhIYbnoxxm7jMnP9CykyIe6Uc
	obwjEZoAll/UlMdvxECaHoZn4ILEEfekL6+4xwfiqN8dnmFjDBcnGkzCDxpDqMEP8MpZ1mHn+lO
	HRoAxVyXX6nUKtpYbu64GRUOKfomhamd1F3rNv3FJ5hOYXTDMjV81nxBrocbd7D7vBeV2wuwnp4
	4P5WvtntIbCKJMUa7WDDgQ0uCVxOnhO/f7IphdwyPBDMA+WeXiDkeqgWck0DoxJfV3EYvezdYJN
	MVcrqPAcuIieQzbY5dw9aaVTPPelfUbtWzmap8EZstEfaqE6E0bc44ivC9xk2LOxKn9nb/j9z5E
	31+FnJ31DiUNjWhb+cXpL7hxryJd7NeXOg6bC6W44szivUTA9o9d1REM6s1aHYaKKxo/oGOYZ67
	ku7jVYHBfhymCF5J37gw2GtSb/+gz968DfYNDP1Y86trDCVFtcHeQ8X4zmL1BA5W8=
X-Received: by 2002:a05:690c:350f:b0:79a:3968:f77d with SMTP id 00721157ae682-79a61888651mr8821417b3.18.1773692867740;
        Mon, 16 Mar 2026 13:27:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-79a1ecda81asm10236337b3.11.2026.03.16.13.27.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2026 13:27:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43b46b2b161so1294272f8f.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 13:27:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773692866; cv=none;
        d=google.com; s=arc-20240605;
        b=hoeW0Zi8OSeo5FW0dsQIbkKjrC+xPaQCBxqDoQApxwAQliJ7BAzWLBNUtdidLcn9ds
         lWfKmggHbrDdx3n7ulR2DNGjxSy03iaO0eam0zP9max9zX0jjZiKaSq2mP+DmPcqzGAu
         cpD8p79EwsONrI1Ku4VzGuXbuQI+gAMLwsjet7lMmtbE/HYVvzkj9DBgZIfI6E1ssMK2
         nmUMcpq5ZJFQbGiiYQVs9YUwRNTKgx1RE96XycQn94PS6lSMsN4bMhki4UDGb36t56l5
         sPyoDjReFH9cieJSq52hU3RdHaEBqaFY0zve9T6tcxoGmu/KeGtDgXo9fPpA8QgLljb3
         7tpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HSm0SI8wDEVphLG992Lz8xcJhsbpy962xvT0PxDLY+k=;
        fh=8DXXuIeKI527N/XFWk/hIggMQY8iurASBgxxY00/rsA=;
        b=IYot/hmD91c7x5u33JI4m17oPphJHwTbJ3WGihFpw09+IBSRuMjCBKXiuGN3sdY9jW
         dBU97cnhEMucKBZgHEfAnCbFpIbFfUQXg7tDSa86BlnRVCrlaHGmQ0JDtWbK+Zmq+OwM
         Ze5ejmU4YD0QNGqahr+xWjjoi5p+eKKAZZ8mF3McFYuU8KK/DrmodgshcY1Dhz3atAOu
         Yu3dTjhURMqMFAPgTxwgMNZA5ggof2xE9hIr/zent3mb+kp4Onxy56IUWOHBPo3dA4dC
         V4XsHMjLet1UKZdt2bgyStZWyQ8Fz4Ph86dhe3+n5SojEY6eT78Beu9HaCR5pZUoVKTR
         QTag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773692866; x=1774297666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HSm0SI8wDEVphLG992Lz8xcJhsbpy962xvT0PxDLY+k=;
        b=aINYCfZKUuDDx6Ec2niJAlF68ZV6bsyWn5sZIULK3YP+Fum1sKRepG2hWDuPrQzTuN
         Gdi19th6lN7GpL8OuIYUPwrwg2EGHcUyCUhkp02svfgLrXn1MwRhfzGtoQxWcBcVZRSP
         +xc2vxm5/ZpGCmYuR2o6h9ZE9O4AXezaw1r3E=
X-Received: by 2002:a05:6000:2403:b0:439:c5cf:fc73 with SMTP id ffacd0b85a97d-43a04d7a050mr25499235f8f.12.1773692865769;
        Mon, 16 Mar 2026 13:27:45 -0700 (PDT)
X-Received: by 2002:a05:6000:2403:b0:439:c5cf:fc73 with SMTP id
 ffacd0b85a97d-43a04d7a050mr25499179f8f.12.1773692865235; Mon, 16 Mar 2026
 13:27:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313222206.778760-1-jitendra.vegiraju@broadcom.com>
 <20260313222206.778760-3-jitendra.vegiraju@broadcom.com> <abSaKe3d4fcBMqLm@shell.armlinux.org.uk>
 <CAMdnO-+UEb8sVf8=Aj7G6UgY-DxWe3bFYbSbKJRdU4woEX+dWQ@mail.gmail.com>
In-Reply-To: <CAMdnO-+UEb8sVf8=Aj7G6UgY-DxWe3bFYbSbKJRdU4woEX+dWQ@mail.gmail.com>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Mon, 16 Mar 2026 13:27:33 -0700
X-Gm-Features: AaiRm53K7fiQEZkpJI-MOvV-cHRkeznqwMJWGxhDHPBRcNZi_mzV70LOImU7VIY
Message-ID: <CAMdnO-La1d7AfqLHPxTX0Y3_17Cpn6SeAqFgW-vJUg+2OZp-xA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/5] net: stmmac: Add DW25GMAC support in
 stmmac core driver
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, rohan.g.thomas@altera.com, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me, me@ziyao.cc, 
	siyanteng@cqsoftware.com.cn, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	weishangjuan@eswincomputing.com, wens@kernel.org, vladimir.oltean@nxp.com, 
	lizhi2@eswincomputing.com, boon.khai.ng@altera.com, 
	maxime.chevallier@bootlin.com, chenchuangyu@xiaomi.com, 
	yangtiezhu@loongson.cn, ovidiu.panait.rb@renesas.com, chenhuacai@kernel.org, 
	florian.fainelli@broadcom.com, quic_abchauha@quicinc.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003abaa6064d2a0d9c"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268273-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[vger.kernel.org,foss.st.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com,iogearbox.net,altera.com,st-md-mailman.stormreply.com,lists.infradead.org,lunn.ch,fomichev.me,ziyao.cc,cqsoftware.com.cn,bp.renesas.com,eswincomputing.com,nxp.com,bootlin.com,xiaomi.com,loongson.cn,renesas.com,quicinc.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jitendra.vegiraju@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,armlinux.org.uk:email,armlinux.org.uk:url,broadcom.com:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: F3CFF2A0432
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000003abaa6064d2a0d9c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, missed one answer in the previous response.
On Mon, Mar 16, 2026 at 1:14=E2=80=AFPM Jitendra Vegiraju
<jitendra.vegiraju@broadcom.com> wrote:
>
> Hi Russell,
> Thank you for reviewing the patches.
>
>
> On Fri, Mar 13, 2026 at 4:14=E2=80=AFPM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Fri, Mar 13, 2026 at 03:22:03PM -0700, \Jitendra Vegiraju wrote:
> > > @@ -42,13 +42,18 @@
> > >  #define DWXGMAC_CORE_2_20    0x22
> > >  #define DWXLGMAC_CORE_2_00   0x20
> > >
> > > +#define DW25GMAC_CORE_3_20   0x32
> > > +#define DW25GMAC_CORE_4_00   0x40
> > > +
> >
> > Do these live in the same versioning numberspace as DWXGMAC and
> > DWXLGMAC?
> >
Yes. We were informed by Synopsys that 0x32 is an early adopter
release and 0x4x is general availability release for DW25GMAC.
Device ID value for 25GMAC is 0x55.

> > > +int dw25gmac_setup(struct stmmac_priv *priv)
> > > +{
> > > +     struct mac_device_info *mac =3D priv->hw;
> > > +
> > > +     dev_info(priv->device, "\tDW25GMAC\n");
> > > +
> > > +     priv->dev->priv_flags |=3D IFF_UNICAST_FLT;
> > > +     mac->pcsr =3D priv->ioaddr;
> > > +     mac->multicast_filter_bins =3D priv->plat->multicast_filter_bin=
s;
> > > +     mac->unicast_filter_entries =3D priv->plat->unicast_filter_entr=
ies;
> > > +     mac->mcast_bits_log2 =3D 0;
> > > +
> > > +     if (mac->multicast_filter_bins)
> > > +             mac->mcast_bits_log2 =3D ilog2(mac->multicast_filter_bi=
ns);
> >
> > The above seems to be common amongst the other two setup functions.
> > Maybe there should be a helper for this?
> >
> Ack. Will address this in v8.
> > > +
> > > +     mac->link.caps =3D MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> > > +                      MAC_1000FD | MAC_2500FD | MAC_5000FD |
> > > +                      MAC_10000FD | MAC_25000FD;
> > > +     mac->link.duplex =3D 0;
> > > +     mac->link.speed10 =3D XGMAC_CONFIG_SS_10_MII;
> > > +     mac->link.speed100 =3D XGMAC_CONFIG_SS_100_MII;
> > > +     mac->link.speed1000 =3D XGMAC_CONFIG_SS_1000_GMII;
> > > +     mac->link.speed2500 =3D XGMAC_CONFIG_SS_2500_GMII;
> > > +     mac->link.xgmii.speed2500 =3D XGMAC_CONFIG_SS_2500;
> > > +     mac->link.xgmii.speed5000 =3D XGMAC_CONFIG_SS_5000;
> > > +     mac->link.xgmii.speed10000 =3D XGMAC_CONFIG_SS_10000;
> > > +     mac->link.xgmii.speed25000 =3D XGMAC_CONFIG_SS_25000;
> > > +     mac->link.speed_mask =3D XGMAC_CONFIG_SS_MASK;
> >
> > Is there any point populating link.speed10 and link.speed100 ?
> > You're telling phylink that 10/100M speeds aren't supported in
> > link.caps, so these speeds won't ever be used.
> >
> Thanks, I missed this. Will remove 10/100M entries.
> > > +
> > > +     mac->mii.addr =3D XGMAC_MDIO_ADDR;
> > > +     mac->mii.data =3D XGMAC_MDIO_DATA;
> > > +     mac->mii.addr_mask =3D GENMASK(20, 16);
> > > +     mac->mii.reg_mask =3D GENMASK(15, 0);
> > > +     mac->mii.clk_csr_mask =3D GENMASK(21, 19);
> >
> > This will be the third instance of this particular mii data setup.
> > Please consider adding a function to do this setup.
> >
> I will move this code segment to common helper function.
> > Thanks.
> >
> > --
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

--0000000000003abaa6064d2a0d9c
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
gccwLwYJKoZIhvcNAQkEMSIEIEmds8YruXz+kLzusi9PvUSj4X/xjlJST+Hyz+O6WN5QMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMxNjIwMjc0NlowXAYJKoZI
hvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAG1Ud31IjVSh
QFZsf6AaDp7pdhVd8kOhGr6bXM6EFiH5Qps9qB57B034/QB2FI5yq0Gp2/JGfIWbrw9c9EbZ67Rm
M4HOoEBQq+cDrQc5+lqMYDVnxmspJqeVC9lMH+MjbcIsONAHoRYoLum3bbQxnjHgHc7JX5PjSW6S
ufSXY8KBrEyDGVCz7/leqfmAnlNAW4e/Xayjcfcwsgt3UykT/bZUkg3SZjQzzczws9jixWlFOYqj
lvp0iRRkK/IB/abdrpKo11OZ7IgboALFQz/7NMlVzIIp5sgTmF77kQ43ujw7kxHjCdqdHakkI3o9
l5FvQ/i6WnfhUmz6yCP+vv5L2Bo=
--0000000000003abaa6064d2a0d9c--


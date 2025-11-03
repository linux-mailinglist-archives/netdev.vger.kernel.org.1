Return-Path: <netdev+bounces-235128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D7DC2C8BC
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 16:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A223ABDB6
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 14:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AA33148B9;
	Mon,  3 Nov 2025 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L522km2c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BU+9zmGR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FDF3148B3
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181253; cv=none; b=oYNkJFhsvZijS7aek3ez9x5hHskgr+acnVE8vj6hs7HrY92Bo63gTqjwiiSi5AnEI1EtcNYBtrVIzxYMcLEsy7ICoYn1ZFtMgUeYJA5a1sl46mboX227WAYpj6gelld5Uj0pS30F9NbwxF8fIyKtoTcxLNAtektITuyeKU638DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181253; c=relaxed/simple;
	bh=1hd5EpfEdqiUeQroDVfYks6fn4WoZ4+prGiNWKovJzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niDScBnvpWU/0nWQt+SfSK11PlTwJlb/BaXuUfJjU7Q+GtB34B8kXxyaVP42Hs4Ro0w1djOs0BWOq2Jyy53oqW2/X4MZXGMqk9IzRf7O9hipMoMrdL4G9M2W+INNkeiZy1QL/TQKHYt+7P7TwPvMZawSe0PebRGicPorOfEq1wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L522km2c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BU+9zmGR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3AIVCV2755773
	for <netdev@vger.kernel.org>; Mon, 3 Nov 2025 14:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=t+itrSyYO+VIvGLI0ZHP7w/t
	itkZWVL2wlVW+eve/BU=; b=L522km2c2+iezrYolQfIEQKB7dzoVdBpOUxZGbwD
	zlsXUbVQ5yQQ5sKAaM8Zq/vAAPEEQ7uJfyGk6hkFKzAApDx0iak2MgYxqcTjwGB0
	urYRJ4cby3GnShAnJ5F5HGlScJ7RnSk9FOOhjIDtw/F5cUFxuUkV4LZxLRe6G//3
	asSwKspaf43v5BGTasYyVnpJKBxg+zOGqr7C5apF3sH5GmRWQXg+YZXHG5igol+C
	ghU+71HJkObjR1Q70744S6BU+tMEgnu+GoDwjumx7ecq33b1rcCblacKPPbmmuVL
	AxXOlecVQKTs+bzuiAObShmKIDniL5Vsay4lzjGQVB7ohQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6th9rnpw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 14:47:30 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b9b9e8b0812so2243555a12.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 06:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762181250; x=1762786050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t+itrSyYO+VIvGLI0ZHP7w/titkZWVL2wlVW+eve/BU=;
        b=BU+9zmGRWW0WT+4+FIAJxGH/xcCoL173Peix+wxXtrUJM7Ss2ris+J54uSFKrUe6m1
         OgcLHzrPg/v7a8icCG58cSaGD0vn/XCJjxfuolhe1JLfGVv6Q/J3v2PycrpCU4LrulW5
         uVYMdi+PpOLoRB3Xco3nuzyVwGwQtJn91UdYPh3QTceU5JS0b9S8TAAzc61uTEMyuPkd
         QSkvtp4D9jwqNr6o61/No4NOLzdnFwET2pGUlkA1+dU8IbXXuasOG1URVgYmm4Cb6SPf
         v0rfKrQ2c24nC4qqumKk8aTBR4lPFNRnZ7MA5IyCvOhOWiP2CK6sB+ZSs9c9DurbIMgZ
         WynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762181250; x=1762786050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+itrSyYO+VIvGLI0ZHP7w/titkZWVL2wlVW+eve/BU=;
        b=xHNpVQ2ndJOtK02Lg79D624qq3pjCLjGhlWhVOwfx8G7Ir2dIANio9C20nZzZvDyFC
         QnYHLlQ+kmYZACikgjjKhlM2EjCClx0HzBkzq1tbuTR6Ns66TGzTQOdd7jhDOOTYK14y
         AWkAy3KFV2ByOG+kOYaUrxIy+P98MSva3zKc0g+V3nfXg6QiX2C5N4iZH3XX1f0Fzv+A
         vgTu9iqa+olcMF/6xcAzUYXz2Bxh1dZj1DIxkEV2Cnb8sAlMsLsQvYVxDnKW7CuwYKuC
         R5stsl07TfDOnPww9V+2d9TJUtGfaNqoQ5OCIlCa8TfQzRflXiT5o7txiKh8ie+pE0Wk
         C8rg==
X-Forwarded-Encrypted: i=1; AJvYcCXa+oAr8tYq1p7ZnuWFpKYiuIovIeUaCX9tvLSr5N3/U2NrNVZfqXAzhDrrEmVYNlsr42LNAJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJKdgpX9CmE5wDinP4ztKms6JKSXtXV4yk+NVlKn30JrecKDVS
	+De91EmXO4gh9kT70YroyPxS0k2fAgZoUCvit/hhtxblgdlZHlF1Vd1BF+RzPl2fPK0ZJZAKQ67
	ySFgAvaruXWW8WEPLV2nDfJUo1BrqUepY2TuQe/B+R86MwL0/VghdRtbI0ys=
X-Gm-Gg: ASbGncuz6lSb0QpUWtKQYFpdD0yaorF8u1waaOljEMLfx+MRy8FlTz7e7hgHEzzncdJ
	S7j5mR5xjxylYCTnh66DENL+1mq1w/IMpdsfxh2JS3OXNig73Wduyh0A66iTlfYLViRXCEbpMV4
	JS4VGGOZitZexfRm09CmlD/9KKBD2CVsm3OaxfB9j67qIAepjoPPTlf6zSdnsEfBxiJvNXXtiRk
	LBsb5b0lajAuDN17SWSz+AdpRToYJvLKxYv6nPcME+xKWEXnRwR0wXqxCsl/U5gvsBm3TUJvZYf
	wPurteijP+91lE5V5leyQ1SY5kBHds4G+cht6qn911CB3L/0QwQLM5aOaIikRnR6EBU0xQkyZST
	mT2DlvUF2m18g
X-Received: by 2002:a17:902:ec89:b0:265:47:a7bd with SMTP id d9443c01a7336-2951a390601mr145597105ad.4.1762181249587;
        Mon, 03 Nov 2025 06:47:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+wPyTqTTn2BtjnZCi7zVqSmwEwlcCURWpSI4e7r+UwEdUK2siu1cWW/W0oIfwt/nQiM0MvQ==
X-Received: by 2002:a17:902:ec89:b0:265:47:a7bd with SMTP id d9443c01a7336-2951a390601mr145596525ad.4.1762181248883;
        Mon, 03 Nov 2025 06:47:28 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699c9dbsm125010705ad.84.2025.11.03.06.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 06:47:28 -0800 (PST)
Date: Mon, 3 Nov 2025 20:17:20 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Boon Khai Ng <boon.khai.ng@altera.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Furong Xu <0x1207@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH net-next 0/3] net: stmmac: phylink PCS conversion part 3
 (dodgy stuff)
Message-ID: <aQjAeCNGA2cjNXy6@oss.qualcomm.com>
References: <aQNmM5+cptKllTS8@oss.qualcomm.com>
 <aQOB_yCzCmAVM34V@shell.armlinux.org.uk>
 <aQOCpG_gjJlnm0A1@shell.armlinux.org.uk>
 <aQhusPX0Hw9ZuLNR@oss.qualcomm.com>
 <aQh7Zj10C7QcDoqn@shell.armlinux.org.uk>
 <aQiBjYNtJks2/mrw@oss.qualcomm.com>
 <20251103104820.3fcksk27j34zu6cg@skbuf>
 <aQiP46tKUHGwmiTo@oss.qualcomm.com>
 <aQiVWydDsRaMz8ua@shell.armlinux.org.uk>
 <20251103121353.dbnalfub5mzwad62@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103121353.dbnalfub5mzwad62@skbuf>
X-Proofpoint-GUID: dT9C_AnCt_b8f_ubZGnCEkspJLUCwgj6
X-Authority-Analysis: v=2.4 cv=ea8wvrEH c=1 sm=1 tr=0 ts=6908c082 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8AirrxEcAAAA:8 a=h6mluUUUhvrYO4b4W1oA:9
 a=CjuIK1q_8ugA:10 a=x9snwWr2DeNwDh03kgHS:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: dT9C_AnCt_b8f_ubZGnCEkspJLUCwgj6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEzNCBTYWx0ZWRfX/GWv2ZAYn+dh
 eb1oG8NpulBsnRwO8G+UizW4fNMg4EYTbX/QvSm6Nn47auoi2yZjxD7qDiXRnHXqid+4g8RybDp
 gc5ynQnQW8WMHV99BpVb08flD1iGnho6nY1fgQqgBIlpmniSTLXzj38VfoZtdVmn0SifYjZPDFC
 EeLG2neJ1yW3P5r7Ve5JI5eLthJImaki4IATyYBG5krnK/tfkWBLLZuxI5zd0Dj2D30qof544sm
 P0/lwQphsV7nXrWsQtl+IizOQGuSUoN7/+he0KIfVmQmZ7+uD04NBs+L+6QIMVzQIMdHCgE7F7B
 5UBHxT2c4rZzXU4wK6B8el688gpsLm5MCqDwQ4Vx1UzaaMPKcWL7HBaVQje5MG1349tI0G1Ximv
 79CCElWzf6hhGoKbidAsC90Abj8P/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_02,2025-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030134

On Mon, Nov 03, 2025 at 02:13:53PM +0200, Vladimir Oltean wrote:
> On Mon, Nov 03, 2025 at 11:43:23AM +0000, Russell King (Oracle) wrote:
> > On Mon, Nov 03, 2025 at 04:50:03PM +0530, Mohd Ayaan Anwar wrote:
> > > On Mon, Nov 03, 2025 at 12:48:20PM +0200, Vladimir Oltean wrote:
> > > > 
> > > > As Russell partially pointed out, there are several assumptions in the
> > > > Aquantia PHY driver and in phylink, three of them being that:
> > > > - rate matching is only supported for PHY_INTERFACE_MODE_10GBASER and
> > > >   PHY_INTERFACE_MODE_2500BASEX (thus not PHY_INTERFACE_MODE_SGMII)
> > > > - if phy_get_rate_matching() returns RATE_MATCH_NONE for an interface,
> > > >   pl->phy_state.rate_matching will also be RATE_MATCH_NONE when using
> > > >   that interface
> > > > - if rate matching is used, the PHY is configured to use it for all
> > > >   media speeds <= phylink_interface_max_speed(link_state.interface)
> > > > 
> > > > Those assumptions are not validated very well against the ground truth
> > > > from the PHY provisioning, so the next step would be for us to see that
> > > > directly.
> > > > 
> > > > Please turn this print from aqr_gen2_read_global_syscfg() into something
> > > > visible in dmesg, i.e. by replacing phydev_dbg() with phydev_info():
> > > > 
> > > > 		phydev_dbg(phydev,
> > > > 			   "Media speed %d uses host interface %s with %s\n",
> > > > 			   syscfg->speed, phy_modes(syscfg->interface),
> > > > 			   syscfg->rate_adapt == AQR_RATE_ADAPT_NONE ? "no rate adaptation" :
> > > > 			   syscfg->rate_adapt == AQR_RATE_ADAPT_PAUSE ? "rate adaptation through flow control" :
> > > > 			   syscfg->rate_adapt == AQR_RATE_ADAPT_USX ? "rate adaptation through symbol replication" :
> > > > 			   "unrecognized rate adaptation type");
> > > 
> > > Thanks. Looks like rate adaptation is only provisioned for 10M, which
> > > matches my observation where phylink passes the exact speeds for
> > > 100/1000/2500 but 1000 for 10M.
> > 
> > Hmm, I wonder what the PHY is doing for that then. stmmac will be
> > programmed to read the Cisco SGMII in-band control word, and use
> > that to determine whether symbol replication for slower speeds is
> > being used.
> > 
> > If AQR115C is indicating 10M in the in-band control word, but is
> > actually operating the link at 1G speed, things are not going to
> > work, and I would say the PHY is broken to be doing that. The point
> > of the SGMII in-band control word is to tell the MAC about the
> > required symbol replication on the link for transmitting the slower
> > data rates over the link.
> > 
> > stmmac unfortunately doesn't give access to the raw Cisco SGMII
> > in-band control word. However, reading register 0xf8 bits 31:16 for
> > dwmac4, or register 0xd8 bits 15:0 for dwmac1000 will give this
> > information. In that bitfield, bits 2:1 give the speed. 2 = 1G,
> > 1 = 100M, 0 = 10M.
> 
> It might be Linux who is forcing the AQR115C into the nonsensical
> behaviour of advertising 10M in the SGMII control word while
> simultanously forcing the PHY MII to operate at 1G with flow control
> for the 10M media speed.
> 
> We don't control the latter, but we do control the former:
> aqr_gen2_config_inband(), if given modes == LINK_INBAND_ENABLE, will
> enable in-band for all media speeds that use PHY_INTERFACE_MODE_SGMII.
> Regardless of how the PHY was provisioned for each media speed, and
> especially regardless of rate matching settings, this function will
> uniformly set the same in-band enabled/disabled setting for all media
> speeds using the same host interface.
> 
> If dwmac_integrated_pcs_inband_caps(), as per Russell's patch 1/3,
> reports LINK_INBAND_ENABLE | LINK_INBAND_DISABLE, and if
> aqr_gen2_inband_caps() also reports LINK_INBAND_ENABLE | LINK_INBAND_DISABLE,
> then we're giving phylink_pcs_neg_mode() all the tools it needs to shoot
> itself in the foot, and select LINK_INBAND_ENABLE.
> 
> The judgement call in the Aquantia PHY driver was mine, as documented in
> commit 5d59109d47c0 ("net: phy: aquantia: report and configure in-band
> autoneg capabilities"). The idea being that the configuration would have
> been unsupportable anyway given the question that the framework asks:
> "does the PHY use in-band for SGMII, or does it not?"
> 
> Assuming the configuration at 10Mbps wasn't always broken, there's only
> one way to know how it was supposed to work: more dumping of the initial
> provisioning, prior to our modification in aqr_gen2_config_inband().
> Ayaan, please re-print the same info with this new untested patch applied.
> I am going to assume that in-band autoneg isn't enabled in the unmodified
> provisioning, at least for 10M.
> 
> Russell's request for the integrated PCS status is also a good parallel
> confirmation that yes, we've entered a mode where the PHY advertises
> SGMII replication at 10M.

> From b91162e5dae8e20b477999c4f2fcdb98c219d663 Mon Sep 17 00:00:00 2001
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Date: Mon, 3 Nov 2025 14:03:55 +0200
> Subject: [PATCH] net: phy: aquantia: add inband setting to the
>  aqr_gen2_read_global_syscfg() print
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/phy/aquantia/aquantia_main.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
> index 41f3676c7f1e..f06b7b51bb7d 100644
> --- a/drivers/net/phy/aquantia/aquantia_main.c
> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> @@ -839,6 +839,7 @@ static int aqr_gen2_read_global_syscfg(struct phy_device *phydev)
>  
>  	for (i = 0; i < AQR_NUM_GLOBAL_CFG; i++) {
>  		struct aqr_global_syscfg *syscfg = &priv->global_cfg[i];
> +		bool inband;
>  
>  		syscfg->speed = aqr_global_cfg_regs[i].speed;
>  
> @@ -849,6 +850,7 @@ static int aqr_gen2_read_global_syscfg(struct phy_device *phydev)
>  
>  		serdes_mode = FIELD_GET(VEND1_GLOBAL_CFG_SERDES_MODE, val);
>  		rate_adapt = FIELD_GET(VEND1_GLOBAL_CFG_RATE_ADAPT, val);
> +		inband = FIELD_GET(VEND1_GLOBAL_CFG_AUTONEG_ENA, val);
>  
>  		switch (serdes_mode) {
>  		case VEND1_GLOBAL_CFG_SERDES_MODE_XFI:
> @@ -896,12 +898,13 @@ static int aqr_gen2_read_global_syscfg(struct phy_device *phydev)
>  		}
>  
>  		phydev_dbg(phydev,
> -			   "Media speed %d uses host interface %s with %s\n",
> +			   "Media speed %d uses host interface %s with %s, inband %s\n",
>  			   syscfg->speed, phy_modes(syscfg->interface),
>  			   syscfg->rate_adapt == AQR_RATE_ADAPT_NONE ? "no rate adaptation" :
>  			   syscfg->rate_adapt == AQR_RATE_ADAPT_PAUSE ? "rate adaptation through flow control" :
>  			   syscfg->rate_adapt == AQR_RATE_ADAPT_USX ? "rate adaptation through symbol replication" :
> -			   "unrecognized rate adaptation type");
> +			   "unrecognized rate adaptation type",
> +			   str_enabled_disabled(inband));
>  	}
>  
>  	return 0;
> -- 
> 2.43.0
> 

Here are the logs when I boot up with a 10M link:

[   10.743044] Aquantia AQR115C stmmac-0:08: Media speed 10 uses host interface sgmii with rate adaptation through flow control, inband enabled
[   10.757965] Aquantia AQR115C stmmac-0:08: Media speed 100 uses host interface sgmii with no rate adaptation, inband enabled
[   10.769857] Aquantia AQR115C stmmac-0:08: Media speed 1000 uses host interface sgmii with no rate adaptation, inband enabled
[   10.781840] Aquantia AQR115C stmmac-0:08: Media speed 2500 uses host interface 2500base-x with no rate adaptation, inband disabled
[   10.794346] Aquantia AQR115C stmmac-0:08: Media speed 5000 uses host interface 10gbase-r with rate adaptation through flow control, inband disabled
[   10.808358] Aquantia AQR115C stmmac-0:08: Media speed 10000 uses host interface 10gbase-r with no rate adaptation, inband disabled
[   10.827242] qcom-ethqos 23040000.ethernet eth1: PHY stmmac-0:08 uses interfaces 4,23,27, validating 23
[   10.836812] qcom-ethqos 23040000.ethernet eth1:  interface 23 (2500base-x) rate match pause supports 0-7,9,13-14,47
[   10.836817] qcom-ethqos 23040000.ethernet eth1: PHY [stmmac-0:08] driver [Aquantia AQR115C] (irq=318)
[   10.836819] qcom-ethqos 23040000.ethernet eth1: phy: 2500base-x setting supported 0000000,00000000,00008000,000062ff advertising 0000000,00000000,00008000,000062ff
[   10.851865] qcom-ethqos 23040000.ethernet eth1: Enabling Safety Features
[   10.882611] qcom-ethqos 23040000.ethernet eth1: IEEE 1588-2008 Advanced Timestamp supported
[   10.895207] qcom-ethqos 23040000.ethernet eth1: registered PTP clock
[   10.902334] qcom-ethqos 23040000.ethernet eth1: configuring for phy/2500base-x link mode
[   10.910654] qcom-ethqos 23040000.ethernet eth1: major config, requested phy/2500base-x
[   10.918790] qcom-ethqos 23040000.ethernet eth1: has pcs = true
[   10.924787] qcom-ethqos 23040000.ethernet eth1: interface 2500base-x inband modes: pcs=01 phy=00
[   10.933809] qcom-ethqos 23040000.ethernet eth1: major config, active phy/outband/2500base-x
[   10.942388] qcom-ethqos 23040000.ethernet eth1: phylink_mac_config: mode=phy/2500base-x/none adv=0000000,00000000,00000000,00000000 pause=00
[   10.966344] qcom-ethqos 23040000.ethernet eth1: phy link down 2500base-x/Unknown/Unknown/none/off/nolpi
[   12.819779] qcom-ethqos 23040000.ethernet eth1: phy link up sgmii/10Mbps/Half/pause/off/nolpi
[   12.825947] stmmac_pcs: Link Down
[   12.829539] qcom-ethqos 23040000.ethernet eth1: major config, requested phy/sgmii
[   12.831998] stmmac_pcs: Link Down
[   12.839683] qcom-ethqos 23040000.ethernet eth1: has pcs = true
[   12.843123] stmmac_pcs: Link Down
[   12.849121] qcom-ethqos 23040000.ethernet eth1: interface sgmii inband modes: pcs=03 phy=03
[   12.852546] stmmac_pcs: Link Down
[   12.861109] qcom-ethqos 23040000.ethernet eth1: major config, active phy/outband/sgmii
[   12.864535] stmmac_pcs: Link Down
[   12.872724] qcom-ethqos 23040000.ethernet eth1: phylink_mac_config: mode=phy/sgmii/pause adv=0000000,00000000,00000000,00000000 pause=00
[   12.876094] stmmac_pcs: Link Down
[   12.891394] qcom-ethqos 23040000.ethernet eth1: ethqos_configure_sgmii : Speed = 1000
[   12.892094] stmmac_pcs: Link Down
[   12.900109] dwmac: PCS configuration changed from phylink by glue, please report: 0x00040000 -> 0x00041200
[   12.903555] stmmac_pcs: Link Up
[   12.913473] qcom-ethqos 23040000.ethernet eth1: Link is Up - 10Mbps/Half - flow control off
[   12.916679] stmmac_pcs: Link Down
[   12.928659] stmmac_pcs: ANE process completed
[   12.933133] stmmac_pcs: Link Up

Although unrelated, I found it weird that the link comes up in half
duplex mode for 10M. To enable full duplex, I have to manually do it via
ethtool. I will try to connect a different link partner tomorrow, just
to rule out any issues on the other end.

	Ayaan



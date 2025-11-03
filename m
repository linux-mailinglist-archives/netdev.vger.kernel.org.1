Return-Path: <netdev+bounces-234984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20194C2AA92
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 09:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43AE94E8618
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 08:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849B92E2665;
	Mon,  3 Nov 2025 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gIsyvSkZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YGIzDPz4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0772C2DF6F8
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762160317; cv=none; b=qKgBR98GWOQDCOHBZsJYfYsYP9PvzK1p+Rx/r8bLwb8VhM4oWh1py6kPs6pR7DgZC9Cpjbz0wgiFb0v+Jf7u0gF8DBg9hblypIjlozGy3tKtgRi7/oJH9D/gtwrmudAjhGZWJ7AXuiHk/kE35JGHIjV+yRO/OwAbgPWgHD6JjTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762160317; c=relaxed/simple;
	bh=3v0N22QuQR0w9tFPdor0L6ZhqpkZIwkaDx3N1PLlLXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+NKkDn0X7GdgdzCFryCjfJW2ylm2mbDuKPUWZvs+j3atusWKtSW3QMOMRxf9HyPpLG2mEvXpOCyHl4Mj23NJQaJVKKI1OAHSMfoHe4d8u/wBgA8nFQYLc5yAQK5DFyVSdee2/yj3oUk5pWYfVdlLBeET60M+5+5oF2STJje9pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gIsyvSkZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YGIzDPz4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A36BH4l2267853
	for <netdev@vger.kernel.org>; Mon, 3 Nov 2025 08:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=24U/P21yAhIHR6ao9I05xoum
	vaOn7aHOYNLWI3fMklM=; b=gIsyvSkZy/hNlt+P/kBl3JMlADcBnVq11LYn4j5N
	RRVwFToKaveyEEMs4oLH9PaNOdMFc9UT2jq/mycTed3n1ptKGZAwBU2lXQP2qlAi
	yymIGDiz8HXnpEQ+HNwytqKIHZHqba6X48u/roUkFvsJRBMXkbCOZTiW6iMEc6Ez
	thjF3/YJuw3u1kMPkFiOmTv+goNISxeQHYZD7TbXFHXxuLPeIlPDAQK04uGrivhF
	XSPMj3TuURiBaIUpa2ZNFK7lPMt8gJkmw/IcVuz/05abz7D8af6Mm7LnRLmp59My
	0ugUHaerL0xVy041N4OB4OVJUquadIZLPg89IlZ0q8+Ohg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6pwaggnj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 08:58:34 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2956a694b47so16214795ad.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 00:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762160314; x=1762765114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=24U/P21yAhIHR6ao9I05xoumvaOn7aHOYNLWI3fMklM=;
        b=YGIzDPz4xQpPGti1hfHHaIUs7rDBHc+FzHGWgbOeB/VsEkzaqtgxuxOSzv+XT/qPDy
         +azVeMyJEnjFz9K33RX9muVGzX5TodyPKvVAZTYpoOHGAMsO7tjvmT/hl1J5VcpXG8i8
         YxC1Kxw1z7ZLc8j1hPcOGdfZmSc4bTAmTzclu+B/CD8ohl1IXY6KtIzApMbh4L/c0ofF
         XIhS052AnhrjXjJy6MJQIozRfm+niTT+lRahk+sQn9INyCR0c5j0POK5NZFjaPMdLmQu
         lEWbYfiMFCMKOqF8QFhk6GiHwRxXloATvmkfifcyMq9mFV2i3+EvOpYqyd9E+MtGCytd
         8rBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762160314; x=1762765114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24U/P21yAhIHR6ao9I05xoumvaOn7aHOYNLWI3fMklM=;
        b=lNbv9jnZyjTJxpqaPtSM3sE7NZc8Mpu7NCoOnax1h3P+75drhcUgjw3vnISYR603An
         wWG7YrpDtOZG43N+dQoMpW0CCMFwpt2aODeGId6//PH0REYRkqlhIfPAPQoHktlD93Fy
         4X7c5I6jBVHrAE2ZTj0xv7wxnFgWBstkCrK78FP9sElEJA4lwmyXU5HJDgcpO5DDY7HY
         LzIL+EDaoL1aPT1FbmMVKODTtzotA6uqDXp70zBS/NwTDVyWk/gab8tTxZ/vuUsmCST7
         zLXZVJjKQ0AkrFjPozk6zhqcObYAlhCoT5RVNW7p7wOTvbVhr9uuocitieZ8aS4z02tg
         8GSA==
X-Forwarded-Encrypted: i=1; AJvYcCUJTeO1GxqZAi1YPmmCiD8mu6umJgZ3NlT63MYPmId9hLOz9mr05qAODimArBN6V0jg+yivM2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8KUD7ZYZJb9WEdhKwndQAXNnxqy1waNIEPgNvU0z+MFCZ5CBD
	hibOIHJQ+OPybcUnOnKQ0l8Yty5mhdELSOaUkBpJLqbND6SONn17yushJ9yyQNFUOSkQ3olOM11
	wc4iNUsSgapZbZ/NSGEJ3Vq+uno6iXwrX8XpwVFiWNCC/ZFpMuG38P30vEXM=
X-Gm-Gg: ASbGncsYH1KhF9lpvOxa27/l/tJfjwl8vtTG9PM1u6PEfQHRSK54e/Ij2kCgbsMTmAg
	D3+PiSFd+Vdijrk3P2Zn765b04ga3ebRe27XF9xOJ8aIVNV0iIRt6fQVOSAT+lMHNJVTYs9aVDp
	SM+AsQk/aYmhjT2SSvbQIOFreuZVHNrnIpF5GtPq7SY33jDftk/h1QeCM/yjwrTo53cf1oIDQJH
	QMJEbNqr8+ijq2c/p4jymmTVMKMBe5X54QMRY4Gr88NWc5Q5HAEvvnnjrtjuwlqQzYHP2l/WP8c
	IkHx5lP1jR2/+oi8wqgG/IyZNQ2jFS6X+dOMTRidITOUl1lz7YAI5DLrjhDFOEE+eW/sRwjUxih
	HQ/LDPXmFK91G
X-Received: by 2002:a17:902:c405:b0:295:426a:77a6 with SMTP id d9443c01a7336-295426a786amr114541665ad.32.1762160314046;
        Mon, 03 Nov 2025 00:58:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCIJI3R8udQvqnXnErxlmj0951sOi8WiW5KGVY7kXreBHT9GpCTkmGTuANv6IuF/RSmhXY+Q==
X-Received: by 2002:a17:902:c405:b0:295:426a:77a6 with SMTP id d9443c01a7336-295426a786amr114541215ad.32.1762160313415;
        Mon, 03 Nov 2025 00:58:33 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29531a1965esm105434655ad.6.2025.11.03.00.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 00:58:33 -0800 (PST)
Date: Mon, 3 Nov 2025 14:28:24 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
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
        Vladimir Oltean <olteanv@gmail.com>,
        Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH net-next 0/3] net: stmmac: phylink PCS conversion part 3
 (dodgy stuff)
Message-ID: <aQhusPX0Hw9ZuLNR@oss.qualcomm.com>
References: <aP03aQLADMg-J_4W@shell.armlinux.org.uk>
 <aQExx0zXT5SvFxAk@oss.qualcomm.com>
 <aQHc6SowbWsIA1A5@shell.armlinux.org.uk>
 <aQNmM5+cptKllTS8@oss.qualcomm.com>
 <aQOB_yCzCmAVM34V@shell.armlinux.org.uk>
 <aQOCpG_gjJlnm0A1@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQOCpG_gjJlnm0A1@shell.armlinux.org.uk>
X-Authority-Analysis: v=2.4 cv=OrdCCi/t c=1 sm=1 tr=0 ts=69086eba cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=PHq6YzTAAAAA:8 a=RUCXIr6eBFmux7r5iq0A:9
 a=CjuIK1q_8ugA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-ORIG-GUID: 2fircIJk92fo_OJJAsrXUmJPzHxjC5v4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA4MiBTYWx0ZWRfXzgLimzdmZi8D
 L4pJdPqUXT9ahqzOhwmQ/YHM/aRu0sTXkwkFapuViDc0p58iBMjOqf8oB10ImPZ65EkVRQCLJPl
 iq1GjHGVXdcx4Ajw25OQWkTE9D4WZhMntCku8sFMXbEFWRIdRsw0KMllwj7hyTEkua8X5C2vO3f
 hqMuNqt80OYpZL11ugi2RoOoH7pXwx7WaREwfnpaQh41Nb4k5q7EoG8sqdIypgDYfrkdBfOY9sy
 ANtNEwNL/KjvFUv8HMZzOiLefXcAyFkOvLK43doAz6efTQ4AHjJghn4Cp5ItB/X2GEkDYvyakUW
 49s3DxtuMzH8sRpfbLzClB8v5TYKE5ThmBgrUfRFSrQkzERaCdii/5tweN5GBkA4Ct4yAhqNqU6
 hA4QpXxmQSu3K9o/vUMr3DPKy4ePYQ==
X-Proofpoint-GUID: 2fircIJk92fo_OJJAsrXUmJPzHxjC5v4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030082

On Thu, Oct 30, 2025 at 03:22:12PM +0000, Russell King (Oracle) wrote:
> On Thu, Oct 30, 2025 at 03:19:27PM +0000, Russell King (Oracle) wrote:
> > > 
> > > This is probably fine since Bit(9) is self-clearing and its value just
> > > after this is 0x00041000.
> > 
> > Yes, and bit 9 doesn't need to be set at all. SGMII isn't "negotiation"
> > but the PHY says to the MAC "this is how I'm operating" and the MAC says
> > "okay". Nothing more.
> > 
> > I'm afraid the presence of snps,ps-speed, this disrupts the test.
> 
> Note also that testing a 10M link, 100M, 1G and finally 100M again in
> that order would also be interesting given my question about the RGMII
> register changes that configure_sgmii does.
> 

Despite several attempts, I couldn't get 10M to work. There is a link-up
but the data path is broken. I checked the net-next tip and it's broken
there as well.

Oddly enough, configure_sgmii is called with its speed argument set to
1000:
[   12.305488] qcom-ethqos 23040000.ethernet eth0: phy link up sgmii/10Mbps/Half/pause/off/nolpi
[   12.315233] qcom-ethqos 23040000.ethernet eth0: major config, requested phy/sgmii
[   12.322965] qcom-ethqos 23040000.ethernet eth0: interface sgmii inband modes: pcs=00 phy=03
[   12.331586] qcom-ethqos 23040000.ethernet eth0: major config, active phy/outband/sgmii
[   12.339738] qcom-ethqos 23040000.ethernet eth0: phylink_mac_config: mode=phy/sgmii/pause adv=0000000,00000000,00000000,00000000 pause=00
[   12.355113] qcom-ethqos 23040000.ethernet eth0: ethqos_configure_sgmii : Speed = 1000
[   12.363196] qcom-ethqos 23040000.ethernet eth0: Link is Up - 10Mbps/Half - flow control off

Nevertheless, I manually updated RGMII_CONFIG_SGMII_CLK_DVDR to 0x31 and
did not observe any issues with 100M and 1G (and 10M was still broken).

I tried to dig around for information about the particular register
update and found basically the same thing as Konrad.
1. B(18:10) - RGMII_CONFIG_SGMII_CLK_DVDR - It defines programming value
for Divider 20. This field is used for 10Mbs mode operation in RMII and
set value of 9'd 19.
2. The programming guide for this IOMACRO core mentions that the field
needs to be set to 0x31 for 10M link.

I am inclined to believe that the register description is a typo (as the
reset value of this field is anyways 0x13). The 0x31 value is
recommended for only 10M. For other speeds, it mentions the default
value of 0x13.

However, that does raise the question of why setting the field to 0x31
is not impacting 100M/1G. I will try to investigate more on this. But
right now I am trying to prioritize on verifying 100M/1G/2.5G links as
those should be more common. After that, there's still the issue of IQ8
only advertising support for 2.5G.

	Ayaan

> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


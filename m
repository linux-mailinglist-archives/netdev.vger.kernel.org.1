Return-Path: <netdev+bounces-235056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21416C2B9C9
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 13:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18CDE4F31E4
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 12:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11256309DD2;
	Mon,  3 Nov 2025 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pqb0b5m0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iXBFiCbU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8083778F2F
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172268; cv=none; b=Cip/RyriTQ/HDLW9SDVM4F5v9tEtDoG0t0lVxfI+hkQQb9OOOAGIHHhypx7DR11RGeUohFQeeXdbsUqSuImML/t1+ZjFcv07YB/Omt1SwYZjQeeir8aAr2nrmpY9GzV8FVaGG3dDrLAQmM2CYQLfHP59/4jgDXF4KROVwpmtAk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172268; c=relaxed/simple;
	bh=bA+gs0P1eISD6FLo7woFckNwmEyK0P5ec36lx7dCgz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPwiGcHu+9v6dOgz7ysKA4/zcd18JFxIIKi2OZ7idZqo8mdomcNO7paIlDStxotQRM0xD0jn8QsOcdYr8vQCJhzvepM3ZtCTheAQeTjePGa1gl7/TMcWsGjXERPy4GFNqdABm7GOxm8HL9tgcA7RV7fign3HyMQii3BE2jwndjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pqb0b5m0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iXBFiCbU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3AIUo12755762
	for <netdev@vger.kernel.org>; Mon, 3 Nov 2025 12:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZWLtXDn6y7nGmkcEsraLlFmo
	QbxgqaYx7SxZvmnC95k=; b=Pqb0b5m0HDGsitHhufbYsYt3yvsRLDBHc+EANvD2
	9F9FnEMheGDP9pUHAIpYFHoQug11F45f9QUWvc7Zjwnun1UaYI4yaoI/3yLsAHd1
	YCtvKolV9jShUjXCl8iKNL9JZjjZvoK3MH5IH4f/tdidFQ5PL4XODYnhb0Gs79uQ
	IoJi8v82gOW0CIVPR73hVKnhsKs4CAKW/osObsPOa2g75tNfQYrVo8iFP7GEj6Pm
	XxalGZB6cAHXcY0s9nUhmIOTukFh3vjc2NOcG4QWQPN7G32jWZIBQWh9I6I6dJEt
	QwxKQC6O88MZM8mrhXhGGfkJuMblPH7Xt9HD3CXZthdwyQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6th9r99a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 12:17:45 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6cff817142so3063590a12.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 04:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762172265; x=1762777065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWLtXDn6y7nGmkcEsraLlFmoQbxgqaYx7SxZvmnC95k=;
        b=iXBFiCbUzBlbMd1r8cBbcNGKeeOEERR9GjpxgXpcwBcTpJeP/dTDKoqcBmTTnJayNs
         /LN5HeGAeoZ31CyyxY5NNZ1bIFexNzDG/xyOuhWl9ufmm69HNh0xw7YFORQl7V71unyG
         7yZ4eZg2IXlU43eVSmm1OdLyoFE7Ih/8iayJc2JOo2r7X4ZfFSSoFxB2hJWWXQ+qDVBZ
         O8EJW5ubLEnoYOL3V1pq+72mRD5VSs+A+cFI5VA+5VuV3T/QnywT5n88aXKNZ6fuuNoZ
         1Wfjw2ep+Kr49Bq3oZbx0hyg6M6ezV+TI/VPAD/ySFiwsVUxpfGdgM4rIvEosQvFfYX9
         o6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762172265; x=1762777065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWLtXDn6y7nGmkcEsraLlFmoQbxgqaYx7SxZvmnC95k=;
        b=mFhNLNKO3UGpzvCTFpoH+8EDYHp1vOeERP+yjkbvl7dupoHyI3EDB3Y4WJXEIIOKFb
         TrMVEobJVk8BQ1SDLY5Zny9w3nVTRGnZ0hcoh874bCyWZLSF2lSmP690ZusSscapz68k
         Cz/EGmQv0yn2E6C7NtJZCLNFDact31aMhXgXi2TLx6520Q/X2Ic728vWF6Dtjp7zcHbd
         V/E5sz07Dhxhouk09sB7avUFwAFiUs3geNeIZi8Df9hPLsflZN9ix7KCjzhSK++ELU/F
         9EY9LCCnA7fuwlxuck+zsN9b341VZFkjdjDl08Sgji+H5Qxg2/r6De9K66bD7TxUv8u4
         4fsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhrVGOdXe4p0sS4jxSHHMdXbqZBACjHdrn5tNq+GtF4oh4r7xq0LIQnbn8IcJgXEITf7PW/Qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuTye0Beny/cctByMDDWggMBhuS62Mu268E+OMcb00FT+tKcly
	S+gGJMsiEsuplpAaNsmrS8w04RFhfgcgHLdFCIfU88CpK9DdmGzA4KTuP0dD1IpeY+y3x6gIFbL
	qnWfAK0+3XBxJMyvyS0Mjpgd/+uYxL7QjLJ2/8lWZla3rWcE6Eb3JqM5SqWM=
X-Gm-Gg: ASbGncvbQrbnGEEvCpR5VAqP9seAHBoJjy1De+qdzj4AgMsLLCouRv0iVv6zCagBHY/
	GO7wyfnoKVvtDsLIdpZap5PyrLs5AfKeMpFp4N578uaWBBzlkBBbRFfaPMrx7Rwh2MFoZs/Qjol
	/ohWTN8vmIKhzhOto85IgchMJxEuNAmpyS80rFGgpDTP2pfvDn54Y/35BAuKN8MZ2VmndLw2jhU
	NVmO6HKd3G8es4rghx2S1l+MOT6thmU8JPYBP3r7EKlkKKKTMuOguWm2Y41j7XsJN89WTibxSKm
	PyWdI76e3MN9rs2+cPakm28Sp6mKcPWSGa3RAQ+G12dgkaDHDCTe1khF6DG82txOJzM/4uCSnuT
	c55sISqgJ8/ZL
X-Received: by 2002:a05:6a20:7f96:b0:334:89c6:cdeb with SMTP id adf61e73a8af0-348cca003c8mr15764671637.56.1762172264659;
        Mon, 03 Nov 2025 04:17:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE684E5CNdnLqZ8LrjHHapbK4k//kPutpzHfK5KHya4nfTR8e77rbPAda3wA4b8obXBE8KQPw==
X-Received: by 2002:a05:6a20:7f96:b0:334:89c6:cdeb with SMTP id adf61e73a8af0-348cca003c8mr15764617637.56.1762172264108;
        Mon, 03 Nov 2025 04:17:44 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db197335sm11262090b3a.47.2025.11.03.04.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 04:17:43 -0800 (PST)
Date: Mon, 3 Nov 2025 17:47:35 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
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
Message-ID: <aQidX6SPDbOQ5WKU@oss.qualcomm.com>
References: <aQHc6SowbWsIA1A5@shell.armlinux.org.uk>
 <aQNmM5+cptKllTS8@oss.qualcomm.com>
 <aQOB_yCzCmAVM34V@shell.armlinux.org.uk>
 <aQOCpG_gjJlnm0A1@shell.armlinux.org.uk>
 <aQhusPX0Hw9ZuLNR@oss.qualcomm.com>
 <aQh7Zj10C7QcDoqn@shell.armlinux.org.uk>
 <aQiBjYNtJks2/mrw@oss.qualcomm.com>
 <20251103104820.3fcksk27j34zu6cg@skbuf>
 <aQiP46tKUHGwmiTo@oss.qualcomm.com>
 <aQiVWydDsRaMz8ua@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQiVWydDsRaMz8ua@shell.armlinux.org.uk>
X-Proofpoint-GUID: yEvlHzSHEp3otMVhNWgW1t9AR1AE6exo
X-Authority-Analysis: v=2.4 cv=ea8wvrEH c=1 sm=1 tr=0 ts=69089d69 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=PHq6YzTAAAAA:8 a=XsfPzZo74fLR1ronddIA:9
 a=CjuIK1q_8ugA:10 a=bFCP_H2QrGi7Okbo017w:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-ORIG-GUID: yEvlHzSHEp3otMVhNWgW1t9AR1AE6exo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExMiBTYWx0ZWRfX42nhkNyAjlod
 OXM/50pCiUF7sU714dNdBDIUDMtDCnn1Std4PzkqEgKWBVNTWIeIoY2qhqMu4u0UaZwa70TeLz4
 On97zirEK6/k0191vch+jisTMmvO/I3/u+ptqpboVA/q1/nMGhZRtMfYgB3FfnZ3DHjDwsfeZ7/
 yLLZIX7tU6QvH4Y5aUJEqINO1pajRkgstK8OkPgXr+sUvP6eQ5m9ateaNp/O40LzE90Zx/Sofqc
 AZso8jjFVPy61a0dSMU4+ea6i+wbyc6FT/KqyczR4H+VOo5KRpOxTtJGpMOBFpovvxx1jdMiGlA
 8Q0k0kSBAKUcyTQv8EGtCdMQIlrafsCmZwBtSV87xUyBjT3ScZCtfEWnANG8LCd3f6WJgU95e9E
 /28sUCehBgy7nswrkJyP+xxLQd7j9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030112

On Mon, Nov 03, 2025 at 11:43:23AM +0000, Russell King (Oracle) wrote:
> On Mon, Nov 03, 2025 at 04:50:03PM +0530, Mohd Ayaan Anwar wrote:
> > On Mon, Nov 03, 2025 at 12:48:20PM +0200, Vladimir Oltean wrote:
> > > 
> > > As Russell partially pointed out, there are several assumptions in the
> > > Aquantia PHY driver and in phylink, three of them being that:
> > > - rate matching is only supported for PHY_INTERFACE_MODE_10GBASER and
> > >   PHY_INTERFACE_MODE_2500BASEX (thus not PHY_INTERFACE_MODE_SGMII)
> > > - if phy_get_rate_matching() returns RATE_MATCH_NONE for an interface,
> > >   pl->phy_state.rate_matching will also be RATE_MATCH_NONE when using
> > >   that interface
> > > - if rate matching is used, the PHY is configured to use it for all
> > >   media speeds <= phylink_interface_max_speed(link_state.interface)
> > > 
> > > Those assumptions are not validated very well against the ground truth
> > > from the PHY provisioning, so the next step would be for us to see that
> > > directly.
> > > 
> > > Please turn this print from aqr_gen2_read_global_syscfg() into something
> > > visible in dmesg, i.e. by replacing phydev_dbg() with phydev_info():
> > > 
> > > 		phydev_dbg(phydev,
> > > 			   "Media speed %d uses host interface %s with %s\n",
> > > 			   syscfg->speed, phy_modes(syscfg->interface),
> > > 			   syscfg->rate_adapt == AQR_RATE_ADAPT_NONE ? "no rate adaptation" :
> > > 			   syscfg->rate_adapt == AQR_RATE_ADAPT_PAUSE ? "rate adaptation through flow control" :
> > > 			   syscfg->rate_adapt == AQR_RATE_ADAPT_USX ? "rate adaptation through symbol replication" :
> > > 			   "unrecognized rate adaptation type");
> > 
> > Thanks. Looks like rate adaptation is only provisioned for 10M, which
> > matches my observation where phylink passes the exact speeds for
> > 100/1000/2500 but 1000 for 10M.
> 
> Hmm, I wonder what the PHY is doing for that then. stmmac will be
> programmed to read the Cisco SGMII in-band control word, and use
> that to determine whether symbol replication for slower speeds is
> being used.
> 
> If AQR115C is indicating 10M in the in-band control word, but is
> actually operating the link at 1G speed, things are not going to
> work, and I would say the PHY is broken to be doing that. The point
> of the SGMII in-band control word is to tell the MAC about the
> required symbol replication on the link for transmitting the slower
> data rates over the link.
> 
> stmmac unfortunately doesn't give access to the raw Cisco SGMII
> in-band control word. However, reading register 0xf8 bits 31:16 for
> dwmac4, or register 0xd8 bits 15:0 for dwmac1000 will give this
> information. In that bitfield, bits 2:1 give the speed. 2 = 1G,
> 1 = 100M, 0 = 10M.
> 

This is dwmac4 and I got the following values with devmem at different
link speeds:
1. 10M:		0x00080000  => Bit 2:1 = 0
2. 100M:	0x000A0000  => Bit 2:1 = 1
3. 1G: 		0x000D0000  => Bit 2:1 = 2

> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


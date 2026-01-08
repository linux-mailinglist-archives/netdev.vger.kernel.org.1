Return-Path: <netdev+bounces-248029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C315ED02561
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 12:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D88B31CCB21
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 11:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815CA3D3D10;
	Thu,  8 Jan 2026 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="V0hyD3JK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46D33D3D06;
	Thu,  8 Jan 2026 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767866748; cv=none; b=b81pSks89NaEtrSk565CofTYepayNgJ38g4rziF/mXZK5A3e/2rpm1pGlJlaj1ieZiEUn2oInhSIPX1qLzicMAmc++RkxjYqDQa/aAysAXEal+38xvkWndjinWwuK2X6Eq18X0yvFEDDfB4ox2FtM67d55HIwBnoVZgfm3kmUsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767866748; c=relaxed/simple;
	bh=XMkwXayjCzPZQIoKrghk+AI8rddAh7OXJnvhpON1SI4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiMfZtTxg6SRS/L/ujRvMAeIylefKEOA63KpIR/Ov9B9iDz4/X0zoJw5OHDwcHKOOnlPF1rnmR4Gk6bqZiYD2ThNB9rzMumSjk+mGggMXIeTfKXgWrgOM908YV4ivfSJs/tgOZXuMUvmntAERznp17j8DD+y4fLyuWWyPlCzBvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=V0hyD3JK; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607MJEkg1058250;
	Thu, 8 Jan 2026 02:05:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=qro90WFnBng8Fsvr48rpqiHDG
	Pv9Fdvw6hm+RVDF42w=; b=V0hyD3JKCU3LRgXTm07ukzVLoNZq1OSeQDEbODRHb
	CbN0RwWvzqt6vfA884z4iN/2zkukjuvWhPtQETXKvm8DYlGxBsv8AhXI3gLnYGfd
	D/FTx8ZxB3LfUrPF/GFFl+IPbJQBr/0bL1OsxNm05e3vWQHuWZQWWaneozxW/7hR
	ma5vNKzo38z5aF2o/4HOTZ47CUammxuNUOWF18iArEXXuCLEeQbDNN9IsZdRDxui
	Ye3oyhTZS8ClJgSkYML95qsRnajGr0pE+o8jFmPnBNRsRerc+qYbHDcQ8HuDgeve
	/nBvMcwXiEtLhu+3hF0zZbjLILzZiODJdaCoYyf3gY4Nw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bgf3fym7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 02:05:32 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 8 Jan 2026 02:05:32 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 8 Jan 2026 02:05:32 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 2B1383F7091;
	Thu,  8 Jan 2026 02:05:28 -0800 (PST)
Date: Thu, 8 Jan 2026 15:35:28 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <sgoutham@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 09/10] octeontx2: switch: Flow offload support
Message-ID: <aV-BaKNhJJMM-GIE@rkannoth-OptiPlex-7090>
References: <20260107132408.3904352-1-rkannoth@marvell.com>
 <20260107132408.3904352-10-rkannoth@marvell.com>
 <f8d9d910-e2bf-42cf-b15a-b6624c0bda56@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f8d9d910-e2bf-42cf-b15a-b6624c0bda56@oracle.com>
X-Authority-Analysis: v=2.4 cv=PLgCOPqC c=1 sm=1 tr=0 ts=695f816c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=fx7Rj7giRjSIOVbTE-wA:9 a=CjuIK1q_8ugA:10
 a=8_z660xuARpGUQqPBE_n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA2NyBTYWx0ZWRfXzZdrP1kGVnON
 3PM2HWO7Dq9op+12PPCPQ3DXTFPRAKMudtnxcDaKBUuxXlF0ENuDpq0uByAyNHD8BqO47chQrIX
 3JvxKJuXkaAPa2+GbVatLQ0Ip4ZnkqFuazHCQ8Ql7xIF9UnQK6j8aDmCCUhDNiIYkluYpkfmREv
 KZLp2HRj/CunCIPBbdk8UYikuYYGOiNLNgwpxtCxxIDv6/vu2dgv+mNmXfj1cZYBAuGLXupk4r1
 hpve1FlX/xvIQg4vgMpP3h17tEeGNx31TlWNrf9Qfm4yDkgGvy4dwZE5aM47aelc/WurI4pNy33
 jGsDYM6MnQ3A5xSAv5LMF70LT1rsn+WJkDXkp3+y4Q71XgAQW6zsyFCY3qeMsYoV0DmgJW7wX7+
 UjSrgAtg5xXx67vxu5nICserbLsbxLpuAyw3WGrVAhvihDwCSe2y9bSh/l9SMPV32bw9qMCybIb
 2rA0hLWEmEaBB07LPwQ==
X-Proofpoint-GUID: igYmndpY7_jxkoUNs3uNOIFnnR6IpJgc
X-Proofpoint-ORIG-GUID: igYmndpY7_jxkoUNs3uNOIFnnR6IpJgc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01

On 2026-01-08 at 14:39:11, ALOK TIWARI (alok.a.tiwari@oracle.com) wrote:
>
>
> On 1/7/2026 6:54 PM, Ratheesh Kannoth wrote:
> > +	err = sw_fl_get_route(&res, dst);
> > +	if (err) {
> > +		pr_err("%s:%d Failed to find route to dst %pI4\n",
> > +		       __func__, __LINE__, &dst);
> > +		goto done;
> > +	}
> > +
> > +	if (res.fi->fib_type != RTN_UNICAST) {
> > +		pr_err("%s:%d Not unicast  route to dst %pi4\n",
>
> %pi4 -> %pI4
ACK
>
> > +		       __func__, __LINE__, &dst);
> > +		err = -EFAULT;
> > +		goto done;
> > +	}
> > +
> > +	fib_nhc = fib_info_nhc(res.fi, 0);
> > +	if (!fib_nhc) {
> > +		err = -EINVAL;
> > +		pr_err("%s:%d Could not get fib_nhc for %pI4\n",
> > +		       __func__, __LINE__, &dst);
> > +		goto done;
> > +	}
>
>
> Thanks,
> Alok


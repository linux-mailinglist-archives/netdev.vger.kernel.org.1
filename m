Return-Path: <netdev+bounces-257106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CR9I/ZwhGnI2wMAu9opvQ
	(envelope-from <netdev+bounces-257106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 11:29:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 320C6F14BA
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 11:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93CA73008C2B
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 10:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EFE3A6407;
	Thu,  5 Feb 2026 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IqoVJ+Yw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iP8X/7yb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCF33A6402
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770287348; cv=none; b=KtqL5lafO9V4p/CrZBGNQJzOmrsmEMt46OvBWV5ULIFvF9J3q0vmnJEkMgzIX6UacdJs7IHjQpmF4IEh6LODnmPOozHPXLJiUM7c237kmxQnnyQcYShUpF2UzsYLvbK6HOwSSk7zAHI0mdZd0Vw9WNHalXa9DH/dbmLANYBZ2DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770287348; c=relaxed/simple;
	bh=KkhwwxKoa0sjlvwVH2E+K+JM5PAZw/cFTOykkt23HoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWDEJWLBA2HfmhCkPlm8IkzwSNm11wdBNHfgtCykmq8ZTkpct943dp+19N276qPB4rl8IRDfPDeWvYs0v4AwhtqqbNMHjFeAC4/lkvPLkgbihqkO2pZtddKtVlmUCBTXKSMmWEEu7aP8Y8IpN3Bn/K8i689sAFMpxwbHw/9nJWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IqoVJ+Yw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iP8X/7yb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61555nIo3047819
	for <netdev@vger.kernel.org>; Thu, 5 Feb 2026 10:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7XgVQgH5FytF8RnzcwtnZGEm
	theQcG/boixIGeEwwMg=; b=IqoVJ+Ywp1NwX67gZQldLM2edKO+gK63/kiAldlL
	yGRfOw4bXyMBlR7nfp4Nv3ppUMZiDDEFk8dIMMbx66nZKrB935FoEXUoJ2w+D3/s
	BcLDC0BUTr8eOTMuXUmgDaHdyQyt78M0XwEA+DYEZfade/mPb1jmCZj8RHGqx9vj
	mu9XQkL3IEKvNg1f7dMCkkhN8WysFv8UltSG87KBCzFTTd4dB628tBEAVtViozzx
	BqjoTLX+bI3MyfXLhl7R6LH0PzXKQPQFPEJ0G8p+KfWnPOc3wNJetjAZ+pcol36t
	E6nQE9rnSbPPNx6UFWvhopekG88Jt62+mCTdo8q64NFVsQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c4mrtgxhy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 10:29:07 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so1538614b3a.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 02:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770287346; x=1770892146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7XgVQgH5FytF8RnzcwtnZGEmtheQcG/boixIGeEwwMg=;
        b=iP8X/7ybuzrLEAq0pNyKKd+iO3OTNLohXofMYIR8JnX5ahCuetemkS0M+P8G4Df1UD
         YH7K+uxIc+6kuI5lm0cioFYcPkw4gXANKK9RNnqfmW2ZXHMSsutmUCiJ23hJZ2W99vAX
         TkL/ErKXAolr9do+MgYWDZB4UHjEcYX3Qw9OKsxjjXx+RscFjNp8ttHEJUdtk6tbFh6O
         iyQ/wmunKr/Mi028XVZKbKl9myOEKJnrE335E6cRgWB7rqsxfeXFHHFFD7WAdvr6oXDm
         46aXOKcHkgaOmaEAp/9lqSEyxgrDo1t0QzSIEzGD4Qq/EJ3/3x8OTsl7ZURm7inbcB08
         uKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770287346; x=1770892146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XgVQgH5FytF8RnzcwtnZGEmtheQcG/boixIGeEwwMg=;
        b=flXdDn78cqykrvMxqAGkLxy/BP5YWv0hfzajdploLaRZCR0bqfrhbKqH53WYKVKrem
         UhEUXtrFn+m0RzS/lpMoy1RYzEam/QO3Z0xcAQhWRD49rcw2XKOxeMbvU8lrWwsBxlEn
         DztkDTy0s+1kyaWad/CSfqVuXPXVwaHJA21aJ6pf2ym2DOK8jodHelX6p9woPy9ZJVrP
         EiMy57ac1Hg+blVSldEkZd11IudPxk+YyF2ULapiabLlfqJg3t0mMPdSuhLLcFF1i3bu
         +HYalaWTIrKhk8Xyo5TfHu8we/vsOLcWTnMfJbH/EHjEpswEpOHXLxLpsLYK88yjoTVh
         4jlA==
X-Forwarded-Encrypted: i=1; AJvYcCXw+ZSaMNQ1L4dQLUDPgQMuvfEwUb7D5MkT6MjQrMQ0GQ2bZfMKqSAEDydvz6KQrt2XZ4dbgM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKqV2hAjmf6wF2saVSojGQV3yq228SyavsZPKQFeNQ0yNq1jIY
	8np3cmu3y1IXXQDtc7nWOzMs7ZEg+yXLns7luVaOBYqpvypI2q4xn2iGU0HvB7Q/0S5jPVSaLLh
	zbWwLWAm8A4HpSi/JRCI+uKoapSj5CJZjXXhhUPf69PxHoXoJnsxeCUNUYNQ=
X-Gm-Gg: AZuq6aKw6OpVj5Eygh6xFWr7GVBrKH8FnvEWgc29We2H74Y9gZ1r2PIkZTcNllNaiTA
	uiEP/+VMLn2D1Ra7wxnAlMpl2prttE5F+R3dH7+u48bD0iEukAF3vABiaqTWxyvYe9fzGTfDagH
	BHexYA4CPMrPqrz9d/TSltx7/hbILurJEfTHuqA7qR9RUXD3pDQU/0gxy+EDT2ap7sJae1jEwwb
	Tw47rp/pQ8HXOCYbwSYHKeYASjDaObm1vVfAoOvec3PqWH8AtjnVwriWsq3EWbpIhM4Eg7gollp
	DMD7MoQu7ZgEvMH6haqDPyp1pCATWgKZBPO/zNSytzYJC2HZr+RYRAVZm8YXUlew0soGyo2KSiV
	l636D8XVRBKWRj2/tWBlep9Q=
X-Received: by 2002:a05:6a20:3d8a:b0:366:1917:54cb with SMTP id adf61e73a8af0-3939025841dmr2317129637.3.1770287346156;
        Thu, 05 Feb 2026 02:29:06 -0800 (PST)
X-Received: by 2002:a05:6a20:3d8a:b0:366:1917:54cb with SMTP id adf61e73a8af0-3939025841dmr2317105637.3.1770287345619;
        Thu, 05 Feb 2026 02:29:05 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3549c09df19sm2040354a91.1.2026.02.05.02.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 02:29:05 -0800 (PST)
Date: Thu, 5 Feb 2026 15:58:59 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 0/4] net: stmmac: fix serdes power methods
Message-ID: <aYRw6xSvEYmpWnSs@oss.qualcomm.com>
References: <aYHHWm5UkD1JVa7D@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYHHWm5UkD1JVa7D@shell.armlinux.org.uk>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA3NiBTYWx0ZWRfX/7Jeax02eWlV
 Vt/Lszzc/jxZIbWVA8uMB5XwOD/mJp3crCPtiaZtPLQMXtGkTvrz/CV1jgmpir1s/TprSReyDkE
 2hPcxK+mGK5a7+2fdk2KWMibdG8sX7UGwtGGjrdPXu31IWJbF4UCNN+9ysiwiNpvYpQCy9tGymQ
 fOG7sjaOWUKYbfbuq+mzs/MN9wm5A9rYlCChEWniiQOWao5DcRpGruD8kEOyK1qmDGKtBUPmE/6
 zTyuBu4z+tk9ONarv84G5EhquXiKXF3j5f+RCrq1a6kM5iyEtRRNvSPcoIEbULLW0i+2FHNTqjH
 oHWelbx6pysz0X1O8/zCwTdlsLeryLdQVNfxP6kDa0xVJF61eIlCtnqt+OEcFk4vwMAa+ecBV5S
 4UerisZcBFnF8lcZLIZ+UE/FmP4aBNcXQaP2/rZ9pYNCRVUj7/OhMb/VnELbbhXUBWrkRaUmw7t
 8t6EO7zp2/XUukVex+A==
X-Proofpoint-ORIG-GUID: 9lClzYBn3i9I6yJ6VxKMZAlo2KwVUyPL
X-Authority-Analysis: v=2.4 cv=UoBu9uwB c=1 sm=1 tr=0 ts=698470f3 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=spYx4npwnBwiAfMOhkEA:9
 a=CjuIK1q_8ugA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: 9lClzYBn3i9I6yJ6VxKMZAlo2KwVUyPL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050076
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257106-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 320C6F14BA
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 10:00:58AM +0000, Russell King (Oracle) wrote:
> The stmmac serdes powerup/powerdown methods are not guaranteed to be
> called in a balancing fashion, but these are used to call the generic
> PHY subsystem's phy_power_up() and phy_power_down() methods which do
> require balanced calls.
> 
> This series addresses this by making the stmmac serdes methods balanced.
> 
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  1 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 65 ++++++++++++++---------
>  2 files changed, 41 insertions(+), 25 deletions(-)
> 

For this series:

Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

	Ayaan


Return-Path: <netdev+bounces-294759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xP1VHF4zIGoAygAAu9opvQ
	(envelope-from <netdev+bounces-294759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 15:59:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C42DE638527
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 15:59:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=bnMv+xfQ;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=HPOt61OM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294759-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294759-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06EAE30166D0
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 13:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E3633C53F;
	Wed,  3 Jun 2026 13:52:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28C93328FA
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 13:52:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780494735; cv=none; b=kjeK/boY6Ts5AXWow6DasyI7o0HKHKxZ5QqOOLOab9cmuMpZF4ss1saaPweML4zcJ7qsP7P2vdY3ySDm72FaJzRg5GoG50lqdIOgUUv1p51JgaOyWYURteqaAxabOHU0cxpQG1efPq5QWiq52MXjOmQ/He0+yB70Y9xAzdRPfnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780494735; c=relaxed/simple;
	bh=KMtEGmrA8m1N7KoJpVywfirfp33O1hFNJjUcBMTi9l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yqk52DIbgr1c6gQf5Q4xj74P8PdrcIyQxSScyUyEPMVeIfxJl1vUomQ+SiW3z954MNdoscFVBHxZVCWAMJAC4alkZN3xIre9EWCWVcu/5EQ2EkraH2JsNYXv6K1MpMAzmwUBLBZ/Kud4GdR9FuXkPIod8BBoarfv8c8BY/g+n8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bnMv+xfQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HPOt61OM; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653C2gbn1200143
	for <netdev@vger.kernel.org>; Wed, 3 Jun 2026 13:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LEAaW4KMsR0ywjUGKkykMwna
	d8EiVghRjvhmLV4s5e8=; b=bnMv+xfQYTdAjpRsy5U2bFaDDP+plpadUibJmKM9
	iTBQR/WkMLtJYmbIRQp3jQDdBq6bTHrH1I16D8yso18Wh7jMhaaB46ietSkWN+xG
	eF6HT0OJEMYRRodRl4BhDRW0x2lA5TTETyngkp2m+vFLpNHDm+j8n/T5m3qsUvwk
	i0RITu2DcEVLn7dViELM1BYwvjSYTXpr4TPTd/azCSmbI4s6c73qGPR+LTxQfEzK
	jC1ojnVxkNcAEoBPeevPTHYvP1BC68SaboT3HkJkIXTTa3UxhFoOlfioNEOijpqq
	cs3mZxWLGEUFH9nTYuQqcaHJLdseaM3zUhMPKTIACPBdQg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejckw29d3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 13:52:12 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6cff652cc58so6438813137.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 06:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780494732; x=1781099532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LEAaW4KMsR0ywjUGKkykMwnad8EiVghRjvhmLV4s5e8=;
        b=HPOt61OMK3qXqQCODRrJtQ21U0QIcswCVnJoR/m8mUNoI+THbitM+/jH181qqMpMDc
         PEs+N7tpi1v4DMTqc8IgFTezsC14u7V5zL1lPsujjmSMzpk5T9ttSpITBrTHra1XvPFa
         Lmfr6CGBv8QA2PCMYkc4QYgwL+OBUoiVqhJIcCGFS23XNHwMHZpFRQDY4JyXMX6g4NYs
         DEsevGxAFGCmPGZj0fzTsc+BQe9COwLk9YNpZexY5d0m7M+GpBVAICKd6o7Na2+h+Kz6
         xXCzyVa8td2zzNIRSaoe9eaQs+HePLFBHx6Sj6LfwfsWAU6ixAvRGXIcrnbdrFwg5d1z
         bw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780494732; x=1781099532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEAaW4KMsR0ywjUGKkykMwnad8EiVghRjvhmLV4s5e8=;
        b=aJUy9LcGE93ZBunvr3qtBpUAzuhGDKVWf3t31XufsYJHUd4TD8HK6FEHCZAfOLqlMj
         L6y0jr0vUfSX5C8NVubXQOxVzBxpIr5jESkgSAjeQPMtNYwS8EFECTUZDtzai2O69cER
         6iAj4qxS1qu5Qm3uc99zsySdryQ47i9XB++Ori7EoT8erhQTJQCaLr2aXolLShZN9otx
         VENgjbDVALfuLmJOYBApNDyQWodyYcCDWR2nfXaJdCDySM5xuhdvpd26CXp/MNmln8X4
         xQ3Vu7hFWLXYwNcgqFTwgqLRSCvgJDiIzc8Mj7FHqU1kIboSFH6yEnu7jjXUN/vHBwdX
         PrBA==
X-Forwarded-Encrypted: i=1; AFNElJ+8Eag5BjwQ5798YkaLbyjqbjLuVFp+Uzutr1eWLi18et3SJvWNcOk0jieeEa8KD9Arks0p+UI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyjNhbRJZBOzOg1ipRJ92/YDt2T38j68YR2y4QDIWpEkmKnQ50
	eu1Pvq1LIkR9i5Ud3x1borlUBle1ndhcpkHVj/jQwBAuNvuqcDfPeU1IGgBlwSu9IAYZgxlj689
	B49b/h+5sDPZrP+tURPNwRlsZ83xKzRSCA/l7mdXNwEA9GbxFFl0W/ct135A=
X-Gm-Gg: Acq92OEW4gdKU1dAZt5hntyJCVcG2Qm9VfmR2aiJHFORAonl2LAH+Eiy1S8vnTg88ai
	kbay5lQYDN/98PcRIIylBtB+Wph/q0/NyWYW2Ioep3Kob80Qmn+6NxNRBiEDyX204cYUgI4KVq9
	03QtUv07/tbXAJt+/PCZzX56QuEtAIC3JSH4zf8mcbiDXPAQy5lIHMvhVALmb03b1EYBvdRmTWm
	P6inxTGex0QL2SbYVrkDUXFNvJwk9bHQHThaZfhemaSJvZrCBgCKRa8AxlJBqV1tfepuSxQvon9
	hl6qg8ZqT91dtxG2Vs2Pcy99a3AeKsZZwNQHEiYK6t+1/oWVxuw4i8Y/wmp2nO619YXwOKuIyZS
	CAKRi0IRQ0lcgglF0wkMMIIMIv62do3vQ2mGGtLJ7oHZzAR1GTFW3a7aaVZvj3I3z4EovyC8sEn
	0L/j//9o9Q/G3Xiof4RC+VlYvrRvMOQPV2qWJZvYucIsJ57A==
X-Received: by 2002:a05:6102:5091:b0:6c5:d55d:c096 with SMTP id ada2fe7eead31-6ec45900816mr1645176137.16.1780494732047;
        Wed, 03 Jun 2026 06:52:12 -0700 (PDT)
X-Received: by 2002:a05:6102:5091:b0:6c5:d55d:c096 with SMTP id ada2fe7eead31-6ec45900816mr1645158137.16.1780494731608;
        Wed, 03 Jun 2026 06:52:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac2ed925sm9320831fa.39.2026.06.03.06.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:52:10 -0700 (PDT)
Date: Wed, 3 Jun 2026 16:52:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: george.moussalem@outlook.com
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64: qcom: ipq5018: Add GEPHY RX and TX clocks
Message-ID: <66sew7qesxu5nrhtol32jvtc2et2wryypvhx4ytdebqwcopca2@xaryrll542yu>
References: <20260602-ipq5018-gephy-clocks-v2-0-65a1f1d881f3@outlook.com>
 <20260602-ipq5018-gephy-clocks-v2-3-65a1f1d881f3@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-ipq5018-gephy-clocks-v2-3-65a1f1d881f3@outlook.com>
X-Proofpoint-ORIG-GUID: bXnVd9IosvyMogOxa5mRSiujlvN3AejC
X-Authority-Analysis: v=2.4 cv=edUNubEH c=1 sm=1 tr=0 ts=6a20318c cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=UqCG9HQmAAAA:8
 a=EUspDBNiAAAA:8 a=5nzw82lfuaBeqxAF_j4A:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzMyBTYWx0ZWRfXzZALvdhlutrV
 Px7STJzjbi/7lSK290NjycCjbd4/l4m6Nu1gpnors3dIVECoMn0OXccR1tAw9Wp8I1kpGSVhpel
 7GMHhX8AkInFb4GzNZMJDJYahvSXOsNqgVoIN2JKMmLXj+cdu59Gy7UvnpCFeD3NSgB8jUwdula
 2l78ig9zbww66gFmOOAUryO7rTvERyQCKNROxHJEIKAiCa9MXjA7KMsPCaz1pcRo3r1dlfqbdFx
 bSWbzOmZ87WXzJRfs3JeJbkh2bMW48MeCFh7DjB0K4HeSIJb3knCxztr1SD/lH8t8qpti10Xuog
 zw4SX/8a+9nJzAfqQjWzSxYh6XMFdiGtMl+jl1drRpb7b8gdgHmeN3Mwan8RlkDFm+5UWQ33VnP
 CBm269IyGXWPwq+MZLpZq4ztPE2yiLVirHKEoTmVgs6m2w0Dofu2aloOTHURWTg6/qCclRG+r2U
 kOMxXRPoFCKS+3VA8Dg==
X-Proofpoint-GUID: bXnVd9IosvyMogOxa5mRSiujlvN3AejC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030133
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294759-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,outlook.com:email,xaryrll542yu:mid];
	FREEMAIL_TO(0.00)[outlook.com];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:george.moussalem@outlook.com,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:f.fainelli@gmail.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:konrad.dybcio@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:ffainelli@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,oss.qualcomm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C42DE638527

On Tue, Jun 02, 2026 at 10:50:39AM +0400, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Add RX and TX clocks for the IPQ5018 GEPHY to enable the datapath.
> 
> Fixes: f5f2b835e316 ("arm64: dts: qcom: ipq5018: Add GE PHY to internal mdio bus")
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


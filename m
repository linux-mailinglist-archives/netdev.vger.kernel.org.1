Return-Path: <netdev+bounces-239898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80548C6DAE1
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 436552E293
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD5633C52A;
	Wed, 19 Nov 2025 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lb6SkCgT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BBT/9ZzL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77A333343E
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544028; cv=none; b=SnDvlzdDopodrgHo1NjNH7eLWY85sc6zj9f+aXm8ecGflDQwb76U3p4EVGJG10ZbM1IA+BwcLHqBrgxB1SWdCvg3Se9cSKpL/JraGzKYfSyGb5YlbLUhHvKph9i18u8bkboaMqZ/1ItAbz98TW42slkcczHjF3AzF1hbVzb97L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544028; c=relaxed/simple;
	bh=9fJPnNI2m4Mw0YErBLTK/xunUVSnJ8Sguqhqukm3oVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1oyPQS6bDF56t26UxbKN7U0mPkNzstC7+jQmEV0PK2772/uoNmBvlwjLeVKbDnaFS95ojRmabKBUPf+xdbeZZoYQJWp12NqjD7e9urIN+k4T+7AcFGUv6lVr0+UB0LCg/Q5nxo9jOW5Yqo/iBtAt/WU5syEvpN06ttMB5sNdUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lb6SkCgT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BBT/9ZzL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ5CBLs2802375
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 09:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0oqujWEyH8f4p+10/5HYloF0
	w0PhJk2k7kxRCmoUJvM=; b=lb6SkCgTzCZF49CVkyhmn3O9IW8BOSOoQh7dumF+
	T4rWEs8ttUJKDLC9MdbGWsv7kapWNLCZlMoVFddeJXh8FUm7LH8JeZThA6Bc8atf
	B84XzMPqgGzabFKC3JCGKxBwWWph2qqtbpLuWWfDnFSfT/trhK2Kpp8Lu1zRbSCh
	iT21P7qjO/1tM47l82uPbfdsYOH/49RDLXFQmFdj8HMy/XvILN/uP60rdfCuF4u2
	5ktdJiCwmQrBLAMzpzT1vu8axFxHI6BrC7hEPtqzuB84cbMdLiuYnJcLpImj1oie
	PEMShc2NWp+xiQaYDF9MinGC4/n1GgM1PdG9xNgbPo+iBw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agrk23cw0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 09:20:25 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-89ee646359cso2071716485a.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 01:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763544024; x=1764148824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0oqujWEyH8f4p+10/5HYloF0w0PhJk2k7kxRCmoUJvM=;
        b=BBT/9ZzLDVnR8t++xXG0CCW+efVGR+GcVanY/RuVpx1WTIucLzzbKaADXVUpNjmWE3
         7H1ZzTold14RtCJScpntYDxlC4zFSBqaL/uFhwtvlaYo0slKOn2kOn1Alb5VvxXH5NAu
         fmluJaS72I/0v8W54n10N2zJ73iF7RmoNI/7tC3mRFtItrQBbNY/3FQWZ25NXAxJLrlR
         AnzcuAdm8Ov8Fa8/VW9RVXzldJ5k0vgJbiHmhLvqBPE4vr1XF9rMNeeTYnyid3O1R6aR
         UnvroVhjFx9uRgFfFcFFVjHLrblk/2aKf77/uS2zKRMmric1A86VPPkcR03BaisV3QgZ
         5iHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763544024; x=1764148824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0oqujWEyH8f4p+10/5HYloF0w0PhJk2k7kxRCmoUJvM=;
        b=EdwO+hXfNd60qr4eigzUkYgOcRceLsSSc2e2TQiVuv8+CJwS2xb2bgMtqka+pyIBh+
         RjBFU45bcVydVnTVyLfpQMyURXD9+eT0dPDKS8mR+aFpveY7wVI8yw6ozztUa5X2nOpx
         Xy83YJN27i6KNR7dnuM1kqyv3T9QYiNcssNPOqH/zbv5SJqUDu3vU7TRar/gz3tV0qRX
         OiOEh2ODSCHQA1vs6+LRJYg1yWFaOFKmtm8IOrq8XiQZmT6Jz6GaukFyMMqnML0NIqF2
         /tzVkp8/Z3G9ceZ50p1RL+Ehc/y6sjSTPeGck66MuoMsi38BVVHU2Bx+6/91D92y1Cpl
         HFAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwrIC+nBDtDvv6tbPBWdnUfvlefer3oRxqV5SgsrULrLmWCwC8q6ZckvoZi5im2kQWxNmBYhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiZnBzPxR91cZR2vmXBahQ2LpWzdrSR+NVKCAyueKMzSUncjnk
	+2j91xw72XvUvOhcs4Qj1RxDLAMVocdJIYQImeiuIQCYPLMZ9sX5E57ICNO0aBKWmNIfwev/8Eq
	JKTSfbHhrQSuOkQCAJg+80/4+TZ4sD3+vhdXPPo2GTAsLL8KthO+FNMS85tA=
X-Gm-Gg: ASbGncu3ps4kR2i5u1lqiNG+0W62bZs1LZYseSRLL4KGq5IGv0xLgQrdn1TTtCeLXxb
	/aU5z8lrwPs1NhCSM7Ap/4MXa/2ozAiZrK6OJXyD281mrZpayzFqnNE6varN++Yug3EW44/wZc8
	HRdP/y3oWo8K5THxuYNCSS8d1wDWNFPrpSl4uab+MLEntc8g2BWmNmAieFUi3o4Lp6HJiSV1sac
	+13Z8bew1R4lDwzYeqO30Hu5lpj7WLBYQ0EvUYYJz/XR70s51cRtgIEpZY8LsaDmjCM9CDCAn50
	+Q4uQb8boN2vAH1JLQSGH2ANSESKo+v/8xgwWZTGyJTSf13O9Y4lxsexIOz/foTh5e0tYGzngmd
	+lMCyjalMpT32P1ufvenAEQKXjIwALMRN14/fQRCXbc16tb0Ofdy90yTEJhvlEa1nMGfSp2SoMu
	4Nu1VbAuv3OKdtTDHo/bcM5Sw=
X-Received: by 2002:a05:620a:170f:b0:8a1:426a:2cca with SMTP id af79cd13be357-8b2c31c19b4mr2331069285a.41.1763544024377;
        Wed, 19 Nov 2025 01:20:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwau4TOofaMhlSnertNBlaCy1ih9htw4EInhnJfyfk+IyFhhOlEaMeDB1ZwfqAWXI+o957Ow==
X-Received: by 2002:a05:620a:170f:b0:8a1:426a:2cca with SMTP id af79cd13be357-8b2c31c19b4mr2331067585a.41.1763544023975;
        Wed, 19 Nov 2025 01:20:23 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37b9ce1577fsm40665051fa.17.2025.11.19.01.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 01:20:23 -0800 (PST)
Date: Wed, 19 Nov 2025 11:20:21 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Slark Xiao <slark_xiao@163.com>
Cc: mani@kernel.org, loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
        johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] bus: mhi: host: pci_generic: Add Foxconn T99W760
 modem
Message-ID: <p3b2wmi2kzpeywu7pavmve4tw3esfvp5ltuzr7lbbo4jbqc4ow@q432vndbmye6>
References: <20251119084537.34303-1-slark_xiao@163.com>
 <aqhkk6sbsuvx5yoy564sd53blbb3fqcrlidrg3zuk3gsw64w24@hsxi4nj4t7vy>
 <7373f6c5.8783.19a9b62ad62.Coremail.slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7373f6c5.8783.19a9b62ad62.Coremail.slark_xiao@163.com>
X-Authority-Analysis: v=2.4 cv=a6Q9NESF c=1 sm=1 tr=0 ts=691d8bda cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Byx-y9mGAAAA:8 a=G7VRq2ROR16SoJa6LKcA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: NR1Nssh0SEKzCD3vBLX3YTzVLnXac_dA
X-Proofpoint-ORIG-GUID: NR1Nssh0SEKzCD3vBLX3YTzVLnXac_dA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDA3MyBTYWx0ZWRfX8cRPJ9HjNBRB
 wfoXNHKtCmXNdUFx6WiiWTVyAzy1nhV0XpfkmzPZHp0HeD2fUJk6RbldFZ90nReosonBMRmM7zo
 2fOEjjuUmli3JkXYSCsreSLCmIDtMo5Fqk/TuXWPf1cv0pZHY8tYHH3kNPxhEj7jl7SR/W06FVk
 r7HFV3KLbpoYXQVqACVUtXveqIErAr1rYj6gZV+c3YHZoWRZdliY339t77xs9NxQBaPRd+Q2GdX
 kthClCH13AeUc+22mGGpsP6iCeR+qW1Ue/zZWVKFap8Z4s8XWzGlFc65zdEQfr0yZkgQnGhWI3p
 cMrGgDuSJAI4kjf65JBQ8SVVa63NonnJ/7TJW39VJphdGGqRn8YR6v9+GsQc0Bh4OX9Aswu+502
 W+nnrzBoFqBgrtKAN+J2ieGA1+nI+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511190073

On Wed, Nov 19, 2025 at 05:12:06PM +0800, Slark Xiao wrote:
> 
> At 2025-11-19 17:05:17, "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >On Wed, Nov 19, 2025 at 04:45:37PM +0800, Slark Xiao wrote:
> >> T99W760 modem is based on Qualcomm SDX35 chipset.
> >> It use the same channel settings with Foxconn SDX61.
> >> edl file has been committed to linux-firmware.
> >> 
> >> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> >> ---
> >> v2: Add net and MHI maintainer together
> >> ---
> >>  drivers/bus/mhi/host/pci_generic.c | 13 +++++++++++++
> >>  1 file changed, 13 insertions(+)
> >
> >Note: only 1/2 made it to linux-arm-msm. Is it intentional or was there
> >any kind of an error while sending the patches?
> >
> >-- 
> >With best wishes
> >Dmitry
> Both patches have cc linux-arm-msm@vger.kernel.org.
> And now I can find both patches in:
> patchwork.kernel.org/project/linux-arm-msm/list/

See the thread as archived by lore:

https://lore.kernel.org/linux-arm-msm/aqhkk6sbsuvx5yoy564sd53blbb3fqcrlidrg3zuk3gsw64w24@hsxi4nj4t7vy/T/#t

-- 
With best wishes
Dmitry


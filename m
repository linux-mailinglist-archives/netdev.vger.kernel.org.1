Return-Path: <netdev+bounces-182438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47935A88BD9
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF0F3B5B55
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C901AF0AE;
	Mon, 14 Apr 2025 18:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vki2Dbt6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A08DDDC3
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744657002; cv=none; b=KHimasOvzfaKjvs1JDt6ovodpmGjIASz6fDlBe5utsTav6G71h6+EEOWTwLdAYJjF7t9kLEb4h+DRYm/jmARn1JSGmGCrpxrqwcLilJdW3mUwTBQX88eo/uIuC8up+Ni1EXiF7tkOxByKCFEG+CJ4r2jr0SHPX4UStc2EaiSBSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744657002; c=relaxed/simple;
	bh=m4n/Im+Gnx8SffOix3LPwL4MdLXi9D4xkKwy+KbrkCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWyKlYFF0TZBPa6BTmdPz293xnxRxL/WbiNHsY4XsuOr26hTgnRh7G4obKVrEou7M4HDVZzu/yVjnn1qtqpTmKpi5jZM2TNRVbIqAlWqitRcMLt1cn6IIkjijEkAypc8Xkz12/NOwSd8w4YLctljgHzazNn5cYgkdAMpVcBYk7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vki2Dbt6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E99rPn016340
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m4n/Im+Gnx8SffOix3LPwL4MdLXi9D4xkKwy+KbrkCw=; b=Vki2Dbt6eoJeCTQL
	RuUKXeL/gVkEnu6zJeRuZOueaSGRVxFEEgyIIPcP0/pMj+8PB/YEtu4XPKYv/nFo
	F0X6ETDTqYGZXyAwCEaqEr3o069oPvGYhIp0zKmSIhLjVnmcPSxyAansJoDpsUOk
	9lCO1ru4FeEGwvo1JVTzP1f10/FLLJFZDUW2RSJZBEsrfjJu9A2tMinuEE+W1kpQ
	h4IeV1CScrdWuG9claUGcKaIs1V2kgs0cckyRnb/oG/5XRoks3OtYSlBlSCyGwEi
	UayR2Nwtne7p0qnOvDlebftIkIGCSP//vzl8AKYkjh1bUSUz0C4DFL+mx643NhHn
	S8jz5A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfgjdht4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:56:38 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e91a184588so138412016d6.2
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 11:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744656998; x=1745261798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4n/Im+Gnx8SffOix3LPwL4MdLXi9D4xkKwy+KbrkCw=;
        b=oYRlrF7/Yqgm5SqZYBbo3R3DDqyfQoEWayja8xX2Pvs+kZWPvWAI51EsPuN8SPxXmn
         y1CdEdTZN/6q/wZuVvQbNVrrKhzSjVVBtFFsYYKYaa09g7EOPW3CqEPig6hJKlRi8O2g
         OztFht4sDZoEJ5fX+mtagDXFLlYCzSO8ijTordJLoHNP4WfKzeVKB/mKu2ms/g2Mdq8Y
         mHeaYkgAgXiLP2evmasXtKMpvcYHxuF1oXiXPXvwaEyzqrS6zMo15qI4k70REUZJ8kzi
         9qOIgcDr10K+sCeb+AfG/qfCXa98wEqnZKU71+QUIJDUuWCYIdQEou4Oibur87YTmHnf
         m50A==
X-Forwarded-Encrypted: i=1; AJvYcCWBbFIImxEL0CKWr5GYqbB00giWKBlNuY8D3HDiNXqoksetnPckB6y9cbt66r6vTHbxKcGBbVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytrEEXl7BXpWXgvze9x2FIG9uEL7gy2xgNvbsVsxzQv7lvb8X7
	WMjztl9rrCr1LsOtNeV9J30Kd/Tv3AJ5RtQ9ECJjaK1hcuU0iTUqmU06w/2yQVG7+k20SJysmMN
	DTVPsmN4/gtIKmZe53BlfNiImDd4+t33YTkDRGhN7gRIoKIGcgFdVEra3xwY/gSevimjmD4D17Z
	NsqGmbKFjpke8Lyk4ALmTMwcEDHV7qiw==
X-Gm-Gg: ASbGnctU42Os/M+Rvc6j4EKji5H77m/Ym/Mat5VuaCZ2vZ3ieoI7kJGL+srFPoJkraJ
	hx0F7iuynr30aYY4sH2O5M+hlpO5CsapJLtgz7Mrb1y587yEuGy9WCf0RPXeRsDn0jdoBahE=
X-Received: by 2002:ad4:5bc7:0:b0:6e8:9b26:8c5 with SMTP id 6a1803df08f44-6f230ceb5a1mr218866726d6.10.1744656997867;
        Mon, 14 Apr 2025 11:56:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1b2Q1EnFBY7+Jr6M1TxbjF1hEia4FwQtheN/1o1ocMpWBfB/D2wF5Ob7BH359dF+dRq3RLgFt5oY+PoN9jOk=
X-Received: by 2002:ad4:5bc7:0:b0:6e8:9b26:8c5 with SMTP id
 6a1803df08f44-6f230ceb5a1mr218866376d6.10.1744656997471; Mon, 14 Apr 2025
 11:56:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408233118.21452-1-ryazanov.s.a@gmail.com> <20250408233118.21452-6-ryazanov.s.a@gmail.com>
In-Reply-To: <20250408233118.21452-6-ryazanov.s.a@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 14 Apr 2025 20:56:26 +0200
X-Gm-Features: ATxdqUFpRCz3XRZZ1VQ9zND1HUopT0BxvHGJp0N0dgkHvGmDwkCrqp5R6IBW8VA
Message-ID: <CAFEp6-1DhbDFuWYhdM=uM8eVRtruacd9psVPLTOgnOQ4XVGiGA@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] net: wwan: hwsim: refactor to support more port types
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: AtsP5Rmr5FvpTE1QmtUMikZbZ_OtP_m2
X-Proofpoint-ORIG-GUID: AtsP5Rmr5FvpTE1QmtUMikZbZ_OtP_m2
X-Authority-Analysis: v=2.4 cv=Cve/cm4D c=1 sm=1 tr=0 ts=67fd5a66 cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=XIB30I8Fq4NfyXnsoAUA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=630 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140138

On Wed, Apr 9, 2025 at 1:31=E2=80=AFAM Sergey Ryazanov <ryazanov.s.a@gmail.=
com> wrote:
>
> Just introduced WWAN NMEA port type needs a testing option. The WWAN HW
> simulator was developed with the AT port type in mind and cannot be
> easily extended. Refactor it now to make it capable to support more port
> types.
>
> No big functional changes, mostly renaming with a little code
> rearrangement.
>
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>


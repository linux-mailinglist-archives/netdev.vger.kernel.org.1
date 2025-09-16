Return-Path: <netdev+bounces-223476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4C1B5947B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9642A09FC
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CE62C1581;
	Tue, 16 Sep 2025 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iyu5PinM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63904238C0D
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020366; cv=none; b=ApmqIE2X/wYI4xxBgfiTJTCr7QU3FXCYegRIfvjfd/zho8YJ00MYwR/0Vbi6IDQk66xj8Tq5ex1s7i1UYEvsKTu1AAJTzIguI7I8TrbBNHdGB5Ow8tp8zMK2zRx2UxOZXPuRRPh67ew3O+nRLks4HUnzLhJUEDHA2oREHCxsI3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020366; c=relaxed/simple;
	bh=3dM7vJjkg5Mx5e5iRX613YlVuqKV1/6CMF1mfmG8ByA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsM0FO5ACmHMLAGpHJ8blI4/BOoUn2YzFocWyL5kJFx/R7u8vlDYsJq5kCUdpusZBpBNV6bidqcVbo/WRkD1rLEXRu84yfgJyZhUXEkH6eJ3bPTDfix8cULbAKJWbG9IdXp9ynA9MMa1pv78dEHPJSoXlKAHtUYj03yk5PduW9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iyu5PinM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAmw1H021429
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mFiDkj+L3cwYNIifGEmZEYEZ
	JXhnfzx+t8PT08ZFf5U=; b=iyu5PinMriJk0GeFWONK3k72LxXT9dlRpzDlwyID
	4isrTtlsPWxGcINhGfRg2Gz5klPHcUspF3zgrVQ+seHHm0GDEZbC3vFJAlvWN1W7
	J9KZCeD8idbZDwUHjhannikKtAwrG4llLAVfqxzB1vfwixDftMI+ZtJQiHpQ4QiD
	vHkr0TDI/RcA2d40hH0TN3wDURsxw6x0VSyS9ieY2/L75xobUQ7HFngo9mMaOdit
	hv6c0eRkZA67mzRSBZQVbHCoSgiDq1QDbtnHZjhaa6JU5Jp3TObH8SJSkVPB08ir
	56dC+5seyG2nJwTCZcx+QaWjJ2DZuxXjJPFFCr5GokZ8uA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma8k57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:59:24 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b49666c8b8so104231941cf.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 03:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758020363; x=1758625163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFiDkj+L3cwYNIifGEmZEYEZJXhnfzx+t8PT08ZFf5U=;
        b=Tf6LhaEFYxnEIUlwjcYOAwmMae+iOn+BAtaGPthf04P53HIeM3EekWUh+9V9tyJyWQ
         nxtvemJqohGJb1QaWrSdFVLv9NuIDY7yuTpJ9tHTdndB+ZtGQLGAUVKtqNT30wfUGDTQ
         lRzXOuAlml2MIHdSYp/j21dPQyMsPlTAaVq5fJMcOvd6md4AjCabzaDQyiBwak/CoDU9
         X5ImPOx1Ulfa0n+D4aqzYXF/LGfGDi6m6mznxTY4CPnsTsJvyvE7RNderGIla+Di2maU
         ltR5BjKWCgUUbkxZAWMIVz305jamPYIDMzkdkPlTQewOcc9r1E6q3BTpcGVV7T3cJ5sF
         xIbw==
X-Forwarded-Encrypted: i=1; AJvYcCWgtNlK9PcLoqkYlOmGbQpxD1n3HAza9jFWetGUI/fXKrKXeuHDkno8oqVvpr78ELRjbTMJyds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx45H2iT8vDj5e3NWqY2iYch6xnHRBovhxO38YRsyuPZEczWkYv
	NcPuofru4nNLjf7J9qB2LMBB4knEJnvSR9cdwxejrj4+owOuCZwSX4vF4Si1NnqjWEj8SuG76PL
	Fj1rTuWtE3tHxRHhaleEzf1BbUfonQ3QY4iUmQ+WcpM+lFecSQGjrcVvMVWo=
X-Gm-Gg: ASbGnctpPw5CZwyzuzrag/Ui00w3+K64Pe9da84w/U3aWj9NLScvx6nKnchEtyjqkTy
	7O4XJnvZ9Y87Ywkpn3mqol5LzDQeNtkprb5859wqo5TaSmHiSUHfyb+Sh1GC15o9w98OgrypQQa
	Wm49FKSy1H20YMu+UjxfFtCnCH4fgk+kxZk425UiPuzexa0OxidLHEdQLjoNtSEBYo9xx+d8e5i
	macCLuYYFAwvQL1iyPJUr1pIJOpf23nlvMx+oO6zZB0/KDkuZ/Yk3E5na4isUQUOA6EMkh5eZnK
	diFIfByIsx0XVq3z9Bq136O7YaGFze4RBvdw2SXln/cjauL63Y4ysJ1achUdjK5t46aXpWD3IgV
	Q8gEsgiKKKTmRSoCuSoqJU1Nzu6EMiaCTw9bPhVF/NhhI84YNABCg
X-Received: by 2002:a05:622a:5e18:b0:4b7:8cf8:21a1 with SMTP id d75a77b69052e-4b78cf8257dmr88217091cf.82.1758020363405;
        Tue, 16 Sep 2025 03:59:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDj/hhJ5O4jQLZi/UnXUBCLpKD2mcKKa7z5f6/+2XEQQYMmtnF8am0LXMBESmcmRpgg7zgUA==
X-Received: by 2002:a05:622a:5e18:b0:4b7:8cf8:21a1 with SMTP id d75a77b69052e-4b78cf8257dmr88216741cf.82.1758020362518;
        Tue, 16 Sep 2025 03:59:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e663c5005sm4331812e87.149.2025.09.16.03.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:59:21 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:59:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: Re: [PATCH v5 02/10] arm64: dts: qcom: lemans-evk: Enable GPI DMA
 and QUPv3 controllers
Message-ID: <n4p4www37qz4hw75l6z2opeqks4g3u26brceyxi6golam7f5aw@raandspcihi6>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v5-2-53d7d206669d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-lemans-evk-bu-v5-2-53d7d206669d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfX3Vz45v6GeJjW
 ujeB76f3aCbGKmvGh6yqTk7O7rNf+0OreJcM/c4I17/fYO6iCtYpopezV0DwZ2cn0oAqMkdfTus
 +gmMPnseJr0YHtdra7cEGHYU9Ra6yxGF9uYx0zTq0AN3G27s7lZU6QLC0f51UrOEsMMPzZPpcV0
 QDA+2W1dnH4Ojdd4pLykRMZqd/U/iQyIAcL2X7qTqoF5PTh//mlQ5PLGhrWeHH9H4/Us3L3p7GV
 enBtCsudBJb0aORCSW5g78xo5L/IcFAHwX1Qahi+Blz47WeD+ap4CTn1pjDeJOIXoTi+sdbIWRX
 8cG4KJjVp4zAGbhQ40sVgq6H1aAm4dAYQwZm3NRBITLZ4HPCk+zNgQ0fFFQeDFCVhN+M4t8BxLm
 3Dh9Nm7J
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c9430c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=E-8pkxSmLjkzrIbgvO0A:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 3gDjFtG_2jLWG0L1b4IGVNwVsMUe13po
X-Proofpoint-GUID: 3gDjFtG_2jLWG0L1b4IGVNwVsMUe13po
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019

On Tue, Sep 16, 2025 at 04:16:50PM +0530, Wasim Nazir wrote:
> From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> 
> Enable GPI DMA controllers (gpi_dma0, gpi_dma1, gpi_dma2) and QUPv3
> interfaces (qupv3_id_0, qupv3_id_2) in the device tree to support
> DMA and peripheral communication on the Lemans EVK platform.
> 
> qupv3_id_0 provides access to I2C/SPI/UART instances 0-5.

Nit: used for foo, bar, baz and slot ZYX.

> qupv3_id_2 provides access to I2C/SPI/UART instances 14-20.

Ditto

> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

-- 
With best wishes
Dmitry


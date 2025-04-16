Return-Path: <netdev+bounces-183476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D118EA90CB9
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AB8B7A27E8
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E55822424D;
	Wed, 16 Apr 2025 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HlIpG+57"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98231189915
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744833870; cv=none; b=Rv46OOI9K0gbjs/PL77OekZyM3O8purDEHVN5oI6MCLQicXSiRRRxaD8BhZqNgA7sfe1NxUsaKgQJbXKxoRj81PGEO5TIr/tBVTnvLIRnMkqhbJdzVAQPLjaFdMVU2gCLAfJy8PVPpxO16k2ucOVI+dynRDIe6DOiSe5C5h6nqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744833870; c=relaxed/simple;
	bh=tTntMSIDC/R5ahfuIPRwDetJ9biStCih0Rbua2tWaUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nqU/0QKjp9g0pvL8Q1wL1IxvhDgXWwEv5Bqzc+Vd46YrQZMDKKqs4rGaTNLlRHOshTQjXOT/9CkcaXdz3Y4SRoF+a96LohqsoA0HvJWFVjjw0Xc+YgAb/2Rt+GM7WXjtpuTfDf7qBDahEgLDM4T8Dp8c1mo1QZptn9cDdvj6YAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HlIpG+57; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G9mH5s020781
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 20:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E2CTcsXmxIkfct6FzFBikq64ncDPSfg06WCEJzRAD78=; b=HlIpG+57U2kx7hz/
	5O/Gr8Z7ur0TCnVr8gfBNCyn3Ns3NL3qi2WgDlnhlUVcwIy4KsYzyefH/axpql4p
	vMZqcpC5I9LniJyOMeCmb1Mb+KHkSxpbkkK8nbeMxmsQazSHUwTQgqm/a3GlbddW
	sonRXtbjy77OZUnboTWvcsCSfj4JlvT6P2/9ktUgmStuylP4nhJTpfkw0+hRMkHx
	kede/FFQhHs4sjsjwnrBf/PH/jzLphoLBJfwceR2wTZGOx25WYq3sOyEzRop6g7b
	ZCtp0Syj/dGh1XNiLFhU4DQDmdUUW/c270vraza85QPh0IpzQqWjRBaM7h/0SALC
	SqgtSQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yhbpvh6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 20:04:27 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e913e1cf4aso2057626d6.2
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 13:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744833866; x=1745438666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2CTcsXmxIkfct6FzFBikq64ncDPSfg06WCEJzRAD78=;
        b=IOzPHuRGjKW1ISr/ZSsx4cbxIHNLLzHrsq6QL/oxEEqGAX2c7zP3xKwXJi87az9za9
         jAMNyQlW9QEyIBTQhxwhhnmXZPStImMUU8xx9HihRRyd4FS5HUOcq2JVauwEzGh0f8kT
         iEdN0gNrNndHHuKJxXGxcjPr1i3+6OhmU4LjhhiftNSTgr6oumkiWF+mgRcyLVEgoVI/
         RJ/w/2jAzWMLB38X+FmWrmjI7T/VpQvkaeTtBmA0vH6MKDr60MOboZgSfOK/J6OnDM9p
         nRDzHO33xD0xSamhEVyz3X0WDRwLnGP+iWJVXUmof3OvvxIscrRvU5JKJmjA+iWSr+pb
         msRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0Z0YqO4Zep83lHLBf24K7YrQca9FLOd4mBnVo6BR+piG3+XZOH+9o0P3GZ5yaSsZ+nVQMTj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAqcj1du4arpRrBwLaHoK23kwDuSc3VyZSnsJNNIy8Chii0QCZ
	CCtt3VJ/RIEG0TS7vCyncyX1nRsuGRa3BSexDl7nJXhnK0HEz+gTXBYbIKsT1V/Kln4Pn+6Y//l
	bkkvqYLSysQzlwZws9+9Qcvihp39GP8ezOMrQxOAncG+xxRGJez6aDk6CUvpIBaJGrAqDnph+tE
	OSidrTzKBJwUN9Ypd+pweoIB3Qt7BbMp9Oo/ogoQ==
X-Gm-Gg: ASbGncuTeoD58Yo+5MOM9ibV/fKbAe3/EnMw0/s/0LOgPUpg8BqGu0+Je+Jem/zQYVk
	Vv9LR2jwwyeDdqyJsLpx1BDA2qAra0rNh4RhArRcUzqAseafmrPc7SqOJv5GQBp3PIrUizged1r
	lmQd5V/0Ny/5ptsXgacXWY1H0=
X-Received: by 2002:ad4:574a:0:b0:6d8:846b:cd8d with SMTP id 6a1803df08f44-6f2b303668bmr46988146d6.30.1744833866097;
        Wed, 16 Apr 2025 13:04:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpb+Hdnmosr+aDzLdV4sSh1OZUzwx60EoQZl5NFpwU9BKO6lHR+r+yntpYpujfHAu1aKINXmWCUgQaBJY+/UA=
X-Received: by 2002:ad4:574a:0:b0:6d8:846b:cd8d with SMTP id
 6a1803df08f44-6f2b303668bmr46987716d6.30.1744833865687; Wed, 16 Apr 2025
 13:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408233118.21452-1-ryazanov.s.a@gmail.com> <20250408233118.21452-5-ryazanov.s.a@gmail.com>
In-Reply-To: <20250408233118.21452-5-ryazanov.s.a@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 16 Apr 2025 22:04:13 +0200
X-Gm-Features: ATxdqUET9x0i32WUF8yMm1SJJX5u3h9tXIMR2Fe58KPgNj_YvcveSOl6NFhaBG4
Message-ID: <CAFEp6-1tHbVgAG8LZHyzB=5c0n9D-F7d-VFe7K+LC5gYMq0Thw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/6] net: wwan: add NMEA port support
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org, Slark Xiao <slark_xiao@163.com>,
        Muhammad Nuzaihan <zaihan@unrealasia.net>,
        Qiang Yu <quic_qianyu@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Ny0tr5tjb1mSt6PVDtjPii0_4kop8po7
X-Proofpoint-GUID: Ny0tr5tjb1mSt6PVDtjPii0_4kop8po7
X-Authority-Analysis: v=2.4 cv=I+plRMgg c=1 sm=1 tr=0 ts=68000d4b cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=pGLkceISAAAA:8 a=Byx-y9mGAAAA:8 a=mThdVl9iAAAA:8 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=R7LJU6v_xujNqLHZ4WEA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=GbkGdI2Iuv6_No-W-q0B:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_07,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160164

On Wed, Apr 9, 2025 at 1:31=E2=80=AFAM Sergey Ryazanov <ryazanov.s.a@gmail.=
com> wrote:
>
> Many WWAN modems come with embedded GNSS receiver inside and have a
> dedicated port to output geopositioning data. On the one hand, the
> GNSS receiver has little in common with WWAN modem and just shares a
> host interface and should be exported using the GNSS subsystem. On the
> other hand, GNSS receiver is not automatically activated and needs a
> generic WWAN control port (AT, MBIM, etc.) to be turned on. And a user
> space software needs extra information to find the control port.
>
> Introduce the new type of WWAN port - NMEA. When driver asks to register
> a NMEA port, the core allocates common parent WWAN device as usual, but
> exports the NMEA port via the GNSS subsystem and acts as a proxy between
> the device driver and the GNSS subsystem.
>
> From the WWAN device driver perspective, a NMEA port is registered as a
> regular WWAN port without any difference. And the driver interacts only
> with the WWAN core. From the user space perspective, the NMEA port is a
> GNSS device which parent can be used to enumerate and select the proper
> control port for the GNSS receiver management.
>
> CC: Slark Xiao <slark_xiao@163.com>
> CC: Muhammad Nuzaihan <zaihan@unrealasia.net>
> CC: Qiang Yu <quic_qianyu@quicinc.com>
> CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> CC: Johan Hovold <johan@kernel.org>
> Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> ---
>  drivers/net/wwan/Kconfig     |   1 +
>  drivers/net/wwan/wwan_core.c | 157 ++++++++++++++++++++++++++++++++++-
>  include/linux/wwan.h         |   2 +
>  3 files changed, 156 insertions(+), 4 deletions(-)
>
[...]
> +static void wwan_port_unregister_gnss(struct wwan_port *port)
> +{
> +       struct wwan_device *wwandev =3D to_wwan_dev(port->dev.parent);
> +       struct gnss_device *gdev =3D port->gnss;
> +
> +       dev_info(&wwandev->dev, "port %s disconnected\n", dev_name(&gdev-=
>dev));
> +
> +       gnss_deregister_device(gdev);
> +       gnss_put_device(gdev);
> +
> +       __wwan_port_destroy(port);
> +}
> +#else
> +static inline int wwan_port_register_gnss(struct wwan_port *port)
> +{
> +       __wwan_port_destroy(port);
> +       return -EOPNOTSUPP;
> +}

I don't think the wwan core should return an error in case GNSS_CONFIG
is not enabled, a wwan driver may consider aborting the full
probing/registration if one of the port registrations is failing.
Maybe we should silently ignore such ports, and/or simply print a
warning.

> +
> +static inline void wwan_port_unregister_gnss(struct wwan_port *port)
> +{
> +       WARN_ON(1);     /* This handler cannot be called */
> +}
> +#endif


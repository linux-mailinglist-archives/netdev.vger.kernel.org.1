Return-Path: <netdev+bounces-182437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D7EA88BD7
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8D0B7A9F30
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4AC23D285;
	Mon, 14 Apr 2025 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GAUoT+Au"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B504156236
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656874; cv=none; b=OVswAHJglzhe5wZlGx4Nfx3dFg1+amVTN8sVEsSyDZYMrScx1YYNX/2k7OXFeY7PpQ88gMWprPWXl6+O5mAG+bSl781yhwXUZUScYPrQpODGVJt7MTdrok2U42b/nPdxq5kTXFlK83e2QQ2xS4+k/tKXZmmoJ0ITqfsT6D8ImFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656874; c=relaxed/simple;
	bh=rC6PVrL6ZhUlEEufGDTsQskw5mjSP2EVhi6ZE4fKH7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVuClLebNIqyQJl1+Iyv0dxHC2mZiBD/9Li1Mzbqq4/L/1NhOnHZEapV0Ukh1Ne4gdb8+EJ9FjNfimWLqkogg3ujYg7GH08D3ViMbnGhQHPgRSgBby2t5GIJRyJZWqprP+fygvQKaCdA4tVzD15y7x3rLX86MmUJDY26bqRay4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GAUoT+Au; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E99mio028981
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	naeqesCUXl8xXz5acV8f9amN/jzSddHMszqyup4gsGk=; b=GAUoT+Auk3mwfJmo
	9s5E0CWXJ4BsGDuYorH8Mplg8/vU0GHuySEnRiw4pgQSuBPKCd8smozjUof9Rb1U
	/9m1altp28NTjC4uv4xqTMQA6VSf+bZ2faM5qZtdrObadG7p8P7x6IUQDBd32elm
	tpYrvwvnQI4jkUlb6xCl/vUJdEAyEMtSSu6c52wRK6XgrSRpD7NKgx9d6AgGcnhQ
	ylexfn/Y+ho7S9D8plBeZq6EdWYgvUJ8NZiLPBhiUICpec3cts+HGI1ApR+nWOoM
	WNsPWFhWPUA37m5lCxyhDPawz3mEKHRDXIupxQDA5JcK4KosIsuA3J/Bv4WYKDoO
	Ofg0rQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfs15k14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:54:31 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c793d573b2so854314485a.1
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 11:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744656871; x=1745261671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naeqesCUXl8xXz5acV8f9amN/jzSddHMszqyup4gsGk=;
        b=LW07RZinOzKoKcuMaNw/2qo75C5OMSqZkwkAp1kV718xmC63ne5STm1eB195uEf3Ym
         eJg9HIB/V9Q8uJE2tjMfET4ZtLzVb5/wlqfaDeokZgRPAM5QQjmZUtUQKHeAxy0VNcj7
         DKXcx3La3v3nvYlT/hdJK76RLtSSciCq4BwnELM/kZlqh8emB/7bakoXceWb1H/HOQ3a
         TdiQGSfLluHJkxOLlHnC9ZxcWq2yh9Z7WL4l9RGFKZvHuERa8UatIwUZwehKMC7YmCSM
         k7Ni1ynZwpV7M5cuuv4V5s0Kgtzo/zOXq0G/n1Vs7hWGpVKNLPWBkHf/pXzE4s8Jq9K/
         9GmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzlSlgpENrkulhLp9I3dwuiDGXiH15/6JGYqzBoQlu+4WWUOoC1j6MbcN9yvwpU599ocJqDOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV8EeWHiwkyYpzYS7fMKc2nizXBVVbdJlWQDoxSdhC9a1wF2da
	VYh15xPMYOc16UIp10LYLYnEIuk0hT4+RowfAZw6BobcSldt3598Boi5kJBpMk+s2D0tOl0C7dc
	9S3TVurDoOtmtoYY5wA7A1tRBFp4eM61qTK3Dm8MlgiMPNQ/N5Kv2PqMXHB9bNMHVWXtrkfIH2w
	1sfJ69sU3q/P6jK98ZmGg1rtHdkmeRcw==
X-Gm-Gg: ASbGncsneKt43JflfkBq9N43jokLn55D4QljVCVGY6GWN6TabJWYc84wog5XJVLY+qJ
	UgNRb7aSJFgnOOjp+okbS5HSDJ3vL+VpftmiwbBFPQlaNj6+4A43MlM7v3030lsDDQjHleKI=
X-Received: by 2002:a05:620a:294f:b0:7c7:9813:4ad9 with SMTP id af79cd13be357-7c7af12ecabmr2182443085a.58.1744656870778;
        Mon, 14 Apr 2025 11:54:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJbBEFny49dJELVm80GxiDrcFM/inn4iBMNTjRPt9d0m+aM5aaJmcG0ylxKspayTaZzyKnKrqbzzlGolrjmSA=
X-Received: by 2002:a05:620a:294f:b0:7c7:9813:4ad9 with SMTP id
 af79cd13be357-7c7af12ecabmr2182438485a.58.1744656870200; Mon, 14 Apr 2025
 11:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408233118.21452-1-ryazanov.s.a@gmail.com> <20250408233118.21452-4-ryazanov.s.a@gmail.com>
In-Reply-To: <20250408233118.21452-4-ryazanov.s.a@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 14 Apr 2025 20:54:19 +0200
X-Gm-Features: ATxdqUE4VEbT9YFrdrozGj2rqqwU3xpDUkD2ZWw9zEPQlZIqTJfc-rx-sgFORQ8
Message-ID: <CAFEp6-2MxMohojOeSPzcuP_Fs0fps1EBGHKGcoHSUt+9fMLqJQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/6] net: wwan: core: split port unregister and stop
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=P9I6hjAu c=1 sm=1 tr=0 ts=67fd59e7 cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=pGLkceISAAAA:8 a=Paicb_rpB2J0kmePFMEA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: eNY-2N1ZYFT9pvXq8_2scTFJej61m8Yg
X-Proofpoint-ORIG-GUID: eNY-2N1ZYFT9pvXq8_2scTFJej61m8Yg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140137

On Wed, Apr 9, 2025 at 1:31=E2=80=AFAM Sergey Ryazanov <ryazanov.s.a@gmail.=
com> wrote:
>
> Upcoming GNSS (NMEA) port type support requires exporting it via the
> GNSS subsystem. On another hand, we still need to do basic WWAN core
> work: call the port stop operation, purge queues, release the parent
> WWAN device, etc. To reuse as much code as possible, split the port
> unregistering function into the deregistration of a regular WWAN port
> device, and the common port tearing down code.
>
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> ---
>  drivers/net/wwan/wwan_core.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index 045246d7cd50..439a57bc2b9c 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c
> @@ -486,6 +486,18 @@ static int wwan_port_register_wwan(struct wwan_port =
*port)
>         return 0;
>  }
>
> +/* Unregister regular WWAN port (e.g. AT, MBIM, etc) */
> +static void wwan_port_unregister_wwan(struct wwan_port *port)

Wouldn't it be simpler to name it  `wwan_port_unregister` ?

> +{
> +       struct wwan_device *wwandev =3D to_wwan_dev(port->dev.parent);
> +
> +       dev_set_drvdata(&port->dev, NULL);
> +
> +       dev_info(&wwandev->dev, "port %s disconnected\n", dev_name(&port-=
>dev));
> +
> +       device_unregister(&port->dev);
> +}
> +
>  struct wwan_port *wwan_create_port(struct device *parent,
>                                    enum wwan_port_type type,
>                                    const struct wwan_port_ops *ops,
> @@ -542,18 +554,17 @@ void wwan_remove_port(struct wwan_port *port)
>         struct wwan_device *wwandev =3D to_wwan_dev(port->dev.parent);
>
>         mutex_lock(&port->ops_lock);
> -       if (port->start_count)
> +       if (port->start_count) {
>                 port->ops->stop(port);
> +               port->start_count =3D 0;
> +       }
>         port->ops =3D NULL; /* Prevent any new port operations (e.g. from=
 fops) */
>         mutex_unlock(&port->ops_lock);
>
>         wake_up_interruptible(&port->waitqueue);
> -
>         skb_queue_purge(&port->rxq);
> -       dev_set_drvdata(&port->dev, NULL);
>
> -       dev_info(&wwandev->dev, "port %s disconnected\n", dev_name(&port-=
>dev));
> -       device_unregister(&port->dev);
> +       wwan_port_unregister_wwan(port);
>
>         /* Release related wwan device */
>         wwan_remove_dev(wwandev);
> --
> 2.45.3
>


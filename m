Return-Path: <netdev+bounces-247470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFDDCFAFD5
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 21:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16B2B306EEE6
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 20:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E2E3446D1;
	Tue,  6 Jan 2026 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B+2z9ntl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hoeHAryM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1494C33DEF1
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767731867; cv=none; b=JmpCLSzB2EUC3SMgTyJxo7/ez7fqy8dv/u/LR+BkWjsWJ/PjwFAxCvg5cwBFJaPH0amoiificeVphw3WtzyKvzjRCfhMt8H9/+nlqF3xcS7hINvM2ZstIQDdQb5h1e7luVYP4VKlhbwp4HfFxMFSzbLzQ9MxZSRoGHn9tYv4GZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767731867; c=relaxed/simple;
	bh=Ixumgv/v+IljlZzREi1fYA8fD3j2tzuZvKtHIX9G0JQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GD11CninkHbEpvkzakJhKsYGs+K2eH/LRGg0zQQpeIdT++VzSvbKFaBmIOEmBhuM/px2TCJloN+hXAgGDyXv7hT9A+32ObT8Pu7QJGYA6YNYbdaUjhs2Eo96iD6eB86QQGpCzg1GfQEloAJZtbfI87Obgpf9FEPZW3Ad/EWRCQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B+2z9ntl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hoeHAryM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606GihnX4136987
	for <netdev@vger.kernel.org>; Tue, 6 Jan 2026 20:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oeQPHvrvBe5Ss91AS40DdTHD8xXBJpPnUypnVwhh2RQ=; b=B+2z9ntl0xq9k4kM
	LPBL1S4MJu0ZaR4dZnwB3eFElkQ1i6bBnkctAkb+Rp9DWuxbt0cv/b/Adp/TQQGI
	VkUqEzBMLJJ1KLDOQHSmyonbTt4330RZofgD0iYbm9pKgv3yDVuCM/9gqONmIhrd
	cnwTXTTaauDDHXrrO/xaReWpxUI+O2S9biT+BJ/wp7EO873XdentYn/+M4EZall+
	A03POWw98cSYs9C4mO2sAjAf3KYVK1quVRXnY5RnH8BLo6gEHGLj7omv3g4pyEzE
	MFTxo2QR3UhPW/MEul2CiEoO0wAvlDLBnfdj7kdtLh0tGzftGW6zWyy3R391SVjT
	F/QbMA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh66e0pgq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 20:37:45 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88a32bd53cdso51842906d6.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 12:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767731864; x=1768336664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeQPHvrvBe5Ss91AS40DdTHD8xXBJpPnUypnVwhh2RQ=;
        b=hoeHAryMMB5IDW+uqhxi3oQbT/LPfejOK97lXw+NcTBjIjpdPxea2F1Prhxm9WuWfJ
         upr7kRCSyzDtL7oXvBkjblyR74O0j6dk2GUuWwMXOcK0kMemrzHeej4ZjZMEH2lEvtIc
         Nfo4F3HqHURbgb0RKSyIfiBb4lv+SGPGXpmZyS2H8wen7S6CJFA/gOtwTyPSEi9Ew5xM
         mol/UqK7aY+qipF97pkPbsOoypgrXQISNM8xfUwV0ITU0hfNJxQ940YaivGzybbVNnvC
         LQoEsQlBpslpqsyRWdmdXXSbt+pGJOh8m3lnOuuS78MB2mT7cKZ1LnwOqGtYXYwjkujh
         2+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767731864; x=1768336664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oeQPHvrvBe5Ss91AS40DdTHD8xXBJpPnUypnVwhh2RQ=;
        b=mGrYBT98FIw5W2NmnzfLPVyOIMO5ybIeYgrGCkT11LwGyMHzywmiUlvSE6C/kutxnR
         T+wjQgERsNmwV3JLIbBxlYauvd4g88m3Gm5EJtmOAl/oNi5ownT/zDqpRy5/sWmvUfoM
         suslP9dRXC3nyJNHVDxje7f/M0D/ykTNWcvIDfNpsdL9xOrMGqJh0kv2R+nOcnHV/0qD
         JmDdTWJaIk6PkCUytxvl4fTkGMFCeuTKKc26EPEhRj8FqpyB6m76jwJYisH/SZlxytEG
         frzoAIc4GP1X+78iptCA4sZlM8e5cS+wHOWgHbj4wgFCEXlrPaXB5U2b9/nQPtpETh0Q
         YvRw==
X-Forwarded-Encrypted: i=1; AJvYcCULeyIUKU3Ef0uG9pHjRZkTQ0iFJs0m9ubOTVMnRaDfUILfJmP0CF5EOKVtEC8pb3eeXFEd5Js=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw74lrvVJ1SCZTdWyKTWmtm7PVe73qsn2lXsPnEPQhheEHaYXr1
	11yC9kMvaKf6pT4mNjqsNcp20wFBFdDUFCQo9ip+dThjPn7w7hhcy+kaSjg2QWTOkW0dJEwcVar
	v7oFopS0zcHWBoEvau9ShwR7zyNehSCmh0N3duUmGy1lUThnWU53P6e2E7mytoaImjyervUEKf+
	TZhSnjYc86ViqwpoUqRHUjwWz0UKkPh081dw==
X-Gm-Gg: AY/fxX5Y1ey+dCdM0w+J/ck2UUz12T1mrR1QjVBfs6xWp4wtd/UE9UU47d1ibJW4uhP
	0wH78gxCNwtEcethY2mxckoJY+XiOcfRKpmTyZTLLnmQaLA5VlEymr0FJtOQqee0N6+/ffrD+vr
	Hp3rlgy0ljqqP5JGuta/zVrJ3xsauEd6xU59u1gm6IcCR79CLKWu2DDhK0n7a1JemZ+8bJ1FZT9
	nU1vvSQK0TjIm5y2uYwNpCC/HI=
X-Received: by 2002:a05:6214:20c4:b0:87c:152c:7b25 with SMTP id 6a1803df08f44-8908417a83emr4059376d6.13.1767731863955;
        Tue, 06 Jan 2026 12:37:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHe6k4XyAC7SDNmIV8Widb1Lx0PsZbA3SJB46brDrmjIcwCjVMtRz39h2+S6aiLHZhXDrPcyZUfC0ksAUonE+0=
X-Received: by 2002:a05:6214:20c4:b0:87c:152c:7b25 with SMTP id
 6a1803df08f44-8908417a83emr4058966d6.13.1767731863422; Tue, 06 Jan 2026
 12:37:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105102018.62731-1-slark_xiao@163.com> <20260105102018.62731-7-slark_xiao@163.com>
In-Reply-To: <20260105102018.62731-7-slark_xiao@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 21:37:32 +0100
X-Gm-Features: AQt7F2rECMBW8fLOVj-Gh1CCmiZZoC5Uhn9FeVMWyxZtfED4EVNRzoxpfF3wDOc
Message-ID: <CAFEp6-0McaFcecp-Kg6cj2VACw8MvY0H5dMOk4srS9NhiNBPGw@mail.gmail.com>
Subject: Re: [net-next v4 6/8] net: wwan: hwsim: support NMEA port emulation
To: Slark Xiao <slark_xiao@163.com>
Cc: ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mani@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE3OCBTYWx0ZWRfX/l3+H5exxyNp
 wGBhIRLmtw+zIoSgIO4Y6Gj7pkSTepbBNwPUSE13muJ1qwwHRZE+9xSL/bJDu0pM5DLPXHPMg+F
 xDubIMOlz0u4YEX2rlS7oPdQp6PBtA8fAc16toxOdbCG2Lu4EpoA3MDgNH29/N22jy5GkauWJwY
 BE+NF3/48eSsjTqAICa+5TCsVwpcKDIw0bFbBJLncIU/+jnWVQV4MuOf3zJITGNuGy1X9iCK0Mc
 o4WRy3OmcuOHfZEudG65SAwANvpN6dyIhcoK8ucEn8b25lbvHhO/kcHp1v8nObnh2eb3oMbHtGv
 UaGuMT/I8i1E5eZ0wDTHD60KDuleeycmcU+8gasgvTNUmE7NM6fDoUbMZHq6yZ80AymgWJbfQi+
 FC4itMXvnPEacnrTt/ajHDLo71lO+wf8Z58/GQ6vA3PYNuEbCtyrvYp0tdUgQ7S3v62WuT30DzW
 zaKMcwhHfW7eHVD1E2g==
X-Proofpoint-GUID: RgLc5YaC0bxqpbZyXcFY9bY8bXCZsh-4
X-Proofpoint-ORIG-GUID: RgLc5YaC0bxqpbZyXcFY9bY8bXCZsh-4
X-Authority-Analysis: v=2.4 cv=evHSD4pX c=1 sm=1 tr=0 ts=695d7299 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Byx-y9mGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=7qZPFy86YsvIucM3Wt8A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060178

On Mon, Jan 5, 2026 at 11:21=E2=80=AFAM Slark Xiao <slark_xiao@163.com> wro=
te:
>
> From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>
> Support NMEA port emulation for the WWAN core GNSS port testing purpose.
> Emulator produces pair of GGA + RMC sentences every second what should
> be enough to fool gpsd into believing it is working with a NMEA GNSS
> receiver.
>
> If the GNSS system is enabled then one NMEA port will be created
> automatically for the simulated WWAN device. Manual NMEA port creation
> is not supported at the moment.
>
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/net/wwan/wwan_hwsim.c | 128 +++++++++++++++++++++++++++++++++-
>  1 file changed, 126 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wwan/wwan_hwsim.c b/drivers/net/wwan/wwan_hwsim.=
c
> index 11d15dc39041..e4b1bbff9af2 100644
> --- a/drivers/net/wwan/wwan_hwsim.c
> +++ b/drivers/net/wwan/wwan_hwsim.c
> @@ -2,7 +2,7 @@
>  /*
>   * WWAN device simulator for WWAN framework testing.
>   *
> - * Copyright (c) 2021, Sergey Ryazanov <ryazanov.s.a@gmail.com>
> + * Copyright (c) 2021, 2025, Sergey Ryazanov <ryazanov.s.a@gmail.com>
>   */
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> @@ -12,8 +12,10 @@
>  #include <linux/slab.h>
>  #include <linux/device.h>
>  #include <linux/spinlock.h>
> +#include <linux/time.h>
>  #include <linux/list.h>
>  #include <linux/skbuff.h>
> +#include <linux/timer.h>
>  #include <linux/netdevice.h>
>  #include <linux/wwan.h>
>  #include <linux/debugfs.h>
> @@ -65,6 +67,9 @@ struct wwan_hwsim_port {
>                                 AT_PARSER_SKIP_LINE,
>                         } pstate;
>                 } at_emul;
> +               struct {
> +                       struct timer_list timer;
> +               } nmea_emul;
>         };
>  };
>
> @@ -193,6 +198,108 @@ static const struct wwan_port_ops wwan_hwsim_at_emu=
l_port_ops =3D {
>         .tx =3D wwan_hwsim_at_emul_tx,
>  };
>
> +#if IS_ENABLED(CONFIG_GNSS)
> +#define NMEA_MAX_LEN           82      /* Max sentence length */
> +#define NMEA_TRAIL_LEN         5       /* '*' + Checksum + <CR><LF> */
> +#define NMEA_MAX_DATA_LEN      (NMEA_MAX_LEN - NMEA_TRAIL_LEN)
> +
> +static __printf(2, 3)
> +void wwan_hwsim_nmea_skb_push_sentence(struct sk_buff *skb,
> +                                      const char *fmt, ...)
> +{
> +       unsigned char *s, *p;
> +       va_list ap;
> +       u8 cs =3D 0;
> +       int len;
> +
> +       s =3D skb_put(skb, NMEA_MAX_LEN + 1);     /* +'\0' */
> +       if (!s)
> +               return;
> +
> +       va_start(ap, fmt);
> +       len =3D vsnprintf(s, NMEA_MAX_DATA_LEN + 1, fmt, ap);
> +       va_end(ap);
> +       if (WARN_ON_ONCE(len > NMEA_MAX_DATA_LEN))/* No space for trailer=
 */
> +               return;
> +
> +       for (p =3D s + 1; *p !=3D '\0'; ++p)/* Skip leading '$' or '!' */
> +               cs ^=3D *p;
> +       p +=3D snprintf(p, 5 + 1, "*%02X\r\n", cs);
> +
> +       len =3D (p - s) - (NMEA_MAX_LEN + 1);     /* exp. vs real length =
diff */
> +       skb->tail +=3D len;                       /* Adjust tail to real =
length */
> +       skb->len +=3D len;
> +}
> +
> +static void wwan_hwsim_nmea_emul_timer(struct timer_list *t)
> +{
> +       /* 43.74754722298909 N 11.25759835922875 E in DMM format */
> +       static const unsigned int coord[4 * 2] =3D { 43, 44, 8528, 0,
> +                                                  11, 15, 4559, 0 };
> +       struct wwan_hwsim_port *port =3D timer_container_of(port, t, nmea=
_emul.timer);
> +       struct sk_buff *skb;
> +       struct tm tm;
> +
> +       time64_to_tm(ktime_get_real_seconds(), 0, &tm);
> +
> +       mod_timer(&port->nmea_emul.timer, jiffies + HZ);        /* 1 seco=
nd */
> +
> +       skb =3D alloc_skb(NMEA_MAX_LEN * 2, GFP_KERNEL);  /* GGA + RMC */
> +       if (!skb)
> +               return;
> +
> +       wwan_hwsim_nmea_skb_push_sentence(skb,
> +                                         "$GPGGA,%02u%02u%02u.000,%02u%0=
2u.%04u,%c,%03u%02u.%04u,%c,1,7,1.03,176.2,M,55.2,M,,",
> +                                         tm.tm_hour, tm.tm_min, tm.tm_se=
c,
> +                                         coord[0], coord[1], coord[2],
> +                                         coord[3] ? 'S' : 'N',
> +                                         coord[4], coord[5], coord[6],
> +                                         coord[7] ? 'W' : 'E');
> +
> +       wwan_hwsim_nmea_skb_push_sentence(skb,
> +                                         "$GPRMC,%02u%02u%02u.000,A,%02u=
%02u.%04u,%c,%03u%02u.%04u,%c,0.02,31.66,%02u%02u%02u,,,A",
> +                                         tm.tm_hour, tm.tm_min, tm.tm_se=
c,
> +                                         coord[0], coord[1], coord[2],
> +                                         coord[3] ? 'S' : 'N',
> +                                         coord[4], coord[5], coord[6],
> +                                         coord[7] ? 'W' : 'E',
> +                                         tm.tm_mday, tm.tm_mon + 1,
> +                                         (unsigned int)tm.tm_year - 100)=
;
> +
> +       wwan_port_rx(port->wwan, skb);
> +}
> +
> +static int wwan_hwsim_nmea_emul_start(struct wwan_port *wport)
> +{
> +       struct wwan_hwsim_port *port =3D wwan_port_get_drvdata(wport);
> +
> +       timer_setup(&port->nmea_emul.timer, wwan_hwsim_nmea_emul_timer, 0=
);
> +       wwan_hwsim_nmea_emul_timer(&port->nmea_emul.timer);
> +
> +       return 0;
> +}
> +
> +static void wwan_hwsim_nmea_emul_stop(struct wwan_port *wport)
> +{
> +       struct wwan_hwsim_port *port =3D wwan_port_get_drvdata(wport);
> +
> +       timer_delete_sync(&port->nmea_emul.timer);
> +}
> +
> +static int wwan_hwsim_nmea_emul_tx(struct wwan_port *wport, struct sk_bu=
ff *in)
> +{
> +       consume_skb(in);
> +
> +       return 0;
> +}
> +
> +static const struct wwan_port_ops wwan_hwsim_nmea_emul_port_ops =3D {
> +       .start =3D wwan_hwsim_nmea_emul_start,
> +       .stop =3D wwan_hwsim_nmea_emul_stop,
> +       .tx =3D wwan_hwsim_nmea_emul_tx,
> +};
> +#endif
> +
>  static struct wwan_hwsim_port *wwan_hwsim_port_new(struct wwan_hwsim_dev=
 *dev,
>                                                    enum wwan_port_type ty=
pe)
>  {
> @@ -203,6 +310,10 @@ static struct wwan_hwsim_port *wwan_hwsim_port_new(s=
truct wwan_hwsim_dev *dev,
>
>         if (type =3D=3D WWAN_PORT_AT)
>                 ops =3D &wwan_hwsim_at_emul_port_ops;
> +#if IS_ENABLED(CONFIG_GNSS)
> +       else if (type =3D=3D WWAN_PORT_NMEA)
> +               ops =3D &wwan_hwsim_nmea_emul_port_ops;
> +#endif
>         else
>                 return ERR_PTR(-EINVAL);
>
> @@ -478,9 +589,10 @@ static int __init wwan_hwsim_init_devs(void)
>                 list_add_tail(&dev->list, &wwan_hwsim_devs);
>                 spin_unlock(&wwan_hwsim_devs_lock);
>
> -               /* Create a couple of ports per each device to accelerate
> +               /* Create a few various ports per each device to accelera=
te
>                  * the simulator readiness time.
>                  */
> +
>                 for (j =3D 0; j < 2; ++j) {
>                         port =3D wwan_hwsim_port_new(dev, WWAN_PORT_AT);
>                         if (IS_ERR(port))
> @@ -490,6 +602,18 @@ static int __init wwan_hwsim_init_devs(void)
>                         list_add_tail(&port->list, &dev->ports);
>                         spin_unlock(&dev->ports_lock);
>                 }
> +
> +#if IS_ENABLED(CONFIG_GNSS)
> +               port =3D wwan_hwsim_port_new(dev, WWAN_PORT_NMEA);
> +               if (IS_ERR(port)) {
> +                       dev_warn(&dev->dev, "failed to create initial NME=
A port: %d\n",
> +                                (int)PTR_ERR(port));
> +               } else {
> +                       spin_lock(&dev->ports_lock);
> +                       list_add_tail(&port->list, &dev->ports);
> +                       spin_unlock(&dev->ports_lock);
> +               }
> +#endif
>         }
>
>         return 0;
> --
> 2.25.1
>


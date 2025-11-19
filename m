Return-Path: <netdev+bounces-239945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA5BC6E41C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 12:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D97A13A36B8
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 11:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB0E34F473;
	Wed, 19 Nov 2025 11:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l441NLFQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bR75Cc9Q"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49731350A20
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551687; cv=none; b=Cg9cfKfOy6MwSbxVbGIUa1qNId0HfFFzmjic0/53C5VYq9WOYgbhcN4Vup0FPlHq60rVJzLtgaZnm/TVUL6HvGvHGqz8w3nRsIajT5mNnpTqjvIIWtC25nohKqqCd+89y3WFnFgeDlqYOLDr8sjNp9xLTXr9Xc/2W77Y6etDLxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551687; c=relaxed/simple;
	bh=IOSirFiJv1QDT+bp2xz/aYiux6oUqeUpNbD+FyjjO1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wb54Qz/Pbfu2fcenIXshJyNqslUcFlcaowFW6cq3DwuFggBEjAt4foOSZ33zXWkwlfVDRvyQoiMhfCj6gChjZqtBjEsyFYc4dI0iXLWk13UUg1n/7lgSFzJnLdFy6qcX9XM6Ya0rE3MlYMjgdY3oNl7Vzh9/wSOsnlhXoIbr0y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l441NLFQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bR75Cc9Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ6SVjc2802295
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 11:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OUia5gdgSF8fBHOYAtpUdTOTahjRe0p5uKhA7ZU8OIs=; b=l441NLFQrRenYo4L
	hKeTBPELk8KDwDm+/IemCruUdOYxXjbMTk/RyKhQ7nBxHu3GRC/T2T1mLaJWeWNg
	rDlPCWteQTec7l0Uww4R9/iQgq7X/qpM4as7ra1cx0gO+zwvH0glH6bmwmfvnxq7
	OtVS8EtIkg8/ZlJ1kP/nXqsucUVF5RtCAV/CQRRWcSAx58sDHnmEiGJH2KWqWOig
	4zoj6ILvGKv4iu4IVn7LuTJ1jKWgo4672HlEinrb8GjwA2+upxqU8Un9gS3rnQTv
	Yn2XYMzWBVS+nTnZ2JnqVn9QwFHRCxbvlRttK+iC8nS6m1pdfoS/OEPgd3f8Mfk+
	MTq/zg==
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agrk23s55-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 11:28:04 +0000 (GMT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-9490596dfb4so284471839f.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 03:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763551682; x=1764156482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUia5gdgSF8fBHOYAtpUdTOTahjRe0p5uKhA7ZU8OIs=;
        b=bR75Cc9QNm7+xrjg9KIEGZJChhSwNFfu2J3MQvKiOEB85LFZ/7qDDqx6aNw54qTVcd
         zFVNoikDupor4o2s0UtSB+EdIZZOmXZbAqi+qT7bEKvkq1LCOsYxtVeTWHtyoyoFrxnp
         a+7jmJSdRpPiz+sgJzFPlnkVUWvUH8USFxlrVeed25SUzI6y1/EjRh3xq1AAOmEAVHkt
         jY6eiNxRpatPmm4fFMKqXez3mt17KiYfblTIjIlcNWUzRz6GokX41JCy6pBy9ewcesGU
         T9gyg0xi0Dv4RrJuuU8zGpB/v4UxOR9fU0om6pXjsoZxJGNdQABWK5mQcoVaDyCVBpzv
         8k5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763551682; x=1764156482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OUia5gdgSF8fBHOYAtpUdTOTahjRe0p5uKhA7ZU8OIs=;
        b=LdkqtUStoS7DMbQG5gTzdE3pvT3CDpPQ036bXZcRb18MQKqW5G5a83FWOI8jYpaK2O
         ZhJtrDMaXRAFZcR5Ld1Y7fd4ipOmEGhAdv5PokwbuWOK51pwM/MjIHoX5XaE4w3mep5m
         VeUD7ZwT2Jnk9UueeGhJ5YPydJTsuvcqrVz9bhR4Hz5LvR/xP+BXQ7XkjXMmwPCkwN7n
         lJ0nzFnjF8iev6DxTkKJHFxJY7B8Vlrj+/SzRiTFap2rOpn3PgvCqItLHibRlsmCfbny
         R50dNKRRMG/mM2ZqiujWY3OCJBRM/AWLuX0VTd3Wji5ncozsHD2cTxsbW8AbaBni8TP6
         E+ww==
X-Forwarded-Encrypted: i=1; AJvYcCVE14sZc7M7oZ3Gm00bGK+dkGyLm7441h1gfTKSfykFnZieXrA/AKPCG3aEWjkHBxz23yeE0hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDoxbG2oLAYfDk/4M3riH06R4LiQNwkJ1Yg1ribcfmMxKOchQX
	JTMTNWjfH9fe9mHT7EBhpj333E/lBHI87b58p/GmUWWoCwbF4vtMjLd7wVP6fRluhn0xjaJNAqc
	ykJxZwGXRl/C2jVpx9s398fu5S43p40IEFaFLVWUhTzpQnCDmuPZGyGY3Sp1xY2CowtHNQXKxwS
	EAY7Fg5gOsBUvXGnolXEYy6z+KR66Qh+D7UQ==
X-Gm-Gg: ASbGncsn+v5H1NoKZ+HyJ6McFQRINm+VVYqPLrH/Ec//5+NvK5QylGRSaov4EI+JHjh
	puixCMuOLPGY4y+5lkXqI/ySwUUjtdNdIOoQmBi1dUfO+JXw8vmHDqGAx00Cx87OUQrJ6NVArxO
	VT5jOIsfJDVO6LlM61KvCCTTlvGhEXxqx8D7dnDC16sGVowhwyuIKiLK2nC+qJE9EU6czHmE91f
	rEDu3Aqk210G3/i4DwziFXnf/9H
X-Received: by 2002:a05:6638:2516:b0:5b7:d710:6611 with SMTP id 8926c6da1cb9f-5b7d71067a2mr18421971173.20.1763551681804;
        Wed, 19 Nov 2025 03:28:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPX64il48Vg1nxZy7Lqc5HTj5SsLaZcwSm3jcvtSH/AJOlwfqAwRnjnPiBNvOfUwtKP1kXGmxWZJKnUlP76/w=
X-Received: by 2002:a05:6638:2516:b0:5b7:d710:6611 with SMTP id
 8926c6da1cb9f-5b7d71067a2mr18421934173.20.1763551681408; Wed, 19 Nov 2025
 03:28:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
 <CAFEp6-08JX1gDDn2-hP5AjXHCGsPYHe05FscQoyiP_OaSQfzqQ@mail.gmail.com>
 <fc1f5d15-163c-49d7-ab94-90e0522b0e57@gmail.com> <CAFEp6-1xoFW6xpQHPN4_XNtbjwvW=TUdFrOkFKwM+-rEH7WqMg@mail.gmail.com>
 <e8d7bab.2987.19936a78b86.Coremail.slark_xiao@163.com> <19a5c6e0-fd2a-4cba-92ed-b5c09d68e90c@gmail.com>
 <317b6512.6a9b.1995168196c.Coremail.slark_xiao@163.com> <CAFEp6-0jAV9XV-v5X_iwR+DzyC-qytnDFaRubT2KEQav1KzTew@mail.gmail.com>
 <CAGRyCJG-JvPu5Gizn8qEZy0QNYgw6yVxz6_KW0K0HUfhZsrmbw@mail.gmail.com>
 <CAGRyCJE28yf-rrfkFbzu44ygLEvoUM7fecK1vnrghjG_e9UaRA@mail.gmail.com>
 <CAFEp6-18FHj1Spw-=2j_cccmLTKHDS3uHR4ONw8geiTyWrxN2Q@mail.gmail.com>
 <16c0b1fa-9617-4ee1-b82f-e6237d7b5f6f@gmail.com> <CAGRyCJGHv19PJ+hyaTYf40GeGRHMXKi-qO0sgREnS3=7rfWGqA@mail.gmail.com>
 <90747682-22c6-4cb6-a6d1-3bef4aeab70e@gmail.com> <6d92e13b.5e8c.19a81315289.Coremail.slark_xiao@163.com>
In-Reply-To: <6d92e13b.5e8c.19a81315289.Coremail.slark_xiao@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 19 Nov 2025 12:27:49 +0100
X-Gm-Features: AWmQ_bk9wJZV36wNCxqmxt7Lq-XvcUh7AYLiqaZt7LiKCEGityJP1SQHuTzhYvw
Message-ID: <CAFEp6-3pvrMmyRg37Vyv_NhXeOukY9A4TYBE9f42zMR5i04k_Q@mail.gmail.com>
Subject: Re: Re: [RFC PATCH v2 0/6] net: wwan: add NMEA port type support
To: Slark Xiao <slark_xiao@163.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Daniele Palmas <dnlplm@gmail.com>,
        Muhammad Nuzaihan <zaihan@unrealasia.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org, Qiang Yu <quic_qianyu@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=a6Q9NESF c=1 sm=1 tr=0 ts=691da9c4 cx=c_pps
 a=WjJghted8nQMc6PJgwfwjA==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=DnLhdxUMAAAA:20
 a=NEAV23lmAAAA:8 a=Byx-y9mGAAAA:8 a=pGLkceISAAAA:8 a=fEcjoF647i_CRZEeeLwA:9
 a=QEXdDO2ut3YA:10 a=CtjknkDrmJZAHT7xvMyn:22
X-Proofpoint-GUID: owglf8ZBJ06JUuEjfmvncesRx6592w3n
X-Proofpoint-ORIG-GUID: owglf8ZBJ06JUuEjfmvncesRx6592w3n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDA5MCBTYWx0ZWRfX4XrsrwHWA6jW
 /I0Bi1YOWLDDBkSV7CpFn9nhzhC7Xvh9ScpPPbVyaaei7oHXDA9bzXUk2sTTZfvQU6EfI5jiFzD
 dJWrvKOphgnh/O0qBXpBqfHSYfMhZPFz8FlA/y0VpbuG9mWgGqEmNGKiuuxdPCuTGXByqJ9JEMX
 MB9BRbT59VRtcK49pSG/vLJv/6TlUC5X/ABU4olALVjrbMyt6tlZEQf+1lIF4+It4Rj8huWUE/6
 wT+GFaMPpOInlppH9ctiVj2WBmI3zK3BUhtCje4Gmdxqi8uxvcPzfLCntH9/lmB29nu+6/VaAIM
 HLDECxISi2tdjn2q3Cwq7OFBjf9hbhmJ5g9MyA9BGXZAS6dTvjwpTzZJFdRl1dsoiS3f6S8uuWA
 ryOHvvoqyAbbCAA0ymMi5TvLF8sPRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_03,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511190090

Hi Slark,

On Fri, Nov 14, 2025 at 8:08=E2=80=AFAM Slark Xiao <slark_xiao@163.com> wro=
te:
>
>
> At 2025-10-13 06:55:28, "Sergey Ryazanov" <ryazanov.s.a@gmail.com> wrote:
> >Hi Daniele,
> >
> >On 10/10/25 16:47, Daniele Palmas wrote:
> >> Il giorno mer 8 ott 2025 alle ore 23:00 Sergey Ryazanov
> >> <ryazanov.s.a@gmail.com> ha scritto:
> >>> On 10/2/25 18:44, Loic Poulain wrote:
> >>>> On Tue, Sep 30, 2025 at 9:22=E2=80=AFAM Daniele Palmas <dnlplm@gmail=
.com> wrote:
> >>>> [...]
> >>>>> diff --git a/drivers/net/wwan/wwan_hwsim.c b/drivers/net/wwan/wwan_=
hwsim.c
> >>>>> index a748b3ea1602..e4b1bbff9af2 100644
> >>>>> --- a/drivers/net/wwan/wwan_hwsim.c
> >>>>> +++ b/drivers/net/wwan/wwan_hwsim.c
> >>>>> @@ -236,7 +236,7 @@ static void wwan_hwsim_nmea_emul_timer(struct t=
imer_list *t)
> >>>>>           /* 43.74754722298909 N 11.25759835922875 E in DMM format =
*/
> >>>>>           static const unsigned int coord[4 * 2] =3D { 43, 44, 8528=
, 0,
> >>>>>                                                      11, 15, 4559, =
0 };
> >>>>> -       struct wwan_hwsim_port *port =3D from_timer(port, t, nmea_e=
mul.timer);
> >>>>> +       struct wwan_hwsim_port *port =3D timer_container_of(port, t=
,
> >>>>> nmea_emul.timer);
> >>>>>
> >>>>> it's basically working fine in operative mode though there's an iss=
ue
> >>>>> at the host shutdown, not able to properly terminate.
> >>>>>
> >>>>> Unfortunately I was not able to gather useful text logs besides the=
 picture at
> >>>>>
> >>>>> https://drive.google.com/file/d/13ObWikuiMMUENl2aZerzxFBg57OB1KNj/v=
iew?usp=3Dsharing
> >>>>>
> >>>>> showing an oops with the following call stack:
> >>>>>
> >>>>> __simple_recursive_removal
> >>>>> preempt_count_add
> >>>>> __pfx_remove_one
> >>>>> wwan_remove_port
> >>>>> mhi_wwan_ctrl_remove
> >>>>> mhi_driver_remove
> >>>>> device_remove
> >>>>> device_del
> >>>>>
> >>>>> but the issue is systematic. Any idea?
> >>>>>
> >>>>> At the moment I don't have the time to debug this deeper, I don't e=
ven
> >>>>> exclude the chance that it could be somehow related to the modem. I
> >>>>> would like to further look at this, but I'm not sure exactly when I
> >>>>> can....
> >>>>
> >>>> Thanks a lot for testing, Sergey, do you know what is wrong with por=
t removal?
> >>>
> >>> Daniele, thanks a lot for verifying the proposal on a real hardware a=
nd
> >>> sharing the build fix.
> >>>
> >>> Unfortunately, I unable to reproduce the crash. I have tried multiple
> >>> times to reboot a VM running the simulator module even with opened GN=
SS
> >>> device. No luck. It reboots and shutdowns smoothly.
> >>>
> >>
> >> I've probably figured out what's happening.
> >>
> >> The problem seems that the gnss device is not considered a wwan_child
> >> by is_wwan_child and this makes device_unregister in wwan_remove_dev
> >> to be called twice.
> >>
> >> For testing I've overwritten the gnss device class with the following =
hack:
> >>
> >> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core=
.c
> >> index 4d29fb8c16b8..32b3f7c4a402 100644
> >> --- a/drivers/net/wwan/wwan_core.c
> >> +++ b/drivers/net/wwan/wwan_core.c
> >> @@ -599,6 +599,7 @@ static int wwan_port_register_gnss(struct wwan_por=
t *port)
> >>                  gnss_put_device(gdev);
> >>                  return err;
> >>          }
> >> +       gdev->dev.class =3D &wwan_class;
> >>
> >>          dev_info(&wwandev->dev, "port %s attached\n", dev_name(&gdev-=
>dev));
> >>
> >> and now the system powers off without issues.
> >>
> >> So, not sure how to fix it properly, but at least does the analysis
> >> make sense to you?
> >
> >Nice catch! I had a doubt regarding correct child port detection. Let me
> >double check, and thank you for pointing me to the possible source of
> >issues.
> >
> >--
> >Sergey
>
> Hi Sergey,
> Sorry for bothering this thread again.
> Do we have any updates on this potential issue? If this issue is not a bi=
g problem,
> Could we commit these patches into a branch then every one could help deb=
ug
> it based on this base code?
> I think we shall have a base to develop. No code is perfect.

We shouldn=E2=80=99t merge a series that is known to be broken or causes
crashes. However, based on Daniele=E2=80=99s feedback, the series can be
fixed.

You can check the tentative fix here:
https://github.com/loicpoulain/linux/commits/wwan/pending
This branch includes Sergey=E2=80=99s patch from the mailing list along wit=
h a
proposed fix.

If you can test it on your side, that would be very helpful.

Also, it=E2=80=99s fine to resubmit the corrected series without the RFC ta=
g,
as long as you keep Sergey as the original author.

Regards,
Loic


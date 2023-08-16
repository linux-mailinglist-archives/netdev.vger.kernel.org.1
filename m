Return-Path: <netdev+bounces-28018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 781DA77DE9E
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 12:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9159A281892
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 10:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA4DFC18;
	Wed, 16 Aug 2023 10:28:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC75FDF6F
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 10:28:50 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507E41BD4
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 03:28:48 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9fa64db41so96772381fa.1
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 03:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692181726; x=1692786526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uELcce118sXJ+EW4VKs7BVJr8APQV5mL7VNPgEe8Stw=;
        b=eWt9dkaZ7gn1zEpEnZla/8Z0dxj67MjYx8cknoD5pjxNatzERBFw5bjIY8oyDs3B11
         NqnB/ATBnE7Gv/Zy9f45Or3D43eNn5LdAMj2hk5ZzTWM1D/qU7LKm9S6LHx1hRnWrOE/
         iQNSKpyYcU6L38mjoh7pz4G28voV1Q7UqZCB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692181726; x=1692786526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uELcce118sXJ+EW4VKs7BVJr8APQV5mL7VNPgEe8Stw=;
        b=kzg/rlGO+6Kd6YgoBIN4PhjT81tHQhTv4GYkUee+F7jXymv8yusebb5P+Extd1lpCY
         i6i+RbIsrQYxPyDENFK9M5OBXIKDDp4pZ1jrRY5YI+tdz03px8FugyEWWS3+wkatoW2y
         v/Mpg60Wo+hoyn1jQ59PIVa8UBvjkKB4Qy04NQGK8W6kWvkWjeGUdnzrz3oLILJRxVWN
         frQbIljiCzrgw7oy2y3bUz0NZZk/5EevAd2RcYlv9rf0g4awDr9RdbR17iqiR5wfzO2v
         AkNehL/B18F3CIf+ZOlyFnAWffYeJgwkHy10UGcs23pOzPR3UmJtg3q8tp8+DFnk52qG
         CxHQ==
X-Gm-Message-State: AOJu0Yx13ApEUBDCMm21LY2awfo2B+Ez04PySeuKPMIvMsklkR+RD1mm
	EjJ6sUrvdtU4tLJWWc6rVX6j2llfyGvl7pOq4L/oRg==
X-Google-Smtp-Source: AGHT+IGDnxZj8Sc+nQrDQZ49SyetEzdm1s7tj5awavB1gIlMCwb4W8zItWMTeFU8E+ZEJakEiECrzW3ARpcJDwz8278=
X-Received: by 2002:a2e:9256:0:b0:2bb:99fa:1772 with SMTP id
 v22-20020a2e9256000000b002bb99fa1772mr747610ljg.49.1692181726438; Wed, 16 Aug
 2023 03:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230815045658.80494-1-michael.chan@broadcom.com>
 <20230815045658.80494-12-michael.chan@broadcom.com> <c6f3a05e-f75c-4051-8892-1c2dee2804b0@roeck-us.net>
In-Reply-To: <c6f3a05e-f75c-4051-8892-1c2dee2804b0@roeck-us.net>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 16 Aug 2023 15:58:34 +0530
Message-ID: <CAH-L+nM4MvWODLcApzFB1Xjr4dauii+pBErOZ=frT+eiP8PgVg@mail.gmail.com>
Subject: Re: [PATCH net-next 11/12] bnxt_en: Expose threshold temperatures
 through hwmon
To: Guenter Roeck <linux@roeck-us.net>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com, 
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ba090c060307c224"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--000000000000ba090c060307c224
Content-Type: multipart/alternative; boundary="000000000000b3a492060307c22b"

--000000000000b3a492060307c22b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Guenter for the review and the suggestions.

Please see my response inline.

On Tue, Aug 15, 2023 at 8:35=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:

> On Mon, Aug 14, 2023 at 09:56:57PM -0700, Michael Chan wrote:
> > From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> >
> > HWRM_TEMP_MONITOR_QUERY response now indicates various
> > threshold temperatures. Expose these threshold temperatures
> > through the hwmon sysfs.
> > Also, provide temp1_max_alarm through which the user can check
> > whether the threshold temperature has been reached or not.
> >
> > Example:
> > cat /sys/class/hwmon/hwmon3/temp1_input
> > 75000
> > cat /sys/class/hwmon/hwmon3/temp1_max
> > 105000
> > cat /sys/class/hwmon/hwmon3/temp1_max_alarm
> > 0
> >
> > Cc: Jean Delvare <jdelvare@suse.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: linux-hwmon@vger.kernel.org
> > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  7 ++
> >  .../net/ethernet/broadcom/bnxt/bnxt_hwmon.c   | 71 +++++++++++++++++--
> >  2 files changed, 73 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > index 84cbcfa61bc1..43a07d84f815 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > @@ -2013,6 +2013,7 @@ struct bnxt {
> >       #define BNXT_FW_CAP_RING_MONITOR                BIT_ULL(30)
> >       #define BNXT_FW_CAP_DBG_QCAPS                   BIT_ULL(31)
> >       #define BNXT_FW_CAP_PTP                         BIT_ULL(32)
> > +     #define BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED    BIT_ULL(33)
> >
> >       u32                     fw_dbg_cap;
> >
> > @@ -2185,7 +2186,13 @@ struct bnxt {
> >       struct bnxt_tc_info     *tc_info;
> >       struct list_head        tc_indr_block_list;
> >       struct dentry           *debugfs_pdev;
> > +#ifdef CONFIG_BNXT_HWMON
> >       struct device           *hwmon_dev;
> > +     u8                      warn_thresh_temp;
> > +     u8                      crit_thresh_temp;
> > +     u8                      fatal_thresh_temp;
> > +     u8                      shutdown_thresh_temp;
> > +#endif
> >       enum board_idx          board_idx;
> >  };
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> > index 20381b7b1d78..f5affac1169a 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> > @@ -34,6 +34,15 @@ static int bnxt_hwrm_temp_query(struct bnxt *bp, u8
> *temp)
> >
> >       if (temp)
> >               *temp =3D resp->temp;
> > +
> > +     if (resp->flags &
> TEMP_MONITOR_QUERY_RESP_FLAGS_THRESHOLD_VALUES_AVAILABLE) {
> > +             if (!temp)
> > +                     bp->fw_cap |=3D BNXT_FW_CAP_THRESHOLD_TEMP_SUPPOR=
TED;
>
> The if statement seems unnecessary. If the flag was not set
> during initialization, the limit attributes won't be visible anyway,
> so it doesn't make a difference if it is set now or not.
>
> > +             bp->warn_thresh_temp =3D resp->warn_threshold;
> > +             bp->crit_thresh_temp =3D resp->critical_threshold;
> > +             bp->fatal_thresh_temp =3D resp->fatal_threshold;
> > +             bp->shutdown_thresh_temp =3D resp->shutdown_threshold;
>
> Are those temperatures expected to change during runtime ? If not it migh=
t
> make sense to only execute the entire if condition if temp =3D=3D NULL to
> avoid unnecessary reassignments whenever the temperature is read.
>
> > +     }
> >  err:
> >       hwrm_req_drop(bp, req);
> >       return rc;
> > @@ -42,12 +51,30 @@ static int bnxt_hwrm_temp_query(struct bnxt *bp, u8
> *temp)
> >  static umode_t bnxt_hwmon_is_visible(const void *_data, enum
> hwmon_sensor_types type,
> >                                    u32 attr, int channel)
> >  {
> > +     const struct bnxt *bp =3D _data;
> > +
> >       if (type !=3D hwmon_temp)
> >               return 0;
> >
> >       switch (attr) {
> >       case hwmon_temp_input:
> >               return 0444;
> > +     case hwmon_temp_lcrit:
> > +     case hwmon_temp_crit:
> > +     case hwmon_temp_emergency:
> > +     case hwmon_temp_lcrit_alarm:
> > +     case hwmon_temp_crit_alarm:
> > +     case hwmon_temp_emergency_alarm:
> > +             if (~bp->fw_cap & BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED)
>
> Seems to me that
>                 if (!(bp->fw_cap & BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED))
> would be much easier to understand.
>
> > +                     return 0;
> > +             return 0444;
> > +     /* Max temperature setting in NVM is optional */
> > +     case hwmon_temp_max:
> > +     case hwmon_temp_max_alarm:
> > +             if (~bp->fw_cap & BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED ||
> > +                 !bp->shutdown_thresh_temp)
> > +                     return 0;
>
> Wrong use of the 'max' attribute. More on that below.
>
> > +             return 0444;
> >       default:
> >               return 0;
> >       }
> > @@ -66,6 +93,38 @@ static int bnxt_hwmon_read(struct device *dev, enum
> hwmon_sensor_types type, u32
> >               if (!rc)
> >                       *val =3D temp * 1000;
> >               return rc;
> > +     case hwmon_temp_lcrit:
> > +             *val =3D bp->warn_thresh_temp * 1000;
> > +             return 0;
> > +     case hwmon_temp_crit:
> > +             *val =3D bp->crit_thresh_temp * 1000;
> > +             return 0;
> > +     case hwmon_temp_emergency:
> > +             *val =3D bp->fatal_thresh_temp * 1000;
> > +             return 0;
> > +     case hwmon_temp_max:
> > +             *val =3D bp->shutdown_thresh_temp * 1000;
> > +             return 0;
> > +     case hwmon_temp_lcrit_alarm:
> > +             rc =3D bnxt_hwrm_temp_query(bp, &temp);
> > +             if (!rc)
> > +                     *val =3D temp >=3D bp->warn_thresh_temp;
>
> That is wrong. lcrit is the _lower_ critical temperature, ie the
> temperature is critically low. This is not a "high temperature"
> alarm.
>
> > +             return rc;
> > +     case hwmon_temp_crit_alarm:
> > +             rc =3D bnxt_hwrm_temp_query(bp, &temp);
> > +             if (!rc)
> > +                     *val =3D temp >=3D bp->crit_thresh_temp;
> > +             return rc;
> > +     case hwmon_temp_emergency_alarm:
> > +             rc =3D bnxt_hwrm_temp_query(bp, &temp);
> > +             if (!rc)
> > +                     *val =3D temp >=3D bp->fatal_thresh_temp;
> > +             return rc;
> > +     case hwmon_temp_max_alarm:
> > +             rc =3D bnxt_hwrm_temp_query(bp, &temp);
> > +             if (!rc)
> > +                     *val =3D temp >=3D bp->shutdown_thresh_temp;
>
> Hmm, that isn't really the purpose of alarm attributes. The expectation
> would be that the chip sets alarm flags and the driver reports it.
> I guess there is some value in having it, so I won't object.
>
> Anyway, the ordering is wrong. max_alarm should be the lowest
> alarm level, followed by crit and emergency. So
>                 max_alarm -> temp >=3D bp->warn_thresh_temp
>                 crit_alarm -> temp >=3D bp->crit_thresh_temp
>                 emergency_alarm -> temp >=3D bp->fatal_thresh_temp
>                                 or temp >=3D bp->shutdown_thresh_temp
>
> There are only three levels of upper temperature alarms.
> Abusing lcrit as 4th upper alarm is most definitely wrong.
>
[Kalesh]: Thank you for the clarification.
bnxt_en driver wants to expose 4 threshold temperatures to the user through
hwmon sysfs.
1. warning threshold temperature
2. critical threshold temperature
3. fatal threshold temperature
4. shutdown threshold temperature

I will use the following mapping:

hwmon_temp_max : warning threshold temperature
hwmon_temp_crit : critical threshold temperature
hwmon_temp_emergency : fatal threshold temperature

hwmon_temp_max_alarm : temp >=3D bp->warn_thresh_temp
hwmon_temp_crit_alarm : temp >=3D bp->crit_thresh_temp
hwmon_temp_emergency_alarm : temp >=3D bp->fatal_thresh_temp

Is it OK to map the shutdown threshold temperature to "hwmon_temp_fault"?
If not, can you please suggest an alternative?

Regards,
Kalesh


>
> > +             return rc;
> >       default:
> >               return -EOPNOTSUPP;
> >       }
> > @@ -73,7 +132,11 @@ static int bnxt_hwmon_read(struct device *dev, enum
> hwmon_sensor_types type, u32
> >
> >  static const struct hwmon_channel_info *bnxt_hwmon_info[] =3D {
> >       HWMON_CHANNEL_INFO(temp,
> > -                        HWMON_T_INPUT),
> > +                        HWMON_T_INPUT |
> > +                        HWMON_T_MAX | HWMON_T_LCRIT |
> > +                        HWMON_T_CRIT | HWMON_T_EMERGENCY |
> > +                        HWMON_T_CRIT_ALARM | HWMON_T_LCRIT_ALARM |
> > +                        HWMON_T_MAX_ALARM | HWMON_T_EMERGENCY_ALARM),
> >       NULL
> >  };
> >
> > @@ -97,13 +160,11 @@ void bnxt_hwmon_uninit(struct bnxt *bp)
> >
> >  void bnxt_hwmon_init(struct bnxt *bp)
> >  {
> > -     struct hwrm_temp_monitor_query_input *req;
> >       struct pci_dev *pdev =3D bp->pdev;
> >       int rc;
> >
> > -     rc =3D hwrm_req_init(bp, req, HWRM_TEMP_MONITOR_QUERY);
> > -     if (!rc)
> > -             rc =3D hwrm_req_send_silent(bp, req);
> > +     /* temp1_xxx is only sensor, ensure not registered if it will fai=
l
> */
> > +     rc =3D bnxt_hwrm_temp_query(bp, NULL);
>
> Ah, that is the reason for the check in bnxt_hwrm_temp_query().
> The check in that function should really be added here, not in the
> previous patch.
>
> >       if (rc =3D=3D -EACCES || rc =3D=3D -EOPNOTSUPP) {
> >               bnxt_hwmon_uninit(bp);
> >               return;
> > --
> > 2.30.1
> >
>
>
>

--=20
Regards,
Kalesh A P

--000000000000b3a492060307c22b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Thank you Guenter for the review and the =
suggestions.<br><br>Please see my response inline.<br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 15, 2023=
 at 8:35=E2=80=AFPM Guenter Roeck &lt;<a href=3D"mailto:linux@roeck-us.net"=
 target=3D"_blank">linux@roeck-us.net</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">On Mon, Aug 14, 2023 at 09:56:57PM -07=
00, Michael Chan wrote:<br>
&gt; From: Kalesh AP &lt;<a href=3D"mailto:kalesh-anakkur.purayil@broadcom.=
com" target=3D"_blank">kalesh-anakkur.purayil@broadcom.com</a>&gt;<br>
&gt; <br>
&gt; HWRM_TEMP_MONITOR_QUERY response now indicates various<br>
&gt; threshold temperatures. Expose these threshold temperatures<br>
&gt; through the hwmon sysfs.<br>
&gt; Also, provide temp1_max_alarm through which the user can check<br>
&gt; whether the threshold temperature has been reached or not.<br>
&gt; <br>
&gt; Example:<br>
&gt; cat /sys/class/hwmon/hwmon3/temp1_input<br>
&gt; 75000<br>
&gt; cat /sys/class/hwmon/hwmon3/temp1_max<br>
&gt; 105000<br>
&gt; cat /sys/class/hwmon/hwmon3/temp1_max_alarm<br>
&gt; 0<br>
&gt; <br>
&gt; Cc: Jean Delvare &lt;<a href=3D"mailto:jdelvare@suse.com" target=3D"_b=
lank">jdelvare@suse.com</a>&gt;<br>
&gt; Cc: Guenter Roeck &lt;<a href=3D"mailto:linux@roeck-us.net" target=3D"=
_blank">linux@roeck-us.net</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:linux-hwmon@vger.kernel.org" target=3D"_blank">l=
inux-hwmon@vger.kernel.org</a><br>
&gt; Signed-off-by: Kalesh AP &lt;<a href=3D"mailto:kalesh-anakkur.purayil@=
broadcom.com" target=3D"_blank">kalesh-anakkur.purayil@broadcom.com</a>&gt;=
<br>
&gt; Signed-off-by: Michael Chan &lt;<a href=3D"mailto:michael.chan@broadco=
m.com" target=3D"_blank">michael.chan@broadcom.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/net/ethernet/broadcom/bnxt/bnxt.h=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 7 ++<br>
&gt;=C2=A0 .../net/ethernet/broadcom/bnxt/bnxt_hwmon.c=C2=A0 =C2=A0| 71 +++=
++++++++++++++--<br>
&gt;=C2=A0 2 files changed, 73 insertions(+), 5 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/e=
thernet/broadcom/bnxt/bnxt.h<br>
&gt; index 84cbcfa61bc1..43a07d84f815 100644<br>
&gt; --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h<br>
&gt; +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h<br>
&gt; @@ -2013,6 +2013,7 @@ struct bnxt {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0#define BNXT_FW_CAP_RING_MONITOR=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT_ULL(30)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0#define BNXT_FW_CAP_DBG_QCAPS=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT_ULL(31)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0#define BNXT_FW_CAP_PTP=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT_UL=
L(32)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0#define BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED=C2=
=A0 =C2=A0 BIT_ULL(33)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u32=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fw_dbg_cap;<br>
&gt;=C2=A0 <br>
&gt; @@ -2185,7 +2186,13 @@ struct bnxt {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bnxt_tc_info=C2=A0 =C2=A0 =C2=A0*tc_i=
nfo;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct list_head=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
tc_indr_block_list;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct dentry=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0*debugfs_pdev;<br>
&gt; +#ifdef CONFIG_BNXT_HWMON<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0*hwmon_dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_thresh_temp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 crit_thresh_temp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fatal_thresh_temp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shutdown_thresh_temp;<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0enum board_idx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 board_idx;<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt; diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c b/drivers=
/net/ethernet/broadcom/bnxt/bnxt_hwmon.c<br>
&gt; index 20381b7b1d78..f5affac1169a 100644<br>
&gt; --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c<br>
&gt; +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c<br>
&gt; @@ -34,6 +34,15 @@ static int bnxt_hwrm_temp_query(struct bnxt *bp, u8=
 *temp)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (temp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*temp =3D resp-&=
gt;temp;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (resp-&gt;flags &amp; TEMP_MONITOR_QUERY_RESP_=
FLAGS_THRESHOLD_VALUES_AVAILABLE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!temp)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0bp-&gt;fw_cap |=3D BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED;<br>
<br>
The if statement seems unnecessary. If the flag was not set<br>
during initialization, the limit attributes won&#39;t be visible anyway,<br=
>
so it doesn&#39;t make a difference if it is set now or not.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bp-&gt;warn_thresh_te=
mp =3D resp-&gt;warn_threshold;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bp-&gt;crit_thresh_te=
mp =3D resp-&gt;critical_threshold;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bp-&gt;fatal_thresh_t=
emp =3D resp-&gt;fatal_threshold;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bp-&gt;shutdown_thres=
h_temp =3D resp-&gt;shutdown_threshold;<br>
<br>
Are those temperatures expected to change during runtime ? If not it might<=
br>
make sense to only execute the entire if condition if temp =3D=3D NULL to<b=
r>
avoid unnecessary reassignments whenever the temperature is read.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 err:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hwrm_req_drop(bp, req);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return rc;<br>
&gt; @@ -42,12 +51,30 @@ static int bnxt_hwrm_temp_query(struct bnxt *bp, u=
8 *temp)<br>
&gt;=C2=A0 static umode_t bnxt_hwmon_is_visible(const void *_data, enum hwm=
on_sensor_types type,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 attr, int chann=
el)<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const struct bnxt *bp =3D _data;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (type !=3D hwmon_temp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (attr) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case hwmon_temp_input:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0444;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case hwmon_temp_lcrit:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case hwmon_temp_crit:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case hwmon_temp_emergency:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case hwmon_temp_lcrit_alarm:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case hwmon_temp_crit_alarm:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case hwmon_temp_emergency_alarm:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (~bp-&gt;fw_cap &a=
mp; BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED)<br>
<br>
Seems to me that<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(bp-&gt;fw_cap=
 &amp; BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED))<br>
would be much easier to understand.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0444;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Max temperature setting in NVM is optional */<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0case hwmon_temp_max:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case hwmon_temp_max_alarm:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (~bp-&gt;fw_cap &a=
mp; BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!bp-&gt=
;shutdown_thresh_temp)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return 0;<br>
<br>
Wrong use of the &#39;max&#39; attribute. More on that below.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0444;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; @@ -66,6 +93,38 @@ static int bnxt_hwmon_read(struct device *dev, enum=
 hwmon_sensor_types type, u32<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0*val =3D temp * 1000;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return rc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case hwmon_temp_lcrit:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D bp-&gt;warn_=
thresh_temp * 1000;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case hwmon_temp_crit:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D bp-&gt;crit_=
thresh_temp * 1000;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case hwmon_temp_emergency:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D bp-&gt;fatal=
_thresh_temp * 1000;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case hwmon_temp_max:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D bp-&gt;shutd=
own_thresh_temp * 1000;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case hwmon_temp_lcrit_alarm:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D bnxt_hwrm_temp=
_query(bp, &amp;temp);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rc)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*val =3D temp &gt;=3D bp-&gt;warn_thresh_temp;<br>
<br>
That is wrong. lcrit is the _lower_ critical temperature, ie the<br>
temperature is critically low. This is not a &quot;high temperature&quot;<b=
r>
alarm.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return rc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case hwmon_temp_crit_alarm:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D bnxt_hwrm_temp=
_query(bp, &amp;temp);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rc)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*val =3D temp &gt;=3D bp-&gt;crit_thresh_temp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return rc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case hwmon_temp_emergency_alarm:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D bnxt_hwrm_temp=
_query(bp, &amp;temp);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rc)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*val =3D temp &gt;=3D bp-&gt;fatal_thresh_temp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return rc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case hwmon_temp_max_alarm:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D bnxt_hwrm_temp=
_query(bp, &amp;temp);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rc)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*val =3D temp &gt;=3D bp-&gt;shutdown_thresh_temp;<br>
<br>
Hmm, that isn&#39;t really the purpose of alarm attributes. The expectation=
<br>
would be that the chip sets alarm flags and the driver reports it.<br>
I guess there is some value in having it, so I won&#39;t object.<br>
<br>
Anyway, the ordering is wrong. max_alarm should be the lowest<br>
alarm level, followed by crit and emergency. So<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max_alarm -&gt; tem=
p &gt;=3D bp-&gt;warn_thresh_temp<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 crit_alarm -&gt; te=
mp &gt;=3D bp-&gt;crit_thresh_temp<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 emergency_alarm -&g=
t; temp &gt;=3D bp-&gt;fatal_thresh_temp<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or temp &gt;=3D bp-&gt;shutdown_thre=
sh_temp<br>
<br>
There are only three levels of upper temperature alarms.<br>
Abusing lcrit as 4th upper alarm is most definitely wrong.<br></blockquote>=
<div>[Kalesh]: Thank you for the clarification.</div>bnxt_en driver wants t=
o expose 4 threshold temperatures to the=C2=A0user through hwmon sysfs.<br>=
1. warning threshold temperature<br>2. critical threshold temperature<br>3.=
 fatal threshold temperature<br>4. shutdown threshold temperature<br><br>I =
will use the following mapping:<br><br>hwmon_temp_max : warning threshold t=
emperature<br>hwmon_temp_crit : critical threshold temperature<br>hwmon_tem=
p_emergency : fatal threshold temperature<br><br>hwmon_temp_max_alarm : tem=
p &gt;=3D bp-&gt;warn_thresh_temp<br>hwmon_temp_crit_alarm : temp &gt;=3D b=
p-&gt;crit_thresh_temp<br>hwmon_temp_emergency_alarm : temp &gt;=3D bp-&gt;=
fatal_thresh_temp<br><br>Is it OK to map the shutdown threshold temperature=
 to &quot;hwmon_temp_fault&quot;? If not, can you please suggest an alterna=
tive?</div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">=
Regards,</div><div class=3D"gmail_quote">Kalesh<br><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return rc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSU=
PP;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; @@ -73,7 +132,11 @@ static int bnxt_hwmon_read(struct device *dev, enu=
m hwmon_sensor_types type, u32<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static const struct hwmon_channel_info *bnxt_hwmon_info[] =3D {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0HWMON_CHANNEL_INFO(temp,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 HWMON_T_INPUT),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 HWMON_T_INPUT |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 HWMON_T_MAX | HWMON_T_LCRIT |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 HWMON_T_CRIT | HWMON_T_EMERGENCY |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 HWMON_T_CRIT_ALARM | HWMON_T_LCRIT_ALARM |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 HWMON_T_MAX_ALARM | HWMON_T_EMERGENCY_ALARM),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NULL<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt; @@ -97,13 +160,11 @@ void bnxt_hwmon_uninit(struct bnxt *bp)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 void bnxt_hwmon_init(struct bnxt *bp)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct hwrm_temp_monitor_query_input *req;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct pci_dev *pdev =3D bp-&gt;pdev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int rc;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0rc =3D hwrm_req_init(bp, req, HWRM_TEMP_MONITOR_Q=
UERY);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (!rc)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D hwrm_req_send_=
silent(bp, req);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* temp1_xxx is only sensor, ensure not registere=
d if it will fail */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rc =3D bnxt_hwrm_temp_query(bp, NULL);<br>
<br>
Ah, that is the reason for the check in bnxt_hwrm_temp_query().<br>
The check in that function should really be added here, not in the<br>
previous patch.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc =3D=3D -EACCES || rc =3D=3D -EOPNOTSU=
PP) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bnxt_hwmon_unini=
t(bp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; -- <br>
&gt; 2.30.1<br>
&gt; <br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Regards,<div>Kalesh A P</div></div></div></div>

--000000000000b3a492060307c22b--

--000000000000ba090c060307c224
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIFzpfwcZhFn8Gpu1x+rKDvHCW1i/bk4Djy8m6BOh1gOZMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDgxNjEwMjg0NlowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA9t9zvpc0Q
DQc4ZiWUDd7n7DDxh7oQAPc5AdhsV6aHCI0lUGdysfQzcQ11As2D2jVt41ZRqgQSyS5HHzFxh5zP
6tVkCS6H9bGkmjdk0cpzUo33E3sbADsAYqQTFn55lxnMc5SeVAac8FYVA8D+KFGO3JC7rNdS38Q5
6flwPhOIkTlGaR5ypKDCJF+Ws3XJEDqx+vAm0zvgbE2oIjireYS5I2v/WDetc/qYkXVrs8/3CyWF
4yyAeIqagtggE/BTKdFCiy6d0rlHEeAy4ceszXS0ZfvlRSSx57PgfC6HkPnJCBeW1NUAw9HrS4vd
ZkPGTgEZURIUlZctAsEZtcAD9YlA
--000000000000ba090c060307c224--


Return-Path: <netdev+bounces-28147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7938F77E613
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 18:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD68E281970
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BAD1641B;
	Wed, 16 Aug 2023 16:12:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F3CDDD0
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 16:12:36 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C2AE2
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:12:32 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9ba3d6157so104412641fa.3
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692202350; x=1692807150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nHX3Yq8KoYHwib3eWTBA4c1EOgFhBjTi09fk5LCkf2g=;
        b=WutlLvwuT1KN/+c/H0TSc3jDkhZP+GMOmRgYtiD7wZJen23fIbUJw7O4Vi+S8PftRm
         d+ZgnAwkpQda0MYqmeGncsSNMXDTlHMStEe44wXhAWuS4USIbkIeV9slEeKpmHl5xRKq
         WYWJx/yw29oD3VC89DkXSDMtfN+xpjZt5u2iQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692202350; x=1692807150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHX3Yq8KoYHwib3eWTBA4c1EOgFhBjTi09fk5LCkf2g=;
        b=LoSdMpIJwnd1XGx1KzlxHCxj/WGWDbodu4iUjIJ6jlCrB0m0Xo98AXis45NVXAdYXC
         s4L1dE9dIjxHeuTFHT8S+qomIWQrvJxPkVYLMyW6n2Kf09gJNWq8nhGJH1CblkVQunnj
         J0nAAmR/Xr9wBQNLmZ08ORyV9KBqdYQzKc7xvrddEsHaDGp5MiyKjwED0qmd0396dcGw
         PMqL1gLN7aqbC3IEWMIup23zeFAu//FUWE8twcj2BSCsWdqFjMmTqAhoW8krHAeGvY13
         rLbwHiO4mZehU2gq8Yo7f+haO1jziEbV/bZwHbPd1xt68B0NraQLi38qIgnF4ohLXSB3
         9vZw==
X-Gm-Message-State: AOJu0YwFn/GF6YqnQphBW1HPv+9lFCSxqyvgeHGp/vlLUOJF/V2/9HTW
	4BC0Edde7u2sLbi59k9lIdQC+0LTQWKHLYSaZ1DJ0Q==
X-Google-Smtp-Source: AGHT+IFtBLrWgZa6LKafuIyYafvCTRC5dGyjgfxBgf+RiHEP1cefoUPcE2YcIQpAxHvKLcjzZRC5uZP/gNJpS7YCqLU=
X-Received: by 2002:a2e:7a17:0:b0:2b9:e701:ac48 with SMTP id
 v23-20020a2e7a17000000b002b9e701ac48mr1822991ljc.32.1692202350083; Wed, 16
 Aug 2023 09:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230815045658.80494-1-michael.chan@broadcom.com>
 <20230815045658.80494-12-michael.chan@broadcom.com> <c6f3a05e-f75c-4051-8892-1c2dee2804b0@roeck-us.net>
 <CAH-L+nM4MvWODLcApzFB1Xjr4dauii+pBErOZ=frT+eiP8PgVg@mail.gmail.com> <3d70325b-6b6a-482f-8745-36aceb6b2818@roeck-us.net>
In-Reply-To: <3d70325b-6b6a-482f-8745-36aceb6b2818@roeck-us.net>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 16 Aug 2023 21:42:17 +0530
Message-ID: <CAH-L+nMSZUtDcG9qFSLMJ7ZGDNz91cp+nw0Le7yoxeMkQg9qyA@mail.gmail.com>
Subject: Re: [PATCH net-next 11/12] bnxt_en: Expose threshold temperatures
 through hwmon
To: Guenter Roeck <linux@roeck-us.net>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com, 
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000000be8f06030c9056"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--00000000000000be8f06030c9056
Content-Type: multipart/alternative; boundary="000000000000f7cc7c06030c8f21"

--000000000000f7cc7c06030c8f21
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 5:43=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:

> On Wed, Aug 16, 2023 at 03:58:34PM +0530, Kalesh Anakkur Purayil wrote:
> > Thank you Guenter for the review and the suggestions.
> >
> > Please see my response inline.
> >
> > On Tue, Aug 15, 2023 at 8:35=E2=80=AFPM Guenter Roeck <linux@roeck-us.n=
et>
> wrote:
> >
> [ ... ]
>
> > >
> > > Hmm, that isn't really the purpose of alarm attributes. The expectati=
on
> > > would be that the chip sets alarm flags and the driver reports it.
> > > I guess there is some value in having it, so I won't object.
> > >
> > > Anyway, the ordering is wrong. max_alarm should be the lowest
> > > alarm level, followed by crit and emergency. So
> > >                 max_alarm -> temp >=3D bp->warn_thresh_temp
> > >                 crit_alarm -> temp >=3D bp->crit_thresh_temp
> > >                 emergency_alarm -> temp >=3D bp->fatal_thresh_temp
> > >                                 or temp >=3D bp->shutdown_thresh_temp
> > >
> > > There are only three levels of upper temperature alarms.
> > > Abusing lcrit as 4th upper alarm is most definitely wrong.
> > >
> > [Kalesh]: Thank you for the clarification.
> > bnxt_en driver wants to expose 4 threshold temperatures to the user
> through
> > hwmon sysfs.
> > 1. warning threshold temperature
> > 2. critical threshold temperature
> > 3. fatal threshold temperature
> > 4. shutdown threshold temperature
> >
> > I will use the following mapping:
> >
> > hwmon_temp_max : warning threshold temperature
> > hwmon_temp_crit : critical threshold temperature
> > hwmon_temp_emergency : fatal threshold temperature
> >
> > hwmon_temp_max_alarm : temp >=3D bp->warn_thresh_temp
> > hwmon_temp_crit_alarm : temp >=3D bp->crit_thresh_temp
> > hwmon_temp_emergency_alarm : temp >=3D bp->fatal_thresh_temp
> >
> > Is it OK to map the shutdown threshold temperature to "hwmon_temp_fault=
"?
>
> That is a flag, not a temperature, and it is intended to signal
> a problem ith the sensor.
>
> > If not, can you please suggest an alternative?
> >
>
> The only one I can think of is to add non-standard attributes
> such as temp1_shutdown and temp1_shutdown_alarm.
>
[Kalesh]: Sorry, I don't quite get this part. I was looking at the kernel
hwmon code, but could not find any reference.

Can we add new attributes "shutdown" and "shutdown_alarm" for tempX? For
example:

#define HWMON_T_SHUTDOWN BIT(hwmon_temp_shutdown)

>
> Guenter
>


--=20
Regards,
Kalesh A P

--000000000000f7cc7c06030c8f21
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 16, 2023 at 5:43=E2=80=AF=
PM Guenter Roeck &lt;<a href=3D"mailto:linux@roeck-us.net">linux@roeck-us.n=
et</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On Wed, Aug 16, 2023 at 03:58:34PM +0530, Kalesh Anakkur Purayil wrote:<b=
r>
&gt; Thank you Guenter for the review and the suggestions.<br>
&gt; <br>
&gt; Please see my response inline.<br>
&gt; <br>
&gt; On Tue, Aug 15, 2023 at 8:35=E2=80=AFPM Guenter Roeck &lt;<a href=3D"m=
ailto:linux@roeck-us.net" target=3D"_blank">linux@roeck-us.net</a>&gt; wrot=
e:<br>
&gt; <br>
[ ... ]<br>
<br>
&gt; &gt;<br>
&gt; &gt; Hmm, that isn&#39;t really the purpose of alarm attributes. The e=
xpectation<br>
&gt; &gt; would be that the chip sets alarm flags and the driver reports it=
.<br>
&gt; &gt; I guess there is some value in having it, so I won&#39;t object.<=
br>
&gt; &gt;<br>
&gt; &gt; Anyway, the ordering is wrong. max_alarm should be the lowest<br>
&gt; &gt; alarm level, followed by crit and emergency. So<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0max_=
alarm -&gt; temp &gt;=3D bp-&gt;warn_thresh_temp<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0crit=
_alarm -&gt; temp &gt;=3D bp-&gt;crit_thresh_temp<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0emer=
gency_alarm -&gt; temp &gt;=3D bp-&gt;fatal_thresh_temp<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0or temp &gt;=3D bp-&gt;=
shutdown_thresh_temp<br>
&gt; &gt;<br>
&gt; &gt; There are only three levels of upper temperature alarms.<br>
&gt; &gt; Abusing lcrit as 4th upper alarm is most definitely wrong.<br>
&gt; &gt;<br>
&gt; [Kalesh]: Thank you for the clarification.<br>
&gt; bnxt_en driver wants to expose 4 threshold temperatures to the user th=
rough<br>
&gt; hwmon sysfs.<br>
&gt; 1. warning threshold temperature<br>
&gt; 2. critical threshold temperature<br>
&gt; 3. fatal threshold temperature<br>
&gt; 4. shutdown threshold temperature<br>
&gt; <br>
&gt; I will use the following mapping:<br>
&gt; <br>
&gt; hwmon_temp_max : warning threshold temperature<br>
&gt; hwmon_temp_crit : critical threshold temperature<br>
&gt; hwmon_temp_emergency : fatal threshold temperature<br>
&gt; <br>
&gt; hwmon_temp_max_alarm : temp &gt;=3D bp-&gt;warn_thresh_temp<br>
&gt; hwmon_temp_crit_alarm : temp &gt;=3D bp-&gt;crit_thresh_temp<br>
&gt; hwmon_temp_emergency_alarm : temp &gt;=3D bp-&gt;fatal_thresh_temp<br>
&gt; <br>
&gt; Is it OK to map the shutdown threshold temperature to &quot;hwmon_temp=
_fault&quot;?<br>
<br>
That is a flag, not a temperature, and it is intended to signal<br>
a problem ith the sensor.<br>
<br>
&gt; If not, can you please suggest an alternative?<br>
&gt; <br>
<br>
The only one I can think of is to add non-standard attributes<br>
such as temp1_shutdown and temp1_shutdown_alarm.<br></blockquote><div>[Kale=
sh]: Sorry, I don&#39;t quite get this part. I was looking at the kernel hw=
mon code, but could not find any reference.</div><div><br></div><div>Can we=
 add new attributes &quot;shutdown&quot; and &quot;shutdown_alarm&quot; for=
 tempX? For example:<br><br>#define HWMON_T_SHUTDOWN	BIT(hwmon_temp_shutdow=
n)<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Guenter<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Regards,<div>Kalesh A P</div></div></div></div>

--000000000000f7cc7c06030c8f21--

--00000000000000be8f06030c9056
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
AQkEMSIEIIOfPN4XLi+oeRFoR7FE1qx+7rRaqDyeM+rwGv6D+l1UMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDgxNjE2MTIzMFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCRpxNzu2zf
YGhiamEi1wdGhFqAcX8ySmu5q1zOhuu4z8Rk4AvtN8QbJbkxDnmiKeWaVxOuBYj6Q4g9LGrJGMvx
X9XWrGieRw+TpheZEqUPb+X7NhwLW/7rSfbWLszU0vRcPjRMnXexab4em0gFc9arA482nVPekW2W
iHAkxlDqno4wjRxLe4baPg3yOMb05Dujv2SA5AJ+vvLO3WNPzSnOFoZHtvJ8HIp2BPSUyNk4B9wD
eX6+7vjcCiS+VKpYLGGrwE/jHLW1/wLlRDSxnTCPFo2+CWIQpbT5lc086IfVBSb9/k3pSBPi77eF
1Z5A2++2mkE4GpeIN4wTYNgQ2Xv+
--00000000000000be8f06030c9056--


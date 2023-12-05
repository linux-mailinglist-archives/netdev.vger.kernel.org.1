Return-Path: <netdev+bounces-53747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE2980455B
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 03:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21CAB28110F
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF0B4A12;
	Tue,  5 Dec 2023 02:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ew+1fpIL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02B5A4
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 18:54:40 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7c5634d3189so2648614241.0
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 18:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701744880; x=1702349680; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wYggMWVdMPs0x5DfAcAf8ksqQSzSWVQ+8OvoPkjmjdo=;
        b=Ew+1fpILGEkk44mcGxssJJ0noZCV/79VmIx85wuu4+YvysUsyF+GQVRdoA0r13NIPP
         zaCrcEQE5sg3BOChTsmdddVx4j5P/TNf8ed26yfOGxtD9DaaZGCMt4mPN9L2sW8bPyYw
         ohDWt32vCST2iHTSL18fEoMxDNJZVGm51Qo24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701744880; x=1702349680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYggMWVdMPs0x5DfAcAf8ksqQSzSWVQ+8OvoPkjmjdo=;
        b=CfjiuSUGSGCfP0rwr0k95obxw7Jbp/wk14EQZzZFbTo5agCWifgNIpI+Pdt+6dG4GF
         V+HHx6muRY5zmKq9vNyzwbjpjTmk12Xfi4ybMkyrp80NKPk2rpZlEbCqWaEtLb9VRMvK
         VrxOZ1lSpt91Jn3mDktM1iLM/s8m01tnAW3oHGJjRZaNWwiViYo75j4j38ikZ9cHpN8b
         TGrsZlaItrSRxWP09WRCrtWEdcAn/MKQ8mL6VAUkpn5Z1Zq7X/P4um2icnYI5bl/I5Wi
         nr+aU50ZyfBLZpMm9Y0bjvFEgtNOazRuNT9dLUa7lee2FP14CQrPKd7RWQ97gvswXXf7
         Iq3Q==
X-Gm-Message-State: AOJu0Yz9VGEEbSEB3cRfPqp9OIfOInFv/RcewP9hofB0JBDl/iKimlKD
	bsgKGewaj8sxR1HWZmZ9tA95Z/49m6eW/ANOMaC2sg==
X-Google-Smtp-Source: AGHT+IGHWwxSKnUsu+Ish8NATkJ0XW8MkedQPbf3D+Fm09HnmdC9KxEvcvO/bHKBqw+1OZ5vK8WuXSnHrc7C3awP43k=
X-Received: by 2002:a67:c989:0:b0:464:4897:f5ec with SMTP id
 y9-20020a67c989000000b004644897f5ecmr639133vsk.14.1701744879743; Mon, 04 Dec
 2023 18:54:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204024004.8245-1-dinghao.liu@zju.edu.cn> <CALs4sv1cB6a5jKOgh7JWFLYz8pxfxOuszk3MAYc5xWY9HqYX0g@mail.gmail.com>
 <CACKFLimhHCAqs1APuhX9CWd5c9OQTV=RnA-Aague4SgQufE+_A@mail.gmail.com>
In-Reply-To: <CACKFLimhHCAqs1APuhX9CWd5c9OQTV=RnA-Aague4SgQufE+_A@mail.gmail.com>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Tue, 5 Dec 2023 08:24:25 +0530
Message-ID: <CAOBf=msuHEJOxtOhTd3-Pqg4EG4PS4+o0jLgLO5db59fkKC=gA@mail.gmail.com>
Subject: Re: [PATCH] net: bnxt: fix a potential use-after-free in bnxt_init_tc
To: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Dinghao Liu <dinghao.liu@zju.edu.cn>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000122b24060bba5b1e"

--000000000000122b24060bba5b1e
Content-Type: multipart/alternative; boundary="0000000000000e54ed060bba5b72"

--0000000000000e54ed060bba5b72
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 2:05=E2=80=AFAM Michael Chan <michael.chan@broadcom.=
com>
wrote:

> On Mon, Dec 4, 2023 at 12:56=E2=80=AFAM Pavan Chebbi <pavan.chebbi@broadc=
om.com>
> wrote:
> >
> > On Mon, Dec 4, 2023 at 8:11=E2=80=AFAM Dinghao Liu <dinghao.liu@zju.edu=
.cn>
> wrote:
> > >
> > > When flow_indr_dev_register() fails, bnxt_init_tc will free
> > > bp->tc_info through kfree(). However, the caller function
> > > bnxt_init_one() will ignore this failure and call
> > > bnxt_shutdown_tc() on failure of bnxt_dl_register(), where
> > > a use-after-free happens. Fix this issue by setting
> > > bp->tc_info to NULL after kfree().
> > >
> > > Fixes: 627c89d00fb9 ("bnxt_en: flow_offload: offload tunnel decap
> rules via indirect callbacks")
> > > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> > > ---
> > >  drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
> b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
> > > index 38d89d80b4a9..273c9ba48f09 100644
> > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
> > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
> > > @@ -2075,6 +2075,7 @@ int bnxt_init_tc(struct bnxt *bp)
> > >         rhashtable_destroy(&tc_info->flow_table);
> > >  free_tc_info:
> > >         kfree(tc_info);
> > > +       bp->tc_info =3D NULL;
> > >         return rc;
> > >  }
> >
> > The other way could have been to assign bp->tc_info only after
> > flow_indr_dev_register succeeds.
> > But this one works too. Thanks.
> > Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
>
> I think this is the correct fix.  flow_indr_dev_register(), if
> successful, may call the driver's call back function and so
> bp->tc_info must be set up before the call.  Thanks.
>
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>
>

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>

--0000000000000e54ed060bba5b72
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 5, 2023 at 2:05=E2=80=AFA=
M Michael Chan &lt;<a href=3D"mailto:michael.chan@broadcom.com">michael.cha=
n@broadcom.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Mon, Dec 4, 2023 at 12:56=E2=80=AFAM Pavan Chebbi &lt;<a h=
ref=3D"mailto:pavan.chebbi@broadcom.com" target=3D"_blank">pavan.chebbi@bro=
adcom.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Mon, Dec 4, 2023 at 8:11=E2=80=AFAM Dinghao Liu &lt;<a href=3D"mail=
to:dinghao.liu@zju.edu.cn" target=3D"_blank">dinghao.liu@zju.edu.cn</a>&gt;=
 wrote:<br>
&gt; &gt;<br>
&gt; &gt; When flow_indr_dev_register() fails, bnxt_init_tc will free<br>
&gt; &gt; bp-&gt;tc_info through kfree(). However, the caller function<br>
&gt; &gt; bnxt_init_one() will ignore this failure and call<br>
&gt; &gt; bnxt_shutdown_tc() on failure of bnxt_dl_register(), where<br>
&gt; &gt; a use-after-free happens. Fix this issue by setting<br>
&gt; &gt; bp-&gt;tc_info to NULL after kfree().<br>
&gt; &gt;<br>
&gt; &gt; Fixes: 627c89d00fb9 (&quot;bnxt_en: flow_offload: offload tunnel =
decap rules via indirect callbacks&quot;)<br>
&gt; &gt; Signed-off-by: Dinghao Liu &lt;<a href=3D"mailto:dinghao.liu@zju.=
edu.cn" target=3D"_blank">dinghao.liu@zju.edu.cn</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c | 1 +<br>
&gt; &gt;=C2=A0 1 file changed, 1 insertion(+)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drive=
rs/net/ethernet/broadcom/bnxt/bnxt_tc.c<br>
&gt; &gt; index 38d89d80b4a9..273c9ba48f09 100644<br>
&gt; &gt; --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c<br>
&gt; &gt; +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c<br>
&gt; &gt; @@ -2075,6 +2075,7 @@ int bnxt_init_tc(struct bnxt *bp)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rhashtable_destroy(&amp;tc_info-=
&gt;flow_table);<br>
&gt; &gt;=C2=A0 free_tc_info:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(tc_info);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0bp-&gt;tc_info =3D NULL;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return rc;<br>
&gt; &gt;=C2=A0 }<br>
&gt;<br>
&gt; The other way could have been to assign bp-&gt;tc_info only after<br>
&gt; flow_indr_dev_register succeeds.<br>
&gt; But this one works too. Thanks.<br>
&gt; Reviewed-by: Pavan Chebbi &lt;<a href=3D"mailto:pavan.chebbi@broadcom.=
com" target=3D"_blank">pavan.chebbi@broadcom.com</a>&gt;<br>
<br>
I think this is the correct fix.=C2=A0 flow_indr_dev_register(), if<br>
successful, may call the driver&#39;s call back function and so<br>
bp-&gt;tc_info must be set up before the call.=C2=A0 Thanks.<br>
<br>
Reviewed-by: Michael Chan &lt;<a href=3D"mailto:michael.chan@broadcom.com" =
target=3D"_blank">michael.chan@broadcom.com</a>&gt;<br></blockquote><div><b=
r></div><div>Reviewed-by: Somnath Kotur &lt;<a href=3D"mailto:somnath.kotur=
@broadcom.com">somnath.kotur@broadcom.com</a>&gt;=C2=A0</div></div></div>

--0000000000000e54ed060bba5b72--

--000000000000122b24060bba5b1e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQcAYJKoZIhvcNAQcCoIIQYTCCEF0CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3HMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBU8wggQ3oAMCAQICDHrACvo11BjSxMYbtzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODE4NDJaFw0yNTA5MTAwODE4NDJaMIGQ
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFjAUBgNVBAMTDVNvbW5hdGggS290dXIxKTAnBgkqhkiG9w0B
CQEWGnNvbW5hdGgua290dXJAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAwSM6HryOBKGRppHga4G18QnbgnWFlW7A7HePfwcVN3QOMgkXq0EfqT2hd3VAX9Dgoi2U
JeG28tGwAJpNxAD+aAlL0MVG7D4IcsTW9MrBzUGFMBpeUqG+81YWwUNqxL47kkNHZU5ecEbaUto9
ochP8uGU16ud4wv60eNK59ZvoBDzhc5Po2bEQxrJ5c8V5JHX1K2czTnR6IH6aPmycffF/qHXfWHN
nSGLsSobByQoGh1GyLfFTXI7QOGn/6qvrJ7x9Oem5V7miUTD0wGAIozD7MCVoluf5Psa4Q2a5AFV
gROLty059Ex4oK55Op/0e3Aa/a8hZD/tPBT3WE70owdiCwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpzb21uYXRoLmtvdHVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUabMpSsFcjDNUWMvGf76o
yB7jBJUwDQYJKoZIhvcNAQELBQADggEBAJBDQpQ1TqY57vpQbwtXYP0N01q8J3tfNA/K2vOiNOpv
IufqZ5WKdKEtmT21nujCeuaCQ6SmpWqCUJVkLd+u/sHR62vCo8j2fb1pTkA7jeuCAuT9YMPRE86M
sUphsGDq2ylriQ7y5kvl728hZ0Oakm3xUCnZ9DYS/32sFGSZyrCGZipTBnjK4n5uLQ0yekSLACiD
R0zi4nzkbhwXqDbDaB+Duk52ec/Vj4xuc2uWu9rTmJNVjdk0qu9vh48xcd/BzrlmwY0crGTijAC/
r4x2/y9OfG0FyVmakU0qwDnZX982aa66tXnKNgae2k20WCDVMM5FPTrbMsQyz6Hrv3bg6qgxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgx6wAr6NdQY0sTG
G7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILe6nHLPesYPu7yAqB25rjPKIO4o
LxifEnGtMwEMiUxyMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MTIwNTAyNTQ0MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQANKn7u5RvVxOxAzQZ4ljo1V6qX7p0jbe4JjhCgPk+1Ok0x
1TqpBSBd4FaUfwK0XIF7bFosLZv92TOJd+jDwd9UGJjjjKGj2VhL2tv/ztuV/kWL9xsh5ZWb+MJW
GECmsuhxynEIcO77sHnIzUAqCuC8gB86J1KL1vTmGHfNTJsTe6ev29lvC6cfTKQe8tnjFZFh3Ga+
71IASDURQqKptnaIlCvsbgUrSOSFeExjkzYT058U+T8w6XMshoq+NKDGS6HiMneU3o0ft2SqDJ7k
jLVfNqErbe/fQBDlO+fTJ1RY5P3RIP9GFPKnbszyjJ3Iq7WOHPbEtL1A/RzRgh+QXtt1
--000000000000122b24060bba5b1e--


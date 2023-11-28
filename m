Return-Path: <netdev+bounces-51557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F677FB17E
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 06:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4FAB280354
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 05:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBED110789;
	Tue, 28 Nov 2023 05:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VzJz9XqS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E1419A4
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 21:45:14 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50aa8c0af41so6100695e87.1
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 21:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701150312; x=1701755112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GwIHBfmy6cSRH6f0BZgniHCBBQWGHwmveA+qnfyw2Sk=;
        b=VzJz9XqSXj9WzsbC/Zs/WXDyR0GrPmAPq/zFo5gGUMoLha0CYVd8+nKpm9yetFYrgQ
         H2YpmqIZ93dpQjd8Lc1Y9q4XxHrgh/ijNMBmXMUxPj/1HbcSfSCTTY+ARNA9ECGIOAgr
         hzUT0Osdh82DwzL1ip/m7UrfzMAsrMaEGR0aQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701150312; x=1701755112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwIHBfmy6cSRH6f0BZgniHCBBQWGHwmveA+qnfyw2Sk=;
        b=kKggKJkV4y9yRETlkU6LKD+7ygj0yLlNWllEVMSvwSTZx/PHVq5f0gMjt/8nNIFSRd
         GIGAzyRjFyf0h3vyj6a0eVYDO542ak6HlgUzKvmoUp4JfhL63yzp5DgHW22C1kG9ChB3
         nmjjzyk+iTneE1Lf155bevT++4OYbuXaA8t/f2lTQjjxF/nWEQhsR2pEakdgVj6DYAYf
         JptLFGj5RXElOlvcvttwyZuTlWM20RQbBCc0c1P85o47+hQmjS2LAfbCsfDZjLRaf9jd
         belmi0yf3ZpB7Gxd0C3G3UPCIWNAUAC7ug39T4itFcBA34/OP1Kyw6R2BwnsJpFO/B1u
         DwwA==
X-Gm-Message-State: AOJu0YwaEw9Tw4HFvayUKDP45oiQrRftHyiENbB3k4G5Z9nqGQGUUwe6
	FVEWxyGreNjmQvcGQuplMEuodHuzKxeDCIullFf+tQ==
X-Google-Smtp-Source: AGHT+IF9bUl9vz24RDRrBPfgFMC3ow96M3j3vHgeqGihnXY03JhvyA7xzMqQSwwmh37HaxDbXFCtcHa5YkqXLniJOgY=
X-Received: by 2002:ac2:4468:0:b0:50b:aa7e:7415 with SMTP id
 y8-20020ac24468000000b0050baa7e7415mr2344998lfl.32.1701150312268; Mon, 27 Nov
 2023 21:45:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127030435.17278-1-gakula@marvell.com> <20231127030435.17278-5-gakula@marvell.com>
In-Reply-To: <20231127030435.17278-5-gakula@marvell.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 28 Nov 2023 11:15:00 +0530
Message-ID: <CAH-L+nPuvbefyUo0PPryJc_V5BAQSN=vWBnGUk-_cAsC1z+TBg@mail.gmail.com>
Subject: Re: [net v2 PATCH 4/5] octeontx2-af: Add missing mcs flr handler call
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000018a008060b2fecb2"

--00000000000018a008060b2fecb2
Content-Type: multipart/alternative; boundary="00000000000012f509060b2fecde"

--00000000000012f509060b2fecde
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 8:35=E2=80=AFAM Geetha sowjanya <gakula@marvell.com=
> wrote:

> If mcs resources are attached to PF/VF. These resources need
> to be freed on FLR. This patch add mssing mcs flr call on PF FLR.



> [Kalesh]: s/mssing/missing
>
> Fixes: bd69476e86fc ("octeontx2-af: cn10k: mcs: Install a default TCAM fo=
r
> normal traffic")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> index 22c395c7d040..731bb82b577c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> @@ -2631,6 +2631,9 @@ static void __rvu_flr_handler(struct rvu *rvu, u16
> pcifunc)
>         rvu_npc_free_mcam_entries(rvu, pcifunc, -1);
>         rvu_mac_reset(rvu, pcifunc);
>
> +       if (rvu->mcs_blk_cnt)
> +               rvu_mcs_flr_handler(rvu, pcifunc);
> +
>         mutex_unlock(&rvu->flr_lock);
>  }
>
> --
> 2.25.1
>
>
>

--=20
Regards,
Kalesh A P

--00000000000012f509060b2fecde
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 27, 2023 at 8:35=E2=80=AF=
AM Geetha sowjanya &lt;<a href=3D"mailto:gakula@marvell.com">gakula@marvell=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">If mcs resources are attached to PF/VF. These resources need<br>
to be freed on FLR. This patch add mssing mcs flr call on PF FLR.</blockquo=
te><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">[Kale=
sh]: s/mssing/missing<br>
<br>
Fixes: bd69476e86fc (&quot;octeontx2-af: cn10k: mcs: Install a default TCAM=
 for normal traffic&quot;)<br>
Signed-off-by: Geetha sowjanya &lt;<a href=3D"mailto:gakula@marvell.com" ta=
rget=3D"_blank">gakula@marvell.com</a>&gt;<br>
Reviewed-by: Wojciech Drewek &lt;<a href=3D"mailto:wojciech.drewek@intel.co=
m" target=3D"_blank">wojciech.drewek@intel.com</a>&gt;<br>
---<br>
=C2=A0drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 3 +++<br>
=C2=A01 file changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/=
ethernet/marvell/octeontx2/af/rvu.c<br>
index 22c395c7d040..731bb82b577c 100644<br>
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c<br>
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c<br>
@@ -2631,6 +2631,9 @@ static void __rvu_flr_handler(struct rvu *rvu, u16 pc=
ifunc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rvu_npc_free_mcam_entries(rvu, pcifunc, -1);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rvu_mac_reset(rvu, pcifunc);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rvu-&gt;mcs_blk_cnt)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rvu_mcs_flr_handler=
(rvu, pcifunc);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&amp;rvu-&gt;flr_lock);<br>
=C2=A0}<br>
<br>
-- <br>
2.25.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Regards,<div>Kalesh A P</div></div></div></div>

--00000000000012f509060b2fecde--

--00000000000018a008060b2fecb2
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
AQkEMSIEIHpa/Fe0m0cJEaSVXxaPpaS2pPmWgK8keQSmXdEc5IcGMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEyODA1NDUxMlowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCa/unEuio7
jUjEB2o/j79OZxgFEI7shDAn1Zlosif9+GA1uFXRj+mQH7VVl1qkAt4QRp2cRLWRqQXWNpFFD4P7
YmxTJf2pukHNCylbWI6plh+3AhJ6maXWf1dOnvZcAkXSDvBS1iPjOGJ2WAqIALsscWBGAW7IhOXF
5x7D8BOHDSQvXNTajKyKUawiB+KW0Y3RMaRz49YHRvvHaYBeHSAlQkOysiHoe5WUS1hYrmUdsJps
Z9ceKvAdDrueuNqZCjWQfPpA7VSMxPRC7s9Zhdo4CnKqejjOMPTajRo0ZYrJoy+bPXac3IInDOmd
K11PdpUnNr04E/RxaxZO3WcaB2kG
--00000000000018a008060b2fecb2--


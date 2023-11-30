Return-Path: <netdev+bounces-52402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94F47FEA15
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 09:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4B9BB20DBA
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 08:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BE220B1E;
	Thu, 30 Nov 2023 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RO8aveJA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0011110D9
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 00:01:07 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50bccc2e3efso575785e87.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 00:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701331266; x=1701936066; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JuRJhWnb42//gMuDGqYnUpW4c8SU2sc7uoLCVnJtTWY=;
        b=RO8aveJAseCGssZ6n1OHyuTg5xCZvitsg/DLFlTsvu9rFH+J1LfnuwXm4Q9muP4PXq
         tVcA2lwINFGlTaAU9NRDdGndS+q3VGIGNqG8pUIVEPD/YpyXvHXC90pqJA2nULBNJ7Pk
         a3RNXMfCXJc6R+Vhikc7zahSxKPbMcaiDfLgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701331266; x=1701936066;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JuRJhWnb42//gMuDGqYnUpW4c8SU2sc7uoLCVnJtTWY=;
        b=UrNFWDd5Oj6qs+1K6KjevDubixpsoZ6HS0jr7cZ/qdc9DwnzVHnwy8E1S7t415Pj6X
         tSs+mbnbYgYVQ9lpEjY1o4KlUulK3SPLJrT+JthoXq0flDClFG7mTkgoqi2Bcdq9MDEr
         APcyYaj9DL+TQ1i3F8m6zpaV6INRKP7Ce0a78i6gm2ZMxhDzWg/jPu7Wuc//jKxhYwRu
         OhQjJRwKIBzb8DGAmYaeWPY0NhLzJ3zrJ85hGm/c/CpZBBK3n0uSBHItQdJinoFD4CDE
         y3PNtD/sT73t1QDj7/Fj1rZyChXr0vLwi69tK6QueZEU7CanwoP09tYurBygqcwisNjw
         LQUQ==
X-Gm-Message-State: AOJu0YxTddXX/FDtmsIcBE6fP9Piwj1k5y4zKnjDeXVli/3ak0G1GSL3
	tgtOIulZEaa2gShA7u3bf3Q7eIjSHMYBBXjF8fSibA==
X-Google-Smtp-Source: AGHT+IEOWTag4CF/UiMBec6HQpbr7eQ4oihIKvyjNBZcy8E27Q59NfEt/AIqn6xnijRXmNceMqcO6zEMu+wNaFNYbQI=
X-Received: by 2002:a19:c507:0:b0:50b:cb86:4352 with SMTP id
 w7-20020a19c507000000b0050bcb864352mr918298lfe.44.1701331266327; Thu, 30 Nov
 2023 00:01:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130075818.18401-1-gakula@marvell.com> <20231130075818.18401-3-gakula@marvell.com>
In-Reply-To: <20231130075818.18401-3-gakula@marvell.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Thu, 30 Nov 2023 13:30:54 +0530
Message-ID: <CAH-L+nN96FLT9bR3tXm2qLoC6zjW_tdj2xvVOTK3g0Drp0Kheg@mail.gmail.com>
Subject: Re: [net v3 PATCH 2/5] octeontx2-af: Fix mcs sa cam entries size
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	sgoutham@marvell.com, lcherian@marvell.com, jerinj@marvell.com, 
	sbhatta@marvell.com, hkelam@marvell.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c9926f060b5a0d2c"

--000000000000c9926f060b5a0d2c
Content-Type: multipart/alternative; boundary="000000000000c6c00f060b5a0db8"

--000000000000c6c00f060b5a0db8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 1:28=E2=80=AFPM Geetha sowjanya <gakula@marvell.com=
> wrote:

> On latest silicon versions SA cam entries increased to 256.
> This patch fixes the datatype of sa_entries in mcs_hw_info
> struct to u16 to hold 256 entries.
>
> Fixes: 080bbd19c9dd ("octeontx2-af: cn10k: mcs: Add mailboxes for port
> related operations")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/mbox.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Looks good to me.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index 6845556581c3..5df42634ceb8 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -1945,7 +1945,7 @@ struct mcs_hw_info {
>         u8 tcam_entries;        /* RX/TX Tcam entries per mcs block */
>         u8 secy_entries;        /* RX/TX SECY entries per mcs block */
>         u8 sc_entries;          /* RX/TX SC CAM entries per mcs block */
> -       u8 sa_entries;          /* PN table entries =3D SA entries */
> +       u16 sa_entries;         /* PN table entries =3D SA entries */
>         u64 rsvd[16];
>  };
>
> --
> 2.25.1
>
>
>

--=20
Regards,
Kalesh A P

--000000000000c6c00f060b5a0db8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 30, 2023 at 1:28=E2=80=AF=
PM Geetha sowjanya &lt;<a href=3D"mailto:gakula@marvell.com">gakula@marvell=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On latest silicon versions SA cam entries increased to 256.<br>
This patch fixes the datatype of sa_entries in mcs_hw_info<br>
struct to u16 to hold 256 entries.<br>
<br>
Fixes: 080bbd19c9dd (&quot;octeontx2-af: cn10k: mcs: Add mailboxes for port=
 related operations&quot;)<br>
Signed-off-by: Geetha sowjanya &lt;<a href=3D"mailto:gakula@marvell.com" ta=
rget=3D"_blank">gakula@marvell.com</a>&gt;<br>
Reviewed-by: Wojciech Drewek &lt;<a href=3D"mailto:wojciech.drewek@intel.co=
m" target=3D"_blank">wojciech.drewek@intel.com</a>&gt;<br>
---<br>
=C2=A0drivers/net/ethernet/marvell/octeontx2/af/mbox.h | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br></blockquote><div><b=
r></div>Looks good to me.<br><br><div>Reviewed-by: Kalesh AP &lt;<a href=3D=
"mailto:kalesh-anakkur.purayil@broadcom.com">kalesh-anakkur.purayil@broadco=
m.com</a>&gt;=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net=
/ethernet/marvell/octeontx2/af/mbox.h<br>
index 6845556581c3..5df42634ceb8 100644<br>
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h<br>
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h<br>
@@ -1945,7 +1945,7 @@ struct mcs_hw_info {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 tcam_entries;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* =
RX/TX Tcam entries per mcs block */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 secy_entries;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* =
RX/TX SECY entries per mcs block */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 sc_entries;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* RX/TX SC CAM entries per mcs block */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 sa_entries;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* PN table entries =3D SA entries */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u16 sa_entries;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* PN table entries =3D SA entries */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 rsvd[16];<br>
=C2=A0};<br>
<br>
-- <br>
2.25.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Regards,<div>Kalesh A P</div></div></div></div>

--000000000000c6c00f060b5a0db8--

--000000000000c9926f060b5a0d2c
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
AQkEMSIEIKGmaRT9MKfZNSumAdvRPHv30/mKnzuzqIt2GUHJjlnzMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEzMDA4MDEwNlowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAWjqXXcbNl
CTgajLZw0G55c1G+xevUfvTpMWB0nZbosU3dbKncET+Z2GYhKez3tvDA0jJPYbOG7B7X3K0hkFY0
dSyFTOqQYOcyr9qbg5OdIDMTjwrPfuWF6izquIfNofwjJbBa3bwAp21AXy/6xVEIgkv35nPoeDJ4
4knYT7psCiuwbQEhu4jF276GOERHbQ/Wplr1mPFS0YAlQ2l1mQTyeHSnpxrc+d2xbVZUoaVZ6BgL
qBilT9C19P+uEivo46Q2IGgIiwBktvpuX6Atn7oJRZVfIXcWYZMeh2FHI5A+xx8TnmJ5hNwEt9IN
NNlkYfib9WFVnfkZN5hjkxhvKrfm
--000000000000c9926f060b5a0d2c--


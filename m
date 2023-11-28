Return-Path: <netdev+bounces-51574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AB67FB37A
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8621C20ABE
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65AC14AA5;
	Tue, 28 Nov 2023 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HorgtlBc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC362717
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:01:32 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bb8ff22e6so422735e87.0
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701158491; x=1701763291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=38wxfDGqtM2kcr+hfO/sQ56wn0rUcFifi01gf/6SpPM=;
        b=HorgtlBcoSSJabolbTeaVgW9Kq5jVtOJWyENnyInSd4PwMUYZIdJd/8M/SPT/7leVy
         YwJMjC1ULg6756O2hxHyOK8Ynzz+6WoZz0lVYnu3K6TLYElzdcwRn8KT1+Mj4b9qHY2S
         nTjsFkEO2Yd1aVmz9jr9kXcG74JM4gvJSBSVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701158491; x=1701763291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38wxfDGqtM2kcr+hfO/sQ56wn0rUcFifi01gf/6SpPM=;
        b=ccOqFiGh2/tfCOLU9pdGCHMLC4vgIznhsPc7lhq2v7uXP60Vv8OPQa5X55rG969uZt
         Y3bVNgXv7nPcIDL0Tf/+UbfUo4lNWcqFDPKcH65a5Fy+CuZkBhbTgeqOVaCMBzpGv6U3
         JWJ0xk16Mi6/5KgiCP1Kbat2rTAEGgJ4DpjWEjxnBymEh7z7RMNwx27ou7UYbG+/i4a0
         xvbhD6KWT5Pu+ictJSJiCCyy/qYPSn6qmSkwBirbzkwSIamJtoAQwFwp4C6Re4R4EiZV
         OHfDR1bKbF1aZtYAWFzG2RcxOpmGW4rSGkM+gyjq/Kw3KK3uSZUTPkHuCTtNCHoNV3Ht
         Bu+Q==
X-Gm-Message-State: AOJu0YzVhhh4ogosLXykfeheH6MBxENTdMPz23Z3PRHye/7M7KRAgdiw
	0V3Q3LfUOVYWPaFD1RBNRw5OTxE6uDFk6wY+/9XePw==
X-Google-Smtp-Source: AGHT+IG8ZuqJXUHKD/3ePu3rTVriXspKW74z1/w9gbrkD3EqHlWwDEb7HsKSiRO20clelpaOOmn26oQf6kz8J3D4gkg=
X-Received: by 2002:a05:6512:401f:b0:4fe:8ba8:1a8b with SMTP id
 br31-20020a056512401f00b004fe8ba81a8bmr5554498lfb.7.1701158490900; Tue, 28
 Nov 2023 00:01:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127211037.1135403-1-anthony.l.nguyen@intel.com> <20231127211037.1135403-3-anthony.l.nguyen@intel.com>
In-Reply-To: <20231127211037.1135403-3-anthony.l.nguyen@intel.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 28 Nov 2023 13:31:18 +0530
Message-ID: <CAH-L+nNX3gRdWkgr2xUJRW-_sC0kqD+uqV2rmpX=WZYtYcKQWQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/5] i40e: Remove AQ register definitions for VF types
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, Ivan Vecera <ivecera@redhat.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000946744060b31d350"

--000000000000946744060b31d350
Content-Type: multipart/alternative; boundary="0000000000008efbeb060b31d3d7"

--0000000000008efbeb060b31d3d7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 2:41=E2=80=AFAM Tony Nguyen <anthony.l.nguyen@intel=
.com>
wrote:

> From: Ivan Vecera <ivecera@redhat.com>
>
> The i40e driver does not handle its VF device types so there
> is no need to keep AdminQ register definitions for such
> device types. Remove them.
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_register.h | 10 ----------
>  1 file changed, 10 deletions(-)
>

Looks good to me.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h
> b/drivers/net/ethernet/intel/i40e/i40e_register.h
> index d561687303ea..2e1eaca44343 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_register.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
> @@ -863,16 +863,6 @@
>  #define I40E_PFPM_WUFC 0x0006B400 /* Reset: POR */
>  #define I40E_PFPM_WUFC_MAG_SHIFT 1
>  #define I40E_PFPM_WUFC_MAG_MASK I40E_MASK(0x1, I40E_PFPM_WUFC_MAG_SHIFT)
> -#define I40E_VF_ARQBAH1 0x00006000 /* Reset: EMPR */
> -#define I40E_VF_ARQBAL1 0x00006C00 /* Reset: EMPR */
> -#define I40E_VF_ARQH1 0x00007400 /* Reset: EMPR */
> -#define I40E_VF_ARQLEN1 0x00008000 /* Reset: EMPR */
> -#define I40E_VF_ARQT1 0x00007000 /* Reset: EMPR */
> -#define I40E_VF_ATQBAH1 0x00007800 /* Reset: EMPR */
> -#define I40E_VF_ATQBAL1 0x00007C00 /* Reset: EMPR */
> -#define I40E_VF_ATQH1 0x00006400 /* Reset: EMPR */
> -#define I40E_VF_ATQLEN1 0x00006800 /* Reset: EMPR */
> -#define I40E_VF_ATQT1 0x00008400 /* Reset: EMPR */
>  #define I40E_VFQF_HLUT_MAX_INDEX 15
>
>
> --
> 2.41.0
>
>
>

--=20
Regards,
Kalesh A P

--0000000000008efbeb060b31d3d7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 28, 2023 at 2:41=E2=80=AF=
AM Tony Nguyen &lt;<a href=3D"mailto:anthony.l.nguyen@intel.com">anthony.l.=
nguyen@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">From: Ivan Vecera &lt;<a href=3D"mailto:ivecera@redhat.com"=
 target=3D"_blank">ivecera@redhat.com</a>&gt;<br>
<br>
The i40e driver does not handle its VF device types so there<br>
is no need to keep AdminQ register definitions for such<br>
device types. Remove them.<br>
<br>
Signed-off-by: Ivan Vecera &lt;<a href=3D"mailto:ivecera@redhat.com" target=
=3D"_blank">ivecera@redhat.com</a>&gt;<br>
Reviewed-by: Przemek Kitszel &lt;<a href=3D"mailto:przemyslaw.kitszel@intel=
.com" target=3D"_blank">przemyslaw.kitszel@intel.com</a>&gt;<br>
Reviewed-by: Wojciech Drewek &lt;<a href=3D"mailto:wojciech.drewek@intel.co=
m" target=3D"_blank">wojciech.drewek@intel.com</a>&gt;<br>
Reviewed-by: Simon Horman &lt;<a href=3D"mailto:horms@kernel.org" target=3D=
"_blank">horms@kernel.org</a>&gt;<br>
Signed-off-by: Tony Nguyen &lt;<a href=3D"mailto:anthony.l.nguyen@intel.com=
" target=3D"_blank">anthony.l.nguyen@intel.com</a>&gt;<br>
---<br>
=C2=A0drivers/net/ethernet/intel/i40e/i40e_register.h | 10 ----------<br>
=C2=A01 file changed, 10 deletions(-)<br></blockquote><div><br></div>Looks =
good to me.<br><br><div>Reviewed-by: Kalesh AP &lt;<a href=3D"mailto:kalesh=
-anakkur.purayil@broadcom.com">kalesh-anakkur.purayil@broadcom.com</a>&gt;=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/=
ethernet/intel/i40e/i40e_register.h<br>
index d561687303ea..2e1eaca44343 100644<br>
--- a/drivers/net/ethernet/intel/i40e/i40e_register.h<br>
+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h<br>
@@ -863,16 +863,6 @@<br>
=C2=A0#define I40E_PFPM_WUFC 0x0006B400 /* Reset: POR */<br>
=C2=A0#define I40E_PFPM_WUFC_MAG_SHIFT 1<br>
=C2=A0#define I40E_PFPM_WUFC_MAG_MASK I40E_MASK(0x1, I40E_PFPM_WUFC_MAG_SHI=
FT)<br>
-#define I40E_VF_ARQBAH1 0x00006000 /* Reset: EMPR */<br>
-#define I40E_VF_ARQBAL1 0x00006C00 /* Reset: EMPR */<br>
-#define I40E_VF_ARQH1 0x00007400 /* Reset: EMPR */<br>
-#define I40E_VF_ARQLEN1 0x00008000 /* Reset: EMPR */<br>
-#define I40E_VF_ARQT1 0x00007000 /* Reset: EMPR */<br>
-#define I40E_VF_ATQBAH1 0x00007800 /* Reset: EMPR */<br>
-#define I40E_VF_ATQBAL1 0x00007C00 /* Reset: EMPR */<br>
-#define I40E_VF_ATQH1 0x00006400 /* Reset: EMPR */<br>
-#define I40E_VF_ATQLEN1 0x00006800 /* Reset: EMPR */<br>
-#define I40E_VF_ATQT1 0x00008400 /* Reset: EMPR */<br>
=C2=A0#define I40E_VFQF_HLUT_MAX_INDEX 15<br>
<br>
<br>
-- <br>
2.41.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Regards,<div>Kalesh A P</div></div></div></div>

--0000000000008efbeb060b31d3d7--

--000000000000946744060b31d350
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
AQkEMSIEIIctp7BcjH+M4qRBxv5bm2kLbXWRIlp1wYv9c9nQPREfMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEyODA4MDEzMVowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCA/4d46ZDF
mbzsNTWy9leGAKqDHSu/1PS8l3nAtLVJzmrKthhIt/GCfyQHV5qTKkzS9/Ja4BFkILGN6LU74Yjr
hfBcXIdr2AECVHrhR2EK6g2r82eY699m58YtRKDKdVxXXydYhTEf2rG9M+vR1zJX0MZuOBT0HSTY
pYyldZGN6OO3K3v7cWyvA653ENb6yNMx1kGKnyogW31K2FaQ8YU/thGAK06sXm9S+cR/4oGuRLgN
wyiRrQ4Y787MXLHEscTnJI5vIAKy6lsp7Gy/mCCGXGy1awJc9UcPREfETN/6Q886f/nuCvqMxm8T
QoHXN4n+GtKNFLOcg8fykWwx3oPj
--000000000000946744060b31d350--


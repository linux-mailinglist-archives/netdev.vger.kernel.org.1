Return-Path: <netdev+bounces-51989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D767FCDA5
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 04:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03D22832EB
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E72453B9;
	Wed, 29 Nov 2023 03:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CQoFGJ3a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640C7100
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 19:51:39 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5098e423ba2so9099165e87.2
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 19:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701229897; x=1701834697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GqLUfeSZjRNsCXStiszWRs7P1Z7bN0vKwsy6NSzo31U=;
        b=CQoFGJ3aU/Ir0eJm9Rr/HPlicnJ6AdbpXeA85mA/o9fQLSTrPkYMiMZdDAYxzAfnrf
         ZNCQLYIph4wnyhR0TJcSEBdH6Z2thufS6LwAofhitE9dGX1n069gXMewRgyOq+8uVSfR
         xnWr0mTdhmEUzl7NfSaLdSomAJyHWBnu+DWkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701229897; x=1701834697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqLUfeSZjRNsCXStiszWRs7P1Z7bN0vKwsy6NSzo31U=;
        b=L+bJ+4/LxUQMS+5G2DJtL8WP6LRmj7STkVIn07iBy8mM9DmpCcxrxpNAJvghkhtRIQ
         bOWZHSLaUcQO9A+hfAe+f8pho2p215CJVkGC4wkWCmbiMLbV8LDTmwGz3+wEfLEUmwJY
         Ah94Hfof10WwWJYP1iUyGwuISRQ4uSsdgsM8GoUP4YSXMeY5di7iEOTAvcYhyjkM5mcK
         pxvT/w5zQbx+Hp2SQODUhdGSrd/nuxCmK6eZa5+hMC58zuchMmp2+quNkAimWe3cXKpP
         BxjLEl+P2Lc/+mpvjVGRPytdnknMDcZD5cFa40pzyAeSXwu6P6Z1bADwJJI2sIBLdcwx
         vAlQ==
X-Gm-Message-State: AOJu0Yw8r6F8LublC7pq/W+jCcPFgs7x94gi77MZOCHtX7s6KGiLJBaq
	m3c52esJzDbDPQ46sXYaD91mInUwbDlKwEPCC+90Ag==
X-Google-Smtp-Source: AGHT+IEYeFMW+lMIJvHXDRQB5A4pkj9Rz6Tw35NC1kGXvbY4xZEf7w1NvxXW66IfdB93c6iR/NqTIGHBO9zxUQjqv9c=
X-Received: by 2002:a05:6512:1114:b0:509:8e7f:b46c with SMTP id
 l20-20020a056512111400b005098e7fb46cmr13215305lfg.56.1701229897597; Tue, 28
 Nov 2023 19:51:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128095928.1083292-1-jiawenwu@trustnetic.com>
In-Reply-To: <20231128095928.1083292-1-jiawenwu@trustnetic.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 29 Nov 2023 09:21:26 +0530
Message-ID: <CAH-L+nOxzNGSWmKDN8cMQqp8VMrAmJ+E83daoDsqoeV5yFArFg@mail.gmail.com>
Subject: Re: [PATCH net] net: libwx: fix memory leak on msix entry
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, mengyuanlou@net-swift.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000bf619e060b427316"

--000000000000bf619e060b427316
Content-Type: multipart/alternative; boundary="000000000000ba9fd8060b4273cf"

--000000000000ba9fd8060b4273cf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 3:35=E2=80=AFPM Jiawen Wu <jiawenwu@trustnetic.com>=
 wrote:

> Since pci_free_irq_vectors() set pdev->msix_enabled as 0 in the
> calling of pci_msix_shutdown(), wx->msix_entries is never freed.
> Reordering the lines to fix the memory leak.
>
> Fixes: 3f703186113f ("net: libwx: Add irq flow functions")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Looks good to me.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

>
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 2823861e5a92..a5a50b5a8816 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -1972,11 +1972,11 @@ void wx_reset_interrupt_capability(struct wx *wx)
>         if (!pdev->msi_enabled && !pdev->msix_enabled)
>                 return;
>
> -       pci_free_irq_vectors(wx->pdev);
>         if (pdev->msix_enabled) {
>                 kfree(wx->msix_entries);
>                 wx->msix_entries =3D NULL;
>         }
> +       pci_free_irq_vectors(wx->pdev);
>  }
>  EXPORT_SYMBOL(wx_reset_interrupt_capability);
>
> --
> 2.27.0
>
>
>

--=20
Regards,
Kalesh A P

--000000000000ba9fd8060b4273cf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 28, 2023 at 3:35=E2=80=AF=
PM Jiawen Wu &lt;<a href=3D"mailto:jiawenwu@trustnetic.com">jiawenwu@trustn=
etic.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">Since pci_free_irq_vectors() set pdev-&gt;msix_enabled as 0 in the<=
br>
calling of pci_msix_shutdown(), wx-&gt;msix_entries is never freed.<br>
Reordering the lines to fix the memory leak.<br>
<br>
Fixes: 3f703186113f (&quot;net: libwx: Add irq flow functions&quot;)<br>
Signed-off-by: Jiawen Wu &lt;<a href=3D"mailto:jiawenwu@trustnetic.com" tar=
get=3D"_blank">jiawenwu@trustnetic.com</a>&gt;<br>
---<br>
=C2=A0drivers/net/ethernet/wangxun/libwx/wx_lib.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br></blockquote><div><b=
r></div>Looks good to me.<br><br><div>Reviewed-by: Kalesh AP &lt;<a href=3D=
"mailto:kalesh-anakkur.purayil@broadcom.com">kalesh-anakkur.purayil@broadco=
m.com</a>&gt;=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethe=
rnet/wangxun/libwx/wx_lib.c<br>
index 2823861e5a92..a5a50b5a8816 100644<br>
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c<br>
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c<br>
@@ -1972,11 +1972,11 @@ void wx_reset_interrupt_capability(struct wx *wx)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!pdev-&gt;msi_enabled &amp;&amp; !pdev-&gt;=
msix_enabled)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0pci_free_irq_vectors(wx-&gt;pdev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pdev-&gt;msix_enabled) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(wx-&gt;msix_e=
ntries);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wx-&gt;msix_entries=
 =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pci_free_irq_vectors(wx-&gt;pdev);<br>
=C2=A0}<br>
=C2=A0EXPORT_SYMBOL(wx_reset_interrupt_capability);<br>
<br>
-- <br>
2.27.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Regards,<div>Kalesh A P</div></div></div></div>

--000000000000ba9fd8060b4273cf--

--000000000000bf619e060b427316
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
AQkEMSIEIIEIsc2prkAXd3xhmiEM6qZv+2y7d1eXve8aX9vp+8LlMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEyOTAzNTEzN1owaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAagK5INdSv
EMV6aIUa54MpH2FyUWzOmB9oKkIeh9K3NijR+S+TFi2NhuTKQzHRy/uCruFWuBWr3N+n9QLBKMcw
BD7/nJEZ5g6G9cPQCI6PRthVrUbSe0LP8NTPUSAnsTe9pED5TlmQeOw5QSdvWDKQ1O+sfRfCH0RJ
qDIDwLSpCbij+8xxfUpTKMGdu4S1CEmC9/iVliKQ4EvlTKqSq2AjNI2e83VzbiICiYNUw9ZnMM6i
9LTFGY/mHvPRhgliqmUMp/XJZU9Ym0sbYhfCrD4OwDD5SH2okJiUFjvtntmES/f9h4XvXQPqXOjV
Z4pEhyQiQu5EXMLnBKpYtZgcNQN3
--000000000000bf619e060b427316--


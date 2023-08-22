Return-Path: <netdev+bounces-29546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F2C783B3D
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7865D1C20A56
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 07:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E13B8471;
	Tue, 22 Aug 2023 07:57:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8F26D19
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 07:57:13 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8CF12C
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 00:57:12 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9a2033978so65323641fa.0
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 00:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692691030; x=1693295830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pu5pj6W1sDuyyJYDn50miAEWFHsJgDyqtQuiIF+AuY0=;
        b=dljinJKGmhg4RvN0Be3S7AbuQiJT66p+OcLbW83Eyev9KFR1ws6PC+Z1LdEE2Og+nK
         GvuPEmL63FZcdFuEvB5X/ZyoCREn8rcTUGx5ZfakDrrHyZI0ayiRAgkuFDWlaQlCiC1G
         eUw7X+QdH79f0KzMoOYMuyaOJk1P2YxwKLuDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692691030; x=1693295830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pu5pj6W1sDuyyJYDn50miAEWFHsJgDyqtQuiIF+AuY0=;
        b=VHBuS6AqPn0UL+Ups7v9VFDsQhMKpK+JGX+JSXrGlFyNr2FWyPxg76M0JHrgFhu5So
         j6qHJbdTTp3Vw2Dl6KVnnTBZ1nfCdoiRG3Ykk3JFnKD7HttAOeyN8lWpTpT936wkISKw
         bxdiJveSxBjWZz29rYheYRWPU1ya9AE2VwYf7kT2xtgy/WF65zJLGxRYzHKJpb+AaH6H
         ykUuxABp0dDqN9Oh2NYbqqsSq5L/Q0nEHcFzfaufSt0s6zYK34HLYCF5X0qnEAj7czwN
         Ft+M+//QMYX73+V/82I+Hd3XeSrapgp6EOKNBaOa6Bf2qaUnB5KfE5NnSv7FWok7xg3j
         PPHg==
X-Gm-Message-State: AOJu0YxKTqNYyfcJRsofznveWtWMFgSylDG3SPgn+ZadCX6sOt3Os7EK
	ikIdYz29Q94HEF+iBQEHdKnH0Be5BjYxZ/Lbnyxwjw==
X-Google-Smtp-Source: AGHT+IGMv9KD3I0QgAsj0m8Y2UgHIwDLp48j2jXFhdLK27ZRAHpEi60eKeFDv7N8KoC0KOBpBPKcb+BxL/8D1cOJx1k=
X-Received: by 2002:a2e:9089:0:b0:2b6:fa3e:f2fa with SMTP id
 l9-20020a2e9089000000b002b6fa3ef2famr6718403ljg.32.1692691030254; Tue, 22 Aug
 2023 00:57:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230821141923.1889776-1-idosch@nvidia.com>
In-Reply-To: <20230821141923.1889776-1-idosch@nvidia.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 22 Aug 2023 13:26:58 +0530
Message-ID: <CAH-L+nMoaCynX+3yzVVsrj-4T_nhVXRAgp=BB-nEzPRdr-9qoA@mail.gmail.com>
Subject: Re: [PATCH net-next] vxlan: vnifilter: Use GFP_KERNEL instead of GFP_ATOMIC
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, razor@blackwall.org, mlxsw@nvidia.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009a41be06037e5763"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--0000000000009a41be06037e5763
Content-Type: multipart/alternative; boundary="0000000000009319d706037e57b2"

--0000000000009319d706037e57b2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2023 at 7:51=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:

> The function is not called from an atomic context so use GFP_KERNEL
> instead of GFP_ATOMIC. The allocation of the per-CPU stats is already
> performed with GFP_KERNEL.
>
> Tested using test_vxlan_vnifiltering.sh with CONFIG_DEBUG_ATOMIC_SLEEP.
>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
>

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

> ---
>  drivers/net/vxlan/vxlan_vnifilter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c
> b/drivers/net/vxlan/vxlan_vnifilter.c
> index c3ff30ab782e..9c59d0bf8c3d 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c
> @@ -696,7 +696,7 @@ static struct vxlan_vni_node *vxlan_vni_alloc(struct
> vxlan_dev *vxlan,
>  {
>         struct vxlan_vni_node *vninode;
>
> -       vninode =3D kzalloc(sizeof(*vninode), GFP_ATOMIC);
> +       vninode =3D kzalloc(sizeof(*vninode), GFP_KERNEL);
>         if (!vninode)
>                 return NULL;
>         vninode->stats =3D netdev_alloc_pcpu_stats(struct
> vxlan_vni_stats_pcpu);
> --
> 2.40.1
>
>
>

--=20
Regards,
Kalesh A P

--0000000000009319d706037e57b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 21, 2023 at 7:51=E2=80=AF=
PM Ido Schimmel &lt;<a href=3D"mailto:idosch@nvidia.com">idosch@nvidia.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">T=
he function is not called from an atomic context so use GFP_KERNEL<br>
instead of GFP_ATOMIC. The allocation of the per-CPU stats is already<br>
performed with GFP_KERNEL.<br>
<br>
Tested using test_vxlan_vnifiltering.sh with CONFIG_DEBUG_ATOMIC_SLEEP.<br>
<br>
Signed-off-by: Ido Schimmel &lt;<a href=3D"mailto:idosch@nvidia.com" target=
=3D"_blank">idosch@nvidia.com</a>&gt;<br></blockquote><div><br></div><div>R=
eviewed-by: Kalesh AP &lt;<a href=3D"mailto:kalesh-anakkur.purayil@broadcom=
.com" target=3D"_blank">kalesh-anakkur.purayil@broadcom.com</a>&gt;=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0drivers/net/vxlan/vxlan_vnifilter.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_=
vnifilter.c<br>
index c3ff30ab782e..9c59d0bf8c3d 100644<br>
--- a/drivers/net/vxlan/vxlan_vnifilter.c<br>
+++ b/drivers/net/vxlan/vxlan_vnifilter.c<br>
@@ -696,7 +696,7 @@ static struct vxlan_vni_node *vxlan_vni_alloc(struct vx=
lan_dev *vxlan,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vxlan_vni_node *vninode;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0vninode =3D kzalloc(sizeof(*vninode), GFP_ATOMI=
C);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vninode =3D kzalloc(sizeof(*vninode), GFP_KERNE=
L);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!vninode)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vninode-&gt;stats =3D netdev_alloc_pcpu_stats(s=
truct vxlan_vni_stats_pcpu);<br>
-- <br>
2.40.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Regards,<div>Kalesh A P</div></div></div></div>

--0000000000009319d706037e57b2--

--0000000000009a41be06037e5763
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
AQkEMSIEINGKEjWqc+MtLMLIuGMLTYVVZsDyGKBOgtQhhYfj0uUcMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDgyMjA3NTcxMFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBu5zX1v9tf
Xo0CPlFf/F0CumnJHsq+kyvy6Tu7m7mojqdRAE2iBVx85LVsk4WVkAYqjgDejI/LIFKcB6zYZv0s
RGJQ7yxM0L/gH0EgPfzbn+DmPDmtiYiET7VXEwX/fbkSCkBKRejnlLI01nVIpXll4dOK7130bASA
5sCJ7c5eT6QBNQM5PCQLVJy0EqD8kw+PZnCA9/B2vNIRbtAHNUFvdDFV9l0KXMjKUJYqUXQAZLVE
NS/GhB2TL4JfXSXq1S+EoTRZcYZ2624sUvmy61APEzGx0zA+tWhNBlBgogEuzdBujifTthqLaUOQ
qGuZL1JqCnB9SMKChiuSmqp0SE4n
--0000000000009a41be06037e5763--


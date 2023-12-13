Return-Path: <netdev+bounces-56709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285958108F9
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 05:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FC961C20916
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 04:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE10BA3B;
	Wed, 13 Dec 2023 04:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AqNdDo92"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6EACE
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 20:06:22 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50be9e6427dso6809854e87.1
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 20:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1702440380; x=1703045180; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2cJ8oUh3ydaO2BzziGw9MGPfTlqFCWSwF9Ix10g8oyE=;
        b=AqNdDo92/PVzQl8ZOMPYuZ1IWphgq524XEyIHK7NxpLynRa8u4vj2bdENJaitHlZ7+
         /o7WQnEEudYFce9MfjPHlgxrKz6FFo/u7Nn+bGEmhQIV9YuhVUxCR6LuMt+X/JiV2lgQ
         dskfzD81x4l5Z69wXLbw8UxOg16msIXGKWoo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702440380; x=1703045180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2cJ8oUh3ydaO2BzziGw9MGPfTlqFCWSwF9Ix10g8oyE=;
        b=ryca7s+9LNxS8sZLaQm+/lblrU9lLRJcP4HKkfAN0Lhw+uJtGT/gHdbLUmDTzC1XRr
         KzPAy17QqtYstJv0s286PnJaSHcIE4Q5RZnhN9yXqRlUNMYqxp5Ra2jl5I/pcwCey/SM
         ZgSgGM9Lr/A1E+WXMzdjh7TuvQ0VnDfYXkIynKd7/U+M65dowUWXGHhd6WoJXRdsLk/B
         pYA0nTmHk85m96LRmJGIVwhRufT166r73xQ3dXvOoIl5A7/POXUW8mBceToTZUF+b4d/
         JJ9IjHNQAae0zNJ7Hg3Tx91Ks/6KHQeGHAJPS0/saBzxTbh2AU47tKnvYWgkDY8VQkZl
         KS2w==
X-Gm-Message-State: AOJu0Yz3+UzuM1eihh3uvZ0OQBGTDUbwErMvCbw5+PufU+4mGMwMyyx2
	LZjX/MxkH/cyhsxpmXAXTKOckQqw3YXbuDw1Xt8ExpyiwBSHKd+u
X-Google-Smtp-Source: AGHT+IEHmn0nogLWXtDkmh3xJtW8HDbtX8WsZOI0JRR6z7WltB2UFyCRt12LmqUB0PK+0j7tfWchQiQw0Ei2HV8Qsso=
X-Received: by 2002:a05:6512:b14:b0:50e:c7e:4bf2 with SMTP id
 w20-20020a0565120b1400b0050e0c7e4bf2mr1008091lfu.133.1702440380561; Tue, 12
 Dec 2023 20:06:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206010114.2259388-1-jesse.brandeburg@intel.com> <20231206010114.2259388-15-jesse.brandeburg@intel.com>
In-Reply-To: <20231206010114.2259388-15-jesse.brandeburg@intel.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 13 Dec 2023 09:36:08 +0530
Message-ID: <CAH-L+nPi1yCP+18Z=UJj7E-jeV3W8aWnNXP49SDTVXWEErBqWg@mail.gmail.com>
Subject: Re: [PATCH iwl-next v2 14/15] ice: cleanup inconsistent code
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	aleksander.lobakin@intel.com, przemyslaw.kitszel@intel.com, horms@kernel.org, 
	marcin.szycik@linux.intel.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000289401060c5c4a04"

--000000000000289401060c5c4a04
Content-Type: multipart/alternative; boundary="00000000000022f382060c5c4ae3"

--00000000000022f382060c5c4ae3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 6:32=E2=80=AFAM Jesse Brandeburg <jesse.brandeburg@i=
ntel.com>
wrote:

> It was found while doing further testing of the previous commit
> fbf32a9bab91 ("ice: field get conversion") that one of the FIELD_GET
> conversions should really be a FIELD_PREP. The previous code was styled
> as a match to the FIELD_GET conversion, which always worked because the
> shift value was 0.  The code makes way more sense as a FIELD_PREP and
> was in fact the only FIELD_GET with two constant arguments in this
> series.
>
> Didn't squash this patch to make it easier to call out the
> (non-impactful) bug.
>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb.c | 2 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.c
> b/drivers/net/ethernet/intel/ice/ice_dcb.c
> index 7f3e00c187b4..74418c445cc4 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dcb.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dcb.c
> @@ -967,7 +967,7 @@ void ice_get_dcb_cfg_from_mib_change(struct
> ice_port_info *pi,
>
>         mib =3D (struct ice_aqc_lldp_get_mib *)&event->desc.params.raw;
>
> -       change_type =3D FIELD_GET(ICE_AQ_LLDP_MIB_TYPE_M,  mib->type);
> +       change_type =3D FIELD_GET(ICE_AQ_LLDP_MIB_TYPE_M, mib->type);
>
[Kalesh]: I did not get what exactly changed here? Is that you just removed
one extra space before mib->type?

>         if (change_type =3D=3D ICE_AQ_LLDP_MIB_REMOTE)
>                 dcbx_cfg =3D &pi->qos_cfg.remote_dcbx_cfg;
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 8cdd53412748..d1c1e53fe15c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -974,8 +974,8 @@ static void ice_set_dflt_vsi_ctx(struct ice_hw *hw,
> struct ice_vsi_ctx *ctxt)
>         /* Traffic from VSI can be sent to LAN */
>         ctxt->info.sw_flags2 =3D ICE_AQ_VSI_SW_FLAG_LAN_ENA;
>         /* allow all untagged/tagged packets by default on Tx */
> -       ctxt->info.inner_vlan_flags =3D
> FIELD_GET(ICE_AQ_VSI_INNER_VLAN_TX_MODE_M,
> -
>  ICE_AQ_VSI_INNER_VLAN_TX_MODE_ALL);
> +       ctxt->info.inner_vlan_flags =3D
> FIELD_PREP(ICE_AQ_VSI_INNER_VLAN_TX_MODE_M,
> +
> ICE_AQ_VSI_INNER_VLAN_TX_MODE_ALL);
>         /* SVM - by default bits 3 and 4 in inner_vlan_flags are 0's whic=
h
>          * results in legacy behavior (show VLAN, DEI, and UP) in
> descriptor.
>          *
> --
> 2.39.3
>
>
>

--=20
Regards,
Kalesh A P

--00000000000022f382060c5c4ae3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 6, 2023 at 6:32=E2=80=AFA=
M Jesse Brandeburg &lt;<a href=3D"mailto:jesse.brandeburg@intel.com">jesse.=
brandeburg@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">It was found while doing further testing of the previou=
s commit<br>
fbf32a9bab91 (&quot;ice: field get conversion&quot;) that one of the FIELD_=
GET<br>
conversions should really be a FIELD_PREP. The previous code was styled<br>
as a match to the FIELD_GET conversion, which always worked because the<br>
shift value was 0.=C2=A0 The code makes way more sense as a FIELD_PREP and<=
br>
was in fact the only FIELD_GET with two constant arguments in this<br>
series.<br>
<br>
Didn&#39;t squash this patch to make it easier to call out the<br>
(non-impactful) bug.<br>
<br>
Signed-off-by: Jesse Brandeburg &lt;<a href=3D"mailto:jesse.brandeburg@inte=
l.com" target=3D"_blank">jesse.brandeburg@intel.com</a>&gt;<br>
---<br>
=C2=A0drivers/net/ethernet/intel/ice/ice_dcb.c | 2 +-<br>
=C2=A0drivers/net/ethernet/intel/ice/ice_lib.c | 4 ++--<br>
=C2=A02 files changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.c b/drivers/net/etherne=
t/intel/ice/ice_dcb.c<br>
index 7f3e00c187b4..74418c445cc4 100644<br>
--- a/drivers/net/ethernet/intel/ice/ice_dcb.c<br>
+++ b/drivers/net/ethernet/intel/ice/ice_dcb.c<br>
@@ -967,7 +967,7 @@ void ice_get_dcb_cfg_from_mib_change(struct ice_port_in=
fo *pi,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mib =3D (struct ice_aqc_lldp_get_mib *)&amp;eve=
nt-&gt;desc.params.raw;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0change_type =3D FIELD_GET(ICE_AQ_LLDP_MIB_TYPE_=
M,=C2=A0 mib-&gt;type);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0change_type =3D FIELD_GET(ICE_AQ_LLDP_MIB_TYPE_=
M, mib-&gt;type);<br></blockquote><div>[Kalesh]: I did not get what exactly=
 changed here? Is that you just removed one extra space before mib-&gt;type=
?</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (change_type =3D=3D ICE_AQ_LLDP_MIB_REMOTE)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dcbx_cfg =3D &amp;p=
i-&gt;qos_cfg.remote_dcbx_cfg;<br>
<br>
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/etherne=
t/intel/ice/ice_lib.c<br>
index 8cdd53412748..d1c1e53fe15c 100644<br>
--- a/drivers/net/ethernet/intel/ice/ice_lib.c<br>
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c<br>
@@ -974,8 +974,8 @@ static void ice_set_dflt_vsi_ctx(struct ice_hw *hw, str=
uct ice_vsi_ctx *ctxt)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Traffic from VSI can be sent to LAN */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctxt-&gt;info.sw_flags2 =3D ICE_AQ_VSI_SW_FLAG_=
LAN_ENA;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* allow all untagged/tagged packets by default=
 on Tx */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ctxt-&gt;info.inner_vlan_flags =3D FIELD_GET(IC=
E_AQ_VSI_INNER_VLAN_TX_MODE_M,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ICE_AQ_VSI_INNER_VLAN_TX_MODE_ALL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ctxt-&gt;info.inner_vlan_flags =3D FIELD_PREP(I=
CE_AQ_VSI_INNER_VLAN_TX_MODE_M,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ICE_AQ_VSI_INNER_VLAN_TX_MODE_ALL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* SVM - by default bits 3 and 4 in inner_vlan_=
flags are 0&#39;s which<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* results in legacy behavior (show VLAN, =
DEI, and UP) in descriptor.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
-- <br>
2.39.3<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Regards,<div>Kalesh A P</div></div></div></div>

--00000000000022f382060c5c4ae3--

--000000000000289401060c5c4a04
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
AQkEMSIEINDaAo1XPaBvToeAucg0HnQnE45V3v/Bn/IzJDoasldgMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIxMzA0MDYyMFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAi04WKSoh3
n89BFm655ERnVclql7IRgU5SlD//krmyFwjA3hX8z3RUW6nVKDZAf1QZJZ7QGetYJjmev7yUhEIG
XyH7QW4bHHbtoEu6VeFquQiGxf8MVjpu76h7VkJiASRc4Hwkad1f7vBOYhOYP8/sH2Exh96G/m9N
ojSdopsxVT3ScxApWfxL/4oK6gTz8cNT/netYQkay68+RBsxjXmUQjUqQYfRtss0j7DPM0M3niMK
J52+xDyR3u+rAKgTU3IrRcvU3+UryLYuyyXXS+ElJYhzgsKZgPJePuF8o5WLG4M537ZqMDAv9WsC
Hlk/mhuvtxVWj5euZfErN7grU9ti
--000000000000289401060c5c4a04--


Return-Path: <netdev+bounces-29547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7275B783B48
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9507A1C20A5C
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 07:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D714D8472;
	Tue, 22 Aug 2023 07:58:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC39B8470
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 07:58:23 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA9BCEC
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 00:58:16 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9b50be31aso65159561fa.3
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 00:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692691095; x=1693295895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c9nulgHCWptgLOlI3QXSGLdTnkuh9WpPfZfp1JKVEeY=;
        b=DRG1QzidM07T/e0oOzGKHRVnnRKaKvgE99FDCYu3AovOJRNKx6a8PzWWVPzzhXRZKs
         7Dw92F3VV+aTzGazx3lCGu2Kl3wJf7ZwLlCC6PoD8uq8y98nHLWfRm7/M2C3+25t2Wmw
         nhjx8Ll5WrfWeNoKFPlvPDpaYg4KyrYKTCZPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692691095; x=1693295895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9nulgHCWptgLOlI3QXSGLdTnkuh9WpPfZfp1JKVEeY=;
        b=e98iX/mdEfejPc+zDkl31rQR4RhnE9ZpBXqm0w7f8QqzJQv13lgUa7wNT7q4GmeDvX
         WByLNtH9Ymkuw3m6nyyorZm4X9l3fCAchb7QyPHZppE2P7UGr58BEE5SKz6gDbNatC97
         IzpkUlJA0UtjNYxx+YFmORX1v7PLMpBtnU/wFB5yiMmpVd7lUQhrxI/IR2BrMx3VHvB1
         vctmmL0geoTv6qsj4wOCjf1k6oVLz+gmnIOqVicUShWpOnMGsArZRW7AX3w72SDbampM
         3ipugeRXWjgAOpSO15R39K9T8v2GW5byDoOYuc3RgIgDYQ4MpgJU9x9ISIh7v/CE/iCE
         VA8Q==
X-Gm-Message-State: AOJu0YyJpQv51sX6H2hD+Sn0h41MvDtnObMDES4VeG2y3LntSyjg2MK8
	O7+DhAbEV7io+u+eyjJv8BxwmYWcCgocsuJAsKwVew==
X-Google-Smtp-Source: AGHT+IHcc2ATPKmfCf22ggdT/VY2OJKMqOfwKt1WRQbJMgzcWwkk82QDRmJb8kxE9pv0lwWfCmc9YCgkGrTf41ss9s0=
X-Received: by 2002:a2e:984e:0:b0:2bb:89e6:184a with SMTP id
 e14-20020a2e984e000000b002bb89e6184amr6536488ljj.10.1692691094478; Tue, 22
 Aug 2023 00:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230821171721.2203572-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230821171721.2203572-1-anthony.l.nguyen@intel.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 22 Aug 2023 13:28:03 +0530
Message-ID: <CAH-L+nNj8KSMGiOmuJNBV1i_yNzaGrQ1gv6QBnH=KU1ei-jakQ@mail.gmail.com>
Subject: Re: [PATCH net] igc: Fix the typo in the PTM Control macro
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, 
	Sasha Neftin <sasha.neftin@intel.com>, Naama Meir <naamax.meir@linux.intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006e887b06037e5b99"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--0000000000006e887b06037e5b99
Content-Type: multipart/alternative; boundary="000000000000672f9806037e5b2c"

--000000000000672f9806037e5b2c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2023 at 10:55=E2=80=AFPM Tony Nguyen <anthony.l.nguyen@inte=
l.com>
wrote:

> From: Sasha Neftin <sasha.neftin@intel.com>
>
> The IGC_PTM_CTRL_SHRT_CYC defines the time between two consecutive PTM
> requests. The bit resolution of this field is six bits. That bit five was
> missing in the mask. This patch comes to correct the typo in the
> IGC_PTM_CTRL_SHRT_CYC macro.
>
> Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h
> b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 44a507029946..2f780cc90883 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -546,7 +546,7 @@
>  #define IGC_PTM_CTRL_START_NOW BIT(29) /* Start PTM Now */
>  #define IGC_PTM_CTRL_EN                BIT(30) /* Enable PTM */
>  #define IGC_PTM_CTRL_TRIG      BIT(31) /* PTM Cycle trigger */
> -#define IGC_PTM_CTRL_SHRT_CYC(usec)    (((usec) & 0x2f) << 2)
> +#define IGC_PTM_CTRL_SHRT_CYC(usec)    (((usec) & 0x3f) << 2)
>  #define IGC_PTM_CTRL_PTM_TO(usec)      (((usec) & 0xff) << 8)
>
>  #define IGC_PTM_SHORT_CYC_DEFAULT      10  /* Default Short/interrupted
> cycle interval */
> --
> 2.38.1
>
>
>

--=20
Regards,
Kalesh A P

--000000000000672f9806037e5b2c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 21, 2023 at 10:55=E2=80=
=AFPM Tony Nguyen &lt;<a href=3D"mailto:anthony.l.nguyen@intel.com">anthony=
.l.nguyen@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">From: Sasha Neftin &lt;<a href=3D"mailto:sasha.neftin@in=
tel.com" target=3D"_blank">sasha.neftin@intel.com</a>&gt;<br>
<br>
The IGC_PTM_CTRL_SHRT_CYC defines the time between two consecutive PTM<br>
requests. The bit resolution of this field is six bits. That bit five was<b=
r>
missing in the mask. This patch comes to correct the typo in the<br>
IGC_PTM_CTRL_SHRT_CYC macro.<br>
<br>
Fixes: a90ec8483732 (&quot;igc: Add support for PTP getcrosststamp()&quot;)=
<br>
Signed-off-by: Sasha Neftin &lt;<a href=3D"mailto:sasha.neftin@intel.com" t=
arget=3D"_blank">sasha.neftin@intel.com</a>&gt;<br>
Tested-by: Naama Meir &lt;<a href=3D"mailto:naamax.meir@linux.intel.com" ta=
rget=3D"_blank">naamax.meir@linux.intel.com</a>&gt;<br>
Signed-off-by: Tony Nguyen &lt;<a href=3D"mailto:anthony.l.nguyen@intel.com=
" target=3D"_blank">anthony.l.nguyen@intel.com</a>&gt;<br></blockquote><div=
>=C2=A0</div><div>Reviewed-by: Kalesh AP &lt;<a href=3D"mailto:kalesh-anakk=
ur.purayil@broadcom.com" target=3D"_blank">kalesh-anakkur.purayil@broadcom.=
com</a>&gt;=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0drivers/net/ethernet/intel/igc/igc_defines.h | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/eth=
ernet/intel/igc/igc_defines.h<br>
index 44a507029946..2f780cc90883 100644<br>
--- a/drivers/net/ethernet/intel/igc/igc_defines.h<br>
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h<br>
@@ -546,7 +546,7 @@<br>
=C2=A0#define IGC_PTM_CTRL_START_NOW BIT(29) /* Start PTM Now */<br>
=C2=A0#define IGC_PTM_CTRL_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 BIT(30) /* Enable PTM */<br>
=C2=A0#define IGC_PTM_CTRL_TRIG=C2=A0 =C2=A0 =C2=A0 BIT(31) /* PTM Cycle tr=
igger */<br>
-#define IGC_PTM_CTRL_SHRT_CYC(usec)=C2=A0 =C2=A0 (((usec) &amp; 0x2f) &lt;=
&lt; 2)<br>
+#define IGC_PTM_CTRL_SHRT_CYC(usec)=C2=A0 =C2=A0 (((usec) &amp; 0x3f) &lt;=
&lt; 2)<br>
=C2=A0#define IGC_PTM_CTRL_PTM_TO(usec)=C2=A0 =C2=A0 =C2=A0 (((usec) &amp; =
0xff) &lt;&lt; 8)<br>
<br>
=C2=A0#define IGC_PTM_SHORT_CYC_DEFAULT=C2=A0 =C2=A0 =C2=A0 10=C2=A0 /* Def=
ault Short/interrupted cycle interval */<br>
-- <br>
2.38.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Regards,<div>Kalesh A P</div></div></div></div>

--000000000000672f9806037e5b2c--

--0000000000006e887b06037e5b99
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQiwYJKoZIhvcNAQcCoIIQfDCCEHgCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3iMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
AQkEMSIEINu/Izh8HI8da97RZwSw7FFWgL5GOeq9HD3PMyqjmyWFMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDgyMjA3NTgxNFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCIXl1qJJno
u7y+uNMGSLOQf6CbOUB0QYcaHApirejR3InhVTuYYCahXr4yNOKrWQySuyTBpwIPUss+HbEED+EU
DkMf5PzmwwoetKTvWxkgM5sf5nTCOGmzpNv3KL8cfe3H63Jo42uiVoso6u9H+f+0/ZgGCL9L+9gL
WRecfd4yCtPPI1QSH5jluBgkS+eJtKpsblxlg9sB6kOGIm0f0WZAlcOvyoZbuTgD75Ile/ZrJFUp
vgcm33OPHLckD3o7UE3EmhHdZOxDTa92kU0TiMxQQFqBN3JgpnrbR9qCqrpVNsRlMzkiJX2fq6Jl
1QoUTt7mZEfCd/vAWLak5xUP1F15
--0000000000006e887b06037e5b99--


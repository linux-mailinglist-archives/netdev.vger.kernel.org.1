Return-Path: <netdev+bounces-12339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A85B737210
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 18:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE2C1C20C3F
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 16:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5992AB2A;
	Tue, 20 Jun 2023 16:49:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F172AB25
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 16:49:46 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACEC12C
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 09:49:44 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-56ff9cc91b4so56122927b3.0
        for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 09:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1687279784; x=1689871784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D8yENK0yi1YbLfe4BBCeswTIaHcVbaRsKHHiO5kelPM=;
        b=DcHCobUQUzMX+WisPYmdnEAXpX9bpxs987kmIMWS4RbqX9fzH4cGsQd7kdZmcvVqun
         90NjPO87OZVQlNEQuzfRF3hgKxQSc4oplHgPUpi4PAZq0JWgP0r9NhPUJ2i6x/oRcSzb
         KSTZtc6676TYRn4xnjCxVdtJxkugc42Y/Tlms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687279784; x=1689871784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8yENK0yi1YbLfe4BBCeswTIaHcVbaRsKHHiO5kelPM=;
        b=WCGKWAxn+JobmvnnAl6shBzoX2mu9nuoqneYAl3PacxTxRWS42FzUZh78lE3EIofkA
         2jGE8yfhil8UME86kuf2hcgIawiiKR2lPLHGr2s2OoYNpuD2/MV/hh+gZsRjkwrvQ336
         0bg500UwrjyLW/ZaF94+irwdyWZfXadNFstSNZvN8IMSuP/7LZhs4uHNLTPfnDrzpD4f
         +gz/q06feCurd98u8fSCMwaArPw4yc3coMFQkOpREOm/dyvlLp8p15D2RrkEOlVc2XIk
         aUrJ/4JLoe5gIylvY8x5FPIAp9+JJhw8CpsTfyNfcumn0j8wVkaCWao52Skr+hxOgXwf
         32kw==
X-Gm-Message-State: AC+VfDzM2Vzg9u1kFYa7Y8vBZ6XFvYdVufAkAXrnwNKQQVENangULs9J
	Q3OZg/weeuCuCrA1Odi3/qMUX6QvgQLQAYwlYXhUwZQUqvV22XgJ6RbrJSxKgbdfUe9i62zuuM1
	L+iHb+n4Dv15ziRmeXd92JcQ=
X-Google-Smtp-Source: ACHHUZ6mnQvQ5KfcHYBdIvFw/GTnTZqf1l6oOnr5+/lND4gGOCdgUj+DSoonFtCeUJLqntB6a5E1L9QZJBW99jUuDjo=
X-Received: by 2002:a0d:d611:0:b0:56f:f9c6:3863 with SMTP id
 y17-20020a0dd611000000b0056ff9c63863mr14429018ywd.48.1687279784031; Tue, 20
 Jun 2023 09:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620144855.288443-1-ivecera@redhat.com>
In-Reply-To: <20230620144855.288443-1-ivecera@redhat.com>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Tue, 20 Jun 2023 22:19:32 +0530
Message-ID: <CAHHeUGWQihg4bTeaCNwq8_1ZxSfL5hpdw-RQOPK6QkSGSdX0OA@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: Link representors to PCI device
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002e905705fe9270bc"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--0000000000002e905705fe9270bc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2023 at 10:00=E2=80=AFPM Ivan Vecera <ivecera@redhat.com> w=
rote:
>
> Link VF representors to parent PCI device to benefit from
> systemd defined naming scheme.
>
> Without this change the representor is visible as ethN.
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Acked-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_vfr.c
> index 2f1a1f2d2157..1467b94a6427 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
> @@ -468,6 +468,7 @@ static void bnxt_vf_rep_netdev_init(struct bnxt *bp, =
struct bnxt_vf_rep *vf_rep,
>         struct net_device *pf_dev =3D bp->dev;
>         u16 max_mtu;
>
> +       SET_NETDEV_DEV(dev, &bp->pdev->dev);
>         dev->netdev_ops =3D &bnxt_vf_rep_netdev_ops;
>         dev->ethtool_ops =3D &bnxt_vf_rep_ethtool_ops;
>         /* Just inherit all the featues of the parent PF as the VF-R
> --
> 2.39.3
>
>

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

--0000000000002e905705fe9270bc
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
XzCCBWcwggRPoAMCAQICDAGseBnUOryiK+cWfTANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODE3MzRaFw0yNTA5MTAwODE3MzRaMIGg
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHjAcBgNVBAMTFVNyaWhhcnNoYSBCYXNhdmFwYXRuYTExMC8G
CSqGSIb3DQEJARYic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNvbTCCASIwDQYJKoZI
hvcNAQEBBQADggEPADCCAQoCggEBANGVy7il6qkWFiW5c4+kohP7xrKuKgQsfDqhhdfOx4FvPMTF
A9S2FwTdDOPuDNiSdR2+KK3JzqRLtBCSHV80dlEzwnOgLnlKkFQZvASsdXFtP9j56nc/ni7V4q9G
Ob5RVSl61kWgHXVmZYj+SqUEKdNy1opV5mitkOJHa9zhftMojx+ylauLeBDp7lEjgg5xFPme6KGV
GkD3dAbV6M4mQWaR6RpcUU4Jk+Og3FCDkG8PIxRKia+tBqfj2IGoR9LIlX8WZ/hhHTmkkwnsfr59
kjjPMh9o02jAvOzf/CLmWENkxup5gyPmlM8xAVlqZmn0EtlzxEg2YqBHkRb1s1NNPi0CAwEAAaOC
AeMwggHfMA4GA1UdDwEB/wQEAwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0
dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNydDBBBggrBgEFBQcwAYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3Bl
cnNvbmFsc2lnbjJjYTIwMjAwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEW
Jmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0f
BEIwQDA+oDygOoY4aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMC5jcmwwLQYDVR0RBCYwJIEic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNv
bTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAd
BgNVHQ4EFgQUXHovQBXsYr3/QkkF+EruxqF3ajswDQYJKoZIhvcNAQELBQADggEBAKHfsxL3xirL
i7ilaAfW67MeZRrOqvgw4nXhuj+QzkDDZ4QCb6IEYs1B783CbRNC0Vohjtesr+GKJyeTTRqP/Ca2
tPHjp5VJ3mZZ7Vu1Gnwj5kicRlSs3p7UVzpstr/cGn3oRz4Pby+VIbPftHCyUdrUOocITnz17hmR
JryVxNcbPcjGdGhThv3mdEDg2RCrFR1X0jlSAsLbQn83Agls1OHzBPHuudbspjj3/jJGD8gsIcnx
dgaqC7WHdB3zZutGigdpsmj/fxrvqbTUW8ZakCTtc8C57oDCeoBI4L+KAaFoHOJjVlWaQ3g9Fefa
eiXd6ovtpOAc/1MAXvMftuX+mQIxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNp
Z24gMiBDQSAyMDIwAgwBrHgZ1Dq8oivnFn0wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkE
MSIEIK1vKlNQs+M7jytqzkcQn55JeDmSFlAOeDNN99/FyjkGMBgGCSqGSIb3DQEJAzELBgkqhkiG
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDYyMDE2NDk0NFowaQYJKoZIhvcNAQkPMVwwWjALBglg
hkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0B
AQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAFwYdA7+Ol21s5
krc4HR10fCQXtcwvjr6qsl5JnfdQcI7nKOROqrKoAJhlAN47J9jjFKmdKNy8SxJ8di3i8ig3ArAr
nkbUvpvkVXZ9x3PAs1m8gxtObp8+VNwBNKmG068k5DluUza7evB/D24FZSqklQKcw88l4SmPFZhq
efDGc8NhinrKzGh0wNQW2diwE4sGutn/WX8nCfBc0XiqNmbAM+4VnpI1NIYXrU5jq0VKfqb244Mw
hqnRPqQ8S9DgsxdXqmQeWMhPa40qancmGyCJOKh7RiK+OmzPvVYcysWm01H0OnJJftrUj0vvrmGo
i3BeAN+/WuJoth9NOP/7diUh
--0000000000002e905705fe9270bc--


Return-Path: <netdev+bounces-52387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9417FE8D5
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 06:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B095B20F97
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 05:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE691B277;
	Thu, 30 Nov 2023 05:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MFZrNWQn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B1B10C6
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 21:52:44 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54b0310f536so685075a12.0
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 21:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701323563; x=1701928363; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1GmMxILSO0sS8s9TlKE8oHm8oyoxf77cxXfd7FgCql4=;
        b=MFZrNWQnC/eStHQCN1x8rrjXVObqVqSAgMU3+IbUmlFZkBDkWf0y4oElxwwJBlYibp
         6Dw87TkZ8jNs77gSgUsUGKA77CkHgrafqbtE+a7M1z10risB2yPI+1YAtUTByEzYoQE1
         NaGAj/FRhnIrT+p7P1/KsJTkJv/gEfB4m2XGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701323563; x=1701928363;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1GmMxILSO0sS8s9TlKE8oHm8oyoxf77cxXfd7FgCql4=;
        b=K20nzhAZvjPl4YCT6JPvMgdgORtQ+4osq6bzTKj0J8okrWMKkL+YyQP0WU5tutVYku
         oViR6czhO4Lqg37S54lE4QxxMCe5LuFmrz6aRJFTam/xycLhj3uXAjfFYvJ23o1e5ckl
         uYHpE2OxqCkKppdofogSmM2ngRh9oNLnVEd2QLI5sEgFlqkqYvb/9e+3OH9Z0v9ZrTiC
         tlWfilphrv2JKV3djs2iJtPqjPGVyaWX97w4ce31R3pLkKwI2SSwDhqPMhA64RbdViQG
         p+FKOeC4B43+5ZEt34rw/88Wli814F2A26/+l0Y5gQjuUjAQk8wpooD+4jYlBEUdd4oC
         Hg3w==
X-Gm-Message-State: AOJu0Yzy/YjwwfydGci8LSiupVBCXDbP3GEFgvZInxpkuyMpsh9RUs/c
	CntPdTYV6Z/T0X0WCBS+AIvu3LM/IyKHf2OP6urBHQ==
X-Google-Smtp-Source: AGHT+IFHd8HWGJKoEw7fbtCKUnlcHwgPw/WbSOK+s8KVQEQPX+WBR5iItmUW4GNEIZ/LXK1xDukCjujLJ5eKc15L8VY=
X-Received: by 2002:a50:ccc2:0:b0:548:a1cd:a92c with SMTP id
 b2-20020a50ccc2000000b00548a1cda92cmr17055215edj.5.1701323562727; Wed, 29 Nov
 2023 21:52:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170130378595.5198.158092030504280163.stgit@anambiarhost.jf.intel.com>
 <170130410439.5198.5369308046781025813.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <170130410439.5198.5369308046781025813.stgit@anambiarhost.jf.intel.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 29 Nov 2023 21:52:30 -0800
Message-ID: <CACKFLi=if7dtWvvOnKPwxn-hmfzGMCMzfSacNhOQm=GvfJThQQ@mail.gmail.com>
Subject: Re: [net-next PATCH v10 11/11] eth: bnxt: link NAPI instances to
 queues and IRQs
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, ast@kernel.org, sdf@google.com, lorenzo@kernel.org, 
	tariqt@nvidia.com, daniel@iogearbox.net, anthony.l.nguyen@intel.com, 
	lucien.xin@gmail.com, sridhar.samudrala@intel.com, 
	Andrew Gospodarek <gospo@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a13507060b58429f"

--000000000000a13507060b58429f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 4:11=E2=80=AFPM Amritha Nambiar
<amritha.nambiar@intel.com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> Make bnxt compatible with the newly added netlink queue GET APIs.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index e35e7e02538c..08793e24e0ee 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -3845,6 +3845,9 @@ static int bnxt_init_one_rx_ring(struct bnxt *bp, i=
nt ring_nr)
>         ring =3D &rxr->rx_ring_struct;
>         bnxt_init_rxbd_pages(ring, type);
>
> +       netif_queue_set_napi(bp->dev, ring_nr, NETDEV_QUEUE_TYPE_RX,
> +                            &rxr->bnapi->napi);
> +
>         if (BNXT_RX_PAGE_MODE(bp) && bp->xdp_prog) {
>                 bpf_prog_add(bp->xdp_prog, 1);
>                 rxr->xdp_prog =3D bp->xdp_prog;
> @@ -3921,6 +3924,9 @@ static int bnxt_init_tx_rings(struct bnxt *bp)
>                 struct bnxt_ring_struct *ring =3D &txr->tx_ring_struct;
>
>                 ring->fw_ring_id =3D INVALID_HW_RING_ID;
> +
> +               netif_queue_set_napi(bp->dev, i, NETDEV_QUEUE_TYPE_TX,
> +                                    &txr->bnapi->napi);

This will include the XDP TX rings that are internal to the driver.  I
think we need to exclude these XDP rings and do something like this:

if (i > bp->tx_nr_rings_xdp)
        netif_queue_set_napi(bp->dev, i - bp->tx_nr_rings_xdp,
                             NETDEV_QUEUE_TYPE_TX, &txr->bnapi->napi);

>         }
>
>         return 0;
> @@ -9754,6 +9760,7 @@ static int bnxt_request_irq(struct bnxt *bp)
>                 if (rc)
>                         break;
>
> +               netif_napi_set_irq(&bp->bnapi[i]->napi, irq->vector);
>                 irq->requested =3D 1;
>
>                 if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
> @@ -9781,6 +9788,11 @@ static void bnxt_del_napi(struct bnxt *bp)
>         if (!bp->bnapi)
>                 return;
>
> +       for (i =3D 0; i < bp->rx_nr_rings; i++)
> +               netif_queue_set_napi(bp->dev, i, NETDEV_QUEUE_TYPE_RX, NU=
LL);
> +       for (i =3D 0; i < bp->tx_nr_rings; i++)

Similarly,

for (i =3D 0; i < bp->tx_nr_rings - bp->tx_nr_rings_xdp; i++)

> +               netif_queue_set_napi(bp->dev, i, NETDEV_QUEUE_TYPE_TX, NU=
LL);
> +
>         for (i =3D 0; i < bp->cp_nr_rings; i++) {
>                 struct bnxt_napi *bnapi =3D bp->bnapi[i];
>
>

--000000000000a13507060b58429f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKTx6tRdYo2Ttwbl3gI96Nf/7lelGLSN
5fKcoUaiCNDLMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEz
MDA1NTI0M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAp94K1x/3XJnVmXe2f2SBxb6rBm+5Qwcoh+IUfKD1kc5e/UeCy
2lf7WsRLdUFzX5KrGMGP4I4rIZNV9jvUWmBHkXV5PkKlz3CEVXf+lI9RMrfoWDaMm9OFaaCsJmBW
E2orAfuKbRzCt+p7wrBNjNyYZ9DfIF3ueuV6ZR1q3UW/j4rID1u/HhFJNjITuKMeSNupUGHEU5RE
fu9EuHRZmh/gVAU/xPBeTlY6+8FEONfgebHlW2LdtbzQFkSjbUe/vNkCX/zMaS5O2/kr10tl7NLP
zO9Yj490Zu2/Ny8/WEd+omwdIppkh3JZcM6IksQ06y95Ggp0sOBRMA60bxNwp36P
--000000000000a13507060b58429f--


Return-Path: <netdev+bounces-17786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EAE7530A8
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 06:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1FB11C2152B
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDDEA59;
	Fri, 14 Jul 2023 04:44:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A974C83
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 04:44:17 +0000 (UTC)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CFC1BFB
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 21:44:16 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-55adfa61199so1151745a12.2
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 21:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1689309856; x=1691901856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W/Hg/md2SJdzD68YBtoRCz4F/bQCvbQuOEmZkU+H9SE=;
        b=a84Gun+804GyIEhW6JgxEV3TbiS8HUzPWT0EPrXLWHDi+PIH3GPvDD+QpdcN9KeevY
         twulEAIv68udG572hsDNzb6dqLQeAuwmwRgnh2J1pnk6IwM3Gv1cfTwpmYg71SdCLJw9
         Dx8T+7vbylBySnVkxWD3PWYTgN4jPxmsZU1VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689309856; x=1691901856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/Hg/md2SJdzD68YBtoRCz4F/bQCvbQuOEmZkU+H9SE=;
        b=YwWhsC6mD+QFJszVfo709m5jllOzcYFvFHSdpeNDxbS9Lb1Vh16l4cmaxA6dkP3Iir
         jPge8JFnA6qjqoM+JjTNSNF86xvjyO7H4xHijhMYvtjGwT+SLPB2EwPhVSTK7viiYIAP
         0XWUXrWv5w9aUcCX4PZqJiGGSOYFNWn1WkQSRCo57jInol6PQ72g9+Y5u771PLMn58Yv
         TuURKxOT7l4uaLQBEvThSpXGHaT8z7ThabcbNLvuzl2Q9qqCJflnmPFnlgnUcN41Evd9
         8jeixoArpBCppPUKRUfRhgbu+c0p7lPDUEcElL/J4vK0NMJJUN8gU9YYNLYirKttHC00
         GXZw==
X-Gm-Message-State: ABy/qLbK4+D8h8doHcCUczArGu56txRXqDqyhMkoRpDGwg2+Chg19LwX
	dxgBwykxiR4ibPkEly40Us0GHHkXQh98OhwxVx61Pw==
X-Google-Smtp-Source: APBJJlHHuyTZZ0mC+CmHOVmSZIJmkCyy5JYTpL+J40Hrpz2GM2OOTPh7rjxf5VtpYt6ze+9TqoNoHq2Zcc+B6Pzaxbc=
X-Received: by 2002:a17:90a:65c6:b0:25e:bd1d:4f0c with SMTP id
 i6-20020a17090a65c600b0025ebd1d4f0cmr3019474pjs.10.1689309855615; Thu, 13 Jul
 2023 21:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713095743.30517-1-fercerpav@gmail.com>
In-Reply-To: <20230713095743.30517-1-fercerpav@gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 14 Jul 2023 10:14:02 +0530
Message-ID: <CALs4sv08GJXexShzkrhhW5CDSgJC0z3om5YJzy_qYRqEtvyMtg@mail.gmail.com>
Subject: Re: [PATCH] net: ftgmac100: support getting MAC address from NVMEM
To: Paul Fertser <fercerpav@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Liang He <windhl@126.com>, Geoff Levand <geoff@infradead.org>, 
	Leon Romanovsky <leon@kernel.org>, Tao Ren <rentao.bupt@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, openbmc@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e23a0b06006b196f"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--000000000000e23a0b06006b196f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 3:28=E2=80=AFPM Paul Fertser <fercerpav@gmail.com> =
wrote:
>
> Make use of of_get_ethdev_address() to support reading MAC address not
> only from the usual DT nodes but also from an NVMEM provider (e.g. using
> a dedicated area in an FRU EEPROM).
>

Looks like earlier ftgmac100_probe() would move on with self generated
(random) MAC addr if getting it from the device failed.
Now you will fail the probe in a failure case. Is that OK?

> Signed-off-by: Paul Fertser <fercerpav@gmail.com>
> ---
>  drivers/net/ethernet/faraday/ftgmac100.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ether=
net/faraday/ftgmac100.c
> index a03879a27b04..9135b918dd49 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> @@ -177,16 +177,20 @@ static void ftgmac100_write_mac_addr(struct ftgmac1=
00 *priv, const u8 *mac)
>         iowrite32(laddr, priv->base + FTGMAC100_OFFSET_MAC_LADR);
>  }
>
> -static void ftgmac100_initial_mac(struct ftgmac100 *priv)
> +static int ftgmac100_initial_mac(struct ftgmac100 *priv)
>  {
>         u8 mac[ETH_ALEN];
>         unsigned int m;
>         unsigned int l;
> +       int err;
>
> -       if (!device_get_ethdev_address(priv->dev, priv->netdev)) {
> +       err =3D of_get_ethdev_address(priv->dev->of_node, priv->netdev);
> +       if (err =3D=3D -EPROBE_DEFER)
> +               return err;
> +       if (!err) {
>                 dev_info(priv->dev, "Read MAC address %pM from device tre=
e\n",
>                          priv->netdev->dev_addr);
> -               return;
> +               return 0;
>         }
>
>         m =3D ioread32(priv->base + FTGMAC100_OFFSET_MAC_MADR);
> @@ -207,6 +211,8 @@ static void ftgmac100_initial_mac(struct ftgmac100 *p=
riv)
>                 dev_info(priv->dev, "Generated random MAC address %pM\n",
>                          priv->netdev->dev_addr);
>         }
> +
> +       return 0;
>  }
>
>  static int ftgmac100_set_mac_addr(struct net_device *dev, void *p)
> @@ -1843,7 +1849,9 @@ static int ftgmac100_probe(struct platform_device *=
pdev)
>         priv->aneg_pause =3D true;
>
>         /* MAC address from chip or random one */
> -       ftgmac100_initial_mac(priv);
> +       err =3D ftgmac100_initial_mac(priv);
> +       if (err)
> +               goto err_phy_connect;
>
>         np =3D pdev->dev.of_node;
>         if (np && (of_device_is_compatible(np, "aspeed,ast2400-mac") ||
> --
> 2.34.1
>
>

--000000000000e23a0b06006b196f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OltyqaGBuzv+bJTUL+bmV7E4QBLIqGt4jVr1R9hJdH6KxXwJdyfHZ9C6qXmoe2NQhiFUyBOJ0wgk
dB9Z1IU7nCwvNKYg2JMoJs93tIgbhPJg/D7pqW8gabkCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEV6y/89alKPoFbKUaJXsvWu5
fdowDQYJKoZIhvcNAQELBQADggEBAEHSIB6g652wVb+r2YCmfHW47Jo+5TuCBD99Hla8PYhaWGkd
9HIyD3NPhb6Vb6vtMWJW4MFGQF42xYRrAS4LZj072DuMotr79rI09pbOiWg0FlRRFt6R9vgUgebu
pWSH7kmwVXcPtY94XSMMak4b7RSKig2mKbHDpD4bC7eGlwl5RxzYkgrHtMNRmHmQor5Nvqe52cFJ
25Azqtwvjt5nbrEd81iBmboNTEnLaKuxbbCtLaMEP8xKeDjAKnNOqHUMps0AsQT8c0EGq39YHpjp
Wn1l67VU0rMShbEFsiUf9WYgE677oinpdm0t2mdCjxr35tryxptoTZXKHDxr/Yy6l6ExggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwV/XkICjVscn4SNZMw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJib+BqTeHhMG+M6fPEzGFFnXGCzCVzn
58NN+uSGgctmMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDcx
NDA0NDQxNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBZOMEEQI9N7dRYVMSa59sSlDlAB9YnZiUsR1nv2P+27hBW1UUe
tcWvz1+m8JxpI4jFuqz3REmi5qJMHtkKNcbD+ZrMPGc9IbPzrJ01iVSG+SppwoNsK04giTwMgYE3
PbT8kPoNuQIlWj8HlY1xHbR6ALUUZF4VOvBfc6XWxqfky0ygVIEi6vQ8g06KHaCtvQlVzNBTfgI1
8fHB5hatRZR61dMOGbHP6rHE0znQnNBy+6OaDdgY+J0zxo9NG29Sa8lTGCzW0L2lvtazZt9uJ+1d
CDTIg/y1p4GtS7C7aGMnL5bc68cujTYbS9AXBGpm6UwZjvznOX/9DhkqHD+MX6Ly
--000000000000e23a0b06006b196f--


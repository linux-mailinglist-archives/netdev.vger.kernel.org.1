Return-Path: <netdev+bounces-22148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6164B7663B5
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 07:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB132825FB
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 05:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6C68837;
	Fri, 28 Jul 2023 05:46:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7778D79EE
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 05:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F53C433C8;
	Fri, 28 Jul 2023 05:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690523158;
	bh=bXg8BOFDCBRkgEdmVW5LzCWvnDGdPy1ePQLapozkYLQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SFDJsONLk3ChdAsI4YH1Qys0BPE+ne9tSusb25cOXfCqrvkDLsYo32Ty2nGEhM9AH
	 s526ho+IdNDIRNuS+haenPnsOC91cIlBY1E1QHNvFKuuK/fAO+Qx7mNUtmS3i86lUq
	 zGI4MDgainrt902m6p2U6kCqjQ2dyUoxiWFVARqDtHE6I/igGMD4BkTxXCuGUqpGEW
	 GcMVD6yHR6vQZAXkvMhaHA8AvBuj5bcQVPCdnd8zt3if5XbrRi6dyyYMPB8IKHKUq+
	 XwiuybhCfXvvUTbM5vjJpBH95uY08X6baby2BprNkcbQj0vhNs32+BVEVrWRtiiYWr
	 rT7z+JtpfHNhw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4fdd31bf179so2959616e87.2;
        Thu, 27 Jul 2023 22:45:58 -0700 (PDT)
X-Gm-Message-State: ABy/qLb42qgOgv/7i+Kr8AlvA4sAAzW776yaK0cI2h1sgout0SypMfpa
	/rTqNgQu1rMrHbj+5bCE/nN4j1XcoW68RLf7iM8=
X-Google-Smtp-Source: APBJJlEf2EWPMr2EtPxznEkh00y1MLDF1i7AA7sSnM3UzBnKAWa9VhFPOoeUH2HM/hV3iozs1qjnJ66obFdMyBjAEIU=
X-Received: by 2002:a19:e041:0:b0:4f8:70f8:d424 with SMTP id
 g1-20020a19e041000000b004f870f8d424mr751228lfj.65.1690523156367; Thu, 27 Jul
 2023 22:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230727-synquacer-net-v1-1-4d7f5c4cc8d9@kernel.org>
In-Reply-To: <20230727-synquacer-net-v1-1-4d7f5c4cc8d9@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 28 Jul 2023 07:45:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH_4OEY58Nb9yGHTDvjfouJHKNVhReo0mMdD_aGWW_WGQ@mail.gmail.com>
Message-ID: <CAMj1kXH_4OEY58Nb9yGHTDvjfouJHKNVhReo0mMdD_aGWW_WGQ@mail.gmail.com>
Subject: Re: [PATCH] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
To: Mark Brown <broonie@kernel.org>, Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

(cc Masahisa)

On Thu, 27 Jul 2023 at 23:52, Mark Brown <broonie@kernel.org> wrote:
>
> As documented in acd7aaf51b20 ("netsec: ignore 'phy-mode' device
> property on ACPI systems") the SocioNext SynQuacer platform ships with
> firmware defining the PHY mode as RGMII even though the physical
> configuration of the PHY is for TX and RX commits.  Since
> bbc4d71d63549bc ("net: phy: realtek: fix rtl8211e rx/tx delay config")
> this has caused misconfiguration of the PHY, rendering the network
> unusable.
>
> This was worked around for ACPI by ignoring the phy-mode property but
> the system is also used with DT.  Since the firmware used with DT is the
> same (the firmware interface is selectable in the firmware
> configuration) and the firmware configures the PHY prior to running the
> OS we can use the same workaround.
>

Wouldn't this break SynQuacers booting with firmware that lacks a
network driver? (I.e., u-boot?)

I am not sure why, but quite some effort has gone into porting u-boot
to this SoC as well.


> Limit this to the SynQuacer, though practically speaking this is the
> only currently known system using this device.
>
> Fixes: 533dd11a12f6 ("net: socionext: Add Synquacer NetSec driver")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/net/ethernet/socionext/netsec.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
> index 2d7347b71c41..ae4d336efaa4 100644
> --- a/drivers/net/ethernet/socionext/netsec.c
> +++ b/drivers/net/ethernet/socionext/netsec.c
> @@ -1845,10 +1845,20 @@ static int netsec_of_probe(struct platform_device *pdev,
>  {
>         int err;
>
> -       err = of_get_phy_mode(pdev->dev.of_node, &priv->phy_interface);
> -       if (err) {
> -               dev_err(&pdev->dev, "missing required property 'phy-mode'\n");
> -               return err;
> +       if (of_machine_is_compatible("socionext,developer-box")) {
> +               /*
> +                * SynQuacer reports RGMII but is physically
> +                * configured with TX and RX delays, since the
> +                * firwmare configures the PHY prior to boot just
> +                * ignore the configuration.
> +                */
> +               priv->phy_interface = PHY_INTERFACE_MODE_NA;
> +       } else {
> +               err = of_get_phy_mode(pdev->dev.of_node, &priv->phy_interface);
> +               if (err) {
> +                       dev_err(&pdev->dev, "missing required property 'phy-mode'\n");
> +                       return err;
> +               }
>         }
>
>         priv->phy_np = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
>
> ---
> base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
> change-id: 20230727-synquacer-net-e241f34baceb
>
> Best regards,
> --
> Mark Brown <broonie@kernel.org>
>


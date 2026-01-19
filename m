Return-Path: <netdev+bounces-251095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83313D3AAF5
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FF0530090B4
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D2136D4F9;
	Mon, 19 Jan 2026 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EX+6RBfH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B2536C5B0
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831202; cv=none; b=kcovyn2Tei/+g4IeeRmkXouWXGvH6AiFpfcIPJewtFJ2JKOR7qXHrf+RqJtVwJ8bl5aEjhfiCgaE0ENjKva4bpLGYzjbE8GKL42Vw2jcGc6//wrwDRVTlybmTsqzGR8St3mS7iolLgrTIkRhNzkexfPcAQr4B0DS676hJVbnYOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831202; c=relaxed/simple;
	bh=MIrQUfbJ2zL+AhG7FyLFIXu3ha5qK8PBOAlkOqBeaxM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWaGEuNuNvpJJZEFv4D2YTP5f/LuypNr2oRfThgPs8ZkSltgSrwmHHXv74Jsi21GkVoOHfFNu+eSn/4Yx8AiKxTA1EAz7hNT+5+PunWBmLEPkbuzil9rmU2/b+Jwe/9dmWrneL6UPzJMzVDOa/X9M7sQlmlUfW5e73vRx6qEWWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EX+6RBfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD47EC19424
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768831201;
	bh=MIrQUfbJ2zL+AhG7FyLFIXu3ha5qK8PBOAlkOqBeaxM=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=EX+6RBfHN6arCnN820LmhTyye+ap4LvfT2Vs/A2m6HXJ4BHOWpLAKyRD74+KgJuaL
	 VUR1Ex6JYPUkdQJ6EhnWtpYkQi6tUSQ8l7P0CNvl9QChWXNTJHOgvcK4TjJrI1cH5x
	 E8C3plpVN9xmQM6N4dqPx6PTgTrMK9ORvQv8LobxTG9WLBDQwvEZsSj1YoJY1in/WV
	 IAeJVuZWYuMn3i/0puonnl4zJtICLn9X/ym7f0mTD/ZBibz/+6y5OqO0EDrbBY6Dua
	 5METEPk2nVfmmG0P34OxCytQmjkAxShRvtq54c0eKQTN2/Cb7FvQlnA41gP14L1wTQ
	 LnUuzUGyhsg/A==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59b672f8ec4so4712334e87.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 06:00:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPjGAcIDt7JCzE9k2pPsXUfvQMByN+Ze2K1YKY1q+SVkfgOdTAaec4PUsbMLY/pclRTsZBYzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz95wpdAdo0xlILYaA222/OPpnUF9o7qe5lC1YKQF1jFba+RxHH
	GFjGjpcz9BCSWzjNNshYIBj0GZ8Q/9SI4UKxeJirud2ASgVyRciexIFWGcN3YUHppRE2tVgm5aw
	OgyZuTlsuPE36BxD0xq2Lf89isAZ9LiQDVbvlZUnsuQ==
X-Received: by 2002:a05:6512:3d9f:b0:594:347e:e679 with SMTP id
 2adb3069b0e04-59baeee6123mr4166539e87.43.1768831200472; Mon, 19 Jan 2026
 06:00:00 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Jan 2026 13:59:58 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Jan 2026 13:59:58 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <E1vhoRx-00000005H1H-0YoL@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aW4kakF3Ly7VaxN6@shell.armlinux.org.uk> <E1vhoRx-00000005H1H-0YoL@rmk-PC.armlinux.org.uk>
Date: Mon, 19 Jan 2026 13:59:58 +0000
X-Gmail-Original-Message-ID: <CAMRc=Mc-URPkVzEc5Cu54bA021+XaDh3-kZZDSKyNt0V1YQB3Q@mail.gmail.com>
X-Gm-Features: AZwV_QgrQLlVOMTh-pKGr5woCaDOT6WzYHt89q8m_3zdKt2vs_AoPCBMlqv3zPI
Message-ID: <CAMRc=Mc-URPkVzEc5Cu54bA021+XaDh3-kZZDSKyNt0V1YQB3Q@mail.gmail.com>
Subject: Re: [PATCH net-next 01/14] net: stmmac: qcom-ethqos: remove mac_base
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Jan 2026 13:33:41 +0100, "Russell King (Oracle)"
<rmk+kernel@armlinux.org.uk> said:
> In commit 9b443e58a896 ("net: stmmac: qcom-ethqos: remove MAC_CTRL_REG
> modification"), ethqos->mac_base is only written, never read. Let's
> remove it.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 0826a7bd32ff..869f924f3cde 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -100,7 +100,6 @@ struct ethqos_emac_driver_data {
>  struct qcom_ethqos {
>  	struct platform_device *pdev;
>  	void __iomem *rgmii_base;
> -	void __iomem *mac_base;
>  	int (*configure_func)(struct qcom_ethqos *ethqos, int speed);
>
>  	unsigned int link_clk_rate;
> @@ -772,8 +771,6 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(ethqos->rgmii_base),
>  				     "Failed to map rgmii resource\n");
>
> -	ethqos->mac_base = stmmac_res.addr;
> -
>  	data = of_device_get_match_data(dev);
>  	ethqos->por = data->por;
>  	ethqos->num_por = data->num_por;
> --
> 2.47.3
>
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


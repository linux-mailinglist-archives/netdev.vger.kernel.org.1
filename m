Return-Path: <netdev+bounces-150410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749D19EA295
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 00:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BCEC18882E5
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 23:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8709E1F63E9;
	Mon,  9 Dec 2024 23:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezRxn5lB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC61A3A8A;
	Mon,  9 Dec 2024 23:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733786296; cv=none; b=rjFJGvFa46dLC9gjl7t5C3pNbBqygPr1kbzBNIp0RaZd33BdhQ2j8KNYJJXQtx0r3M1hI07MF98bb4a/+wzuQtsz09HSfikQJ/pRgZKrt78KNTGG9J61NMjw1+2jBzGPg7XSJFHRpxmRlp9+jAvhVJNjYMVB/3yHBeFjSlXVR38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733786296; c=relaxed/simple;
	bh=hmPA1RbKTwQnOsHyx4RnWAjW6XPcda7839gBgswa0Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l6HnTmdJ4AtoVQ3ZoiMwhbBA4Dd2wykvFEcpJuczTEQ4t+49jFhCrQjez1fOJYwZJVr5mFBJvYjC03UpEQS8nBJffEjoAjpTzcv4psJyI5TL+5ES93ymhQyzdlChjZvcXVrhAo+R+WI0U+8sUtkljXGH3MxOpuPBUoJ2v4ncDCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezRxn5lB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E296C4CED1;
	Mon,  9 Dec 2024 23:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733786295;
	bh=hmPA1RbKTwQnOsHyx4RnWAjW6XPcda7839gBgswa0Kg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ezRxn5lBkTzNN0EGCUbugwW9spneaZXOJPMMsVwsQMcm4L0P4vnuSUhjAtDK8f8Ay
	 HIBUulUfDYuQCdk6B1IQrv7tzx2qB6Dq1DI3Eqijv/o0wx02yNC0pYwkLprmRTv7zR
	 PuTZ4YFiYKmF4ROoDR4qctEQTrPD/ZKm1fmq9bVqI/Zf6EPLiEPfpLvwNHAA+4FP14
	 qH9+jEhFK+T7FUAjjo7cf/qnYaP30n0UZ8+6bhj2QH9Th5TIiiCA6boczNHbzh+HY/
	 oY3mLguXSp48182n3hVjI8/GIga71eVeDxpOFFLNvG4rn0pdYbzVmN0vBHdZxd0TXV
	 whdtxyT8UIbBw==
Date: Mon, 9 Dec 2024 15:18:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir
 Oltean <olteanv@gmail.com>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@airoha.com
Subject: Re: [net-next PATCH v11 5/9] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
Message-ID: <20241209151813.106eda03@kernel.org>
In-Reply-To: <20241209134459.27110-6-ansuelsmth@gmail.com>
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
	<20241209134459.27110-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Dec 2024 14:44:22 +0100 Christian Marangi wrote:
> +	regmap = devm_regmap_init(priv->dev, NULL, priv,
> +				  &an8855_regmap_config);
> +	if (IS_ERR(regmap))
            ^^^^^^^^^^^^^^
> +		dev_err_probe(priv->dev, PTR_ERR(priv->dev),
                                         ^^^^^^^^^^^^^^^^^^
> +			      "regmap initialization failed\n");

wrong ptr?
-- 
pw-bot: cr


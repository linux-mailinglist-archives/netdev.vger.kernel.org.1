Return-Path: <netdev+bounces-251098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E67DD3AB06
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E60393004E1B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100B536D513;
	Mon, 19 Jan 2026 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwVKJjp9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BBF36B075
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831252; cv=none; b=C8YzcdxmY37vdGBZaD+tw29Qv+Tp85WWhjHnDjgk4HgHm9g9JPEUBWh+TVdLY3FEqlFCBFd2mwCWpZr1EonEwuuf5P7N+6/K7hEwti2GfnHrqjlTvcTdv6RBAoz8NvsfnAKV8Tmh1invOb/cRzrQdYKsVhIGP04QCT7hQzi9dLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831252; c=relaxed/simple;
	bh=HE73SGFgiopqRikw2FKculLOZOlYZlR6rqxK/wanCFk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rb2TwD5ZsqBUcwk+UKgQ5GkTS0IUdXjOVn98Nu3yJt7P2fPKa1Q2duwqOJY6zUKmeA4jGfLNjn1HVN3tG6nNYlRnOLlMQ+46DJoDHpLkDdu4NYLo/+FGEGrZ6Ppm6ZszBKoDFY+hwWqbJHO/+GKNhbwBkfI+fWb+m/w9ZaTzBm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwVKJjp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A373C2BC9E
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768831251;
	bh=HE73SGFgiopqRikw2FKculLOZOlYZlR6rqxK/wanCFk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=jwVKJjp9fns1b9wcslCE68MTZcgIfU6F5IeoOia67oQxU9ZTsL4T0ai4jPeX69jDG
	 vY1+fpZmZcEYK0lqiSXuyy9QJSxNLWqzrEJvUVQuQFWSFaaGmfjPGWH1SzDLo2xz61
	 vxns494nw4qas7fTVfZDKloTP6zl1HSMaWQQn2OQoZ69mZ221Udsr5vyEM/Im+rtx+
	 tthgza1ro0XjZPTbDSjT1FhE/nNXT0A4u6m6k+nd8e9/ATR2K1gxUmPzsrtEi0Q2U8
	 1DvpW+Au1cbaon6rQDxzuh5jY43wdtpylbec8gATzBbHxp53/osb5a2zmVxPuEwco2
	 WFyTE1ioCZqAQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59b834e3d64so6154370e87.2
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 06:00:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8YkMWNceGGFcrO2RHQmeKNXCpkRyH6T9Dr2gWiYIlMb8YteaOq0b7OuFq6viyEj1Q2Ay7L54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/CoQDSZ0O1uZaSJ20kYA+Wr2YoRVOmviXHv+anmpALIRmA/Uc
	RoewZAAX/oYGM9UgIeAM9/UkhK+kxQyjKVC8hTCRDzmCS5uMkLxtA7h2tCQoeb2hDTL4oZ0Psnd
	R/gJggvvjQ/JdDllA1gv51hMb28qKWvTbjEv88K+4iA==
X-Received: by 2002:a05:6512:3c88:b0:59b:9f6f:20b1 with SMTP id
 2adb3069b0e04-59bafeb6f0dmr3932244e87.21.1768831250152; Mon, 19 Jan 2026
 06:00:50 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Jan 2026 14:00:49 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Jan 2026 14:00:49 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <E1vhoS7-00000005H1T-1dXt@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aW4kakF3Ly7VaxN6@shell.armlinux.org.uk> <E1vhoS7-00000005H1T-1dXt@rmk-PC.armlinux.org.uk>
Date: Mon, 19 Jan 2026 14:00:49 +0000
X-Gmail-Original-Message-ID: <CAMRc=MfqJiHi1Ug92izGoL9CVty7-ijP0+6-m6hMyEJbZeLyBA@mail.gmail.com>
X-Gm-Features: AZwV_QghYvQWH9GY8wcodXLcC8y2z84EtqfT-DXsw94HUPeCH7ZRyaHEOMNrN9A
Message-ID: <CAMRc=MfqJiHi1Ug92izGoL9CVty7-ijP0+6-m6hMyEJbZeLyBA@mail.gmail.com>
Subject: Re: [PATCH net-next 03/14] phy: qcom-sgmii-eth: add .set_mode() and
 .validate() methods
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

On Mon, 19 Jan 2026 13:33:51 +0100, "Russell King (Oracle)"
<rmk+kernel@armlinux.org.uk> said:
> qcom-sgmii-eth is an Ethernet SerDes supporting only Ethernet mode
> using SGMII, 1000BASE-X and 2500BASE-X.
>
> Add an implementation of the .set_mode() method, which can be used
> instead of or as well as the .set_speed() method. The Ethernet
> interface modes mentioned above all have a fixed data rate, so
> setting the mode is sufficient to fully specify the operating
> parameters.
>
> Add an implementation of the .validate() method, which will be
> necessary to allow discovery of the SerDes capabilities for platform
> independent SerDes support in the stmmac network driver.
>
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


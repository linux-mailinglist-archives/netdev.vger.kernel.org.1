Return-Path: <netdev+bounces-61052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6086B822558
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 00:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D421C219EC
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 23:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60EF17731;
	Tue,  2 Jan 2024 23:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIZ9OZIM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40E81772C;
	Tue,  2 Jan 2024 23:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C14C433C8;
	Tue,  2 Jan 2024 23:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704236564;
	bh=TRpt+/kCQxAAj+2PRhnf8dKyATkaXO2xGNy9/hzVgqU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iIZ9OZIM7lmG+4UIJmU78c1JTd4jB9gEu0EqEd4kjS7gBbYv7QoSzeHoJ2/MjT+As
	 CzuOvgXTvvN73qUvzoJN29CiOCCFMgmwViXddmi8J7dAVbT7n2lH0IG+8xxfhqXYxS
	 smg9KXsLwV9muB672CEz5KS/pxNqIYXdiFfi5jru0l2nwpZ8p1gvn0AJuQVDs0yNkH
	 DqrCSrT6rEdjZC/oe3o2m5WySWC2w/MlgD4qXkui37QvUYW6ToQE5LMY1JBJtBUcEp
	 6I6IwDauJdrsa87T699HeHyUaC/BsiFf0wFzE0Hfef9T7q6SNRxp3A0mNZB+DesET7
	 nX4Hgni3ykPEA==
Date: Tue, 2 Jan 2024 15:02:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Emil Renner Berthing <kernel@esmil.dk>, Samin Guo
 <samin.guo@starfivetech.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Giuseppe Cavallaro
 <peppe.cavallaro@st.com>, Andrew Lunn <andrew@lunn.ch>, Jacob Keller
 <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v3 0/2] StarFive DWMAC support for JH7100
Message-ID: <20240102150242.5d556770@kernel.org>
In-Reply-To: <20231222101001.2541758-1-cristian.ciocaltea@collabora.com>
References: <20231222101001.2541758-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Dec 2023 12:09:58 +0200 Cristian Ciocaltea wrote:
> This is just a subset of the initial patch series [1] adding networking
> support for StarFive JH7100 SoC.

We shut down the development at the end of the year:

https://lore.kernel.org/all/20231205101002.1c09e027@kernel.org/

looks like this patch got dropped during the break.

Please rebase & repost.


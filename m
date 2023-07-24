Return-Path: <netdev+bounces-20566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B993760217
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 00:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957862813F5
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 22:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77E411CB6;
	Mon, 24 Jul 2023 22:17:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C89110967
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 22:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712FAC433C7;
	Mon, 24 Jul 2023 22:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690237040;
	bh=oGdT49PMKcFXsNyj44mx+Yx2XSjpJK4Q9Be2rHyZEmo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m4cHNhTjzfUqMOqTsecbMCF1qHTAGGPkpiuQZVRsFnRng/CBKyEixwTbjLmEoRyZD
	 OKdUWiFoSVrz/qChBNUNa1MPwEkmIg5lgm+ipO1bbQre1yp0XyWY+vtt9WTIv511wB
	 UiTpaCn6Mx/TMmDKlIYBpGgIUsgXLwhznkieUNuUfTJMz4qLGUkMs/VueJuyqQKpIV
	 3K+Oz0t7jSxFrOeUA6k5HVToiH0KSkhiRHnfGapghpDV3GXe/sDbqtQRz6xNfSbETN
	 1WQkpazBeQxhwpUesHZVu0JqhYvhs4RkXmOk6UQi6a45mWSYPdxkVod3moyZJaI8br
	 u1A5EtbSyQRlw==
Date: Mon, 24 Jul 2023 15:17:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 00/10] net: stmmac: add new features to xgmac
Message-ID: <20230724151719.145d16b9@kernel.org>
In-Reply-To: <20230723161029.1345-1-jszhang@kernel.org>
References: <20230723161029.1345-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jul 2023 00:10:19 +0800 Jisheng Zhang wrote:
> This series add below new features to xgmac:
> 
> correct RX COE parsing
> add more feature parsing from hw cap
> enlarge C22 ADDR and rx/tx channels
> support parse safety ce/ue irq from DT
> support per channel irq

Giuseppe, please take a look (try 3/3).


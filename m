Return-Path: <netdev+bounces-19545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D7575B253
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 17:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC523281F27
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 15:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2AC18B17;
	Thu, 20 Jul 2023 15:19:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1AC18B0B
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 15:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5B1C433C8;
	Thu, 20 Jul 2023 15:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689866387;
	bh=VzuQfdcXhmSoUTwM4i0KWcI991yn6l0smL1PiDgs5tI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dwTRKEfMnIzLYa1RIKer17DnIERMlzp9u+gvqtr9ZX3/WlEQoaXy/pbLGp0vPd9iW
	 9kOjlGCoAMjHtC0Zbj39/PzO0jeVY3gZwcoEvybwMo9BVzl3nFsJB+Ao74J9gLrU6T
	 H2kHCHebrP/o/bo2mRz5waMdHKoHJM/wKoleBoXwBLl3TOLVpOnonEIbKI5XNuC3iS
	 RC50QLDYzPV48o1iZbUEbHq696V4GJtCLosVcz3/ZLTBaj1lg53l8lmRxv+Z216RLN
	 Sw442+1rCzgfOTuxBXl9R4WxvQDfBv2v/TVsuzqvMsCkiUrHm1LxDsvcftdJQKdO4c
	 11NFS7RoMreiw==
Date: Thu, 20 Jul 2023 08:19:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: add support for phy-supply
Message-ID: <20230720081945.5cf783f0@kernel.org>
In-Reply-To: <20230720064636.5l45ad64kwwgd2iw@pengutronix.de>
References: <20230718132049.3028341-1-m.felsch@pengutronix.de>
	<20230718132049.3028341-2-m.felsch@pengutronix.de>
	<20230719211235.1758bbc0@kernel.org>
	<20230720064636.5l45ad64kwwgd2iw@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jul 2023 08:46:36 +0200 Marco Felsch wrote:
> > Please fix and rebase because the current version does not apply to
> > net-next/main.  
> 
> Sure, I thought the changelog should be part of the commit message in
> net-dev therefore I included it.

Old rules, I think. Since started adding lore links to all patches you
can put the changelog in the cut-off section. Adding a link to the
previous revision there is highly encouraged, too!
  
There's a sample of the preferred format at:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#changes-requested


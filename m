Return-Path: <netdev+bounces-62285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D635F826702
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 02:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CBA52818F2
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 01:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542F0800;
	Mon,  8 Jan 2024 01:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7zs7eQ4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300067F0;
	Mon,  8 Jan 2024 01:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A26C433C8;
	Mon,  8 Jan 2024 01:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704675747;
	bh=1V/lcv+qg9gmbaccW5Zgh47dmTCwqWDyrX9MwgtQ/FQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a7zs7eQ4dqqNKdzuA066xvCidEqdqjigWvs47CVk//uZYqOUfkgX0zhrU0k1qF+/M
	 iqWtJiR8/TrIJA72oIjl/GBk3gkfhhMRXLcct8Q9rzULucRKRKq1Q968JOzCIgUiPc
	 9Ho7B33Ga2HkGNFAfOXnzo13Q72CrfOT9lCXq8U3JsLUyki/PtnDnwvDsjvRq2FoJf
	 EQhEz3R8FAkj9S1iF3qEijWXMQkOY5V476dHlI+qUjBdAXcTtTZWVezDXqxzNXD5K1
	 hQtRBmBFz78MWQkLHzn+S+7JZcYSKGOITsFbYY6DIDWRStl+HiprUbSCETjXdf9Ufo
	 KHDJCHNhumIYQ==
Date: Sun, 7 Jan 2024 17:02:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Cc: Leong Ching Swee <leong.ching.swee@intel.com>, "David S. Miller"
 <davem@davemloft.net>, patchwork-bot+netdevbpf@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, edumazet@google.com, pabeni@redhat.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 peppe.cavallaro@st.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] net: stmmac: Enable Per DMA Channel
 interrupt
Message-ID: <20240107170225.43c82226@kernel.org>
In-Reply-To: <px2f336zjgibl43utjnnljzjweypu5jxovhgthc4xruidvpl3q@yobulxczk7vh>
References: <20240105070925.2948871-1-leong.ching.swee@intel.com>
	<170464562363.18664.8264531122295136817.git-patchwork-notify@kernel.org>
	<2df9fe3e-7971-4aa2-89a9-0e085b3b00d7@linaro.org>
	<px2f336zjgibl43utjnnljzjweypu5jxovhgthc4xruidvpl3q@yobulxczk7vh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jan 2024 00:24:24 +0300 Serge Semin wrote:
> > Please wait for DT bindings review a bit more than one working day (I
> > don't count Saturday and Sunday, because we all have some life...).  
> 
> +1. 

Sorry about that, reverting.


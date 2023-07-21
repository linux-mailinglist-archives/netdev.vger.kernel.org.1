Return-Path: <netdev+bounces-19707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB22775BCA7
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 05:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29911C215CD
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 03:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E5339F;
	Fri, 21 Jul 2023 03:11:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632027F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 03:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4870DC433C8;
	Fri, 21 Jul 2023 03:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689909093;
	bh=Pq/Uyc4eped6jMU42cvi7k4WYaZlbwcGo8MIhkmhssA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IdcWhLUERbQ0UoanBhSRVkQHJNHwuWctu0603avFZSV2CPkyQmFln54oHsoTVwPfA
	 utcAoCCENB92dWcGAyoF8NxtlSwlbU7SJS2rURAt60n0VlkKX+60t3uQ+bWO/tzE9G
	 qkm/1TT881Y4S0msDZz/p7P7q34XSjgHqaBEKLhawpH6opKaRVR/DxVTI+PrURDZYw
	 zx1bItni2S5VO3a6MF1QdwfTSOqziQx1yLKwNE5ad7yY4xs7LU+MeoWmGRsUUWUE8Q
	 jAm/xzR2z5AEZFgx2lhVkreiYnfW2wWQ5/IHIXMhoIRS1nLAYbwFdO+r+x9Euq3lLO
	 SN5bNvbW6ezKg==
Date: Thu, 20 Jul 2023 20:11:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 2/2] net: stmmac: add support for phy-supply
Message-ID: <20230720201132.6c6a4c54@kernel.org>
In-Reply-To: <20230720072304.3358701-2-m.felsch@pengutronix.de>
References: <20230720072304.3358701-1-m.felsch@pengutronix.de>
	<20230720072304.3358701-2-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jul 2023 09:23:04 +0200 Marco Felsch wrote:
> Add generic phy-supply handling support to control the phy regulator to
> avoid handling it within the glue code. Use the generic stmmac_platform
> code to register a possible phy-supply and the stmmac_main code to
> handle the power on/off.

Please rebase on latest net-next/master.
Bartosz converted the use_phy_wol bool to a flag a few weeks back.
-- 
pw-bot: cr


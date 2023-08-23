Return-Path: <netdev+bounces-29825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC136784DBA
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 02:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE581C20B73
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 00:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEC9180;
	Wed, 23 Aug 2023 00:15:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDAB7E
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5563EC433C7;
	Wed, 23 Aug 2023 00:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692749726;
	bh=m3QxC+UW70yVwLmza6iDNCXkPCmq/liyu1hcsOb0IsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hwz9Nl+1z+jtRA2DpiRq32cQoFsmVxS4DEL/2vTmJgHTaQ7TgL/1LcgbHEPoBzUz6
	 YElDzl8+4g3C2NGEhHkRnIUTbvEq9ih4wJ5mbBnntSKiLoS4ab14VsZhHA8WIVKpnS
	 cGY0mQUFGIpf4U1b7azz363yW3q5Y+Tw5Kal+A4Ez7orTCicEBTnx1fFEpSFHN+K/X
	 8hvQwpLwoRSJcOilFv1tTQg4H1Yr7O2O8O/k5cNNEMdv55EJpgre0FYex2oL21JOY+
	 IdGRw+TLiqt/YWiCPwmS9bXG+RMRAENYE302bXWOlgU2DWv302qTcNdqbvZs5/9X8v
	 cjc2gqirf/nuQ==
Date: Tue, 22 Aug 2023 17:15:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rohan G Thomas <rohan.g.thomas@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Serge
 Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH net-next v5 1/2] dt-bindings: net: snps,dwmac: Tx queues
 with coe
Message-ID: <20230822171525.692bd2df@kernel.org>
In-Reply-To: <20230819023132.23082-2-rohan.g.thomas@intel.com>
References: <20230819023132.23082-1-rohan.g.thomas@intel.com>
	<20230819023132.23082-2-rohan.g.thomas@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Aug 2023 10:31:31 +0800 Rohan G Thomas wrote:
> +      snps,tx-queues-with-coe:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: number of TX queues that support TX checksum offloading

Is it going to be obvious that if not present all queues support
checksum offload? I think we should document the default.
-- 
pw-bot: cr


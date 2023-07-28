Return-Path: <netdev+bounces-22415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9F876764F
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 21:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3BC52826BA
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 19:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC11E1BB41;
	Fri, 28 Jul 2023 19:28:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CCEEDC
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 19:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C954C433C7;
	Fri, 28 Jul 2023 19:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690572508;
	bh=tkxqkheUYV+9BQzGj3DyNe/PKGjQVH/d429jWysjUCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZWjdbViMNiV6YzFIlwDasV2ge2qYM+qQj62KAmzx3qY7wbPsT4WEGRbBASsxrTFN
	 BINFjYdnnYEtvcr/9N6ArrwL2yyJIbh+qhQpxlA+/p2NNmfkCaxWMFa1JsX7t2quQL
	 k2ItsPtMHjFfRRCs7dyb0ZFJDeij69Zu6zm4n/JXmYx+9lroBxY/2MOIGBBVJa5ELN
	 DNuIIRxRkxJfCwt8qdm+j86T+JFZOvukM/1/TOffIGPZXwDVlGG956jzyHGKxBso2+
	 tG4LLAPGWFZ6efLogbhCCtqJxJzC/0/r2MllzldvUSRWEMM5VQeE0cSgOoWYnVDpsd
	 Dyq/u3HcYA9QQ==
Received: (nullmailer pid 1175706 invoked by uid 1000);
	Fri, 28 Jul 2023 19:28:24 -0000
Date: Fri, 28 Jul 2023 13:28:24 -0600
From: Rob Herring <robh@kernel.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Michal Kubiak <michal.kubiak@intel.com>, Simon Horman <simon.horman@corigine.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Vivek Yadav <vivek.2311@samsung.com>, linux-can@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Wolfgang Grandegger <wg@grandegger.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/6] dt-bindings: can: tcan4x5x: Add tcan4552 and
 tcan4553 variants
Message-ID: <169057250459.1175653.8334487301732394212.robh@kernel.org>
References: <20230728141923.162477-1-msp@baylibre.com>
 <20230728141923.162477-2-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728141923.162477-2-msp@baylibre.com>


On Fri, 28 Jul 2023 16:19:18 +0200, Markus Schneider-Pargmann wrote:
> These two new chips do not have state or wake pins.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/net/can/tcan4x5x.txt          | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>



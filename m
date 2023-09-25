Return-Path: <netdev+bounces-36058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5818A7ACDC6
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 04:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 72DFB281345
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 02:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2862ECD;
	Mon, 25 Sep 2023 02:02:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5759EA9;
	Mon, 25 Sep 2023 02:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFFBC433C8;
	Mon, 25 Sep 2023 02:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695607331;
	bh=S4mFtilz/zTFKA5aEWbdRfyZRwCqCWDgdc/9ZLSko84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eq4oP9ZcLuW2YaDnd3OHhIs2+6IxttbYZc8nosnj7uDHruxUklJRo7v5zr6Bk/V62
	 bbkVXsyG5ryyyVEfXeLOzNgYT83FxLFyhGxDc1yXlVXTjHrCLDT7QzpzAStsIN2W08
	 Kyw2gnt5MsWxmzTaTeZvSPeMl0KwJpGhtRK9T8JIpvYVWK74/QuE9NiOGcX+MXWHq8
	 DYAk2LYMmNmYIGJg9cUiyaWdzATmorBTbenKEhl6B67vW4xhP1zFCgI4VS4a6BU2Mw
	 j7X+o788xe36+oNxLvxv0RZhdMNbz1hsCVI2lRoyQAqAVZXr48dsL2c3FIvPZ3SQmQ
	 vWMw+YajdQ+Wg==
Date: Mon, 25 Sep 2023 10:02:00 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
	kuba@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH 2/2] arm64: dts: imx8dxl-ss-conn: Complete the FEC
 compatibles
Message-ID: <20230925020200.GU7231@dragon>
References: <20230909123107.1048998-1-festevam@gmail.com>
 <20230909123107.1048998-2-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230909123107.1048998-2-festevam@gmail.com>

On Sat, Sep 09, 2023 at 09:31:07AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Use the full compatible list for the imx8dl FEC as per fsl,fec.yaml. 
> 
> This fixes the following schema warning:
> 
> imx8dxl-evk.dtb: ethernet@5b040000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['fsl,imx8qm-fec'] is too short
> 	'fsl,imx8qm-fec' is not one of ['fsl,imx25-fec', 'fsl,imx27-fec', 'fsl,imx28-fec', 'fsl,imx6q-fec', 'fsl,mvf600-fec', 'fsl,s32v234-fec']
> 	'fsl,imx8qm-fec' is not one of ['fsl,imx53-fec', 'fsl,imx6sl-fec']
> 	'fsl,imx8qm-fec' is not one of ['fsl,imx35-fec', 'fsl,imx51-fec']
> 	'fsl,imx8qm-fec' is not one of ['fsl,imx6ul-fec', 'fsl,imx6sx-fec']
> 	'fsl,imx8qm-fec' is not one of ['fsl,imx7d-fec']
> 	'fsl,imx8mq-fec' was expected
> 	'fsl,imx8qm-fec' is not one of ['fsl,imx8mm-fec', 'fsl,imx8mn-fec', 'fsl,imx8mp-fec', 'fsl,imx93-fec']
> 	'fsl,imx8qm-fec' is not one of ['fsl,imx8dxl-fec', 'fsl,imx8qxp-fec']
> 	'fsl,imx8qm-fec' is not one of ['fsl,imx8ulp-fec']
> 	from schema $id: http://devicetree.org/schemas/net/fsl,fec.yaml#
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied, thanks!


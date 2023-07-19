Return-Path: <netdev+bounces-19244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4328A75A073
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F371C2819ED
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C4C22EEE;
	Wed, 19 Jul 2023 21:17:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF87B1BB20
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BAAC433C8;
	Wed, 19 Jul 2023 21:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689801427;
	bh=AHWnayYkjPbIUyAqedX2DKfC5RK8iRkSYADpwtoqOus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C3J4qTBdZhicQXbHclrOkNHlzo/gvv0LOzVQ/XJxHdRFa2HcP0i6h9YDYv86QIqVb
	 l8So39bb/B8BY266b2SoAEn/LJqmYbaTlxT7pEnYIUs+RUGE0Zy8WFnDeSREdu9/AK
	 mw0d17vJqQ3tse7fC4rsZdrQ8DS6DzsfkhTVA31AOblQ5v4eLf3XNQNXQhMQ8wiPoa
	 DYdiBSL4BKvHVz2Lv9CeEddPFkK4fQebHzczPzHdZXPGSQuimI9qyG1yD9RdRtu7T5
	 0wfrycAQXno8Jg6R97m3lABPKuxvfPy0TkDRlGv9kb1eaqBMqJUW6pselNxeC7878u
	 Fzj53V5FVa70Q==
Received: (nullmailer pid 809255 invoked by uid 1000);
	Wed, 19 Jul 2023 21:17:05 -0000
Date: Wed, 19 Jul 2023 15:17:05 -0600
From: Rob Herring <robh@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org, david.wu@rock-chips.com, heiko@sntech.de, kernel@collabora.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: net: rockchip-dwmac: add default 'input'
 for clock_in_out
Message-ID: <168980142508.809195.11041309654523921501.robh@kernel.org>
References: <20230718090914.282293-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718090914.282293-1-eugen.hristev@collabora.com>


On Tue, 18 Jul 2023 12:09:14 +0300, Eugen Hristev wrote:
> 'clock_in_out' property is optional, and it can be one of two enums.
> The binding does not specify what is the behavior when the property is
> missing altogether.
> Hence, add a default value that the driver can use.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>



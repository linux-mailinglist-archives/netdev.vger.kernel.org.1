Return-Path: <netdev+bounces-34120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 860F07A22B3
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 17:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED18282212
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 15:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B931511C93;
	Fri, 15 Sep 2023 15:43:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6625C30D05;
	Fri, 15 Sep 2023 15:43:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620ADC433C7;
	Fri, 15 Sep 2023 15:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694792581;
	bh=9bRj4OGDHZcWypcbZ6nrLnPTFGOMENS0AvkmhkVoxF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K4HmihmqyVuBI7ExjAGaEePXqlsxLyl0pyr7CY7q1/UigsvPNGqVIo4QlDeC3yvUX
	 X/JN5TCdKnWoL1hVVy4NouqrfLZ7SDilBmkCRGokIfc2ZdpWb8V0DsEd2U6nzCVF4V
	 /4NuE6QAjTGkDA99f1ZCYP+yVFCKRI34ceDSluxCSV7+rkVTBQl2TQjc55U+9wiowC
	 2zHHTM/arQemdTlgHn7QqEVzOKXlsSX0W2W20JTfNnbfKfBknsuXKMFDGqGkT8GUXF
	 AxzoGkYisQPGKRABk5LuQBUb5lWl00q1NA23Wzmmu6sylV/riYdgBaiNZMZgsqNvva
	 K9izqTNKNkIIQ==
Received: (nullmailer pid 3773371 invoked by uid 1000);
	Fri, 15 Sep 2023 15:42:58 -0000
Date: Fri, 15 Sep 2023 10:42:58 -0500
From: Rob Herring <robh@kernel.org>
To: Rohan G Thomas <rohan.g.thomas@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, fancer.lancer@gmail.com, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/2] dt-bindings: net: snps,dwmac: Tx coe
 unsupported
Message-ID: <20230915154258.GA3769303-robh@kernel.org>
References: <20230915095417.1949-1-rohan.g.thomas@intel.com>
 <20230915095417.1949-2-rohan.g.thomas@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915095417.1949-2-rohan.g.thomas@intel.com>

On Fri, Sep 15, 2023 at 05:54:16PM +0800, Rohan G Thomas wrote:
> Add dt-bindings for coe-unsupported property per tx queue.

Why? (What every commit msg should answer)

> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index ddf9522a5dc2..365e6cb73484 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -394,6 +394,9 @@ properties:
>                When a PFC frame is received with priorities matching the bitmask,
>                the queue is blocked from transmitting for the pause time specified
>                in the PFC frame.

blank line needed

> +          snps,coe-unsupported:
> +            type: boolean
> +            description: TX checksum offload is unsupported by the TX queue.

And here.

>          allOf:
>            - if:
>                required:
> -- 
> 2.25.1
> 


Return-Path: <netdev+bounces-12375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC7E737399
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 20:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0EDB2813BD
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 18:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EEF17749;
	Tue, 20 Jun 2023 18:14:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7B32AB5D
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 18:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581AFC433C8;
	Tue, 20 Jun 2023 18:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687284897;
	bh=oS71jJIpPfGeBkc1SVNu2IOd3HxB2C9NjFUUQpei/oc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a+4EnNcNi2GkkACyIYoskSPxqvQ2cvhsc7xaCLyVJi+xL7n/tuFFbNKW/Jk9kDmTu
	 xCM0qZVnNSy18xpuQm1jdJeVR9KCRM82+vb26KALKa4vjUZ1SHmgLC+fdSnSO2sVRJ
	 LvZ+iA/zDTJvyUWzWKyDPHlIBuVCZ7VDFgINZBr4TE3XQ6H0oyLXnvj386tPFaFMn6
	 kgoD8caZDe/2dfmH7Fd/gndraKJPzgzqKnJOIw3TjcotYIgJgxUrSIjj2749zIrl9w
	 CtP/d46lK0fwyGnp5lsrk2s48cnmzPe77PIUUN99zsm4vMb4ar4Rr2/glyMCGqhDI6
	 0hIzxCMIWEa1w==
Date: Tue, 20 Jun 2023 11:14:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Balakrishna Godavarthi <bgodavar@codeaurora.org>, Rocky Liao
 <rjliao@codeaurora.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: bluetooth: qualcomm:
 document VDD_CH1
Message-ID: <20230620111456.48aae53c@kernel.org>
In-Reply-To: <20230617165716.279857-1-krzysztof.kozlowski@linaro.org>
References: <20230617165716.279857-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Jun 2023 18:57:16 +0200 Krzysztof Kozlowski wrote:
> WCN3990 comes with two chains - CH0 and CH1 - where each takes VDD
> regulator.  It seems VDD_CH1 is optional (Linux driver does not care
> about it), so document it to fix dtbs_check warnings like:
> 
>   sdm850-lenovo-yoga-c630.dtb: bluetooth: 'vddch1-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Hi Luiz, I don't see you CCed here, should we take it directly 
to net-next?

> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> index e3a51d66527c..2735c6a4f336 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> @@ -52,6 +52,9 @@ properties:
>    vddch0-supply:
>      description: VDD_CH0 supply regulator handle
>  
> +  vddch1-supply:
> +    description: VDD_CH1 supply regulator handle
> +
>    vddaon-supply:
>      description: VDD_AON supply regulator handle
>  



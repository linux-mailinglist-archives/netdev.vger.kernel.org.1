Return-Path: <netdev+bounces-34745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6047A5429
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B6C2815B2
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9FF28DA5;
	Mon, 18 Sep 2023 20:30:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9B538DF1;
	Mon, 18 Sep 2023 20:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C1CC433C8;
	Mon, 18 Sep 2023 20:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695069039;
	bh=DprrhIgDzelvIyTWIr8SzEXHEnNRh4jr4L7DY+L6emo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJlG/awENwdxcwFxJlc1MwJX/+v8YirCPiKNbHUqYoI+WJYdYGzrFuwaEnwhPGEzm
	 uDdDiWxLHbqUFiaI7vJgUVzqgWy048P7VX2iQ9s6YhYd0N5HzuH/AHo/+CyUcMFI95
	 GQymhqgdw9mXMdTK5n+6Jq7WunLJocXlxyBs3Mtv1VLggfn9nvHpj7rhHLi25Sy3S6
	 SNRajqFCrNxC0RrXgaF9vw7SALDJ7DnKkJgzKr7cnznuMFbA46ME41Xxxn1jVvgyKu
	 jeD8UvDWPtdAj5+NnHnUvcit5++VQCOpTiROFa5ayQHCBeuGtHZbrk9hmVU0p6g9T/
	 iv7lM11J5EcUQ==
Received: (nullmailer pid 1723759 invoked by uid 1000);
	Mon, 18 Sep 2023 20:30:36 -0000
Date: Mon, 18 Sep 2023 15:30:36 -0500
From: Rob Herring <robh@kernel.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: netdev@vger.kernel.org, erkin.bozoglu@xeront.com, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, mithat.guner@xeront.com, Daniel Golle <daniel@makrotopia.org>, Eric Dumazet <edumazet@google.com>, Matthias Brugger <matthias.bgg@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Conor Dooley <conor+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Felix Fietkau <nbd@nbd.name>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: mediatek,net: remove
 reference on top level schema
Message-ID: <169506903453.1723676.13767276753325939381.robh@kernel.org>
References: <20230917124723.143202-1-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230917124723.143202-1-arinc.unal@arinc9.com>


On Sun, 17 Sep 2023 15:47:22 +0300, Arınç ÜNAL wrote:
> The top level schema does not represent an ethernet controller, the
> subschema defining the MAC nodes does. Remove the reference to
> ethernet-controller.yaml on the top level schema.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  Documentation/devicetree/bindings/net/mediatek,net.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>



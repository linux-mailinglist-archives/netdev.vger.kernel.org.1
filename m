Return-Path: <netdev+bounces-34101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C762B7A2194
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 16:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4CE31C2114C
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 14:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D513D6B;
	Fri, 15 Sep 2023 14:57:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC9330CF0;
	Fri, 15 Sep 2023 14:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8725C433C7;
	Fri, 15 Sep 2023 14:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694789830;
	bh=OtkCOYaTksGOTSr2+xlSqvyr4706t1k2gV3aw3sS6Qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gP/0/4qCtDPsPATni8DaF2olJXkIrr8kzSW+57OixCQYR2yH6HoYMfsHYIJjVL5Xx
	 oYqxrjLkzsuzZXaB3yUA0YqkWZSENUMW+1s2iBHphwMJ9dtxoT4EiYNmIPVt7vsXlt
	 /B5RYIky+601hh38PMBV6FQvGidBmewCmTnjTVmOI4ZaRjsqcGNVsfO9Ku+B4wiesm
	 QqBZF/FIOSfB6cP4ATj7CkyWoR6ucVqeFXBOVZcmk+I94Dv6CHA1nDaP8so4GcxBhl
	 ApWRGTRkVF9Jy4ZAARS+UJ1qSqoUyB1Sf50QI9Pk37ilBdLDpywgYZQINOsDIDW1xo
	 LuuckATwX6jiQ==
Received: (nullmailer pid 3715811 invoked by uid 1000);
	Fri, 15 Sep 2023 14:57:07 -0000
Date: Fri, 15 Sep 2023 09:57:07 -0500
From: Rob Herring <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: john@phrozen.org, nbd@nbd.name, daniel@makrotopia.org, netdev@vger.kernel.org, kuba@kernel.org, lorenzo.bianconi@redhat.com, pabeni@redhat.com, edumazet@google.com, Mark-MC.Lee@mediatek.com, linux-mediatek@lists.infradead.org, sujuan.chen@mediatek.com, krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org, sean.wang@mediatek.com, robh+dt@kernel.org, davem@davemloft.net
Subject: Re: [PATCH net-next 02/15] dt-bindings: arm: mediatek: mt7622-wed:
 add WED binding for MT7988 SoC
Message-ID: <169478982727.3715757.9192773418484703094.robh@kernel.org>
References: <cover.1694701767.git.lorenzo@kernel.org>
 <9b84b6b9641a2eebc91e763e2ba9a341e3de1071.1694701767.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b84b6b9641a2eebc91e763e2ba9a341e3de1071.1694701767.git.lorenzo@kernel.org>


On Thu, 14 Sep 2023 16:38:07 +0200, Lorenzo Bianconi wrote:
> Introduce MT7988 SoC compatibility string in mtk_wed binding.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,mt7622-wed.yaml    | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>



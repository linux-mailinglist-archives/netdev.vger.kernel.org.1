Return-Path: <netdev+bounces-34100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8244A7A2192
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 16:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CADD2829B6
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 14:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13B130D1E;
	Fri, 15 Sep 2023 14:56:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C5530CE0;
	Fri, 15 Sep 2023 14:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6887AC433C8;
	Fri, 15 Sep 2023 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694789809;
	bh=LoCrUjxTrM7KusHCy4cbH8DfNMI1fL9H5DnYG6fNdi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0KLM/HvwHgWJagNlleEId/qTHItTQcLgUjqmRIUWFwbpSNtAajZHhTirtm2YRtNd
	 KP8/FkhR9iGhCq/W3AfwJyEIt0Fmdb+GQxBRvDaCa7ifOMtC6SRr44ZQG0SL4UhHk7
	 pH0noXC24PxdZGB2StaHYe/jHxFzDtINdDaLP/LYp0HYknWY6fgt6onpONjbkXOnuC
	 lJheMIcVCVhrM29q5YhiHPkFmZqFFCSb1J7oHQvddiKEyOycSeFwDoi7sVucq+gUpg
	 C6GysGmaLlROOy7NhV8SfMAiBX+1kCrqB3ZKh1Onc4KT8lSQOu2lvmrQOLyLwYblVk
	 kYeoa2VixiImg==
Received: (nullmailer pid 3715285 invoked by uid 1000);
	Fri, 15 Sep 2023 14:56:46 -0000
Date: Fri, 15 Sep 2023 09:56:46 -0500
From: Rob Herring <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-mediatek@lists.infradead.org, robh+dt@kernel.org, Mark-MC.Lee@mediatek.com, daniel@makrotopia.org, pabeni@redhat.com, krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org, john@phrozen.org, sujuan.chen@mediatek.com, netdev@vger.kernel.org, edumazet@google.com, lorenzo.bianconi@redhat.com, sean.wang@mediatek.com, devicetree@vger.kernel.org, nbd@nbd.name, davem@davemloft.net
Subject: Re: [PATCH net-next 01/15] dt-bindings: soc: mediatek:
 mt7986-wo-ccif: add binding for MT7988 SoC
Message-ID: <169478980538.3715231.16721383974701805812.robh@kernel.org>
References: <cover.1694701767.git.lorenzo@kernel.org>
 <148f4f9ff2ec891955f9e9292aff9595f07beded.1694701767.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148f4f9ff2ec891955f9e9292aff9595f07beded.1694701767.git.lorenzo@kernel.org>


On Thu, 14 Sep 2023 16:38:06 +0200, Lorenzo Bianconi wrote:
> Introduce MT7988 SoC compatibility string in mt7986-wo-ccif binding.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../bindings/soc/mediatek/mediatek,mt7986-wo-ccif.yaml           | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>



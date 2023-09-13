Return-Path: <netdev+bounces-33537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF3D79E6AC
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 13:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17FD62827E5
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 11:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EC71E536;
	Wed, 13 Sep 2023 11:25:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2BA1E519
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 11:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D77CC433D9;
	Wed, 13 Sep 2023 11:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694604352;
	bh=bOBtR+/z9v2F7av+y5PYDnndEOGfv/9OmZ5AleloNqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pKnw+4pOhii++igRlU4GOWCpscnEsMxxG0UGPGKCG042EyHs1A0N5QPrIMRTPe2ac
	 mcYjxzLd2rBV1MCt7bAJtql4ElAa8DjVTka5U0cLNOcB5zOkwbxDm8OOtlQcd2HhGK
	 qJTkFW5+DWwHSB8rt0tvN3Fq18Aij32YTE7KrkqtvsDvRUb34WiHPIuN9OiApFfHnH
	 U0+I0II1s0cwvYmBDXBAFp1NidN/sJu58GGjeu8a2tJVmYirXzRVHEtXGINZVIi8Le
	 BsLhO2hOYlIMDZmcPeiQRYBp4iivYekQOD7U82THVWD8GKe5X1tjRKRzexyKkMd3Z9
	 xbRJxB9tQGphw==
Date: Wed, 13 Sep 2023 13:25:46 +0200
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, nbd@nbd.name,
	john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] net: ethernet: mtk_eth_soc: rely on
 mtk_pse_port definitions in mtk_flow_set_output_device
Message-ID: <20230913112546.GR401982@kernel.org>
References: <b86bdb717e963e3246c1dec5f736c810703cf056.1694506814.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b86bdb717e963e3246c1dec5f736c810703cf056.1694506814.git.lorenzo@kernel.org>

On Tue, Sep 12, 2023 at 10:22:56AM +0200, Lorenzo Bianconi wrote:
> Similar to ethernet ports, rely on mtk_pse_port definitions for
> pse wdma ports as well.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>



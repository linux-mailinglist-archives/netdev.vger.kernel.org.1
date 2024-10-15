Return-Path: <netdev+bounces-135633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9572999E9F0
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8911C21136
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093FB220801;
	Tue, 15 Oct 2024 12:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksC6jF94"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87961CEADB
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728995726; cv=none; b=p1S5cil8MaheW+1wvJ15sp4VpjRP6nllh7Gu9gvIHlmEjqDGD2JxBjZYkHOd0a1uDplDL3nRpwLShxnULz7urIO9KcZyX4bPcFQDC4wRbAKdQqWFnA8tlN+vUFk77B2Wy73a4ejQ18/LKb3aSfmZhOcMCxHR9lOEGdv904FKyh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728995726; c=relaxed/simple;
	bh=ZupsWivaJNf9AbMr2VMo7f7YbV6GJym0nRD6piwnCN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJtNYBtIiU50HJbEIAo4A4BoSRBo/D83vn2UxPzNEVivsypAj+XVGbXLW3aB90cm+Io8a4xs6LustzbjEehsfdye4h7UH0c/jdSuBfeZjkR0qvSgdCbSFQzH6o/EbmcXhaFgN4KtnDr4QxUWUp6xeYZDMXJvP8KFbIE4cM0bfF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksC6jF94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874A6C4CEC6;
	Tue, 15 Oct 2024 12:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728995726;
	bh=ZupsWivaJNf9AbMr2VMo7f7YbV6GJym0nRD6piwnCN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ksC6jF94ERjrFtljP8v+q5LG23xm7l7Wq1PEHAXpM3QBCzgscZvwio8MpdEdRYmu+
	 iV587e+SFjEm0rUjEYGNLB1DXhbJbIOdi1Lu2H4zv7Nt7oKN9yUhHHwdd7tfqDSnCq
	 zPOlvnLOsPUZswH4RvQ4IxK3ZF7B5uwHkURs1IohPK0aI6RKqMu+NCZaUZK5TKx4M7
	 xWr3ZbriNt8iWZt56icN5UJOkTZSHYLeNgNsgNDxvQFcm8iU8572F2l9Nh6KpYTn2A
	 FwmDkwHyNuEyjdqqBfUUeynOyDaws2oGHHNFFxv3Ji7iEx66V7t9p0MLw2BICE/ZtH
	 uNaa2STtyn/FQ==
Date: Tue, 15 Oct 2024 13:35:21 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	ChihWei Cheng <chihwei.cheng@airoha.com>
Subject: Re: [PATCH net-next] net: airoha: Fix typo in REG_CDM2_FWD_CFG
 configuration
Message-ID: <20241015123521.GF569285@kernel.org>
References: <20241015-airoha-eth-cdm2-fixes-v1-1-9dc6993286c3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015-airoha-eth-cdm2-fixes-v1-1-9dc6993286c3@kernel.org>

On Tue, Oct 15, 2024 at 09:58:09AM +0200, Lorenzo Bianconi wrote:
> Fix typo in airoha_fe_init routine configuring CDM2_OAM_QSEL_MASK field
> of REG_CDM2_FWD_CFG register.
> This bug is not introducing any user visible problem since Frame Engine
> CDM2 port is used just by the second QDMA block and we currently enable
> just QDMA1 block connected to the MT7530 dsa switch via CDM1 port.
> 
> Introduced by commit 23020f049327 ("net: airoha: Introduce ethernet
> support for EN7581 SoC")
> 
> Reported-by: ChihWei Cheng <chihwei.cheng@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/mediatek/airoha_eth.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
> index e037f725f6d3505a8b91815ae26322f5d1b8590c..45665a5b14f5c646d23aaf4830e55a118e9f1a8a 100644
> --- a/drivers/net/ethernet/mediatek/airoha_eth.c
> +++ b/drivers/net/ethernet/mediatek/airoha_eth.c
> @@ -1371,7 +1371,8 @@ static int airoha_fe_init(struct airoha_eth *eth)
>  	airoha_fe_set(eth, REG_GDM_MISC_CFG,
>  		      GDM2_RDM_ACK_WAIT_PREF_MASK |
>  		      GDM2_CHN_VLD_MODE_MASK);
> -	airoha_fe_rmw(eth, REG_CDM2_FWD_CFG, CDM2_OAM_QSEL_MASK, 15);
> +	airoha_fe_rmw(eth, REG_CDM2_FWD_CFG, CDM2_OAM_QSEL_MASK,
> +		      FIELD_PREP(CDM2_OAM_QSEL_MASK, 15));

I agree FIELD_PREP is correct here as it will both mask (not important
in this case) and shift (very important in this case) it's input (15).
This matches how airoha_fe_rmw() will use this argument.

>  
>  	/* init fragment and assemble Force Port */
>  	/* NPU Core-3, NPU Bridge Channel-3 */
> 
> ---
> base-commit: 60b4d49b9621db4b000c9065dd6457c9a0eda80b
> change-id: 20241014-airoha-eth-cdm2-fixes-92d909308204
> 
> Best regards,
> -- 
> Lorenzo Bianconi <lorenzo@kernel.org>
> 
> 


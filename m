Return-Path: <netdev+bounces-229654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BB5BDF780
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 17:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54BCA18869C1
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 15:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DE4335BA3;
	Wed, 15 Oct 2025 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGH0xtdS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E51A30BB9A;
	Wed, 15 Oct 2025 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760543259; cv=none; b=LwbNNlxl9MqUqoVerR0WKfr4RcDQCgD4F4RIWK3EN06j732DU+hHgsDqAR41gxRgl8XfsuG3yeff30NdETxRTVRxqYBzZDBDFIWaVe8XKwGvILEXJjSnwswXLC8p8wsRDPsRtFS8UEgPPJZLg/5MK65GlRHS9BxG+NfapJZB0ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760543259; c=relaxed/simple;
	bh=7SSKvHAijSlWofXaTTSRV6RFLX2i1LcCrhGDKzWlQ20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4BrMoFbOkNdeGUfrclbTdg5/VTB+lzpA/MPM+WHsTtcGG/TRPgcsDhH7ZQPvT9ON4MTewPVN81dhW1KTJh/jWtcS0Zak3Lmpr/2h3dR1yilFwi2YOpNvXeBIVVwal4TvMZR99SEo+uWKR72VXNEMvEHV55lZADVXo0Z53O6+9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGH0xtdS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD489C4CEF9;
	Wed, 15 Oct 2025 15:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760543258;
	bh=7SSKvHAijSlWofXaTTSRV6RFLX2i1LcCrhGDKzWlQ20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oGH0xtdSIVA/HLIi76/6tLihtexifn5/54YloqXYWip65ngHLQGryac6RYlBgpG4e
	 HoTJwhinxEre29f3obZE9DuhzfKqbkzarHV6a2pbH8uONhgDyT5NSoSEa1GqQ5Tkci
	 pMC/ntF1HlI1keUJDF12UQvI3jGdpDQCeSNwWbDbtsj6cKzmaEDQBYM87d0znGg1lY
	 3ial0Zih5TGRkkfb6e6wHK5VV9eSJRmE/iiJp1D2e/2Y2aho2V0hgfAd3KA2BnEfOa
	 HFcpgCORI2M8wWfslJQTMWYPWn/Ma2F0WXHIDpxwYxlLGTp8dlwj10e2UoVVeg9j3I
	 xc0QomtzAgiEg==
Date: Wed, 15 Oct 2025 16:47:33 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 08/12] net: airoha: ppe: Configure SRAM PPE
 entries via the cpu
Message-ID: <aO_CFRYy6vXCQIS2@horms.kernel.org>
References: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
 <20251015-an7583-eth-support-v1-8-064855f05923@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-an7583-eth-support-v1-8-064855f05923@kernel.org>

On Wed, Oct 15, 2025 at 09:15:08AM +0200, Lorenzo Bianconi wrote:
> Introduce airoha_ppe_foe_commit_sram_entry routine in order to configure
> the SRAM PPE entries directly via the CPU instead of using the NPU APIs.
> This is a preliminary patch to enable netfilter flowtable hw offload for
> AN7583 SoC.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_ppe.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
> index fcfd2d8826a9c2f8f94f1962c2b2a69f67f7f598..0ee2e41489aaa9de9c1e99d242ee0bec11549750 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -662,6 +662,27 @@ static bool airoha_ppe_foe_compare_entry(struct airoha_flow_table_entry *e,
>  	return !memcmp(&e->data.d, &hwe->d, len - sizeof(hwe->ib1));
>  }
>  
> +static int airoha_ppe_foe_commit_sram_entry(struct airoha_ppe *ppe, u32 hash)
> +{
> +	struct airoha_foe_entry *hwe = ppe->foe + hash * sizeof(*hwe);
> +	bool ppe2 = hash >= PPE_SRAM_NUM_ENTRIES;
> +	u32 *ptr = (u32 *)hwe, val;
> +	int i;
> +
> +	for (i = 0; i < sizeof(*hwe) / 4; i++)
> +		airoha_fe_wr(ppe->eth, REG_PPE_RAM_ENTRY(ppe2, i), ptr[i]);

I realise that a similar pattern it is already used elsewhere,
but '4' seems somewhat magic here.

...


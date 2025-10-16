Return-Path: <netdev+bounces-230144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20718BE46C7
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 18:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05BA61A66A7D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 16:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D544234F47A;
	Thu, 16 Oct 2025 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1OZNxhA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA07934DCF7;
	Thu, 16 Oct 2025 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630416; cv=none; b=chxwtRTF6NxjYz7PuVYiB1RuoEjIgV02afc+Gg+PJvfr5KdIpfwLbWsKkyfV9aZltY0GYH0cdQnJfuFnw0w6wxt5vyE/sUFbW+AClpgHxyKRVg//2WijedqgjGACP3YaxXyhcihOzBaANsqi973I+9Y6OmJyNms0XC6qU/LMcPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630416; c=relaxed/simple;
	bh=NuqUOPCKexSPVN6pyx9qmVQ4zuprW6Q0ZQJ3dbKvATs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iU2nBFNrwl3nJ5WrhzLqYPpeieeRjvNDCVWlnYMtw/C/xafuDlm3Ql6N7bS8QDEq3oYGnD1eu+4vQP1vc5CLKM9kpu+bZZ3nv1TVrfhsNcF3N6fcFQT5eouo+S0Csb/e/8BRBnZzXAjSy3D3vfLvRsPtMSXT2rZ/YyYkGdO/i00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1OZNxhA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BD5C4CEF1;
	Thu, 16 Oct 2025 16:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760630416;
	bh=NuqUOPCKexSPVN6pyx9qmVQ4zuprW6Q0ZQJ3dbKvATs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V1OZNxhAC/VFy5c2v7Clp9XcpcWIZEQoDmeu8dfrVkzFV81Ty+TppXZ7CBIMZt6Oq
	 yCpaRt4YuBqED+M9qz7KOHUM3GdjmowtScYZWMePVmuNGzbyb1BS3Z1cmyNfrbWt50
	 mfEMqlKqaI6Ovopzjf6FngMC9/jwJyrSXDsEgOhEZnaMdRkliP+2S0BPnmSlFX9QMH
	 bByZBmnkIrkpZ6M9zAEOpzPxFHf6PwYexqX/tN/PfYeQoCgqON5r2/HPeBID30HghQ
	 VCKVdLtDaOUQS8BJFOdpDSX/o8jfvRK5oMYoklNCSyIWFZdZ8sRfupt8h42ITDpGVZ
	 67TV4890pnI/w==
Date: Thu, 16 Oct 2025 17:00:11 +0100
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
Subject: Re: [PATCH net-next v2 11/13] net: airoha: Refactor src port
 configuration in airhoha_set_gdm2_loopback
Message-ID: <aPEWiwy_ebWLDnNa@horms.kernel.org>
References: <20251016-an7583-eth-support-v2-0-ea6e7e9acbdb@kernel.org>
 <20251016-an7583-eth-support-v2-11-ea6e7e9acbdb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-an7583-eth-support-v2-11-ea6e7e9acbdb@kernel.org>

On Thu, Oct 16, 2025 at 12:28:25PM +0200, Lorenzo Bianconi wrote:
> AN7583 chipset relies on different definitions for source-port
> identifier used for hw offloading. In order to support hw offloading
> in AN7583 controller, refactor src port configuration in
> airhoha_set_gdm2_loopback routine and introduce get_src_port_id
> callback.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>



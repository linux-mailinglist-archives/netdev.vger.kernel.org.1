Return-Path: <netdev+bounces-229663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 956A3BDF8CB
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 412274E261D
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54982DF13E;
	Wed, 15 Oct 2025 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIaU9VER"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE622BDC13;
	Wed, 15 Oct 2025 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544420; cv=none; b=RAMLkjCE6COReYJtsp6pV6Lr/IhK21fk0d3SVyyuFDtQbrXbu1jNspFLtY/AOfz7sRXNUNVROTlMMVlikYBAGAylYWWsrkUPBamJhz5OWFWwyubMdVALsmkzg/w1bi3w0xjiwFs+9YDChhaCL4w58yeU/7HFEhvmfQwnTSG3k60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544420; c=relaxed/simple;
	bh=yrrQGTEKDMa6yuiG3QQ8O0Gf2mIEuJW3I0RJHaiD/aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJSV7GZe7VWJMXn1e3vS1Shc2tU3JffavMCy2Efen56XYMKX496kewJ0JdA27evEfQQFJruHUp4FNwY5bYEe4C/3mEiCQN90Rs0UGyyGa8iUDKB7iDgy4LBkLz8it84O6MLzlHDbjN66BEZL/bSq0scX/BU32coLWNV4Lr6oI+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIaU9VER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850EFC4CEF8;
	Wed, 15 Oct 2025 16:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760544420;
	bh=yrrQGTEKDMa6yuiG3QQ8O0Gf2mIEuJW3I0RJHaiD/aQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZIaU9VERfqZIcGyeL654N5TDtjSmgo9F8TyKOset1ob9H5G/A6Z5UzPpYLlaBVFWd
	 UF43jQ38fG1YBDOntEw5zIx9vVW9N7tm2eKqB4d9OAxgq1V9/m/86q0LCF8S9NRZeB
	 LEIvicMRzl18AtWvw1w2ZbON2uKdVTJ3D1LOI+aLhzdx1XI3pEXygeMbwKQ6mIsnLH
	 Bkp1DGp6v9tMFihAyFL6RlnJeuKFQSdiPn/0/6SMv3SOZ1VngDUNw+pYQn0QLpSLFk
	 2sTFFOSN+waKDun903dy4PFqA2wv26shl8j4TLmfFModc2n+ktsT4SYjqlqsMG2s23
	 gKg2BcZUY4/jw==
Date: Wed, 15 Oct 2025 17:06:55 +0100
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
	devicetree@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH net-next 04/12] net: airoha: Add airoha_eth_soc_data
 struct
Message-ID: <aO_GnwiGo6w4jWuO@horms.kernel.org>
References: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
 <20251015-an7583-eth-support-v1-4-064855f05923@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-an7583-eth-support-v1-4-064855f05923@kernel.org>

On Wed, Oct 15, 2025 at 09:15:04AM +0200, Lorenzo Bianconi wrote:
> Introduce airoha_eth_soc_data struct to contain differences between
> various SoC. Move XSI reset names in airoha_eth_soc_data. This is a
> preliminary patch to enable AN7583 ethernet controller support in
> airoha-eth driver.
> 
> Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>



Return-Path: <netdev+bounces-229664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D51BDF8CE
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E43FC4E6FA6
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5475E2DFA24;
	Wed, 15 Oct 2025 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqGs0yCV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C31C186E40;
	Wed, 15 Oct 2025 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544436; cv=none; b=plkeSGN/MqLjZZb4hq6TmVC4M3ZvRqvkCPR8JaWHwWfhVZmpI9kRgHS+PXGKB5eoxpnRNKsl8ulXOEbH4djaoUYxMH+yEcaSPTUmE8qfH5XMRjqeqR9bMXrRT4T5aMQpYc0wncpmL6J8xbHZ1AjIi5CUsLlnzIyRtWLDaxvPnTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544436; c=relaxed/simple;
	bh=MJJ2ARInEp9nuBoQhvRqunMxsb/z0LeLIlIn+PkYGvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNAeq2r+dgDRC0gANf4pkwMKw4kqJe/88WosP4I3LYaoHtm+bAwhMUg9oDJm57XF5gwP5rPtlrl97YdBo11QCUU0tmpwDS22IdTzRfXuj3g+CVlns08EPaBswpv6h2VzJJ1sViON8519a238kF7UmtEeHsLRd3/6FHCMQ703//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqGs0yCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EB3C4CEF8;
	Wed, 15 Oct 2025 16:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760544434;
	bh=MJJ2ARInEp9nuBoQhvRqunMxsb/z0LeLIlIn+PkYGvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oqGs0yCV9VVLU5C+sp6b4Hpq3r8TEooFHRZn4LXo9RyodYfgMpER76QhgAeN8U/lh
	 fK1u9X8dlcGSlBSLYwKzu2bJbXSiHj7qg6ECnVBJLDf1l2CsSjnLiMLWx6ecWtpNTG
	 7llPkZAGRf3MWjJ9mFzELaBzm1neMdVeuJqEZbRei/K/ykRsn+ahKePq0KHpzfzysa
	 MHwy3qGXLBGNeEtPHxzzppaShKjtN8fx+HEXla3zq9nRoH1t0OCBHQp0QztllA5Oic
	 Xip/KibWyoCl2yuBAeFn8OWbGpnQTD0IEsP0ryrWHnryYJER/Opjhad7YtS7Gaela9
	 59ja/2boyvRuQ==
Date: Wed, 15 Oct 2025 17:07:09 +0100
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
Subject: Re: [PATCH net-next 05/12] net: airoha: Generalize
 airoha_ppe2_is_enabled routine
Message-ID: <aO_Gre1bLbh5qlQ-@horms.kernel.org>
References: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
 <20251015-an7583-eth-support-v1-5-064855f05923@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-an7583-eth-support-v1-5-064855f05923@kernel.org>

On Wed, Oct 15, 2025 at 09:15:05AM +0200, Lorenzo Bianconi wrote:
> Rename airoha_ppe2_is_enabled() in airoha_ppe_is_enabled() and
> generalize it in order to check if each PPE module is enabled.
> Rely on airoha_ppe_is_enabled routine to properly initialize PPE for
> AN7583 SoC since AN7583 does not support PPE2.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>



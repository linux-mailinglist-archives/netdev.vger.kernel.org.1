Return-Path: <netdev+bounces-230146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E38BE471E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 18:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFD95E42C5
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 16:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305D836CE16;
	Thu, 16 Oct 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLsJBU+N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CC836CE09;
	Thu, 16 Oct 2025 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630446; cv=none; b=iIVDePcv3WhBeeHf3RLmON8u9xfjx6UPDFEitu3BGlm8htI76uLNLkSoifRIf9u0jD70Hk4nH60o50bUI1AYWTgJ29/C3wGFmoIpg4wETdD1zWz4WCGrWJDfaT52dP2MTEvEKLx+gI2L4nhzM+u4Be2M2S0u1esIJPdcmwpaEaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630446; c=relaxed/simple;
	bh=wP6vXDlhFuYqFHW+R+FJucItnIxpqKnTwS+F/MUaEXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFRNti9jhFNqyiPEHqVHZQfvqia5ZKvOttS7ckGIKj1MdVNP0FNoxrwtJ8KQLh/OzazYlk35yYP3xg+BX5nR6YZX2tpmJGi8/N8wzRFoUAVomapuWt5cf/q6/x6k6E3vYepVXCsUKUT+OvMo9ntBR5jLIa8WOdcD75op3GbVXcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLsJBU+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D84C4CEFB;
	Thu, 16 Oct 2025 16:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760630445;
	bh=wP6vXDlhFuYqFHW+R+FJucItnIxpqKnTwS+F/MUaEXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KLsJBU+NGTekT3lJD8bZzbUZL7mpypn9d6sseKpSmPBLD3e7VrygExoPmgNHpJ/OR
	 7vpICSiW57AtXnDzb9YV+Px+QYfvbDzsjhZIY3Z1Z17dLe57WaplaG0BtADeU7Xc7m
	 mia7IhBN7M8U90zOmyNmhYTlmKDCdUP1V5rfa6t3ucbhEYfFc6cLMreG59/pNbRE8l
	 Rk474qliIo9+ND1dpjGA7/5Xpokv72LcyIM0UxQ0N+hG5On7+iZyKr+yrvWxddk5VW
	 wIkVCCQYsgRQWIvqHciH7SQ8cDPL/1cvPC7J6Ceu3HHo4QA8EWq5F39OIhg1sJhtaA
	 jMfXlZncMrWFQ==
Date: Thu, 16 Oct 2025 17:00:40 +0100
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
Subject: Re: [PATCH net-next v2 13/13] net: airoha: Add AN7583 SoC support
Message-ID: <aPEWqOoGZFysIBVN@horms.kernel.org>
References: <20251016-an7583-eth-support-v2-0-ea6e7e9acbdb@kernel.org>
 <20251016-an7583-eth-support-v2-13-ea6e7e9acbdb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-an7583-eth-support-v2-13-ea6e7e9acbdb@kernel.org>

On Thu, Oct 16, 2025 at 12:28:27PM +0200, Lorenzo Bianconi wrote:
> Introduce support for AN7583 ethernet controller to airoha-eth dirver.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>



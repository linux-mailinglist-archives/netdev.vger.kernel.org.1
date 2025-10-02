Return-Path: <netdev+bounces-227544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA810BB26F6
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 05:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886B91776F2
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 03:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A4A1E9B0D;
	Thu,  2 Oct 2025 03:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNNgzr2r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D39E1411DE;
	Thu,  2 Oct 2025 03:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759375751; cv=none; b=Vj4kzoDdoxxXrjg6VaWeGK81fjlNNlLpYOlJUiCrclOspE5NoSEJx7/gMkiCapP9uoyAS5GFrNuNQBqKrpEJPsVd07h98jE7OXAOqidDB1x1Ihg+UEvcy2BO9dgYTdnaRL10/pJ2BL8v/d8y2Lj38A4ZsZaUNfxJaTCugSx8D4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759375751; c=relaxed/simple;
	bh=BvDPI/4IuPDJZpOnpNE5Q57W9CRHGfyMP9sQtv6gKEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ry6chcLAPftNC3vi+++5QdaqV4EGZR3BAfyzJXTcs85l7FVG7h7xqcEJen74GCHSEx+u7qZfXmO7rc5ouUNS0fxbbpb+/H/MCZ749OUlyw4++e53or+4N/GEHsSMJzRKo9Bb0rYZ+jCTAv4nukDSubvo5MSZPcTXl+lGSR6aTj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNNgzr2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E777C4CEF9;
	Thu,  2 Oct 2025 03:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759375747;
	bh=BvDPI/4IuPDJZpOnpNE5Q57W9CRHGfyMP9sQtv6gKEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RNNgzr2rdi+C8IDTWCyckUg3LpN7BNsefhA5z81rBhrGppBzA/QwjIGUhZJD1c5Uu
	 N95RMC2emcEtbR+X5tep5Aghvp1hljM6v9+3//KzF3qBklchmTlahhH7jXgUS7LIF+
	 mnYm4MYR8K/PzGibXijcjR1YzeS0gFmujnzyWMdkjyUhegcgXHZx1ji7hol8pv/zCP
	 NVQvMwQLj8+od7LD0PvGRWaTu9pIw+hgygikt+1H9+jnOuh58kinOex3EEmpEYUl8E
	 QNmcqPAh7hID4S4720Uo3PQjQqw5LJyXv16VbbYbT71YEAvOdVJm2rcc2qUbN3Flwf
	 GxYugl0oa5T6g==
Date: Wed, 1 Oct 2025 22:29:06 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-mediatek@lists.infradead.org, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] dt-bindings: net: airoha: npu: Add
 AN7583 support
Message-ID: <175937574555.3012205.7371321429695114509.robh@kernel.org>
References: <20250927-airoha-npu-7583-v2-0-e12fac5cce1f@kernel.org>
 <20250927-airoha-npu-7583-v2-1-e12fac5cce1f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927-airoha-npu-7583-v2-1-e12fac5cce1f@kernel.org>


On Sat, 27 Sep 2025 16:03:40 +0200, Lorenzo Bianconi wrote:
> Introduce AN7583 NPU support to Airoha EN7581 NPU device-tree bindings.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



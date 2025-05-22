Return-Path: <netdev+bounces-192677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9BFAC0CEF
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36DC3A950D
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4742C28BABD;
	Thu, 22 May 2025 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akPRekvw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF6928AAF9;
	Thu, 22 May 2025 13:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921075; cv=none; b=d0dhR7GZqGOd6HV1mT9RImlIVhS7UmicofP/aWcir05g+OzGCI0DmbEEllqDVxFAN3BzVZmdC7EstRHkUS0NfjEkNFf6m9ld5H9xfUniqrHP1BlukVHRAhTvCL5DMlxj8aVYtZ6rEdTGEiW9IlvjvTkpEOaOabmbVa5C4xjAnO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921075; c=relaxed/simple;
	bh=ev0arRRmbzjSG9o7W9ASomHCIPJ3iT09QMhMAO9W+Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzKcvJPHfw59D9eN5tSWi2ZvfmC4fKoY5XTDTSL7YCaFbOwaLt74WH03mCbqGjh6lMapgzYDfM95nk8tpHHORaxbzUv3ql87bs0wyMgSvHD9A7XqHcOSN5M0W8VI6L3Wt/dO3p6k1tlXDeEGK9ZemTTWRIBFH3ihDKudjn2S1CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akPRekvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AE3C4CEED;
	Thu, 22 May 2025 13:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747921074;
	bh=ev0arRRmbzjSG9o7W9ASomHCIPJ3iT09QMhMAO9W+Ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=akPRekvw/K4j6AgtMeGXaP0Tz5yWJj9qSVCI6bwIMYqa+NAzgRM1GgdxYb0BPVJNc
	 dLgeMtQsTl1KbvhCJhvKg1bjC10xyOts+dLA9vlLxwGEP3Ak1/YJTPzTu8P55m6ngP
	 3xTfPOJ+xJ5IPn45kqSFgwJ5w+3GCucRJ/7jL1oi1TQ6n1+yKktBsizWKsNvjBmsaw
	 sEn4OwzXuYPWIkUQ27HPjqHSMyroBGIrGBNG76cHHNXvp/vECE/qipGwoNNpO7dP9a
	 cjc/o18hlrOyvDxfWk15IhzmkXFkBkWlgObMgjZaYWQWbph7aY9WcuVJaI4ZWVkRLU
	 DDw4TAdDxmxLw==
Date: Thu, 22 May 2025 14:37:50 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/4] net: airoha: Add the capability to
 allocate hwfd buffers via reserved-memory
Message-ID: <20250522133750.GD365796@horms.kernel.org>
References: <20250521-airopha-desc-sram-v3-0-a6e9b085b4f0@kernel.org>
 <20250521-airopha-desc-sram-v3-3-a6e9b085b4f0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521-airopha-desc-sram-v3-3-a6e9b085b4f0@kernel.org>

On Wed, May 21, 2025 at 09:16:38AM +0200, Lorenzo Bianconi wrote:
> In some configurations QDMA blocks require a contiguous block of
> system memory for hwfd buffers queue. Introduce the capability to allocate
> hw buffers forwarding queue via the reserved-memory DTS property instead of
> running dmam_alloc_coherent().
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>



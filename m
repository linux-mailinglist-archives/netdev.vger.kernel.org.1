Return-Path: <netdev+bounces-230906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA63BBF1675
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 15:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64EE83AA485
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 13:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2D1242D69;
	Mon, 20 Oct 2025 13:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCsP/78d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE22C23F417
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965327; cv=none; b=XgJcwH3zAWlt1USuP0woQs3cFrLAv9NOGju1en/89qA+tVGcMNfbnjCGMDffACUAzeSuezEwgPK5BqZqHp8dm4l6AsoTCnHfxnkHdE+KUGes6drb7N5XTgNgLWwhhn9hJH/3MUKUvtTY+H5Ugp0peb3hCKxOqjS22Pd0a6LBEws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965327; c=relaxed/simple;
	bh=T7/5yyd4a3f6JPR4Kstl0R7lDf618KW3dNP2+81u6wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IL26p17FTbkA0VuY6692FaGoJR2D36q18tdQjNEAAOYbvMMAlr3dvrLe6rHgIrl7yUg8+13bWf5P5QrHITG/pBqVpd66Pi1qcDwk1bAHVKrQSFFhXFCKNaBnjTWIdJgBSFMSVHsdNyrypebE8Egb2iGcbNMoLqZ5c2FT+I6N+J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCsP/78d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7463C4CEF9;
	Mon, 20 Oct 2025 13:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965327;
	bh=T7/5yyd4a3f6JPR4Kstl0R7lDf618KW3dNP2+81u6wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RCsP/78dKKLmRC9UoH1YTLe6PLvbBT5HrzgNxXHmceOjyFIhE1s0TYBOjQN9+jqWv
	 bYZHyeuQ1zUBwauELTqndxc6itRrzl2Td3JEIu9JzzjNArdScnyJ6iEO6t/w4oS0i5
	 FEzl52vXkPXscqI5Rwh4jDNX5eaONWUCTAgxP84HKnaP5RpDDqTVDmDxRqUePCjApi
	 bQWOuMXbWiksylMiASJB7uvjyH7Q7adFAmf7p3o7TT+SuXngajeYLHC/an81e9G1bH
	 4alHdESnJObtqpbY9PEDw2MGjO6iG4G9hMXe09jyMwpraCS9e4sHN+W4aMJrzy5bAf
	 0UwkKveQJTbWg==
Date: Mon, 20 Oct 2025 14:02:03 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Remove code duplication in
 airoha_regs.h
Message-ID: <aPYyy-aoTX3-Zbon@horms.kernel.org>
References: <20251018-airoha-regs-cosmetics-v1-1-bbf6295c45fd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018-airoha-regs-cosmetics-v1-1-bbf6295c45fd@kernel.org>

On Sat, Oct 18, 2025 at 11:21:47AM +0200, Lorenzo Bianconi wrote:
> This patch does not introduce any logical change, it just removes
> duplicated code in airoha_regs.h.
> Fix naming conventions in airoha_regs.h.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>



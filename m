Return-Path: <netdev+bounces-199457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D97FDAE0611
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719E3188702A
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B01223B607;
	Thu, 19 Jun 2025 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CI7fEyod"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AAA22A4EA
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750336587; cv=none; b=EjOTYopJumYocWof3VQaWjkcjRuuH6oUDi1jQNBD0UF502oy7sGct90ZlQuRjBiK+h9hnXN3OcyUz7gX/HCMgbBhLmhhrZdGpnvYX8LmJXuEmnd8QVnl2V6RaxdUFwBn28Lh1C69IGNaQDUJgEWYbwlbAf1fJC2rl7/LgEXfZ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750336587; c=relaxed/simple;
	bh=0aZ6hvd/IjVOBqGmz7MszhMOejk6IpZuPtDdl9PW9vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldGSPGadkGoMLIJ1ipLfuoA/YsnMPWXY0CLN3up7nA+zv4sVPgexS/WdPupBPh08OKJCyfc7m4rHwa2zUBIEMuaFpCo/dWnMNtN8n92uoyoZmLPs9NmZZT3hlui7b0ljq9lfjyyEuiACBSB8sWhGRtiNDwruYdAZhJ9F1tr0Slo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CI7fEyod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345D0C4CEEE;
	Thu, 19 Jun 2025 12:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750336587;
	bh=0aZ6hvd/IjVOBqGmz7MszhMOejk6IpZuPtDdl9PW9vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CI7fEyodMGaW5jyKK8UY6kiGubgfymOHPJnBbUgexQqVw6f1vhwj+IWYYJCLvi1Mr
	 Edsd3Ntro02FIelndIezoK8WBnFGAHgSiGmGtUUp7/xwv8EsRz9kI+hCic8n8tEclK
	 M40tzSqGmjaBEDQKiJRC+bVFQwFrOvwKDMpHDGBlpqv9O/JU/0Fri55OQptM5Pm24c
	 n2lC5jnDCRGON/s+HlPLM2X7ws9YYSjaut69jLh/emaeHrnFeN0EDxMtJRoriHcCVl
	 m5Qprn+xiHtHiRVOYHZT9cVUhu5kYE8xJw0G5Tb//D4ud1ap7V2LCRo4pKoqH0Y1pX
	 ga2+nPkAM9W3Q==
Date: Thu, 19 Jun 2025 13:36:23 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v4 2/2] net: airoha: Differentiate hwfd buffer size
 for QDMA0 and QDMA1
Message-ID: <20250619123623.GL1699@horms.kernel.org>
References: <20250619-airoha-hw-num-desc-v4-0-49600a9b319a@kernel.org>
 <20250619-airoha-hw-num-desc-v4-2-49600a9b319a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619-airoha-hw-num-desc-v4-2-49600a9b319a@kernel.org>

On Thu, Jun 19, 2025 at 09:07:25AM +0200, Lorenzo Bianconi wrote:
> EN7581 SoC allows configuring the size and the number of buffers in
> hwfd payload queue for both QDMA0 and QDMA1.
> In order to reduce the required DRAM used for hwfd buffers queues and
> decrease the memory footprint, differentiate hwfd buffer size for QDMA0
> and QDMA1 and reduce hwfd buffer size to 1KB for QDMA1 (WAN) while
> maintaining 2KB for QDMA0 (LAN).
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Lorenzo,

Thanks for the updated commit message.

Reviewed-by: Simon Horman <horms@kernel.org>



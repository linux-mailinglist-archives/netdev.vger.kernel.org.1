Return-Path: <netdev+bounces-251180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DD0D3B229
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 17:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E756A3076A8E
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D3931D387;
	Mon, 19 Jan 2026 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rr7PL2iW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E36C314A60;
	Mon, 19 Jan 2026 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840419; cv=none; b=sHbRYsxfnluusGxybsVQGvg2ykiGz0dFAkPg9RSS1vV9yqTnFWdMJ8dLbz18SmIl738grDUhcc2++fjCnVzXYR/6Bo//LvKrk/AD22jNOSSH+H+SgjgeEObwit9rcJcc1nb6tCJz7exKnGV7Qu8Yuq0i42hEOTuJe0ElgGaUoOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840419; c=relaxed/simple;
	bh=K83XyN1kXetyCZqor4EUNgZrgIFaP1RCn2CaY40n8Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7d3Jk10zMBzND5DA4M6a1zCbrEPHMY/v+PBLbubr5ibzUJ9bZ3I7MOv/xw7+MFS1G+Ttks4KsgpyY+utTlrRuCBXpDLxnF2ja1QO98Bn0qyth/USJ7AQPlAYUcF2+wrR/oqRnbzKVKCZPWKAH8nQsTQl/gzKhI62QZ2tVyGWbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rr7PL2iW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792CFC116C6;
	Mon, 19 Jan 2026 16:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840418;
	bh=K83XyN1kXetyCZqor4EUNgZrgIFaP1RCn2CaY40n8Ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rr7PL2iWqiPDY5bmJNbx8/aQbEBBq/ghR1KnrjMJBRQt53994kS67UWiHHtrLfMGr
	 t6Oomty0lCQlKFs6DIZyrkPqgyr4wVEDCB01cay4hZnnvKH87UeejjA2nQZeNu1GiQ
	 Ra1CSdsh/HmHvpni67xyjoh7XTrVx1B3Sa/kz2K85bjQtU/Y29P+q1cdcAWABC4uJg
	 Y51zrrhjFWRfMdeB7tqOaZ3kI2jXcWk5cUol+nlAt2FtMHXuD9PyoTjRf3FEKu+PbQ
	 vsJHzpp23FyR75XND6UXPFkZpUnnjawlhhrXZmui3F+LTvuVU+KX7Smcjp5wJmyQ7W
	 tiPYnMHkY/eCQ==
Date: Mon, 19 Jan 2026 16:33:34 +0000
From: Simon Horman <horms@kernel.org>
To: Vimlesh Kumar <vimleshk@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sedara@marvell.com, srasheed@marvell.com, hgani@marvell.com,
	Veerasenareddy Burru <vburru@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4] octeon_ep: reset firmware ready status
Message-ID: <aW5c3l9_rwXUFVLN@horms.kernel.org>
References: <20260115092048.870237-1-vimleshk@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115092048.870237-1-vimleshk@marvell.com>

On Thu, Jan 15, 2026 at 09:20:47AM +0000, Vimlesh Kumar wrote:
> Add support to reset firmware ready status
> when the driver is removed(either in unload
> or unbind)
> 
> Signed-off-by: Sathesh Edara <sedara@marvell.com>
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
> ---
> V4: Use static inline function instead of macro for readability.
> 
> V3:
> - Reformat code to less than 80 columns wide.
> - Use #defines for register constants.   
> 
> V2: Use recommended bit manipulation macros.
> 
> V1: https://lore.kernel.org/all/20251120112345.649021-2-vimleshk@marvell.com/

Thanks for hte updates.

Reviewed-by: Simon Horman <horms@kernel.org>




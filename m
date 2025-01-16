Return-Path: <netdev+bounces-159009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB5DA141BA
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 19:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5CB188C064
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 18:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02D422F15D;
	Thu, 16 Jan 2025 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIgXc7KJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB8922E3FF
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737052202; cv=none; b=ee/scahaTRd+cjSn2U/l1F3XknPJQn9jGJN3qXHYAxK1vr+N24lSTCOjSLTiGizdI+8NJtrdyTC4A07qV79shOGY5khy6tbZmaD8PhT6WZ6X2EHWzCT4kdXV3U5DkkT1p8gsKgx/wkv1xLkLhb1XhlFOuF4stAmvs3F/6TYEgz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737052202; c=relaxed/simple;
	bh=lwAG8HHQXAjrk4Z8xyWN05Bb//cNJmJJFqicFPLtoN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVtaSZ8Q77VKqTqsKVPo9bYWerrSR/ffIHkLLvLo0rXLsJVwhEpDd/FaJzxPIiR4+M9dTtLfpnuDpF8emwxM2nD6IPB5AO6iu5wMvkobfEIgQ339WcVHBqJc7BatLQzA831eGxh8QBM6VcV0Vw51MxpQKxQcuyq+ECBGoafTrQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIgXc7KJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D7DC4CED6;
	Thu, 16 Jan 2025 18:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737052202;
	bh=lwAG8HHQXAjrk4Z8xyWN05Bb//cNJmJJFqicFPLtoN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rIgXc7KJ9p2Ry0L7VgNlTTVuV42OAfhU3iXOxrBoLlOX1jY3hE1L2vZOPShaEPBcC
	 TRc9Sr76IC2rcvvXAmh9+sM/Dzpw7i0Sx4LxZGNjm9v4uZBKy5cgkD7plQPJ0VyNWg
	 jI2q4b4IOfY1/V9QSVd3HgZHwZyqgCy9kzaeU2u2Lh8CuiNjtpqFeCnogsuNGNDd38
	 zaOFg+n4yfycMjuHUWvo5AZm74sOLh5y/5jk5l525clqjr1JARx1qtNaKtCuD0PrxR
	 UI1Q2Pr6+GQkFsLvEdR8dtBb88/sWZQtOT5EK9iUSq2u3CsF6WTNpXMeBWkdIg3mQD
	 YSWTY3zrRzi2A==
Date: Thu, 16 Jan 2025 18:29:58 +0000
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Subject: Re: [PATCH iwl-net] idpf: synchronize pending IRQs after disable
Message-ID: <20250116182958.GG6206@kernel.org>
References: <20250116134257.93643-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116134257.93643-1-ahmed.zaki@intel.com>

On Thu, Jan 16, 2025 at 06:42:57AM -0700, Ahmed Zaki wrote:
> Wait for pending IRQ handler after it is disabled. This will ensure the IRQ
> is cleanly freed afterwards.
> 
> Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Suggested-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


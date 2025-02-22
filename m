Return-Path: <netdev+bounces-168708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 366B9A403F4
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 01:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838DE19C1E00
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 00:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7BA1EA84;
	Sat, 22 Feb 2025 00:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATY74NUn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116486FC3;
	Sat, 22 Feb 2025 00:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740183375; cv=none; b=cVT+QDfR9ZNIoimv55ulZah1QhfHxDrsp2X98+WwCuZVl/0yqZV8846hafPRG26iT6j1k+OEnBd8N8iy1GODaopoyajXd0xtbhXP9wS7IbPeNWO32esjfUexgjwdb/1J88g2/BgTch49QBitw2PetYpbly12nsbxnm5GqVnJt2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740183375; c=relaxed/simple;
	bh=80Uxk+5snSi9oBnZbUcphQ5jNadj8p+JscCeZPO6iKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9oAUrDBBAwUBtEmDfNvavpOapcts10SR8lkOUuqZwtwoWaHug+Bhnl5G8OwQnpgeEqzkqIEpySUh3dbmr3CRcWu2r9BroE811MtFgMsraNEkrS1EuMGLjD+DnGJu2h0n3PLIzRffhHzvltMRctQmKFMaGq52b1j++6MIpH57gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATY74NUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C32C4CED6;
	Sat, 22 Feb 2025 00:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740183374;
	bh=80Uxk+5snSi9oBnZbUcphQ5jNadj8p+JscCeZPO6iKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ATY74NUndrepW8gsmpbSgwlkor6rP5yCeqwy6A1vzL8Oc2hRjjl75tpIYM+Ncts3q
	 r6soteeBH0Uk4qNJit8vfqbNhiMl7JsAAMb3/I+AxuVZXB5rCy9AGw38s+/W1sIMQ8
	 TLctLVIOWdlL/S9w82dmJpeJfFjSAwC2Gsz/dBqLgTOLEAEFlhe8K+OzM3gTjHXpdl
	 GfYqh2Nt6yPrO/yr+vvQYKvWf5w1sq6/d1lZMbwAaAP8e+F+o7gulVMMXG058YwVEr
	 Ey2CYTZ4QC2Pn1XTSRwMgT3VDkYEp0eeydY652FggFJcYJRRBtf2eDpofw1bOFF4tx
	 6V7kie42WbDGg==
Date: Fri, 21 Feb 2025 16:16:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw: select PAGE_POOL
Message-ID: <20250221161613.67fe279f@kernel.org>
In-Reply-To: <20250220-net-am654-nuss-kconfig-v1-1-acc813b769de@pengutronix.de>
References: <20250220-net-am654-nuss-kconfig-v1-1-acc813b769de@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 09:43:06 +0100 Sascha Hauer wrote:
> am65-cpsw uses page_pool_dev_alloc_pages(), thus needs PAGE_POOL
> selected to avoid linker errors.

If it can actually result in linker errors today could you add a Fixes
tag pointing to the commit that added the dependency?

If it can't (perhaps one of the many already selected symbols already
implies PAGE_POOL?) could you explain in the commit msg?
-- 
pw-bot: cr


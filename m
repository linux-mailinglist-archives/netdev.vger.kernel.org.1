Return-Path: <netdev+bounces-96196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D10F8C49FA
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 01:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A45DB2273E
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 23:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8F484FD2;
	Mon, 13 May 2024 23:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxPZk5cN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C9E2B9D9;
	Mon, 13 May 2024 23:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715642299; cv=none; b=F6Au+hPUXNymyRTscSc8pMXXP8LNmXp9WWP81QII/TCLL5pxn9+a9O0LYKLIDe1NDHFHLe2erUYVw7FhYQpCPtpiTMKF6Z4/F5WabeHmuXouLkjUrrL6JjJIm1EpHI9ZHlmRXIE/p57TrDiuDxu8FAcYwiVkjo/lCz8V+w2qXRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715642299; c=relaxed/simple;
	bh=7YP5DnUgFJ0rvhvCbLRxYGZmXgJBxA/RcgKKAIsDeD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J91WflabfmehWnMpfkVYFtn7jf6sMASpSuRd+JLBCtlZC+iWmKiFg2h3H6foOcLrXQGueD2YxDzylUcQCB3S34cKF4kccMk2NN7/TbGbdK3RBEiCoFVHxQMzEzXNQjuHyhLA1+XYeQr1BSfTyAuKpORhWfGZqu9gJKr7eVmpxA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxPZk5cN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F206C113CC;
	Mon, 13 May 2024 23:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715642299;
	bh=7YP5DnUgFJ0rvhvCbLRxYGZmXgJBxA/RcgKKAIsDeD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KxPZk5cNzBgI/xgadMO90TKRdGIYWHs20CtlIS/29/dq88KGmodXHMmkCo8Ng+wzY
	 XLfKXPPNny0OH2/V5pjBQTyvxH9HrXpI2+OlPgUzv+2ZLNVaticNX+gUWb/xFoumD+
	 oG7NKNq8KyfiriRjsBVhjH+2BC4cuOzLUnF+UFO6tu/EPuVS/7PwZB3Vlp+aDYKHt/
	 C3N45FkSErMSCPLlhGAqouGFnV1urt29Rw4hsUXuLU5qEhYwPz93POgxXpnPfCshA+
	 63Mtbf93+69Zeei8BF/nJxBkcLExDNvkG2oP0rNf1+6Jmmf4SaB+CPHODRHz0JMZaD
	 RRgSP82ZyPpQQ==
Date: Mon, 13 May 2024 16:18:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <sgoutham@marvell.com>, <gakula@marvell.com>,
 <jerinj@marvell.com>, <lcherian@marvell.com>, <sbhatta@marvell.com>,
 <naveenm@marvell.com>, <edumazet@google.com>, <pabeni@redhat.com>
Subject: Re: [PATCH] octeontx2-pf: devlink params support to set TL1 round
 robin priority
Message-ID: <20240513161817.048123bf@kernel.org>
In-Reply-To: <20240513053546.4067-1-hkelam@marvell.com>
References: <20240513053546.4067-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 11:05:46 +0530 Hariprasad Kelam wrote:
> Added support for setting or modifying transmit level (tl1) round robin
> priority at runtime via devlink params.
> 
> Octeontx2 and CN10K silicon's support five transmit levels (TL5 to TL1).
> On each transmit level Hardware supports DWRR and strict priority,
> depend on the configuration the hardware will choose the appropriate method
> to select packets for the next level in the transmission process.

Configuring DWRR parameters seems in no way HW specific.
Please work on extending one of the Tx scheduling APIs to express this.
-- 
pw-bot: cr


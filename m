Return-Path: <netdev+bounces-207856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BECB08CFE
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D671C25B1A
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B5B2D0C7E;
	Thu, 17 Jul 2025 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oqu6ituP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B55829B239;
	Thu, 17 Jul 2025 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755619; cv=none; b=ncypiIX4m4064Ow5Sf6qyyWDLSAbvIxlJW5K5D7O/F5hAq+ERMn0/alppjI1mC0hWQNVJwtw3XtUlCZoKS6AtJ8W7Fr+dbQg/f0mMMYiFo7soZj4/Fj7MmqVMqa4jKallbGgZbl9r9fPBP5tLPaTXdk20XqIi7l4PEXraMonuwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755619; c=relaxed/simple;
	bh=53N5Ja6jJo8h1a7l432pW3S39rhZalQI6jv5e/4Xg9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oF1gCvrogV0+sdOW/TrVIhQJfq2h0gpvzXcK725LQrZf2iEHjvqCy0XqkqAjB10MK9Ad7+FSSnLnr3wc1HX2V90gsrhyXXPMCnsY88qgSU7+dYprkGu25JSRUHNHNzrxDhpT7RNtZE9UL57qBZncBToi/YE+u1Oj/RHzdJ7JEjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oqu6ituP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7AFC4CEF0;
	Thu, 17 Jul 2025 12:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752755615;
	bh=53N5Ja6jJo8h1a7l432pW3S39rhZalQI6jv5e/4Xg9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oqu6ituPrgxugbgfNzrTbp1dYaodktEvg3G1N/Iu3fSaTbFUJadKbstivnbABQYHF
	 Lm5gbyOi0cOFTWTefQteTDcZ500WbX36cMg0XwgSp9Qh2Zk1GLEkekpu0DgNjKuAG+
	 bRis7fZ/WBns/pgihbIeDr/S+e7bD/JhWfDPQJ/cM9mI6W/sHuOD8g6bR23bO9Cpv6
	 eVIt4m+R+TetOvMcCA7EOYwTjTwjUYAB5hIwEVBPdHaAzAbxG/QHjPGUpmKa9mUNu/
	 JrBmkf+uTdkuKjr5LlFWDEdNsZ9Ej2GU3cRoeVxS5uFXdFM3QR0CyHDb2mDLY39l7y
	 d6QgrBvrIh6jw==
Date: Thu, 17 Jul 2025 13:33:30 +0100
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, lcherian@marvell.com, sbhatta@marvell.com,
	naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, bbhushan2@marvell.com
Subject: Re: [net-next 2/4] Octeontx2-af: Disable stale DMAC filters
Message-ID: <20250717123330.GC27043@horms.kernel.org>
References: <20250716164158.1537269-1-hkelam@marvell.com>
 <20250716164158.1537269-3-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716164158.1537269-3-hkelam@marvell.com>

On Wed, Jul 16, 2025 at 10:11:56PM +0530, Hariprasad Kelam wrote:
> From: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> During driver initialization disable stale DMAC filters
> in CGX/RPM set by firmware.
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>



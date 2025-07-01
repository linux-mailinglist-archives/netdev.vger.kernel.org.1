Return-Path: <netdev+bounces-203036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC04AF0408
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 21:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A774A2F1C
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 19:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864C8242930;
	Tue,  1 Jul 2025 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cd2qj/7M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628531E5B6D
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751399063; cv=none; b=KoZAvIw01pjc5eVHEdFxLuvHTMTKEiCs8KoMNkVts/Hy3wGT/hepcrnCi9gCsXrotNW5V1bSz0ssOIqpIRoW4n9BATQrcFHZEmOKvlSHTb//M+MCltdKON4Ke/qzahZZsxWzE74xb51CwIKo5FC254Q/r2RMvVb8igf7bHcUBxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751399063; c=relaxed/simple;
	bh=rOnItsWbwsqBZlNi7WNmPsFgwdDzG2ZNGlzI5qR99a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2DDQis9cv+vA/wQCBk4n6ds/UNjLLK1dSq5wF/TXnDQeMAsNDmSMU9YsaVXbaIvRnkuEI79sju4Y45fw2nXDSfKbh63VdTbdUy/t7HfDuXEcC8hG0lijeDlBv7V+bBn5Zi3MOqsVm0xmd7ZrQZITl8wtomo3f/+/QqGLStJhcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cd2qj/7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A38C4CEEB;
	Tue,  1 Jul 2025 19:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751399062;
	bh=rOnItsWbwsqBZlNi7WNmPsFgwdDzG2ZNGlzI5qR99a8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cd2qj/7M0rfrLu+b4rXDwXMePQiw7FoB0PqfYOM62oCuUxZ78rJhYumJFD/eBlywT
	 Iug39ilmsK/J35JCwRMig7Jp2pEYV+t19cOStuCdBY6j6y3qiu/PHmycXoIhXGCAgU
	 qHZMgIdhUj+JnUHOCl9RLhmaD36c2Yc0tI1/Ad63j09VaUizkzg5fZKTvyMlLzl2oM
	 9h0eynbkEZSauzGp3FLaXruQrTvfCsq4pKK/lWNVgfnBIfZnhLJZhBLM6V0yV/dWSK
	 bxWGSmv+kYcwc3m4aSyG9mcwDnWsk9piF1Wt3x39SOodcaEyJrjc5eQSpBOwn88Pbs
	 DgsSYedFB4BGg==
Date: Tue, 1 Jul 2025 20:44:19 +0100
From: Simon Horman <horms@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	Shyam-sundar.S-k@amd.com
Subject: Re: [RESEND PATCH net-next v2] amd-xgbe: add support for giant
 packet size
Message-ID: <20250701194419.GC41770@horms.kernel.org>
References: <20250701121929.319690-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701121929.319690-1-Raju.Rangoju@amd.com>

On Tue, Jul 01, 2025 at 05:49:29PM +0530, Raju Rangoju wrote:
> AMD XGBE hardware supports giant Ethernet frames up to 16K bytes.
> Add support for configuring and enabling giant packet handling
> in the driver.
> 
> - Define new register fields and macros for giant packet support.
> - Update the jumbo frame configuration logic to enable giant
>   packet mode when MTU exceeds the jumbo threshold.
> 
> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>



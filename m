Return-Path: <netdev+bounces-172419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C632A54859
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E5A173374
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354DD202984;
	Thu,  6 Mar 2025 10:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwCysbI2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110B5202971
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 10:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258071; cv=none; b=g2LWgwM/rrMb17aKIRDsfJkBt85MePZaEP7zQmF/XybH5KwREGd7L86OZH34mRCMHt75cWP3yn5t6YZcXmjBjFWqJagsizlWv4y1LXzTS8vYDVdeO/fXjr97aNM9OgbBmk/G3mH4Psc5ZP1pG1Td+V/U5mVvHh8wb2ApJ1RV5Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258071; c=relaxed/simple;
	bh=IADfqX2cvos4tpXgLDzVC9YDBUnCxnLRvhTPxaFn5to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9mK2O8wW7ZiaPX2ca5SloWKs+I+RXnpjSt2ed5k4zq2mVMMH6fLT5NoTI7vFLUNRVlgD/v16LLyh5wP0uaiuzZM/aYXLBB7l8o8mlWlxRoyz2HBJEkV6c5RjszeM/DZjlv81B/bEAWUGLry1hU3LW5cCZZKauMOdn/vTIizs5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwCysbI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F40FC4CEE0;
	Thu,  6 Mar 2025 10:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741258070;
	bh=IADfqX2cvos4tpXgLDzVC9YDBUnCxnLRvhTPxaFn5to=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QwCysbI2dPmfL0pFEkylboBjxL6V3c4sZ35shhe9nZbdJwP/Xw0tpAJ0vOcb4YDGD
	 iZcQB/mUb02h+m841lUwzJgWH5cgCuJFjDJ9DEq6E5xSm6OTSG0EWQ8zPc8w8SD7ln
	 wyDMlSZGFygKwOZQjD4mnsFGZXq5knJiZl71XLPGpDgTGVM1MhPHdWrsy/gJokqbuy
	 Q7NzVWAIYvFEMNsykuLnuARehCNmdtpCHlWvyoIpvEmGm5hyRZ/uD3DIKTPoOcpnhQ
	 lKYSMgrynW6HMpqyah7nIs6P6RYqdECZL1TbH4ZwxyAsELMV59phywSdeuVH+BlkVK
	 OAgkwX49KrbeQ==
Date: Thu, 6 Mar 2025 10:47:46 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: airoha: Increase max mtu to 9k
Message-ID: <20250306104746.GV3666230@kernel.org>
References: <20250304-airoha-eth-rx-sg-v1-0-283ebc61120e@kernel.org>
 <20250304-airoha-eth-rx-sg-v1-4-283ebc61120e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-airoha-eth-rx-sg-v1-4-283ebc61120e@kernel.org>

On Tue, Mar 04, 2025 at 03:21:11PM +0100, Lorenzo Bianconi wrote:
> EN7581 SoC supports 9k maximum MTU.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>



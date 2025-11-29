Return-Path: <netdev+bounces-242660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24131C937AE
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 04:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A743A9BCE
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 03:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9713221423C;
	Sat, 29 Nov 2025 03:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8aGawlG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4831C701F;
	Sat, 29 Nov 2025 03:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764388558; cv=none; b=XSdSomIgwD3nE+teOWMr4VlvBgNQFa/IHjGGmR0Kea6gJNSSXIQHWvm3SP8RisIY75sXo5pwfv2xQcJrf9TfnTORB3HDbgwTlQcwFShDXgS6jPGMDzBF92L2qRuu18ZUStbH7sVULZ1CfpHjlzOcpLGxsi3RhjmsfY6cP6Nony4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764388558; c=relaxed/simple;
	bh=+CUFcLX6e8fDnXyzZQ4+eyzKynvjxNbepNI2+SXkwiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gea7K4ShOOOLUBy7NkmQfp/cvDuiFHmHBhSq+JIVNhmWHoRLAug9+ILWTgc8qla0L8t6WFmAnfOsXvU4GRddqdbdyD4gj5pg8LJOtO+jZcbDv/WlU8pZsqa33CdCY0uKrDI9USl0BrEBGGr1yFIgBOZ6w6vcgSryNapsX0Qo7fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8aGawlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3318C4CEF7;
	Sat, 29 Nov 2025 03:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764388558;
	bh=+CUFcLX6e8fDnXyzZQ4+eyzKynvjxNbepNI2+SXkwiQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J8aGawlGIFRu7gkXnSaPLuqgSlfqbgpL2G1mJueXShfvjoC+fnMrspAsRF0Z7Kav6
	 in3VxCq/IrmO6BD9emrx2I+tt7lHbdFNONA0SpbTOQqPeFhvnhFRAl09WOcWC0NG3i
	 ekE36CZGz5AsE8mfJxbdaNQtvXOoiOCcYIE4plT+qAiE1Fia94lpASi7UocQmBKExe
	 H86biTPNSLCEXZEBiBHjUlP/mKsCOZJb7PVOZa47O9Yt/H7vPPB2TrIb17YJJ8U0Bx
	 7BZS4zNyKzygqhc/8KfOuNrNPX5uYsurFDSpIS0cPmShdFp3Vts4WilDwCC9Zu77eN
	 +kf0ztZrbj6KQ==
Date: Fri, 28 Nov 2025 19:55:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, dsahern@kernel.org,
 edumazet@google.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 pablo@netfilter.org
Subject: Re: [PATCH] net: ipv6: fix spelling typos in comments
Message-ID: <20251128195556.5c457238@kernel.org>
In-Reply-To: <20251127103133.13877-1-i.shihao.999@gmail.com>
References: <20251127103133.13877-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Nov 2025 16:01:33 +0530 Shi Hao wrote:
> Correct misspelled typos in comments
> 
> - informations -> information
> - wont -> won't
> - upto -> up to
> - destionation -> destination

Your changes does not apply, please rebase on netdev/net-next/main
-- 
pw-bot: cr


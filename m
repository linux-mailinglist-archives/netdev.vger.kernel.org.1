Return-Path: <netdev+bounces-217519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C5EB38F72
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EBAE4636C7
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B2C1553AA;
	Thu, 28 Aug 2025 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVbPPPWz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE722288D2;
	Thu, 28 Aug 2025 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756339219; cv=none; b=oAQImOBXa1hEHZOgoW5JTXsNyom6ervjZfHe1exvkhwtA52AQoYX1DTbzM/rGemoVFlDAnwyzN38RDVgtIZVlLJG54Dk9w/v9UHNqeNU2fsqy2p3xX8m5ZrI+gCU5ziIeAOx7QJ72G0sZlgCH39RQTALGjD6WvFtSZN/KN9aRX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756339219; c=relaxed/simple;
	bh=KSww82SZBA+lEYAy6bmPkw4csTCsIM3F9qv0kkKQK84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZJR04clt8elypUmDoGi7/YSAYWhRgpqDf3sGTuf6prG8PMIeKNsBJP807AUikVVtoL8as5pJ6MVsEqYU1a7FTKfnGkgU2jAO65g2D8XyKn3UnY1H/bQaML+RAqdM19NwTvepBUhZCBuQ+hs/0GrJFllrq28StkhvoNFUlwX3Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVbPPPWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A793C4CEEB;
	Thu, 28 Aug 2025 00:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756339219;
	bh=KSww82SZBA+lEYAy6bmPkw4csTCsIM3F9qv0kkKQK84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fVbPPPWzHDKnPghCUXUn0VKieFz/ONW3b0f25VxRoxeyJx9IE7stuZi/fPRb9EuHM
	 2IEdJE3yWjJ5BZdD0Dmd/sY+4zdtKxwBXzdFUPm0BV/C+RwF2ImnJMw6C5w7rSjjQG
	 Xl0oYWTYx9mo1Ratb1EVI5LGG3Wm5NndLU5AeUNJBfpLhe9p5s76LuRMuEBLae1t8Z
	 zO2M93ks3ocYQuuEWswtLbI50myu6JnS1q2fs0gizGMHWClFjfsTT1EHP4HN+kIwKv
	 lU/tvr+QMjM0DK16vYJMDp5vDfzHwBM1hdBwKnOzmvScIolPWN1agOOvVyxx1EWYUO
	 t1DJw8mdalmfg==
Date: Wed, 27 Aug 2025 17:00:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 richardcochran@gmail.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
 xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 Frank.Li@nxp.com, shawnguo@kernel.org, fushi.peng@nxp.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v6 net-next 04/17] ptp: add debugfs interfaces to loop
 back the periodic output signal
Message-ID: <20250827170017.455aa59f@kernel.org>
In-Reply-To: <20250827063332.1217664-5-wei.fang@nxp.com>
References: <20250827063332.1217664-1-wei.fang@nxp.com>
	<20250827063332.1217664-5-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Aug 2025 14:33:19 +0800 Wei Fang wrote:
> ---
> v6 changes:
> 1. New patch
> ---

Please drop this patch and patch 17 from the series.
This one because it's controversial, and 17 because it's not for
net-next. This way you'll be under the limit of 15, per:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pw-bot: cr


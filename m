Return-Path: <netdev+bounces-200896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C54EAE7420
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 03:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEC117E4F4
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 01:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADD5126F0A;
	Wed, 25 Jun 2025 01:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4iiJiki"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D301F1E4BE;
	Wed, 25 Jun 2025 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750813905; cv=none; b=mUUEzI0DiP/0mWHWKhR4TnACF5w/CgVw6tFBiaWaC0YEUxPtw6um7HYyrcRt9u5hZTguJzuVmGefaIeVqAS7Dso5zP46cbZSt7NgpOg6DiHWfpJ6xx9M4jBvLMMk4euWmT1dHrC14zYSFMBalBwl1VfRkzeaSOgWf8qActBcMF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750813905; c=relaxed/simple;
	bh=J7mskIOl6mooDicAfCx/bLYXvIrbA0wCKKMXKC4Ob4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9sayPDbzDpCFZu9tg/6KHw5NYPYyjtm9dxrmUJ26WsPnrr7Gk7GtZ6tzOe2iqgIAvFnzmfDcIrU3/zNbn4w26cBmJNpJvHvGiTwDDX0P8jwvWE6keGyKWppSauO3j3ddo2cttKkIgiZ3ylZN5HxrdRjKjeR55bRAmhqfw0UYdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4iiJiki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E83C4CEF0;
	Wed, 25 Jun 2025 01:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750813905;
	bh=J7mskIOl6mooDicAfCx/bLYXvIrbA0wCKKMXKC4Ob4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U4iiJikiRVIDFHdX3jSVgsKA0BadcI31/tXpsbHSG0/GavRjf+XHhUiIjOWtHsDRE
	 MNfKUvablXbnnyGk9cSAdL+fj2yxpzp8HcPc+di2aN/7thWaDY1yq/JJhAjgEhTp+C
	 Am5/1IPsgkKixGYXeoHb25OwtR+4P660BhbxyrtqdaZIHV1r1cK9fpn+fiplFY03z+
	 lfAb+sUaVBvZEf+LkjY3u32vZhMD/v6dKyk5D558s01uTAmJaJtN8KljEOX4E0abxK
	 qJnCxr7AmYfSKiREKVBYdbhAs1LWToL1uXLcbXNj4xPhkGoKlMYG2h5Xf22sDVONz+
	 FwrvZb0lEk9kQ==
Date: Tue, 24 Jun 2025 18:11:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 net-next 0/3] change some statistics to 64-bit
Message-ID: <20250624181143.6206a518@kernel.org>
In-Reply-To: <20250624101548.2669522-1-wei.fang@nxp.com>
References: <20250624101548.2669522-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Jun 2025 18:15:45 +0800 Wei Fang wrote:
> The port MAC counters of ENETC are 64-bit registers and the statistics
> of ethtool are also u64 type, so add enetc_port_rd64() helper function
> to read 64-bit statistics from these registers, and also change the
> statistics of ring to unsigned long type to be consistent with the
> statistics type in struct net_device_stats.

this series adds almost 100 sparse warnings
please trying building it with C=1
-- 
pw-bot: cr


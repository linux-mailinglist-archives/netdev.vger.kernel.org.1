Return-Path: <netdev+bounces-70165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E993F84DE58
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 11:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2653F1C20A08
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 10:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F15954645;
	Thu,  8 Feb 2024 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPScYLK4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3BC4205A
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388288; cv=none; b=oOlimcpATXR/9yswZoHIRKLe9bNi5XWksL6CK+9GI2Qv/tnxcGm6CXkZFKKffm930t2GFKXKfSmmo8rXwjj6/yumdP7na63D6+ZsphUeUM6L9lg3ZNQF6jFzm68H5SSPcOZi67VmfwnWIZ9j7YKYfwjTzh1gDx73UjMJP/ep7JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388288; c=relaxed/simple;
	bh=J3kUvtKJLI54FTDZhtMVHM65tPP1r+hVENBOLqWG4B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvKkY0wXUFTCJC5h0glTdApvoTSGIu69KQ14QpWGuA5OGuZ9hY6N5cZrYDok7frb9N44hRyr641FICLCiVAAfGk5YzolGV3xXlsQdPxbWhgkQbjncI/tSX5KiJiKlOnUpF+jmSus/KuaIqDiznOwj6wEmoWc/JSMW4IzMMUOXf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPScYLK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4186C433F1;
	Thu,  8 Feb 2024 10:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707388287;
	bh=J3kUvtKJLI54FTDZhtMVHM65tPP1r+hVENBOLqWG4B0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BPScYLK4AKJcAJSnajFKv1jInM81T6HYCbMC4A77HbXzV0V32xIpZCEqWaPBScHUi
	 mrRPau2Nxb6XGE0rUmN4m3Th/UAH07awr6D2ksBk3rlnbfx8Px9KDebafwf1h+EEex
	 jXSowFCv6Bu15qui1AaYdqueXvyFqB048UlYOFIFHLAcGZIQNs8IsiQgjv5pw06kAb
	 wRPI/J/kTObD6V/Q50+V9EQLHycvcxxmbJ+PgkOFaut+SSWtlKmSYJiEeOVOegM62z
	 yK6a66OLyDt0TGmH6ft61BXYdI8Si0ZO0bgXKVQ3c+NTCl5ooMu2jVFMuhHfafIFqs
	 Bg4T68o9DMykQ==
Date: Thu, 8 Feb 2024 10:31:23 +0000
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next 2/2] net: dsa: tag_sja1105: remove "inline"
 keyword
Message-ID: <20240208103123.GE1435458@kernel.org>
References: <20240206112927.4134375-1-vladimir.oltean@nxp.com>
 <20240206112927.4134375-2-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206112927.4134375-2-vladimir.oltean@nxp.com>

On Tue, Feb 06, 2024 at 01:29:27PM +0200, Vladimir Oltean wrote:
> The convention is to not use the "inline" keyword for functions in C
> files, but to let the compiler choose.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>



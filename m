Return-Path: <netdev+bounces-171247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9DAA4C240
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 14:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5163B1712B2
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 13:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4B22116EE;
	Mon,  3 Mar 2025 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/3Va+tq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C581EFFB4;
	Mon,  3 Mar 2025 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009335; cv=none; b=Jc026IRQgwuuyul0KxosuSNJ7dhfLF2LPMstUnHrG1ZxLUjz5V57mAK2D4TDHsaxzHNFy9AvA9qI2LaVN538LdfxAEAjzZTQFNPCSUpvwwaBfl7bwC8mDHLT1SBu4jsN+uMbYoOtsKceFkxrxkmxomZgxF9lFBoorEvtguzS8xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009335; c=relaxed/simple;
	bh=+x1M0xAUI4i6rAatwBpVulw/4Yee7AfTm/reCel12kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaoJq+a5By/MA5dgzObWuX7s/VSaUJYdJTb6bgy83OkAfyU5AapCs6f5xvj1izUhhdwIeBMKJe8ZixWLqul74oSreHx+AxNIVya+UhnyTuQozdmRdjGsP3uerMkzd1S+iDBR3XWJrkGd0tbQ5KvJzhOc5CT+0IOB4Gbnys/Re6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/3Va+tq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047F0C4CED6;
	Mon,  3 Mar 2025 13:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741009334;
	bh=+x1M0xAUI4i6rAatwBpVulw/4Yee7AfTm/reCel12kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/3Va+tqsKURLRutURqRLBVl02bfAmE7iHrtGF7WMJiNUwLhJa+bVlcydar2210jE
	 12a3bOgqHwzYuXRPpzirSZzwt7958Ko1HzV4PyIYLNSbCEBZx9ZWlXjqEBeBDKO9h7
	 /0bL6T0JRy6kKjLYJCfsyvMCBomt/xVw2Hr6hPyDSs5q2IsDqyNme1IA2sJ1K8WMRe
	 iNlwaPd4jyh/dlqN3fHgEz5Uxunmv9/xgx2N5fRq9cYUNyD+roSWIbrL0KdyBHqV0A
	 YWH0kSdrL+ZSNX5/jtYSXDAuSrCcWwGCLOJBk8JigpBETC1TsUeKJEIwn8ltiIonLw
	 tL7Mo9HQzQeWA==
Date: Mon, 3 Mar 2025 13:42:09 +0000
From: Simon Horman <horms@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Meghana Malladi <m-malladi@ti.com>, Diogo Ivo <diogo.ivo@siemens.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next] net: ti: icssg-prueth: Add ICSSG FW Stats
Message-ID: <20250303134209.GU1615191@kernel.org>
References: <20250227093712.2130561-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227093712.2130561-1-danishanwar@ti.com>

On Thu, Feb 27, 2025 at 03:07:12PM +0530, MD Danish Anwar wrote:
> The ICSSG firmware maintains set of stats called PA_STATS.
> Currently the driver only dumps 4 stats. Add support for dumping more
> stats.
> 
> The offset for different stats are defined as MACROs in icssg_switch_map.h
> file. All the offsets are for Slice0. Slice1 offsets are slice0 + 4.
> The offset calculation is taken care while reading the stats in
> emac_update_hardware_stats().
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Simon Horman <horms@kernel.org>



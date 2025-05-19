Return-Path: <netdev+bounces-191531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C96BABBD67
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 14:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BABC83BBBB6
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983FB27603D;
	Mon, 19 May 2025 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ol4GBUuX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730F01C683
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747656838; cv=none; b=q8lnI3sVHjm2dnJ971EFp6iHFkJbfigeqYEnH6gCwc4aeXJvL0LIfTi40Udk9yPdj9rJzh736TuWumpKgm7vh0QPGK+PAFG52AIIWnLhOX+1cDvWwh/pDa4XhxHLAG2KmVAb/rzpYFBzzD0vTyuHc4pHftg3ZzsqesIHyRhGo74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747656838; c=relaxed/simple;
	bh=f23eUtT7BEUA7/nRp9QvcwG51LrVKaiTyUgVJZIeJsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsTo0SR+wGGqrLcnZSH8OAfGwO985AWbByXkNR8e3QOA70Z0e5dOZiQ6r8hFXtoqoXT/GNIii2/57ZviN1tSz6qKa4OouNsMljwHDakmI49/3ewsFD8cZsdgMtvDmmYr/huTED+Djj9/RxovfnJ66LAWDVxHvVVTWY/RBVcULT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ol4GBUuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD9FC4CEE4;
	Mon, 19 May 2025 12:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747656837;
	bh=f23eUtT7BEUA7/nRp9QvcwG51LrVKaiTyUgVJZIeJsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ol4GBUuX5cs+yypqjzDTvI3hT5PWV7jWmATikdbSM/bjN5ivwqom0uOTRZj8F7lsP
	 Gl2haMmESPnp3/vUIMl+Q0i+Sq7U9nfXvifBwKKbRKW1ZWkCi3gmZmHv/VBCwrnoF2
	 ULP8tcmf/zEwYk1xHvv+IaXVSqm5fjLcu+qtWs8Ulrm+QMEM1FzAAglsCQNoSF8r1U
	 X/pS7HJQPojUt89f5hocTfyyAbrVcJdMCTEWEt7j2YoQ0WDYufDyZP7LyQp0facjEQ
	 Q578vBREYq48EL5lNSZSEyEUCAJnCcYyXSH0pgGL01jT1+Rjxpv+Z5vFSykbOtsscZ
	 HbffsaY+LZiEw==
Date: Mon, 19 May 2025 13:13:54 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: airoha: ppe: Disable packet
 keepalive
Message-ID: <20250519121354.GH365796@horms.kernel.org>
References: <20250516-airoha-en7581-flowstats-v2-0-06d5fbf28984@kernel.org>
 <20250516-airoha-en7581-flowstats-v2-3-06d5fbf28984@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516-airoha-en7581-flowstats-v2-3-06d5fbf28984@kernel.org>

On Fri, May 16, 2025 at 10:00:01AM +0200, Lorenzo Bianconi wrote:
> Since netfilter flowtable entries are now refreshed by flow-stats
> polling, we can disable hw packet keepalive used to periodically send
> packets belonging to offloaded flows to the kernel in order to refresh
> flowtable entries.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>



Return-Path: <netdev+bounces-173012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD84AA56E24
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400E73AA845
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A2723ED75;
	Fri,  7 Mar 2025 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlA/2tTf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3415223E35F;
	Fri,  7 Mar 2025 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365601; cv=none; b=Pxi4ccDc8QUulnLuWYBxMO8yu8vQJO3sHcO4Jbz9fz8+qNCUvjOYZKuIgYphfYfE8g8YN85YHSWz+3je0ImKMFmnldUMyi8LEk56MkKll9/OMtu4vEJkvL7m7WeAN7IH/toqyqm9NclCFLC3htxHjE8xZ27K8xLgKSaVFI7QTIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365601; c=relaxed/simple;
	bh=HOeJpd1r+tua3PHtEh6C8x0ozDENLgAh0S3dq7OosLc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ld6CH5Ad4Gj3lqR3LJqdD60zRiM6q763k60Si1LLFwSgfEE/4q1zOklM8wq/bhCPKDZiSar4ZldSkXjnpoM2bBtxIxao+WLwI0kYsrlcIl98ICrj2Fp37s16sDjHxbdaSBEwpVBFnVFV5oMn09ZSccwKnqW/HIp+SWdafEjR4WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlA/2tTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADB6C4CED1;
	Fri,  7 Mar 2025 16:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741365600;
	bh=HOeJpd1r+tua3PHtEh6C8x0ozDENLgAh0S3dq7OosLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HlA/2tTf49Drh9dXoRuX4+ksLB0ISVkvOod9RvdmQMyAiFTikLxbVABO5cI+KhZ6+
	 /yo7hwScdT7/+NiRTQt8gSjN9+h1nXclYB/sy68vJmxmQsS4yg0YyPJU4ld+Cb7O6H
	 5iiym06QWuGMruMU4kug65VmbU7/QNCL+cdwqmu7YkMuO3iEeLwqvQWUDce66hbt1F
	 r+4hleY9aa1viPBbcx1WYlg6mZ9ieQufN8m4i9l8l1cPN6jny0xAtq99DawzUCfFLJ
	 tlRMtH6PEAXztFhtXfPCGDVACS7QoVtoFSe84hzEQbkQAex5AIHjWvyYrFRIy8ksr0
	 T2d7l4acdNG6w==
Date: Fri, 7 Mar 2025 08:39:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Meghana Malladi
 <m-malladi@ti.com>, Diogo Ivo <diogo.ivo@siemens.com>, Lee Trager
 <lee@trager.us>, Andrew Lunn <andrew+netdev@lunn.ch>, Roger Quadros
 <rogerq@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Simon Horman
 <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>
Subject: Re: [PATCH net-next v2] net: ti: icssg-prueth: Add ICSSG FW Stats
Message-ID: <20250307083959.33098949@kernel.org>
In-Reply-To: <3931a391-3967-4260-a104-4eb313810c0d@ti.com>
References: <20250305111608.520042-1-danishanwar@ti.com>
	<20250306165513.541ff46e@kernel.org>
	<3931a391-3967-4260-a104-4eb313810c0d@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Mar 2025 16:00:40 +0530 MD Danish Anwar wrote:
> > Thanks for the docs, it looks good. Now, do all of these get included
> > in the standard stats returned by icssg_ndo_get_stats64 ?
> > That's the primary source of information for the user regarding packet
> > loss.  
> 
> No, these are not reported via icssg_ndo_get_stats64.
> 
> .ndo_get_stats64 populates stats that are part of `struct
> rtnl_link_stats64`. icssg_ndo_get_stats64 populates those stats wherever
> applicable. These firmware stats are not same as the ones defined in
> `icssg_ndo_get_stats64` hence they are not populated. They are not
> standard stats, they will be dumped by `ethtool -S`. Wherever there is a
> standard stats, I will make sure it gets dumped from the standard
> interface instead of `ethtool -S`
> 
> Only below stats are included in the standard stats returned by
> icssg_ndo_get_stats64
> - rx_packets
> - rx_bytes
> - tx_packets
> - tx_bytes
> - rx_crc_errors
> - rx_over_errors
> - rx_multicast_frames

Yes, but if the stats you're adding here relate to packets sent /
destined to the host which were lost you should include them
in the aggregate rx_errors / rx_dropped / tx_errors / tx_dropped.
I understand that there's unlikely to be a 1:1 match with specific
stats.

> > This gets called by icssg_ndo_get_stats64() which is under RCU   
> 
> Yes, this does get called by icssg_ndo_get_stats64(). Apart from that
> there is a workqueue (`icssg_stats_work_handler`) that calls this API
> periodically and updates the emac->stats and emac->pa_stats arrays.
>
> > protection and nothing else. I don't see any locking here, and  
> 
> There is no locking here. I don't think this is related to the patch.
> The API emac_update_hardware_stats() updates all the stats supported by
> ICSSG not just standard stats.

Yes, I'm saying you should send a separate fix, not really related or
blocking this patch (unless they conflict)

> > I hope the regmap doesn't sleep. cat /proc/net/dev to test.
> > You probably need to send some fixes to net.  
> 
> I checked cat /proc/net/dev and the stats shown there are not related to
> the stats I am introducing in this series.

You misunderstood. I pointed that you so you can check on a debug
kernel if there are any warnings (e.g. something tries to sleep
since /proc/net/dev read is under RCU lock).

> The fix could be to add a lock in this function, but we have close to 90
> stats and this function is called not only from icssg_ndo_get_stats64()
> but from emac_get_ethtool_stats(). The function also gets called
> periodically (Every 25 Seconds for 1G Link). I think every time locking
> 90 regmap_reads() could result in performance degradation.

Correctness comes first.


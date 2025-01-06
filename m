Return-Path: <netdev+bounces-155410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97BBA02476
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49BD13A2FB2
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 11:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215501DAC9A;
	Mon,  6 Jan 2025 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBhJPTW0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADD11D6182;
	Mon,  6 Jan 2025 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736163788; cv=none; b=iqBhVGTQiVeYL4TaqsavGl1gENhaSfV0ZTv3/ARZBAg5zgztEGig+tU8ogMDbcetJKVQKxwMr7AoZAH0LK/EWxoi/9nOu0jdFSluBPcAfOJjIbwU2/gD3E95QUYDCGhKyLmeOnd1WuVsZBL/cApPc1mLXvB/IctN75KPWGTleyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736163788; c=relaxed/simple;
	bh=JvkP9mKcxBWVEDPrahfv8JaLjHl0dGLATypCidOU4NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxISLvsA/c9KU1ZIDkLHv8SadbQIsjYVpKOxLUsqL3wCHGx4qnK1UDlTBapSAoy0sPxbvVrI393SrgcjZbAl5+sQrsXeO7EVCMazLCe9Ao8quN1biKQqVYrv7eTf/pIqJf79kebOoGpMCffusrlM5aslLIOSyALM2X3gmuNgOik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBhJPTW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42749C4CED2;
	Mon,  6 Jan 2025 11:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736163787;
	bh=JvkP9mKcxBWVEDPrahfv8JaLjHl0dGLATypCidOU4NQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MBhJPTW0CDQxnA3BHJLvvh2qVGPF22XHxUM/79Zg4Pk3gIhIiYrmMWJbXhowN7O86
	 4drGC/NcU5FLRgcOJgA14GorIbBcoBPtBjFRTLYie56uR4OYBg2soAuvPiBuWppfWv
	 Acsl8qTRP/yA1oOH0tux0jW3aR1yT7/lCS2K3L18BjUwMFzgnhNrh+DPMRnEnR4/s5
	 54WYEXDZUoI3pjIqnXkqL51M2bPIPcj3/xRmKoeTNpMCU0jRlOSeLbXXHv2d1X/9SK
	 ZqzMPKlFYV1J7Bigk43XRB5EYbAg7/DmR8u2Zp//OTpx6yoP35BdEwv+Pau81RSEEp
	 H+OyzphstWm7w==
Date: Mon, 6 Jan 2025 11:43:03 +0000
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 1/9] i40e: Deadcode i40e_aq_*
Message-ID: <20250106114303.GD4068@kernel.org>
References: <20241221184247.118752-1-linux@treblig.org>
 <20241221184247.118752-2-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241221184247.118752-2-linux@treblig.org>

On Sat, Dec 21, 2024 at 06:42:39PM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> i40e_aq_add_mirrorrule(), i40e_aq_delete_mirrorrule() and
> i40e_aq_set_vsi_vlan_promisc() were added in 2016 by
> commit 7bd6875bef70 ("i40e: APIs to Add/remove port mirroring rules")
> but haven't been used.
> 
> They were the last user of i40e_mirrorrule_op().
> 
> i40e_aq_rearrange_nvm() was added in 2018 by
> commit f05798b4ff82 ("i40e: Add AQ command for rearrange NVM structure")
> but hasn't been used.
> 
> i40e_aq_restore_lldp() was added in 2019 by
> commit c65e78f87f81 ("i40e: Further implementation of LLDP")
> but hasn't been used.
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Simon Horman <horms@kernel.org>



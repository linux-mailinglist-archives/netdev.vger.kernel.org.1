Return-Path: <netdev+bounces-233498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37287C14786
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 12:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1D61982EBB
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 11:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDF430DD31;
	Tue, 28 Oct 2025 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOK34LRG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E6029B8DC
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652169; cv=none; b=UBl2cspQw5FlFSpu7BJJkVLqGEs1fjVUQvlWHUVTBcV9MbdEQaJBwIBrfnlgtEXEMjaV8YNJVOuWw6YHnWbM/7FMHHobuaPcfySz31kd2XYwNd3Ngkg0rRzcoILlJkpT1F3GaY9wZ8+ceoPxWPcZ1JWj/Z41wdYI6luSqUMYq5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652169; c=relaxed/simple;
	bh=JmqcCi+GOwJI9weQpXLYFTgQXGBYVITGNtQadOF6pPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYgnl01Knbk488mgDpoklnR4wD5xU+AqxHlxWAEjP7k7g6r3yeC/Q2HETp4OBR1iU3/gTae1YWRGxCdyDIoDpgK6GFNt5Lg8ok4sN9D7a5U9wC9DiB9DCE9vcCoBfuecQTH06kfhXjuIZBUdEkKwddnpSb157g57s6FzeLcQ1WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOK34LRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04417C4CEE7;
	Tue, 28 Oct 2025 11:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761652168;
	bh=JmqcCi+GOwJI9weQpXLYFTgQXGBYVITGNtQadOF6pPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oOK34LRGnCMqUglM2hkkkCqZABMvjePIM8cH4mbKXDY20x2UVK1qn8K1SalmSSLkw
	 FkRrFsPaXjo3JWWk0bjaR8WFvp3cDZpCbaH30Y+6idGPHxkzqepAkI4E4Lz9SPQ1Uy
	 dChwmYlLrzc3NOg5tUsLTh47pbU2OK6GsEGqCwiZcCIy68NoIdPQ/ZEUOj2mdgCfjm
	 tOH3oOHYHxhZuw2PuWrEb3F24tKzJppfK7N8KTIS6AmtDLihp9iITCY678+4EJaVT/
	 xdmtUyPmlwDkPCzAGWg0JFSAItT5B1KKGQMUad+ppQFMyKp6G6OqzORINA1r7pf2Xq
	 1FZskvf0cgdvg==
Date: Tue, 28 Oct 2025 11:49:24 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Dan Nowlin <dan.nowlin@intel.com>, Qi Zhang <qi.z.zhang@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: Re: [PATCH iwl-next v7 5/6] ice: Extend PTYPE bitmap coverage for
 GTP encapsulated flows
Message-ID: <aQCtxIJiuVADyc1R@horms.kernel.org>
References: <20251027093736.3582567-1-aleksandr.loktionov@intel.com>
 <20251027093736.3582567-6-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027093736.3582567-6-aleksandr.loktionov@intel.com>

On Mon, Oct 27, 2025 at 10:37:35AM +0100, Aleksandr Loktionov wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Consolidate updates to the Protocol Type (PTYPE) bitmap definitions
> across multiple flow types in the Intel ICE driver to support GTP
> (GPRS Tunneling Protocol) encapsulated traffic.
> 
> Enable improved Receive Side Scaling (RSS) configuration for both user
> and control plane GTP flows.
> 
> Cover a wide range of protocol and encapsulation scenarios, including:
>  - MAC OFOS and IL
>  - IPv4 and IPv6 (OFOS, IL, ALL, no-L4)
>  - TCP, SCTP, ICMP
>  - GRE OF
>  - GTPC (control plane)
> 
> Expand the PTYPE bitmap entries to improve classification and
> distribution of GTP traffic across multiple queues, enhancing
> performance and scalability in mobile network environments.
> 
> --
>  ice_flow.c |   54 +++++++++++++++++++++++++++---------------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)

The four lines above seem out of place.
And as git truncates the commit message at the ('--')
the tags below are missing in it's view of the world.

> 
> Co-developed-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> Co-developed-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Co-developed-by: Jie Wang <jie1x.wang@intel.com>
> Signed-off-by: Jie Wang <jie1x.wang@intel.com>
> Co-developed-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

...


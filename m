Return-Path: <netdev+bounces-116889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B7F94BFC5
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AAD8B24820
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC8C18E756;
	Thu,  8 Aug 2024 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoJ3ztLW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E4518C92D;
	Thu,  8 Aug 2024 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128056; cv=none; b=QVxzKrnbj83DKZ/bXXYrAK6mQDqZsFGtODpEG3nRQ9ObIcYGT9u3NBduUXKB6oMw3WAZWwELRZBdJJhlPzdvIWWlNAMF4TLtIFfuNOva02FXKYt4PVbW9P7GoslB8enEk71YGHlSpbzr1hM3WCskb6ziTDFsEbTQzB2QGjeCXBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128056; c=relaxed/simple;
	bh=jO6BXL2j1BdyKTYSfTIpsKgtUG5vv/FpcTckPRUbbTI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cugJIvJ7Y9jXQqc3EjuzwMKKt1lIMXX70VESt6WoMq84XnzphN0ZZ5XWQahwJIeJjpQuRZieJWS7XeGysr3Zx2/PD1K7NVNUD9xejCzIKD95UgMLnyeZMJm6Q4+y7aBEaLXF00iyA1bwCPpyzsbGbgPoLEjf0CDNxHoRPUzZxYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoJ3ztLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04920C4AF0C;
	Thu,  8 Aug 2024 14:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723128055;
	bh=jO6BXL2j1BdyKTYSfTIpsKgtUG5vv/FpcTckPRUbbTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SoJ3ztLWM3BeqN2GCWUg3hDTjicK2R8Q/EUZpUA8Sz3eY9pbyaQPGWpI+rZDpgoiZ
	 eqijti5T7PKQlXgzio5z7T8G79PmrRs9cGTBmoOizPeQZo1i5cVVgdJIiW/6tNqsIq
	 cbFUvMwtDGDOXc9vECfD30EyZXhcQJcN4uSTDQRcZJDPFapEInvp51a+U05rSFpP4s
	 HM9FN/2cVGrG19Siit4iO130QSpYkOvfkV2SbaTTYRXLPN+eQpLqsVlmOz3LPIeXPU
	 rElRlZNBbz8AV2wQWK2/kzChymY8odpRWEUWgrsCQVjcLN/lIw/NLhi8kMM0JO4xNm
	 Mx1r5x7qh9T7w==
Date: Thu, 8 Aug 2024 07:40:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Cc: Geethasowjanya Akula <gakula@marvell.com>, Jiri Pirko
 <jiri@resnulli.us>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>, Subbaraya
 Sundeep Bhatta <sbhatta@marvell.com>, Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [EXTERNAL] Re: [net-next PATCH v10 00/11] Introduce RVU
 representors
Message-ID: <20240808074054.21e7abc6@kernel.org>
In-Reply-To: <BY3PR18MB473740348BD4FF7241E79C27C6B92@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240805131815.7588-1-gakula@marvell.com>
	<20240807194647.1dc92a9e@kernel.org>
	<BY3PR18MB473740348BD4FF7241E79C27C6B92@BY3PR18MB4737.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Aug 2024 11:30:29 +0000 Sunil Kovvuri Goutham wrote:
> >I can't bring myself to apply this.
> >Jiri do you have an opinion?
> >The device is a NPU/SmartNIC/DPU/IPU, it should be very flexible.
> >Yet, instead of just implementing the representors like everyone else you do your
> >own thing and create separate bus devices.  
> 
> Can you please elaborate what you mean by "create separate bus devices"

You have a separate PF (on top of the existing "AF" PF) which doesn't
have any datapath port of its own.

> Just to clarify we are not creating separate bus devices for representors perse.
> On our HW, there are multiple SRIOV PCI devices.

As in SR-IOV-capable PFs?

> We are using one of those PCI devices (pci/0002:1c:00.0), to attach required hardware resources to it, for doing packet IO
> Between representors and the representees. Once the HW resources (Rx, Tx queues) are attached to it 
> we are registering multiple netdevs from this ie one rx/tx queue for one representor.
> Beyond that there are no other bus devices being created/used.

What port is used for communication to the host and the uplink?
We're on v10 and I keep asking for documentation showing the system
topology.


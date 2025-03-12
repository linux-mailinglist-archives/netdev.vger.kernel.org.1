Return-Path: <netdev+bounces-174248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C778BA5DFD8
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 16:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AFFE16C65D
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 15:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C1E24FC0D;
	Wed, 12 Mar 2025 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYJ/bcnz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD39A142659;
	Wed, 12 Mar 2025 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792243; cv=none; b=P3wu5m8ViVakCmc5MyG+H1VQh1CVuz8ZuaIACast9Ioa10WayYYiexYH0AVTdRyGAlaBB51wasegvAaUExLAz3hSBc0hnoaRrgNkMrWg5a3ZGug8rlXi8XlqBiJePAjE9AtQXmRPEAa0afgI3uhV61n+72TDM/fXb9rJ8DnYpoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792243; c=relaxed/simple;
	bh=feyOgx8IA2ysiNd2yFBWWhwxIJoait0rEV2rixVlKQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJmrRfTnvE0YBFurq1iCMUreQC/VL/jlB/qOKMZ/LrSnfKYGgSGaeYRlTr9aLXCY4BhNrmux6fCG2yjtL1jPJsPDf4sX7FrGygWy6UTx+i4H+R/h/PLPG8WKAD9whGYgt6I+ztUs/UmrpIbCWuL4CFOfMgLdNQNaqY+j2rLMKF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYJ/bcnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A89C4CEDD;
	Wed, 12 Mar 2025 15:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741792242;
	bh=feyOgx8IA2ysiNd2yFBWWhwxIJoait0rEV2rixVlKQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cYJ/bcnzu87KHde0Gkwx+VRElazIxRdAUPV6Twztq8Ov3Mm6aNYxPHSeO7U+lCXjd
	 ZOOwE+MayuIMQGTyEvU8A839PQXSfGha2CAyWUkWF9cfrvEf+eGNYp7sTQ7TGoad3K
	 bVJUxe3TVYDTw3nec/Ooi5YKfSchH+lLf4SvAMd3fq2nQaKuDtqPll5MOjrM1yG9cH
	 XKsNNGRW2Ys1ma+D6fJ1kooDE8nqNImpqDjDwrODU3nbIrK24BDLEERQn6tL0PUiG+
	 k3Fp7nDX8qg3gbnBHUbl0l4J9I8c7Q96+6udbYf2oMQFJIEsrMZzJZM4BxPhAzCRlH
	 UG1v65rJUY2EA==
Date: Wed, 12 Mar 2025 17:10:37 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Nikolay Aleksandrov <nikolay@enfabrica.net>
Cc: netdev@vger.kernel.org, shrijeet@enfabrica.net, alex.badea@keysight.com,
	eric.davis@broadcom.com, rip.sohan@amd.com, dsahern@kernel.org,
	bmt@zurich.ibm.com, roland@enfabrica.net, winston.liu@keysight.com,
	dan.mihailescu@keysight.com, kheib@redhat.com,
	parth.v.parikh@keysight.com, davem@redhat.com, ian.ziemba@hpe.com,
	andrew.tauferner@cornelisnetworks.com, welch@hpe.com,
	rakhahari.bhunia@keysight.com, kingshuk.mandal@keysight.com,
	linux-rdma@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Message-ID: <20250312151037.GE1322339@unreal>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250308184650.GV1955273@unreal>
 <2f06a40d-2f14-439a-9c95-0231dce5772d@enfabrica.net>
 <20250312112921.GA1322339@unreal>
 <86af1a4b-e988-4402-aed2-60609c319dc1@enfabrica.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86af1a4b-e988-4402-aed2-60609c319dc1@enfabrica.net>

On Wed, Mar 12, 2025 at 04:20:08PM +0200, Nikolay Aleksandrov wrote:
> On 3/12/25 1:29 PM, Leon Romanovsky wrote:
> > On Wed, Mar 12, 2025 at 11:40:05AM +0200, Nikolay Aleksandrov wrote:
> >> On 3/8/25 8:46 PM, Leon Romanovsky wrote:
> >>> On Fri, Mar 07, 2025 at 01:01:50AM +0200, Nikolay Aleksandrov wrote:
> [snip]
> >> Also we have the ephemeral PDC connections>> that come and go as
> needed. There more such objects coming with more
> >> state, configuration and lifecycle management. That is why we added a
> >> separate netlink family to cleanly manage them without trying to fit
> >> a square peg in a round hole so to speak.
> > 
> > Yeah, I saw that you are planning to use netlink to manage objects,
> > which is very questionable. It is slow, unreliable, requires sockets,
> > needs more parsing logic e.t.c
> > 
> > To avoid all this overhead, RDMA uses netlink-like ioctl calls, which
> > fits better for object configurations.
> > 
> > Thanks
> 
> We'd definitely like to keep using netlink for control path object
> management. Also please note we're talking about genetlink family. It is
> fast and reliable enough for us, very easily extensible,
> has a nice precise object definition with policies to enforce various
> limitations, has extensive tooling (e.g. ynl), communication can be
> monitored in realtime for debugging (e.g. nlmon), has a nice human
> readable error reporting, gives the ability to easily dump large object
> groups with filters applied, YAML family definitions and so on.
> Having sockets or parsing are not issues.

Of course it is issue as netlink relies on Netlink sockets, which means
that you constantly move your configuration data instead of doing
standard to whole linux kernel pattern of allocating configuration
structs in user-space and just providing pointer to that through ioctl
call.

However, this discussion is premature and as an intro it is worth to
read this cover letter for how object management is done in RDMA
subsystem.

https://lore.kernel.org/linux-rdma/1501765627-104860-1-git-send-email-matanb@mellanox.com/

Thanks

> 
> Cheers,
>  Nik
> 
> 


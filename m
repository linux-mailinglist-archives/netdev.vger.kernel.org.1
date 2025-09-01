Return-Path: <netdev+bounces-218608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C102B3D901
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 07:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637EF170F1D
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 05:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EB121C163;
	Mon,  1 Sep 2025 05:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gZPNgVOK"
X-Original-To: netdev@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD041E5B70
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 05:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756705630; cv=none; b=OCLq7oPKsMPQ+u7xui49ScDfirEqIgcvWOFWl64MJ4NkU69AT0TAKWyNmx6Yn3ZYd6vV/mrDTo1u7es0Wtmf+OqeJc7+ACPK6hfjWSuVYpd1/ksgzxgUX5L47/Dyr4ybkGod8AkIXRu+fxPUBCpBtqijqLmYw9VkA63gTQXt3fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756705630; c=relaxed/simple;
	bh=M2DILyXx8L+/IbeSFshz1HYqwkxr2Aiw1uswkEhZIuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QonILFSMIpMSOuxoCl9u9qz/3QfRmlmWUd2qtWaHQk0T+0MFNktfjFYi5M8xbciNU28smA3fyl45qMPKLyBCqDTT111YAWDObLqldXBo79gabSB6fFb2QNf2f0Ejre88OGcjSRBk4e8X1nyT390ltmlLaGD9yCGhePvC3Ci0ap4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gZPNgVOK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 96A702116295; Sun, 31 Aug 2025 22:47:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 96A702116295
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756705622;
	bh=tblBew3GU0jR5Ecb+9P2B0jCfDiwkUaMq8EalZh+LTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gZPNgVOKCvR9FqDuML+vLo9WmheBOy/qrftdvJzN4e5t7Lsz8XuDmNiEJ8a5hiCuf
	 efxRl89L5n16/RSLy+3zMsntRcdXJU2m98VgzmnennNgQpQ7O8/adwl85Jrn3DuP3x
	 9A2FQH8PszkwAv2xmB649X99716smNsneDW9tJqs=
Date: Sun, 31 Aug 2025 22:47:02 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jakub Kicinski <kuba@kernel.org>, dsahern@gmail.com,
	netdev@vger.kernel.org, haiyangz@microsoft.com,
	shradhagupta@linux.microsoft.com, ssengar@microsoft.com,
	dipayanroy@microsoft.com, ernis@microsoft.com
Subject: Re: [PATCH iproute2-next v3] iproute2: Add 'netshaper' command to
 'ip link' for netdev shaping
Message-ID: <20250901054702.GA14068@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1754895902-8790-1-git-send-email-ernis@linux.microsoft.com>
 <20250816155510.03a99223@hermes.local>
 <20250818083612.68a3c137@kernel.org>
 <20250821110607.GC7364@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250825091622.417897ca@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825091622.417897ca@hermes.local>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Aug 25, 2025 at 09:16:22AM -0700, Stephen Hemminger wrote:
> On Thu, 21 Aug 2025 04:06:07 -0700
> Erni Sri Satya Vennela <ernis@linux.microsoft.com> wrote:
> 
> > On Mon, Aug 18, 2025 at 08:36:12AM -0700, Jakub Kicinski wrote:
> > > On Sat, 16 Aug 2025 15:55:10 -0700 Stephen Hemminger wrote:  
> > > > On Mon, 11 Aug 2025 00:05:02 -0700
> > > > Erni Sri Satya Vennela <ernis@linux.microsoft.com> wrote:
> > > >   
> > > > > Add support for the netshaper Generic Netlink
> > > > > family to iproute2. Introduce a new subcommand to `ip link` for
> > > > > configuring netshaper parameters directly from userspace.
> > > > > 
> > > > > This interface allows users to set shaping attributes (such as speed)
> > > > > which are passed to the kernel to perform the corresponding netshaper
> > > > > operation.
> > > > > 
> > > > > Example usage:
> > > > > $ip link netshaper { set | get | delete } dev DEVNAME \
> > > > >                    handle scope SCOPE id ID \
> > > > >                    [ speed SPEED ]    
> > > > 
> > > > The choice of ip link is awkward and doesn't match other options.
> > > > I can think of some better other choices:
> > > > 
> > > >   1. netshaper could be a property of the device. But the choice of using genetlink
> > > >      instead of regular ip netlink attributes makes this hard.
> > > >   2. netshaper could be part of devlink. Since it is more targeted at hardware
> > > >      device attributes.
> > > >   3. netshaper could be a standalone command like bridge, dcb, devlink, rdma, tipc and vdpa.
> > > > 
> > > > What ever choice the command line options need to follow similar syntax to other iproute commands.  
> > > 
> > > I think historically we gravitated towards option 3 -- each family has
> > > a command? But indeed we could fold it together with something like
> > > the netdev family without much issue, they are both key'd on netdevs.
> > > 
> > > Somewhat related -- what's your take on integrating / vendoring in YNL?
> > > mnl doesn't provide any extack support..  
> 
> No YNL integration with iproute adds too much.

Thankyou Stephen and Jakub for the feedback.
After reviewing the discussion,  I will proceed with the next version
of the patch with netshaper as a standalone command.

I appreciate the perspectives shared and will keep YNL in mind for
future work.


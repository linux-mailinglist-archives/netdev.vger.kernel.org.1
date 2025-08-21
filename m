Return-Path: <netdev+bounces-215586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E22CB2F5E2
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 13:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E974B1CC6FA6
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 11:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A28930C34D;
	Thu, 21 Aug 2025 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="okFQX9Ao"
X-Original-To: netdev@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DEF30C36D
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 11:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774369; cv=none; b=XHH1WVweNU6U97DiEK9T3z7oAkgT6midgfeCZNbhRa8K6adnkN87QhbbGQd63Mmq9YLwl1FRIPzwNpiXLfPlpFr4SJ0Orjssf/DTag2tPzgiRND2gtd3QMMv8Z74Gk3FKQj6w8rIUvTL7Efd+82W6IHwA/PWNbAFIieLOB1X9ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774369; c=relaxed/simple;
	bh=YsDIhuRNGE+4/wmy1jjagFktsQcJjYOPZR+VqA5NHPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXVww+4l4nHaj77N9/tdsTCwqK2AAHFEggUangOSoic/BiVYFG4HDZXbR4poNuZW4apEXzp+bacWsHYT6mctA6kW8fEOFyK4W3Dr7nvMVamaHyHcd3cCxKxIyPi3hQINwvJx36fCyZGDkcVMYPS2Hs5lvvsNx2CBG3F94iCkHpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=okFQX9Ao; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 9A02B2115A5D; Thu, 21 Aug 2025 04:06:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9A02B2115A5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755774367;
	bh=9G4yc2KQOR2pELGVXWYSwi9XPpvTxGGAnY0JY469J6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=okFQX9AoqB/n1CeDSDa8P3pmZn97PkPCV3BKM2chfFjyTMLrSX9emfXKcWPnsbVLo
	 5L9UURLP+gWwQZznkt48r9kGMDcGNib91JN4wBMNWR6b5xw7Tpr0RbmoYu/qRUmgEK
	 zPJdlPos261EJsXqVrzBQfg+dv1UfpRMEI2cMZgA=
Date: Thu, 21 Aug 2025 04:06:07 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dsahern@gmail.com,
	netdev@vger.kernel.org, haiyangz@microsoft.com,
	shradhagupta@linux.microsoft.com, ssengar@microsoft.com,
	dipayanroy@microsoft.com, ernis@microsoft.com
Subject: Re: [PATCH iproute2-next v3] iproute2: Add 'netshaper' command to
 'ip link' for netdev shaping
Message-ID: <20250821110607.GC7364@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1754895902-8790-1-git-send-email-ernis@linux.microsoft.com>
 <20250816155510.03a99223@hermes.local>
 <20250818083612.68a3c137@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818083612.68a3c137@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Aug 18, 2025 at 08:36:12AM -0700, Jakub Kicinski wrote:
> On Sat, 16 Aug 2025 15:55:10 -0700 Stephen Hemminger wrote:
> > On Mon, 11 Aug 2025 00:05:02 -0700
> > Erni Sri Satya Vennela <ernis@linux.microsoft.com> wrote:
> > 
> > > Add support for the netshaper Generic Netlink
> > > family to iproute2. Introduce a new subcommand to `ip link` for
> > > configuring netshaper parameters directly from userspace.
> > > 
> > > This interface allows users to set shaping attributes (such as speed)
> > > which are passed to the kernel to perform the corresponding netshaper
> > > operation.
> > > 
> > > Example usage:
> > > $ip link netshaper { set | get | delete } dev DEVNAME \
> > >                    handle scope SCOPE id ID \
> > >                    [ speed SPEED ]  
> > 
> > The choice of ip link is awkward and doesn't match other options.
> > I can think of some better other choices:
> > 
> >   1. netshaper could be a property of the device. But the choice of using genetlink
> >      instead of regular ip netlink attributes makes this hard.
> >   2. netshaper could be part of devlink. Since it is more targeted at hardware
> >      device attributes.
> >   3. netshaper could be a standalone command like bridge, dcb, devlink, rdma, tipc and vdpa.
> > 
> > What ever choice the command line options need to follow similar syntax to other iproute commands.
> 
> I think historically we gravitated towards option 3 -- each family has
> a command? But indeed we could fold it together with something like
> the netdev family without much issue, they are both key'd on netdevs.
> 
> Somewhat related -- what's your take on integrating / vendoring in YNL?
> mnl doesn't provide any extack support..

I have done some tests and found that if we install pkg-config and
libmnl packages beforehand. The extack error messages from the kernel
are being printed to the stdout.

Example 1:
$ sudo ip link netshaper set dev <interface> handle scope queue id 1
speed 15gbit

Error: mana: net shaper scope should be netdev.
Kernel command failed: -1

Example 2:
$ sudo ip link netshaper set dev <interface> handle scope netdev id 2
speed 15gbit

Error: mana: Cannot create multiple shapers.
Kernel command failed: -1



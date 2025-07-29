Return-Path: <netdev+bounces-210790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B54AB14CF7
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 13:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2D0169253
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 11:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3E928C02E;
	Tue, 29 Jul 2025 11:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="V8lC+cFB"
X-Original-To: netdev@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6853E287249
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753788222; cv=none; b=jD0pnEJYyJM0xSAT58QkL1jzqe/IiA8EL8aJ9hdtFBlNT/LJPdyDbfDBB14baZAOY4/PVyrcVRezN8NZoqOWz0b/Wb7DGtUkf6+AbcMZ079FX0h53Rv0Su3Z0jX6/wgolYgWfFJDkrZvlwO/JJY569nGB6FUE40OmnTY4ommn7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753788222; c=relaxed/simple;
	bh=S7twu9PMv5C2776S9Sf6JAJ8VA57i0I+cwV8Nr2jvgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2Y0cW+M9nYT/YlWB6wYEo4MqxI9E3vpm4KKRv7zrQx69U5hxw4kIhy+MFcYv0ePDLEySDcqWKyfi3KH8kKcxOuutM6ZyrNTakbjrlahMV6ADLycX1nO9eYoVP8AltOukJrFsrw3tq/AhqPxUpmPUtJ+I++zSC6553Yznb3dJrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=V8lC+cFB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id E2854211764E; Tue, 29 Jul 2025 04:23:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E2854211764E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753788220;
	bh=E3hJJMzwz5FYOXzGpXF6lWX0lnr6tJOx/1JH4VY1ndw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V8lC+cFB9gVcXGxArmqQMAj5A2VAkoSwtN3rgvg/EZ8aOFu40xijTtxV1Pdp+sq1C
	 dqvbhTwLi8PNTyH6KyytL/Rihso9xHphUTppa98GVq27Boe6YaQ8haONAFoVfGgmGO
	 Gpf4wvfyGdqE5uJoOZ8eRzVepRcYbLcieAQ9peIo=
Date: Tue, 29 Jul 2025 04:23:40 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: David Ahern <dsahern@gmail.com>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org,
	haiyangz@microsoft.com, shradhagupta@linux.microsoft.com,
	ssengar@microsoft.com, ernis@microsoft.com
Subject: Re: [PATCH iproute2-next] iproute2: Add 'netshaper' command to 'ip
 link' for netdev shaping
Message-ID: <20250729112340.GB15902@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1753694099-14792-1-git-send-email-ernis@linux.microsoft.com>
 <796ca41f-37a1-4bdb-9de2-e52a2c11ff49@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <796ca41f-37a1-4bdb-9de2-e52a2c11ff49@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Jul 28, 2025 at 12:15:19PM -0600, David Ahern wrote:
> On 7/28/25 3:14 AM, Erni Sri Satya Vennela wrote:
> > Add support for the netshaper Generic Netlink
> > family to iproute2. Introduce a new subcommand to `ip link` for
> > configuring netshaper parameters directly from userspace.
> > 
> > This interface allows users to set shaping attributes (such as speed)
> > which are passed to the kernel to perform the corresponding netshaper
> > operation.
> > 
> > Example usage:
> > $ip link netshaper { set | get | delete } dev DEVNAME \
> >                    handle scope SCOPE id ID \
> >                    [ speed SPEED ]
> > 
> > Internally, this triggers a kernel call to apply the shaping
> > configuration to the specified network device.
> > 
> > Currently, the tool supports the following functionalities:
> > - Setting speed in Mbps, enabling bandwidth clamping for
> >   a network device that support netshaper operations.
> > - Deleting the current configuration.
> > - Querying the existing configuration.
> > 
> > Additional netshaper operations will be integrated into the tool
> > as per requirement.
> > 
> > This change enables easy and scriptable configuration of bandwidth
> > shaping for  devices that use the netshaper Netlink family.
> > 
> > Corresponding net-next patches:
> > 1) https://lore.kernel.org/all/cover.1728460186.git.pabeni@redhat.com/
> > 2) https://lore.kernel.org/lkml/1750144656-2021-1-git-send-email-ernis@linux.microsoft.com/
> > 
> > Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> > ---
> >  include/uapi/linux/netshaper.h |  92 +++++++++++++++++
> 
> the file in the kernel tree is net_shaper.h? drop it from the patch and
> ask for it to be added to the uapi files when posting the next version.
Yes, netshaper.h is same uapi file as net_shaper.h in kernel tree.
I'll remove this file in my next version.

Shall I mention about adding this file below the Signed-off-by section
in the commit message or create a patch seperately for this file?

Thankyou.


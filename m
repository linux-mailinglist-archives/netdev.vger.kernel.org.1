Return-Path: <netdev+bounces-185977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48335A9C899
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 14:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB9D1B872C7
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 12:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA72235C14;
	Fri, 25 Apr 2025 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="m0/OmJzV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209CC22170B;
	Fri, 25 Apr 2025 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745583112; cv=none; b=dA02FeFy31fO8BBcHV703FSbuGpOIcTijsJlFJYdB7P5/f1vjxJmM35puUQg0e0eKW7uZqBfLFUhn5F0Ix/LBGJkX97bB0nCLVOY6qKZe4tNaP4TckHB2CO4DPmUSZtyylkhMs/m75LqGUdQ92Q2Vg9PHOT7eAlZf0khmqnxE4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745583112; c=relaxed/simple;
	bh=25Gq2pA3kprdCJxS3eq0hR1lrKQfi5uu9mUgXtFY62M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rla3ITJML8V3orcyTvZSi6WC5DN9Nu2BndetOgi8OK/+3LMSklpa8kMnQ5Z0c8JMSLODAf5Kc42/Xnv1MIoxaQ4vqVJ8y/DrVTZCsVTYwyJVBIMjcDhb2DXgmFVNRDV7wZnejq+2W9UWfDJ5JEnXinqhjGB0JqH+pdP3RDCkrKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=m0/OmJzV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CUpdrH/ZFAXHl51ysjVDk22kdqFFa21IA1blC1XUfOo=; b=m0/OmJzVaZQh87A1923YHZEW6W
	fIjBM03gZuCghRoGehvOb724F6xNmO4yqsPDbL3zIjXMhxekHKqGB+iEqgFE6DOZRWxV0zDqzqCKx
	vCSswBaq0M1qhn5G86owpRVgFXMRM9vPbxQYatZjrC0/u1EpKOKpQzr38hLXdUHkZQhM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u8HuB-00AZZb-IM; Fri, 25 Apr 2025 14:11:43 +0200
Date: Fri, 25 Apr 2025 14:11:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Howells <dhowells@redhat.com>
Cc: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Paulo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Is it possible to undo the ixgbe device name change?
Message-ID: <64be8692-ea6a-4f49-9b5c-396761957b81@lunn.ch>
References: <7b468f16-f648-4432-aa59-927d37a411a7@lunn.ch>
 <3452224.1745518016@warthog.procyon.org.uk>
 <3531595.1745571515@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3531595.1745571515@warthog.procyon.org.uk>

On Fri, Apr 25, 2025 at 09:58:35AM +0100, David Howells wrote:
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > Are you sure this patch is directly responsible? Looking at the patch
> 
> I bisected it to that commit.  Userspace didn't change.

As Jakub pointed out, the kernel is now providing additional
information to user space, via devlink. That causes systemd's 'stable'
names to change. The naming rules are documented somewhere.

> > Notice the context, not the change. The interface is being called
> > eth%d, which is normal. The kernel will replace the %d with a unique
> > number. So the kernel will call it eth42 or something. You should see
> > this in dmesg.
> 
> Something like this?
> 
> ... systemd-udevd[2215]: link_config: autonegotiation is unset or enabled, the speed and duplex are not writable.
> ... kernel: ixgbe 0000:01:00.0 enp1s0: renamed from eth0
> 
> or:
> 
> ... systemd-udevd[2568]: link_config: autonegotiation is unset or enabled, the speed and duplex are not writable.
> ... kernel: ixgbe 0000:01:00.0 enp1s0np0: renamed from eth0
> 
> I presume the kernel message saying that the renaming happened is triggered by
> systemd-udevd?

systemd-udevd is not really triggering it. It is providing the new
name and asking the kernel to change the name. To some extent, you can
think of this as policy. The kernel tries to avoid policy, it leaves
it up to user space. The kernel provides a default name for the
interface, but it is policy in user space which gives it its final
name.

	Andrew


Return-Path: <netdev+bounces-185771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8F7A9BB17
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 01:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B841BA33C7
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 23:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C225828CF73;
	Thu, 24 Apr 2025 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tK7c29F5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D1927BF78;
	Thu, 24 Apr 2025 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745536261; cv=none; b=UOKCFlf+pchqxTHfBTCI3QsACoCQ9ppBGegkdLIBsOgd/UaS6rBBl2epPaQFolL+dYWPk4d573OEC3czhoJyi9YTbUFYsDYmt7oZtMXyPsdwf+1r27fpUZFnfFnrTMvG6Y1gVex7tilUasL5afsRD4TfCJa0XKVtYrZ9NrVOiLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745536261; c=relaxed/simple;
	bh=ogEt419A1KQ5Hjf25BhrbbxyeWcR8uknx+vIiq7g+7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=etDHJu8VK6ub4STcgbGM/Y5D7i4ZN13waokvX4svNJCVuT8unx2TxRSNQAahfoOTeQRPwOEtqw972TVv4bzpH8tcuuG0HzeBrQdSmrffVjb4rMMCEynAFs8HWVSV/OpeoEotRatArQzhYLSj38cydj3VxtuAbSo6iy1D4J9+amk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tK7c29F5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AB2C4CEE3;
	Thu, 24 Apr 2025 23:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745536261;
	bh=ogEt419A1KQ5Hjf25BhrbbxyeWcR8uknx+vIiq7g+7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tK7c29F5uZ9SLzCMxMA39eBX5gfxK31Fz3E/Ip3HaM6R7pm5tF8KbvL6Pp9aRs/Q5
	 mp/qHgTAZc0zd40lkxwFfNPeTS3QbANk4AkGQDdNU7Ai3J824K44qEJFn8+26yU3hy
	 2PVDEfX30rD+loapmKykmaHCb1Lx2G7ac8PwO60EviKsLWcsYd+wIzqVFnArOCdeU9
	 eBsEmiJ/+NT6a+rgJNqmfB1ok5n8DhqO5CT0Zn6ju8fuoml5/NicyRzyhIYSZzytE6
	 inF4qtbUzbdcV2AaJPgkLhiOOFvW8NVYYJ0tgFFTX/yS39dD4h/PpsRNWcIyFzoMFt
	 Dn13kgCQrR1Qw==
Date: Thu, 24 Apr 2025 16:10:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: David Howells <dhowells@redhat.com>, Jedrzej Jagielski
 <jedrzej.jagielski@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Paulo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: Is it possible to undo the ixgbe device name change?
Message-ID: <20250424161059.2e85f8a0@kernel.org>
In-Reply-To: <7b468f16-f648-4432-aa59-927d37a411a7@lunn.ch>
References: <3452224.1745518016@warthog.procyon.org.uk>
	<7b468f16-f648-4432-aa59-927d37a411a7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 23:32:12 +0200 Andrew Lunn wrote:
> > With commit:
> > 
> > 	a0285236ab93fdfdd1008afaa04561d142d6c276
> > 	ixgbe: add initial devlink support
> > 
> > the name of the device that I see on my 10G ethernet card changes from enp1s0
> > to enp1s0np0.  
> 
> Are you sure this patch is directly responsible? Looking at the patch
> i see:
> 
> @@ -11617,6 +11626,11 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>         }
>         strcpy(netdev->name, "eth%d");
>         pci_set_drvdata(pdev, adapter);
> +
> +       devl_lock(adapter->devlink);
> +       ixgbe_devlink_register_port(adapter);
> +       SET_NETDEV_DEVLINK_PORT(adapter->netdev, &adapter->devlink_port);
> +
> 
> Notice the context, not the change. The interface is being called
> eth%d, which is normal. The kernel will replace the %d with a unique
> number. So the kernel will call it eth42 or something. You should see
> this in dmesg.
> 
> It is systemd which later renames it to enp1s0 or enp1s0np0. If you
> ask me, you are talking to the wrong people.

Hooking up the devlink port will add a suffix identifying the port,
it comes via dev_get_phys_port_name(). Intel could possibly implement
an empty ndo_get_phys_port_name to override. Tho, I do agree with you
in principle that this is highly unfortunate -- in principle _adding_
attributes should not cause regressions :(
Maybe NM could be thought to use altnames. But that's not a silver
bullet.


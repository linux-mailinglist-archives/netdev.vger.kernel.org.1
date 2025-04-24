Return-Path: <netdev+bounces-185749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A923A9B9EE
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 23:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD78D3ACB0C
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 21:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFA11B040B;
	Thu, 24 Apr 2025 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JvLMt4bI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF672701AC;
	Thu, 24 Apr 2025 21:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530344; cv=none; b=C8HEvwhrMPrACzd0ta3A7IU2RM9Tj9uvaX+Qo5eicli/HIGkXhAkZzstiEzX+fNsTEjnOdw/tmWKqpHZI1CufKPy5FK9giOS8p75eS8Myr1HA29Mgwi2V9LuKjZgZ5oyUV3r8mfUKKvubxF27Brh3ARqtuCkDVGiCiaOpWIBHwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530344; c=relaxed/simple;
	bh=F9Jv4GJ3j0VXb2ogXxDFAGRTm9u7zm0uKbOes1xYM2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kh/mo+dk/pm+98sRzKMIiKY6VH4TLHyuHDrQYz+JKAlASUGT2kcKm/HQoKH6MGShXStanNK57oTtVp8BqEw6dm3nkUtxz+3b5z7PCQSTEld8HW0QHvhtHNTyAbA9gdwVZMsS8jPuf5039IcidZfpv1QVL9diAFMRxa3FtPTFRnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JvLMt4bI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BBDzFFL9rZVzREy0qETSrAqtD3sLRPAv+48jROirht8=; b=JvLMt4bIVJ61LUC5hRtAm852o9
	Tm5EsPu7k/wZYWiVIlTgT1EfbijSRBoVLFGfyZGot23N/OSmQGnLn7z4HKCTV82FeL1iJB0t3OlO/
	276TZae6ABbZxB6Uh70LdMzl85PZMGzeR5KxF2IWfJ5Ah8MJqh0GtLGC1o6Fe1UmpSY0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u84B2-00AW1O-32; Thu, 24 Apr 2025 23:32:12 +0200
Date: Thu, 24 Apr 2025 23:32:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Howells <dhowells@redhat.com>
Cc: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Paulo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Is it possible to undo the ixgbe device name change?
Message-ID: <7b468f16-f648-4432-aa59-927d37a411a7@lunn.ch>
References: <3452224.1745518016@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3452224.1745518016@warthog.procyon.org.uk>

On Thu, Apr 24, 2025 at 07:06:56PM +0100, David Howells wrote:
> [resent with mailing list addresses fixes]
> 
> Hi,
> 
> With commit:
> 
> 	a0285236ab93fdfdd1008afaa04561d142d6c276
> 	ixgbe: add initial devlink support
> 
> the name of the device that I see on my 10G ethernet card changes from enp1s0
> to enp1s0np0.

Are you sure this patch is directly responsible? Looking at the patch
i see:

@@ -11617,6 +11626,11 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
        }
        strcpy(netdev->name, "eth%d");
        pci_set_drvdata(pdev, adapter);
+
+       devl_lock(adapter->devlink);
+       ixgbe_devlink_register_port(adapter);
+       SET_NETDEV_DEVLINK_PORT(adapter->netdev, &adapter->devlink_port);
+

Notice the context, not the change. The interface is being called
eth%d, which is normal. The kernel will replace the %d with a unique
number. So the kernel will call it eth42 or something. You should see
this in dmesg.

It is systemd which later renames it to enp1s0 or enp1s0np0. If you
ask me, you are talking to the wrong people.

	Andrew


Return-Path: <netdev+bounces-146049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22289D1D6F
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 02:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B07B228BC
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 01:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE87126F0A;
	Tue, 19 Nov 2024 01:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ocu3JtOn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407E6126BF9;
	Tue, 19 Nov 2024 01:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731980346; cv=none; b=rLYMfKRlbJmELsfP0A+NVLPWDRsZObolzMvjx4dgFgTRVQxW1eXKutzcIOIfLpo16EdjxNb0N0+O5cgHoYopodDuRVfkpfPn2XzlJABoV/P/Ic8aEHgoCBbXltXWSFIzrpyQvVcpdh6Nnxcr3ua5KntMs443lseh02gXleQvxuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731980346; c=relaxed/simple;
	bh=CGMJ7Kwutgdd8qqQi2XxhRcY3GZZmmGJQKWW6/BRBFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ttmtt9GjfOsYXCgUA8s4wuA5B0sUVDWDdO0/HGBlGKj1sUcsT4cUlA/R6bH8z5IT42aHJPEXwmH/dRDvyd8xs/NgZ1APtV8UmI7sGdr92uPzDA4nZFoJ3pdgFzk8LPdoIoIkakTHO1huforTukDk9SFMcW9+XTXUTh6k8oKpJ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ocu3JtOn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HrSZI+NPZ4tgITxEvMXBm8bIkUrQe0QQVbdP2vVsny0=; b=Ocu3JtOn0gbs7DoGvb8Ezc8PSr
	7QP7aDDZVFwJnShLpHesLDSZF4kSG+egSLu9B6MjO8SnMkE+6nLGA+X7m5ECUa9WUohe0I3DR2njB
	5MbPvh87Kc8OZzQqNZiAtLnHPqEgwyhsNyI0TMf+G6iBxcL3mnRL9i+XLW9jAAHoyv2o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tDDCd-00DjRC-Qb; Tue, 19 Nov 2024 02:38:51 +0100
Date: Tue, 19 Nov 2024 02:38:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Suraj Gupta <suraj.gupta2@amd.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, michal.simek@amd.com,
	radhey.shyam.pandey@amd.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, git@amd.com, harini.katakam@amd.com
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: xlnx,axi-ethernet: Add
 bindings for AXI 2.5G MAC
Message-ID: <ce534b32-7363-4433-8b1d-4e01c3d92084@lunn.ch>
References: <20241118081822.19383-1-suraj.gupta2@amd.com>
 <20241118081822.19383-2-suraj.gupta2@amd.com>
 <20241118165451.6a8b53ed@fedora.home>
 <410bf89c-7218-463d-9edf-f43fc1047c89@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410bf89c-7218-463d-9edf-f43fc1047c89@linux.dev>

On Mon, Nov 18, 2024 at 10:57:45AM -0500, Sean Anderson wrote:
> On 11/18/24 10:54, Maxime Chevallier wrote:
> > Hello,
> > 
> > On Mon, 18 Nov 2024 13:48:21 +0530
> > Suraj Gupta <suraj.gupta2@amd.com> wrote:
> > 
> >> AXI 1G/2.5G Ethernet subsystem supports 1G and 2.5G speeds. "max-speed"
> >> property is used to distinguish 1G and 2.5G MACs of AXI 1G/2.5G IP.
> >> max-speed is made a required property, and it breaks DT ABI but driver
> >> implementation ensures backward compatibility and assumes 1G when this
> >> property is absent.
> >> Modify existing bindings description for 2.5G MAC.
> > 
> > That may be a silly question, but as this is another version of the IP
> > that behaves differently than the 1G version, could you use instead a
> > dedicated compatible string for the 2.5G variant ?
> > 
> > As the current one is :
> > 
> > compatible = "xlnx,axi-ethernet-1.00.a";
> > 
> > it seems to already contain some version information.
> > 
> > But I might also be missing something :)
> 
> As it happens, this is not another version of the same IP but a
> different configuration. It's just that no one has bothered to add 2.5G
> support yet.

Do you mean 2.5G is a synthesis option? Or are you saying it has
always been able to do 2.5G, but nobody has added the needed code?

This is a pretty unusual use of max-speed, so i would like to fully
understand why it is being used before allowing it.

	Andrew


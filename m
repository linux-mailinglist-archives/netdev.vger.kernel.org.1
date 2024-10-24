Return-Path: <netdev+bounces-138726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE029AEA64
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26DB11C2264E
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6E61EF0BB;
	Thu, 24 Oct 2024 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFlSlW3f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDC91EC00F;
	Thu, 24 Oct 2024 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783701; cv=none; b=WO6GgwP0GT+TKQ6GL1Ekc6anE4olMA/+PXTyMu0IxuOsWqoVXC14tyhve5+RJ8EAbFz10SwgSrQU8vc8UsrYC/sBxJ50nKyQeMImxmt0mgPPfjE+ernaRJHvu4Yk39r403UjbitxhFU09Pij61lANAG/DuHJ+2SKZXc29kV0Ubc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783701; c=relaxed/simple;
	bh=A3+WFvu5Hl8t2/BhdPAsefVmYLEp9do9rPFLS0+ariQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a33QpGGTmW/FFAU11dROv0cu/cZbOn2bHxQNdccWObmHyHRJKjgKNhN6IgVj/CwAC7Y9LQesP/wi153g7TZ9G/SYU3116h0lHJPIQ+Wbvxl6Vf3VWpmyJMG0pk9uc9t5wJ3ELgFkP5RAKfIOwGZhynQuwdNmjLnZ6+l/01vQJ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFlSlW3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC48C4CEC7;
	Thu, 24 Oct 2024 15:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729783700;
	bh=A3+WFvu5Hl8t2/BhdPAsefVmYLEp9do9rPFLS0+ariQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZFlSlW3f8oB626HmiKkyLOJu5+l42JXKVnmoUyWYKkhsdnxMNRC6ziN8Dnvhj82+X
	 Dt93tXjeQISjgAFxG58PgmzBzNQDFAvv2jT+/h/vvwmdfF0v5+2pQomOpR84n+g/1n
	 BJlvm9VovVkudzla+NNkE11u0SEIWHWWW/giX7mezrOHTDL13odSH5ehhPIhKrN1nd
	 FToP+cc93aWSMwkZJrEA2ZKKpM2gDz+pJ5cZLgFnQTMRy1rCpzWl4Ie2r5lYAQn3J4
	 zOWQsxm2qtmiOTXNB6xCEAQUMlKRWUYf2arQ1ehMX0l9O6GSoEzJ5qmaLTpGMambej
	 qFtjF+59xfdsw==
Date: Thu, 24 Oct 2024 16:28:16 +0100
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next] Documentation: networking: Add missing PHY_GET
 command in the message list
Message-ID: <20241024152816.GA1202098@kernel.org>
References: <20241023141559.100973-1-kory.maincent@bootlin.com>
 <20241024145223.GR1202098@kernel.org>
 <20241024171802.4e0f0110@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024171802.4e0f0110@kmaincent-XPS-13-7390>

On Thu, Oct 24, 2024 at 05:18:02PM +0200, Kory Maincent wrote:
> On Thu, 24 Oct 2024 15:52:23 +0100
> Simon Horman <horms@kernel.org> wrote:
> 
> > On Wed, Oct 23, 2024 at 04:15:58PM +0200, Kory Maincent wrote:
> > > ETHTOOL_MSG_PHY_GET/GET_REPLY/NTF is missing in the ethtool message list.
> > > Add it to the ethool netlink documentation.
> > > 
> > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > ---
> > >  Documentation/networking/ethtool-netlink.rst | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/Documentation/networking/ethtool-netlink.rst
> > > b/Documentation/networking/ethtool-netlink.rst index
> > > 295563e91082..70ecc3821007 100644 ---
> > > a/Documentation/networking/ethtool-netlink.rst +++
> > > b/Documentation/networking/ethtool-netlink.rst @@ -236,6 +236,7 @@
> > > Userspace to kernel: ``ETHTOOL_MSG_MM_GET``                get MAC merge
> > > layer state ``ETHTOOL_MSG_MM_SET``                set MAC merge layer
> > > parameters ``ETHTOOL_MSG_MODULE_FW_FLASH_ACT``   flash transceiver module
> > > firmware
> > > +  ``ETHTOOL_MSG_PHY_GET``               get Ethernet PHY information
> > >    ===================================== =================================
> > >  
> > >  Kernel to userspace:
> > > @@ -283,6 +284,8 @@ Kernel to userspace:
> > >    ``ETHTOOL_MSG_PLCA_NTF``                 PLCA RS parameters
> > >    ``ETHTOOL_MSG_MM_GET_REPLY``             MAC merge layer status
> > >    ``ETHTOOL_MSG_MODULE_FW_FLASH_NTF``      transceiver module flash updates
> > > +  ``ETHTOOL_MSG_PHY_GET_REPLY``            Ethernet PHY information
> > > +  ``ETHTOOL_MSG_PHY_NTF``                  Ethernet PHY information  
> > 
> > I wonder if ETHTOOL_MSG_PHY_NTF should be removed.
> > It doesn't seem to be used anywhere.
> 
> We can't, as it is in the ethtool UAPI. Also I believe Maxime will use it on
> later patch series. Maxime, you confirm?

Ok, if it's in the UAPI then I suppose it needs to stay.

But could we differentiate in the documentation between
ETHTOOL_MSG_PHY_GET_REPLY and ETHTOOL_MSG_PHY_NTF?


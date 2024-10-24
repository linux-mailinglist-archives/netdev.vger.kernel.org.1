Return-Path: <netdev+bounces-138746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304C09AEB8D
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 18:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29801F2326E
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F9F1F76AB;
	Thu, 24 Oct 2024 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="glQO7erl"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E983139578;
	Thu, 24 Oct 2024 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786331; cv=none; b=mPBgkq9Bim+M+UgA34LLs4bV3qRadpqs9QSwXkLvBZEvtVY1nbtx0VuSVIg5tzSlWRIgwNaXpzXWBGtFubGvDu9dFbaloHOZe803NgezqIZQexl/CARteAHOW1fwXu/ebL3DHTlnaxfVnMvUEymQ1Jr6ECp3N51hd0hcsef2MDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786331; c=relaxed/simple;
	bh=gdlisyXK2+659MhL+7tq7TctbDgTxLnZv+WJgTIBhyE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLMIUCXYFhCnKd2SXvqi/TMTBgWWy2yIcoBAqRwuhGlavxga6sZdLLZEJJWY2rLAexae16en9DUD83wmeTRq2Do7t9IS4cFzcVNsrJhAxM3Jb0Zm77JBsarN+5EwmP47UFxmO8JNTOCqXAFGdSXM4DbsKkvyQF/Mp6u+z4vL490=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=glQO7erl; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C888620004;
	Thu, 24 Oct 2024 16:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729786320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XB3VRwVYgwtYy/jngMFSX+SYdmqp53Fh8T0vpxq9TpA=;
	b=glQO7erlFzg/9GexBOmJtAzZDGVHViXGzDNZwLSCOMixc5uIP2ML1vdj7uuHno7ZVZEQwA
	bXe+/mGxzBJOtod0ExZkhLemJ3xAlaWuKFGIQDgzdT4hUL7yn65x2yU04hxHQCN5abMs9o
	P57J5FRwo6KzVXVGbc0LHzuaoz7n8dYiyiQmolsmd7XokC6/h6PFj9VEP/k3ED+tDbH2g1
	Xu4nzx8u4i2q/1Zpa9Nh+QPhkM4miCM0eXb8B3TMMQZNVucqn7jRFIJ1pIzHsIBPyx6F2l
	RqlHQRgaLHwdqZWGYP1bytHMi/RwG3T54yw3rFNz+JsXbQyLjMPZVzCtUYhb2w==
Date: Thu, 24 Oct 2024 18:11:57 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next] Documentation: networking: Add missing PHY_GET
 command in the message list
Message-ID: <20241024181157.261e3194@device-21.home>
In-Reply-To: <20241024152816.GA1202098@kernel.org>
References: <20241023141559.100973-1-kory.maincent@bootlin.com>
	<20241024145223.GR1202098@kernel.org>
	<20241024171802.4e0f0110@kmaincent-XPS-13-7390>
	<20241024152816.GA1202098@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Simon,

On Thu, 24 Oct 2024 16:28:16 +0100
Simon Horman <horms@kernel.org> wrote:

> On Thu, Oct 24, 2024 at 05:18:02PM +0200, Kory Maincent wrote:
> > On Thu, 24 Oct 2024 15:52:23 +0100
> > Simon Horman <horms@kernel.org> wrote:
> >   
> > > On Wed, Oct 23, 2024 at 04:15:58PM +0200, Kory Maincent wrote:  
> > > > ETHTOOL_MSG_PHY_GET/GET_REPLY/NTF is missing in the ethtool message list.
> > > > Add it to the ethool netlink documentation.
> > > > 
> > > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > > ---
> > > >  Documentation/networking/ethtool-netlink.rst | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/Documentation/networking/ethtool-netlink.rst
> > > > b/Documentation/networking/ethtool-netlink.rst index
> > > > 295563e91082..70ecc3821007 100644 ---
> > > > a/Documentation/networking/ethtool-netlink.rst +++
> > > > b/Documentation/networking/ethtool-netlink.rst @@ -236,6 +236,7 @@
> > > > Userspace to kernel: ``ETHTOOL_MSG_MM_GET``                get MAC merge
> > > > layer state ``ETHTOOL_MSG_MM_SET``                set MAC merge layer
> > > > parameters ``ETHTOOL_MSG_MODULE_FW_FLASH_ACT``   flash transceiver module
> > > > firmware
> > > > +  ``ETHTOOL_MSG_PHY_GET``               get Ethernet PHY information
> > > >    ===================================== =================================
> > > >  
> > > >  Kernel to userspace:
> > > > @@ -283,6 +284,8 @@ Kernel to userspace:
> > > >    ``ETHTOOL_MSG_PLCA_NTF``                 PLCA RS parameters
> > > >    ``ETHTOOL_MSG_MM_GET_REPLY``             MAC merge layer status
> > > >    ``ETHTOOL_MSG_MODULE_FW_FLASH_NTF``      transceiver module flash updates
> > > > +  ``ETHTOOL_MSG_PHY_GET_REPLY``            Ethernet PHY information
> > > > +  ``ETHTOOL_MSG_PHY_NTF``                  Ethernet PHY information    
> > > 
> > > I wonder if ETHTOOL_MSG_PHY_NTF should be removed.
> > > It doesn't seem to be used anywhere.  
> > 
> > We can't, as it is in the ethtool UAPI. Also I believe Maxime will use it on
> > later patch series. Maxime, you confirm?  
> 
> Ok, if it's in the UAPI then I suppose it needs to stay.
> 
> But could we differentiate in the documentation between
> ETHTOOL_MSG_PHY_GET_REPLY and ETHTOOL_MSG_PHY_NTF?

Yeah it was a leftover from when I implemented that, however I do plan
on adding this notification though, so if it's OK for it to stay that's
perfect as it'll get used.

Then for the documentation, we can specify "Ethernet PHY information
change notification". This would trigger when the PHYs are appearing on
the topology.

Thanks,

Maxime


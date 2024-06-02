Return-Path: <netdev+bounces-100009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA208D7700
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 17:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27E06B224CC
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 15:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2A047F6A;
	Sun,  2 Jun 2024 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZehAeZcv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B4813AF2;
	Sun,  2 Jun 2024 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717343660; cv=none; b=KLUGJm9Te39Gs/IxsCzcVMtucs+KF88ak9ylwi4vMs3tNFNmq4ninrXiBz8E5FWmXV0QKfA6jNtV8qbQ9VtCHSG/hWceoBP9yMpZf/Oebtlvy8wqmvsGJFdXiqrrNgRLJN4KgdP08Zu+4NpnPKvlACmPZw+Z9d+76m25lU0bmfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717343660; c=relaxed/simple;
	bh=O8x9QJjrChVP+uJek3aA1p8gux7bi0OdNCSQ/EwzXYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1cuLfXLAYSjYm7CRzkLc5kshkCzrCBZFkTKjdJFUxwGZOntpkMZJMcnYKPdn0UC+ADFyVF1VxQuos77rSwrlOLc7fPk6eOpMneb9qbl6GaH+/S/33oDKOkvgzGVo023/rrAZ6rXfJovfDcF7BVkAy2KacdCX9oL/8nwRtf5bCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZehAeZcv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jAp9ulkP+aIOZlRN7+1gRLXP/ryNz1Huu1tcBNgtGD0=; b=ZehAeZcvlmuFe91tGL05XO7Yta
	W+UTUi4HdWUITRmOA6euQ6KGGqfE41bGfxW86WhQ5XnjCEKQaREP1rGz7IoL6vec6C2MAmk69DS7v
	FY2IjDQQAqy/TaQGI1DVdmPcQyW7q6BqNkPDdUT2yUrWSBhVWQcApeV525APxecWxcnI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sDnX6-00Gdvb-37; Sun, 02 Jun 2024 17:54:08 +0200
Date: Sun, 2 Jun 2024 17:54:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Yojana Mallik <y-mallik@ti.com>, schnelle@linux.ibm.com,
	wsa+renesas@sang-engineering.com, diogo.ivo@siemens.com,
	rdunlap@infradead.org, horms@kernel.org, vigneshr@ti.com,
	rogerq@ti.com, danishanwar@ti.com, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com,
	rogerq@kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: ethernet: ti: Register the RPMsg
 driver as network device
Message-ID: <16504fb9-f786-492b-8982-b46854a7de1e@lunn.ch>
References: <20240531064006.1223417-1-y-mallik@ti.com>
 <20240531064006.1223417-3-y-mallik@ti.com>
 <cae9e96a-50ff-496d-93e7-fe1f16db7b89@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cae9e96a-50ff-496d-93e7-fe1f16db7b89@ti.com>

> > +#define ICVE_MIN_PACKET_SIZE ETH_ZLEN
> > +#define ICVE_MAX_PACKET_SIZE 1540 //(ETH_FRAME_LEN + ETH_FCS_LEN)
> 
> Is the commented portion above required?

I would actually say the comment part is better, since it gives an
idea where the number comes from. However, 1514 + 4 != 1540. So there
is something missing here.

> >  struct icve_port {
> > +	struct icve_shared_mem *tx_buffer; /* Write buffer for data to be consumed remote side */
> > +	struct icve_shared_mem *rx_buffer; /* Read buffer for data to be consumed by this driver */
> > +	struct timer_list rx_timer;
> >  	struct icve_common *common;
> > -} __packed;
> 
> Is the "__packed" attribute no longer required, or was it overlooked?

Why is packed even needed? This is not a message structure to be
passed over the RPC is it?

I think this is the second time code has been added in one patch, and
then removed in the next. That is bad practice and suggests the
overall code quality is not good. Please do some internal reviews.

	Andrew


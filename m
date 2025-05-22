Return-Path: <netdev+bounces-192678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8A8AC0CF8
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92339175846
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3F328AAF9;
	Thu, 22 May 2025 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rrzlMLxh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D827F3010C;
	Thu, 22 May 2025 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921162; cv=none; b=FXhRpCinn3g+ef2Fx0J/KzwLFepu8tCwHBQbMEIPpQrx3r//FRjS3JfRV/FcWwz78eNSoqAiejY3rGmQovOjmCg1GyZNlpzg8/FlMRvNqardjC5dcFA7isY3zImvBVrgb/jqbo7r9GO/GeS6INRTN0apItEvwqlrx/B5huoTsus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921162; c=relaxed/simple;
	bh=xjuI21sO+TkhCNbE2k5F8Z+xtDLNQU3EzZ3ixPfOWQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6q+s/JoRGB17ryMr6yeJUKjKMMP9qgf1LM7gsx0tUduGKk1x7vvapYhRvkFKNryCZQ36x0vh7uq9esZ70ON9dx7F3UGrrtwBM+LJPb20Kllxy/ChKB8tuSrOGAXwYnTDuXNC4a0z4c5hgmJkutTQUBqiP/bG2Q+FxnVdW24+Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rrzlMLxh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1XM5xDv7Bj0KgXxesCWne38qDPbZ7vxIDgzhvd1vrEo=; b=rrzlMLxh8Hx9cgD9w87ouAY1xO
	AVWTxMwXua/Jo5x8nUFPPncHmgyuztKmpv0F5mpLsZ4xpYcQ0LhcTGINkM99g3KxjK1e8DU2OeVjA
	r9n5/HH5DWSKhT/Zv1e7amfiH4V+GAj7DoarKyeZZBiP9HM0ULt5HquWc2a9EulwLlqg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uI68W-00DUwk-0m; Thu, 22 May 2025 15:39:04 +0200
Date: Thu, 22 May 2025 15:39:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: Synchronize c45_ids to phy_id
Message-ID: <831a5923-5946-457e-8ff6-e92c8a0818fd@lunn.ch>
References: <20250522131918.31454-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522131918.31454-1-yajun.deng@linux.dev>

On Thu, May 22, 2025 at 09:19:18PM +0800, Yajun Deng wrote:
> The phy_id_show() function emit the phy_id for the phy device. If the phy
> device is a c45 device, the phy_id is empty. In other words, phy_id_show()
> only works with the c22 device.
> 
> Synchronize c45_ids to phy_id, phy_id_show() will work with both the c22
> and c45 devices.

First off, they are different things. A device can have both a C22 and
a collection of C45 IDs. So they should not be mixed up in one sysfs
attribute.

The second point has already been made by Russell, there are lots of
different C45 IDs, and phylib will try to find a driver based on any
of them.

If you want to export the C45 IDs, please think about adding new sysfs
attributes.

	Andrew


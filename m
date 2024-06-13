Return-Path: <netdev+bounces-103392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4C4907D9F
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 22:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D283B229F0
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 20:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1211013B588;
	Thu, 13 Jun 2024 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="t/CGnthG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A5C763E7;
	Thu, 13 Jun 2024 20:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718311586; cv=none; b=lzRDOIj1rkFyeZcCx90AZcpgHHNaJZDGtPSd64IQif9oW0uydFpF03KIKQI7Zgid9Pj+226zMgdzf2l9gDIQ5/PuZo8fbxMegxXv+uAjesZRijS/j6CDqqUQLnj7DKvQE6BTbFAmwzIYSuQm3sB3jn3JFUcbWw1h618r7j8pJbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718311586; c=relaxed/simple;
	bh=HicCLRv+HEWgT4PEns+naj+VIcI7qkndERvazIZM33g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mgn0/Zo2ylkdxrtzeKxel5ScCw9TmjAfvRaXtD16aR7CJ0N98gr8hkyyWTUgGd9FsttqxqgpAcqWfVGFSY16fJCOFbdtGKe+dAMFWhe0MHQSPnU0FxbZhau55XHu+8wSb03IB9RGPwBpLtvHiE4cxDQyeWsbVGetuctWUqkZjPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=t/CGnthG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rdUt95wCW7pUkKB7MuV0OXQsjoGeXHyKiKG8gB7jBxw=; b=t/CGnthG7/sB5eOHvVxPMw254R
	rYKGxhsxSrlVd1M19VkDAM7Ij2cdor+ezzPSlaQPt41RbGiH0hlwFBPYFFBjax6tvBIrafaw0ziNp
	bMT/cuqDMWrQD9lkrBeRQbxKSm/00LV0m+Txf9iKaea8R4dJX0BHbcxLXt1Dfpgd7kZk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sHrKn-0000Mh-OF; Thu, 13 Jun 2024 22:46:13 +0200
Date: Thu, 13 Jun 2024 22:46:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rengarajan S <rengarajan.s@microchip.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] lan78xx: lan7801 MAC support with lan8841
Message-ID: <6eec7a37-13d0-4451-9b32-4b031c942aa1@lunn.ch>
References: <20240611094233.865234-1-rengarajan.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611094233.865234-1-rengarajan.s@microchip.com>

On Tue, Jun 11, 2024 at 03:12:33PM +0530, Rengarajan S wrote:
> Add lan7801 MAC only support with lan8841. The PHY fixup is registered
> for lan8841 and the initializations are done using lan8835_fixup since
> the register configs are similar for both lann8841 and lan8835.

What exactly does this fixup do?

Looking at it, what protects it from being used on some other device
which also happens to use the same PHY? Is there something to
guarantee:

struct lan78xx_net *dev = netdev_priv(phydev->attached_dev);

really is a lan78xx_net * ?

   Andrew


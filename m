Return-Path: <netdev+bounces-147873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4219DE9FC
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 16:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AFAF28132D
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 15:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981EB1448F2;
	Fri, 29 Nov 2024 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SoKj2oXa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA89140E34;
	Fri, 29 Nov 2024 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732895711; cv=none; b=XmQtPrYJoykLx/DCvO5y5xvYiIy5AhLljKx8oZ9juVMH8GGdKUMuLkNSi/Ln8vgyie23c/N+S3zDIMzoMM/dpTbj/yLwW/Z3q14TfGIOA7oQAAwYIZ6ZqVGyQQG+7qSBirK4HMD5ndQoLNXTzz9w7vfN9WhXocyAH36AOQ/Ov3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732895711; c=relaxed/simple;
	bh=kC3k2ptxWAmZ0pSJaZ/GqEPlSHcg8ARsRjC1K/4EzZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CP1B1lqFch2BteJ2frS8VTtiphk73c0j9Y5s+m4pZw9jFac6lFdCdqtn0QyA8Aope3ZiwemdWLxRYlJS0fPEfVtNRSFhQPedAVubu+Lxs/qtZKDw4jNQ+BF69VUFqP7DC0xq3hkoOx2T8hObP/tBH0Pa0C/6MWdzOD3OtyXAnY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SoKj2oXa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=G3nR71lc/iIy9K8Syw7R0FIxtppl6TKV5Wan+unn58c=; b=SoKj2oXad/hOnKXgxOh5FtNXx/
	pTwmnHVUCfW25PYXYspAI5ZzBOIauWGH+5bCxzeX/xZIorRlB2GFzBVxw5mJoa2zuzS1UzJpd/zVX
	isisKqoILDWaZf8KmnQ85lIzc5Ul9OSgybXi1nUTMe340rq7RePukpqRsb+m6OxiI0wI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tH3Kd-00EmWm-V4; Fri, 29 Nov 2024 16:54:59 +0100
Date: Fri, 29 Nov 2024 16:54:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Patrick Williams <patrick@stwcx.xyz>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Cosmo Chou <cosmo.chou@quantatw.com>,
	Potin Lai <potin.lai@quantatw.com>
Subject: Re: [PATCH] Revert "net/ncsi: change from ndo_set_mac_address to
 dev_set_mac_address"
Message-ID: <33c32912-cf13-49c9-a786-a44c0bb482a6@lunn.ch>
References: <20241129-potin-revert-ncsi-set-mac-addr-v1-1-94ea2cb596af@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129-potin-revert-ncsi-set-mac-addr-v1-1-94ea2cb596af@gmail.com>

On Fri, Nov 29, 2024 at 05:12:56PM +0800, Potin Lai wrote:
> From: Potin Lai <potin.lai@quantatw.com>
> 
> This reverts commit 790071347a0a1a89e618eedcd51c687ea783aeb3.
> 
> We are seeing kernel panic when enabling two NCSI interfaces at same
> time. It looks like mutex lock is being used in softirq caused the
> issue.

So a revert does make sense, you are seeing a real problem from that
commit.

However with the revert, is the code actually correct? Or is it
missing some locking? Normally dev_addr_sem is used to protect against
two calls to change the MAC address at once. Is this protection
needed? It would also be typical to hold RTNL while changing the MAC
address. So it would be nice to see an analysis of the locking, and
maybe the revert commit message says this gets you from a broken state
to a less broken state, and the real fix will be submitted soon?

	Andrew


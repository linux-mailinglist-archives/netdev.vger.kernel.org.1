Return-Path: <netdev+bounces-59540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BE181B30E
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 11:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4DBB1C2397F
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 10:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970A14D580;
	Thu, 21 Dec 2023 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1gT/WhHL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2F84D11C
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=HeK61wtCrn9BWwLsjuCFW9plJ6a6LDMdNhk+e/GRqCw=; b=1g
	T/WhHLm1sb192RCOIi/zhVSnul0IxZxhy/vrkZQb10JCJqR0bHgfqDBSSZXYdt+WEemlcmpUYJlak
	zDtWjdAUJcWzgyLs4jJI6cbRUYXpTEyeoNXdpWY0wclfsH6ChBLW1J19yivWZX4LhGpz9GMHycgn1
	MBVzv5+iFaKwyoE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rGFte-003Uz1-Dz; Thu, 21 Dec 2023 11:03:18 +0100
Date: Thu, 21 Dec 2023 11:03:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: netdev@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, Wei Lei <quic_leiwei@quicinc.com>
Subject: Re: [PATCH net-next] net: sfp: fix PHY discovery for FS SFP-10G-T
 module
Message-ID: <d7e37e48-a557-4dad-91a5-85283dd3fc5f@lunn.ch>
References: <20231219162415.29409-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231219162415.29409-1-kabel@kernel.org>

On Tue, Dec 19, 2023 at 05:24:15PM +0100, Marek Behún wrote:
> Commit 2f3ce7a56c6e ("net: sfp: rework the RollBall PHY waiting code")
> changed the long wait before accessing RollBall / FS modules into
> probing for PHY every 1 second, and trying 25 times.
> 
> Wei Lei reports that this does not work correctly on FS modules: when
> initializing, they may report values different from 0xffff in PHY ID
> registers for some MMDs, causing get_phy_c45_ids() to find some bogus
> MMD.
> 
> Fix this by adding the module_t_wait member back, and setting it to 4
> seconds for FS modules.
> 
> Fixes: 2f3ce7a56c6e ("net: sfp: rework the RollBall PHY waiting code")
> Reported-by: Wei Lei <quic_leiwei@quicinc.com>
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


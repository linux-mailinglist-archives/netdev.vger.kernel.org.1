Return-Path: <netdev+bounces-196738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B9CAD6226
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 00:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C8D3ABB71
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 22:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A10248F5C;
	Wed, 11 Jun 2025 22:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nMeKEvkN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9E9248878
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 22:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749679405; cv=none; b=PbLsmapY+BNjXcpGEyT+U4TbrsnN3SkkLednu256RBjGW6Nc5B2PR5+yAeW0nR1Ja0nKqLKbBRruF3dMmN0Hcx0oPuSNUxQxfOMhw037f4bhl2hGOIYUwZrlJXIk1Y0+eq9X07OcXKxg1ETX1q0mKdyJ6W5tg7hUX9GRZlhK/Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749679405; c=relaxed/simple;
	bh=rO9bR0UaQlSQ9kKMkKJ5pJJbD9kJb4CA390jtnvEaeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEAEsFieR0Mg+rdvymzA0V00TgRL4jEpYrifpLA0Wf7FgVwi8LJhGkIMT9ErYjVY/9P/B2q5guIWcpYBuyPOHBd0SM0cWH1QtoQkDzpJ3qeFUcjtd3BYfuSp4QxSgBip8mp4iWZ+rn9+mzJE9vLKSwzjlYW8h2e+7EARNK/1dHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nMeKEvkN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oy4VhcftvS+YB03k1b0Missh9Pi38mv9EyYccouLufs=; b=nMeKEvkNlKRfkeRiGHObAWJX6M
	mI5+xf3i6aZbK5CxHzqv+5qSd+NK7i1GDw4FBM/Y6B+0JmqDU6vkuqcH97poY0Az3Vzaj72VybV7k
	/f65PnGQb1uhS6zf2vcbIJ5RiAHYIR5P1wm9xVV0tsGntLBJLvqpbMuUzDsI7sJrzBp4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPTXT-00FSYA-Ua; Thu, 12 Jun 2025 00:03:19 +0200
Date: Thu, 12 Jun 2025 00:03:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev,
	sanman.p211993@gmail.com, jacob.e.keller@intel.com, lee@trager.us,
	suhui@nfschina.com
Subject: Re: [PATCH net-next 2/2] eth: fbnic: Expand coverage of mac stats
Message-ID: <a4428312-35d4-4424-b13e-7a4f109d75a1@lunn.ch>
References: <20250610171109.1481229-1-mohsin.bashr@gmail.com>
 <20250610171109.1481229-3-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610171109.1481229-3-mohsin.bashr@gmail.com>

On Tue, Jun 10, 2025 at 10:11:09AM -0700, Mohsin Bashir wrote:
> Expand coverage of MAC stats via ethtool by adding rmon and eth-ctrl
> stats.
> 
> ethtool -S eth0 --groups eth-ctrl
> Standard stats for eth0:
> eth-ctrl-MACControlFramesTransmitted: 0
> eth-ctrl-MACControlFramesReceived: 0
> 
> ethtool -S eth0 --groups rmon
> Standard stats for eth0:
> rmon-etherStatsUndersizePkts: 0
> rmon-etherStatsOversizePkts: 0
> rmon-etherStatsFragments: 0
> rmon-etherStatsJabbers: 0
> rx-rmon-etherStatsPkts64Octets: 32807689
> rx-rmon-etherStatsPkts65to127Octets: 567512968
> rx-rmon-etherStatsPkts128to255Octets: 64730266
> rx-rmon-etherStatsPkts256to511Octets: 20136039
> rx-rmon-etherStatsPkts512to1023Octets: 28476870
> rx-rmon-etherStatsPkts1024to1518Octets: 6958335
> rx-rmon-etherStatsPkts1519to2047Octets: 164
> rx-rmon-etherStatsPkts2048to4095Octets: 3844
> rx-rmon-etherStatsPkts4096to8191Octets: 21814
> rx-rmon-etherStatsPkts8192to9216Octets: 6540818
> rx-rmon-etherStatsPkts9217to9742Octets: 4180897
> tx-rmon-etherStatsPkts64Octets: 8786
> tx-rmon-etherStatsPkts65to127Octets: 31475804
> tx-rmon-etherStatsPkts128to255Octets: 3581331
> tx-rmon-etherStatsPkts256to511Octets: 2483038
> tx-rmon-etherStatsPkts512to1023Octets: 4500916
> tx-rmon-etherStatsPkts1024to1518Octets: 38741270
> tx-rmon-etherStatsPkts1519to2047Octets: 15521
> tx-rmon-etherStatsPkts2048to4095Octets: 4109
> tx-rmon-etherStatsPkts4096to8191Octets: 20817
> tx-rmon-etherStatsPkts8192to9216Octets: 6904055
> tx-rmon-etherStatsPkts9217to9742Octets: 6757746
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


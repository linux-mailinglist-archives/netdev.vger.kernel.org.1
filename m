Return-Path: <netdev+bounces-161982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430C5A24F02
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 17:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E8D162AF9
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 16:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC043596F;
	Sun,  2 Feb 2025 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Qg4wG+Ol"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B9D2AD20
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738515002; cv=none; b=VVG0nWVdRjfWf1o/gPzw/HJPOSs1ysJ8mMAuNhuY/g4z7Zuf1nOufnyXeMAD6Osw1wYEIaWPssyMW+8Np5sgsUuPafqb1nPPQmQneMvumuhTx48+7X8KZJcRq91+Gy+Od2UwNIB1jkqYrGF4NnDXOaLDmVA2JWVr+1w5SDQYzHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738515002; c=relaxed/simple;
	bh=wpjaadWgqFNZ2XE7a7slXTmj2Cn0xQQKG37IF8p/+HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIFvHzumSbL32vagYpIzBVns6RZjVJ2yZyxZ1AIlzji3Ec95Zy69TpSHxp8xqxifMP40YsV5b46c0xJcJpF4t1yIFyqE92VcS5M/7L7j1xqAHp7ENoN7VM6Z97PNKBEgY7687B4q1zlG8s25BYPnqhy3jrxgmHAy/h2T30z+Wpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Qg4wG+Ol; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AXTs6bB9RhTJB+9vrRSN7Uzp+PsrgtFWXqtF3VZzzp4=; b=Qg4wG+Oln8AXlzgLmKH3Ekfi3e
	q2hdaUg/X/9xd+mm2gnaADeW3npN7S6ZIlmxSNaCtYTBN7BqyluxRxuQozZ0D9ozmgCx+/ePtxksr
	jQnyNn46mvi0AOjnCfhc709o70Fd13c4roV5Sworicwgtz6oHZBMKG9yiDBRxZMM0ZhM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tedAL-00AIOk-EK; Sun, 02 Feb 2025 17:49:49 +0100
Date: Sun, 2 Feb 2025 17:49:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	nbd@nbd.name, sean.wang@mediatek.com, upstream@airoha.com
Subject: Re: Move airoha in a dedicated folder
Message-ID: <634c90a1-e671-42ae-9751-fee3a599af20@lunn.ch>
References: <Z54XRR9DE7MIc0Sk@lore-desk>
 <20250201155009.GA211663@kernel.org>
 <CA+_ehUwFTa2VvfqeTPyedFDWBHj3PeUem=ASMrrh1h3++yLc_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+_ehUwFTa2VvfqeTPyedFDWBHj3PeUem=ASMrrh1h3++yLc_A@mail.gmail.com>

> Hi,
> may I push for a dedicated Airoha directory? (/net/ethernet/airoha ?)
> 
> With new SoC it seems Airoha is progressively detaching from Mediatek.

The vendor name is actually not very relevant. Linux has a much longer
life than most vendors. Assets get bought and sold, but they keep the
same name in Linux simply to make Maintenance simpler. FEC has not
been part of Freescale for a long time. Microsemi and micrel are part
of microchip, but we still call them microsemi and micrel, because who
knows, microchip might soon be eaten by somebody bigger, or broken up?

> Putting stuff in ethernet/mediatek/airoha would imply starting to
> use format like #include "../stuff.h" and maybe we would start to
> import stuff from mediatek that should not be used by airoha.

obj-$(CONFIG_NET_AIROHA) += airoha_eth.o

#include <linux/etherdevice.h>
#include <linux/iopoll.h>
#include <linux/kernel.h>
#include <linux/netdevice.h>
#include <linux/of.h>
#include <linux/of_net.h>
#include <linux/platform_device.h>
#include <linux/reset.h>
#include <linux/tcp.h>
#include <linux/u64_stats_sync.h>
#include <net/dsa.h>
#include <net/page_pool/helpers.h>
#include <net/pkt_cls.h>
#include <uapi/linux/ppp_defs.h>

I don't see anything being shared. Maybe that is just because those
features are not implemented yet? But if there is sharing, we do want
code to be shared, rather than copy/paste bugs and code between
drivers.

Maybe drivers/net/ethernet/wangxun is a good model to follow, although
i might put the headers in include/linux/net/mediatek rather than do
relative #includes.

	Andrew


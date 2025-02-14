Return-Path: <netdev+bounces-166400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8038A35E87
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 688157A06A8
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 13:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B271263F2E;
	Fri, 14 Feb 2025 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5y3pZT9x"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7CF2753FC;
	Fri, 14 Feb 2025 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739538888; cv=none; b=OPvBJnKEuP87yGoZ0E3DFUENFhf7aGsIyQdWn2wl/hPXuAsHiiYNorOQNkWJaJeCcYMPZxJK/Oa3qDecD4dRzjVqrL4mAGQe4xriXwEhwSrfIh+b1ktAq2aryxN/Yovn/r6B0lyA/R86D+DdiRNDE3s7dJGxGjAYibDTc/Aggqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739538888; c=relaxed/simple;
	bh=6oDcW75qUCH8EauoDZEesOlHRIrOTMEnECDTMiOK6J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZwLwALj/UwYKw3VxjhmEND/xFGkq8liHQiCKD1IUv8tCXfhGA0I5M5O32kE07aLxod6R5tOl2ggso4JwIprgnoB/870Nr50NqeIb8yioi4lpTEnGyyu4W9W/avJMCCLl8ktIQl+gKmWsu2IRtilmydLuGpu6QeLQfxXRdQgsY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5y3pZT9x; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YjsHEfo/qiRRRbNh0TXBs04HjQPppZ55+bcTb3JVFDE=; b=5y3pZT9xEJp+yHFLR6BVPnkZkj
	5VG5PWgvE0P+qCuoCReQzsiWT7pBT/zLHKnlAczalSXPzOQ4Scj2EXB6SeuV9kMWwxw3J+/6b+E1L
	ssDIxqUIUdheODYcVVb+sHG3EdwwH41GWndexQ8JLLW3vegHhXgWW+UMsf0LbwDBdl5k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tivWX-00E4X7-T8; Fri, 14 Feb 2025 14:14:29 +0100
Date: Fri, 14 Feb 2025 14:14:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: xiaopeitux@foxmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Pei Xiao <xiaopei01@kylinos.cn>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] net: freescale: ucc_geth: make ugeth_mac_ops be static
Message-ID: <8b45aa58-3128-44b0-9408-3d7794436cd4@lunn.ch>
References: <tencent_832FF5138D392257AC081FEE322A03C84907@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_832FF5138D392257AC081FEE322A03C84907@qq.com>

On Fri, Feb 14, 2025 at 02:11:07PM +0800, xiaopeitux@foxmail.com wrote:
> From: Pei Xiao <xiaopei01@kylinos.cn>
> 
> sparse warning:
>     sparse: symbol 'ugeth_mac_ops' was not declared. Should it be
> static.
> 
> Add static to fix sparse warnings.

While you are touching it, can it also be made const?

struct phylink *phylink_create(struct phylink_config *,
			       const struct fwnode_handle *,
			       phy_interface_t,
			       const struct phylink_mac_ops *);

phylink_create() will accept a const struct *.

	Andrew


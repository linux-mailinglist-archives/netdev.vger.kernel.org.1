Return-Path: <netdev+bounces-146880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3319D66DA
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 01:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA22E281568
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 00:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B164B660;
	Sat, 23 Nov 2024 00:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R3RpkYDn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465F2F9EC;
	Sat, 23 Nov 2024 00:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732322719; cv=none; b=oLxaUU50j18SxKA5+1LK+1IvZEmwK3HpXAJgTFC2Rc6C38AGvvznL26x9S3hLikxgf4BX0ROPN/KdI1uPRDyt/5H+icn0l+FVmYkUfaym1KV74ojXNxJVfMDt9UcGud9VKyM57U+E24VzyWxnRoj3DILwiVFcGeg3CRP0leinp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732322719; c=relaxed/simple;
	bh=MUtFFihg5paON/LQGz8+V3IscqpvUiyOdci+P+6AY90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4fe5IA2rGbed+Jr4wAylKzcPvRKYbOhkBPnSHx3VVtsWzskJkkJgQwHOaxr+XOTjXuDNjNvyS+txpR/tMBT71ujdyGF34LLys99jySwHbBEeXVp91Ps/8/0To7CAapLpK+dPGTdQ9fWOla72Ca+mefTxIlIvK+TGtaIjWtGJj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R3RpkYDn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wkAMD6+Xsoa00qoTvYqndK96Qtwb7/08ps3RP3TEKsA=; b=R3RpkYDnbEx98NFepoo6u+5aH5
	8DzuYfYlA36Ky7VCp2zPlIpAMg4WN7+9tzr4gTH4F/z23kkEJqf+VLj+HNTHFf9FigwFmzBH8zM7r
	G6vBPbdFTlUK80F9eecsH8OmBDCpJH7vgkbjLUtrGZKdUQ7B79Hu2RqX7uIfrynY9CK0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tEeGr-00EBAl-8T; Sat, 23 Nov 2024 01:45:09 +0100
Date: Sat, 23 Nov 2024 01:45:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com, hua.sun@motor-comm.com
Subject: Re: [PATCH net-next v2 00/21] net:yt6801: Add Motorcomm yt6801 PCIe
 driver
Message-ID: <19de98cc-ad94-4f27-8c14-a9f3c427ffa7@lunn.ch>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120105625.22508-1-Frank.Sae@motor-comm.com>

On Wed, Nov 20, 2024 at 06:56:04PM +0800, Frank Sae wrote:
> This series includes adding Motorcomm YT6801 Gigabit ethernet driver
> and adding yt6801 ethernet driver entry in MAINTAINERS file.
> 
> YT6801 integrates a YT8531S phy.
> 
> v1 -> v2:
> - Split this driver into multiple patches.
> - Reorganize this driver code and remove redundant code

I would say this is still too much code for one submission. You don't
need every feature in the first patch series. Please post just post a
basic driver without all the optional features. Keep to the 15 patch
limit. You can the add more features in follow up patch sets.

	Andrew


Return-Path: <netdev+bounces-226418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A015B9FF72
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 16:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE85188FEE2
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B51929ACDB;
	Thu, 25 Sep 2025 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dLm06J0p"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8823529AB11;
	Thu, 25 Sep 2025 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809971; cv=none; b=ufvJeWZC6QH08zv/KPt/WIhyYTHysnEZS19K432yTQ8Ovk4lCfLyn3dktGzzVBLBJE4v3XWgv4PZ6Z72lM6QDtMnVTIF1SeotsAPv3vWs+2ersrIrBvLuvRCJUJofrXsjQL7wNLvHr0Ua61p/XzSM2slH+W7eftXBHUJgEFYxgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809971; c=relaxed/simple;
	bh=t7xFgnh5MgrwO3gD07DVPaBNwLpzNwehzftgcOddfZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLw+1vLULRnZXRcgFUA5GpvjoSSn2ja4zZwSdxrdxJ5gSxqvtQ+0f4C9gMfo+2sBWIbtYmLwCgwGkEXlEryVx9G7+kWqAzHZjXBCCgWFQlVSi1XogDebeiVquVvKajqK/kLX79qX8vuqEKCtoEmgkD+xUtbni/kMt0BWFc1Z+Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dLm06J0p; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0tvvhk7kaFoub2LyK/A4hB18ZONEl+pKYHKqNPFI5nk=; b=dLm06J0p7oEXoCKsX8k1lfe87z
	JhvusHQiSWY5y6udVzhqDKqbSzfGwBO/Zsjwe9x0xqengE4nX/kJN4NhRoBbzqfj0o7tJkpRlGoge
	1mqXHqaNQCAGPai3ZngbJuXiQjZtcTsPJNFOl6vQskAb/7HBzXA3yfsLFBrgioIWl16g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v1mob-009TTy-7Y; Thu, 25 Sep 2025 16:19:21 +0200
Date: Thu, 25 Sep 2025 16:19:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com,
	rogerq@kernel.org, pmohan@couthit.com, basharath@couthit.com,
	afd@ti.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, pratheesh@ti.com,
	prajith@ti.com, vigneshr@ti.com, praneeth@ti.com, srk@ti.com,
	rogerq@ti.com, krishna@couthit.com, mohan@couthit.com
Subject: Re: [PATCH net-next 0/3] RSTP SWITCH support for PRU-ICSSM Ethernet
 driver
Message-ID: <0080e79a-cf10-43a1-9fc5-864e2b5f5d7a@lunn.ch>
References: <20250925141246.3433603-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925141246.3433603-1-parvathi@couthit.com>

On Thu, Sep 25, 2025 at 07:32:09PM +0530, Parvathi Pudi wrote:
> Hi,
> 
> The DUAL-EMAC patch series for Megabit Industrial Communication Sub-system
> (ICSSM), which provides the foundational support for Ethernet functionality
> over PRU-ICSS on the TI SOCs (AM335x, AM437x, and AM57x), was merged into
> net-next recently [1].
> 
> This patch series enhances the PRU-ICSSM Ethernet driver to support
> RSTP SWITCH mode, which has been implemented based on "switchdev" and
> interacts with "mstp daemon" to support Rapid Spanning Tree Protocol
> (RSTP) as well.

Is there anything in this patchset which is specific to RSTP? In
general, there is no difference between STP and RSTP. STP is generally
done in the kernel as part of the kernel bridge code. RSTP does it in
user space. But the hardware driver does not care if it is STP or
RSTP, it is the same API to the layer above.

	Andrew


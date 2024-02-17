Return-Path: <netdev+bounces-72649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060638590C0
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 17:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB171282210
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 16:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0799F7C6DE;
	Sat, 17 Feb 2024 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6Bz2TXO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81F31D53D
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708185808; cv=none; b=prQBVT2l1Ppx0ZvkjUZ5ufnNS7QaBo5EvMlB1zYMej+u0ZQXt8BIe0NSCY2XSwQerpKGFgEetBXHPgoYn2k1gX0pk+RyufnOC6cJFrsxGjXB1wN4ec1+eeg87ROPr2iQTie89soF3Uk1DsMGUf36zM9eCmW8PFR23vnqKYWBwp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708185808; c=relaxed/simple;
	bh=+Zw+4WncBkvZ9K3jD5FgUbbdsI6PCd65vBmR3SDi0lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sutPDDaIUF8/s50vnrH4FOjBL+ah2K1gybRF1R4WGCos8pNv6OGI3H4E4PztrGsD8l84gOPzwYD3BUOICUjU0vNE064Wdw3LR2CADqsM4Uguw5LyBdmXRD2O/A2FGEAR8S19Hd9cTzHnziisyGpAr1q4ja4rqrKplj1TfCskiFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6Bz2TXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC37AC433F1;
	Sat, 17 Feb 2024 16:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708185808;
	bh=+Zw+4WncBkvZ9K3jD5FgUbbdsI6PCd65vBmR3SDi0lI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X6Bz2TXOR2ZeHfCqiTCDneysd694dKcYEWgkxKeC47bZZxJM5hqjPUr9IByjsjxFO
	 Eu4vUrP7C9UCZkFCHmGuOTUD81DFy9knHgwpPl+6qteoe3iJZAB4YLGzjw4QduGrCG
	 HSmNY8ovaW/QrZdlanuohQfjAFioR3ty/LAYG5pDnxLVaBIIcjptOvq3pnAR+Wvevu
	 8Xjlw72EqtTIbBARkpKfc2bEfoCxVtMgMDcBGVyxlp7uoDWH6sz1J6JEjJBVPtWTU3
	 RXXHs9THR/193INMe++x6AIz+oEo3vAWv0tgK7sTe9izroPra2c8oK8OPI2SK4Zhht
	 0rRi4XFzZFCCw==
Date: Sat, 17 Feb 2024 16:03:24 +0000
From: Simon Horman <horms@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, Shyam-sundar.S-k@amd.com,
	Sudheesh Mavila <sudheesh.mavila@amd.com>
Subject: Re: [PATCH v4 net-next 2/2] amd-xgbe: add support for Crater
 ethernet device
Message-ID: <20240217160324.GQ40273@kernel.org>
References: <20240205204900.2442500-1-Raju.Rangoju@amd.com>
 <20240205204900.2442500-3-Raju.Rangoju@amd.com>
 <20240207190946.GM1297511@kernel.org>
 <9d7ee663-86ea-9fb8-dbf4-31726354a398@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d7ee663-86ea-9fb8-dbf4-31726354a398@amd.com>

On Mon, Feb 12, 2024 at 05:27:32PM +0530, Raju Rangoju wrote:
> 
> 
> On 2/8/2024 12:39 AM, Simon Horman wrote:
> > On Tue, Feb 06, 2024 at 02:19:00AM +0530, Raju Rangoju wrote:
> > > Add the necessary support to enable Crater ethernet device. Since the
> > > BAR1 address cannot be used to access the XPCS registers on Crater, use
> > > the smn functions.
> > > 
> > > Some of the ethernet add-in-cards have dual PHY but share a single MDIO
> > > line (between the ports). In such cases, link inconsistencies are
> > > noticed during the heavy traffic and during reboot stress tests. Using
> > > smn calls helps avoid such race conditions.
> > > 
> > > Suggested-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
> > > Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> > > ---
> > >   drivers/net/ethernet/amd/xgbe/xgbe-common.h |   5 +
> > >   drivers/net/ethernet/amd/xgbe/xgbe-dev.c    |  57 ++++++++
> > >   drivers/net/ethernet/amd/xgbe/xgbe-pci.c    |  33 ++++-
> > >   drivers/net/ethernet/amd/xgbe/xgbe-smn.h    | 139 ++++++++++++++++++++
> > >   drivers/net/ethernet/amd/xgbe/xgbe.h        |   7 +
> > >   5 files changed, 240 insertions(+), 1 deletion(-)
> > >   create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-smn.h
> > 
> > Hi Raju,
> > 
> > This patch seems to be doing a lot.
> > 
> > * Add support for XGBE_RN_PCI_DEVICE_ID to xgbe_pci_probe()
> > * Add fallback implementations of amd_smn_(write|read)()
> > * Add XGBE_XPCS_ACCESS_V3 support to xgbe_(read|write)_mmd_regs()
> > * Add XGBE_XPCS_ACCESS_V3 support to xgbe_pci_probe()
> > * Add support for PCI_VDEVICE(AMD, 0x1641)
> > 
> > So a similar theme to my comment on patch 1/1,
> > I wonder if it could be broken up into separate patches.
> 
> Hi Simon,
> 
> In my v2[*] series I had initially split pci_id patch to separate patch.
> But, I had received a comment from you about "W=1 allmodconfig builds on
> x86_64 with gcc-13 and clang-16 flag that xgbe_v3 us defined but not used."
> In this series, I had ensured warnings are taken care.
> 
> However, based on your new comments I will further try to separate the
> patches taking care of warnings.
> 
> [*] "[PATCH v2 net-next 2/4] amd-xgbe: add support for Crater ethernet
> device"

Thanks, I understand your point that I have provided somewhat conflicting
advice there. Sorry about that.

> > I will also say that I am surprised to see this driver using
> > full licence preambles rather than SPDX headers. I assume that
> > is due to direction from legal. And if so, I accept that you may not
> > be in a position to change this. But my comment stands.
> 
> This is done to ensure xgbe-smn.h license match with license in all the
> other files.

Yes, understood.

I think that it owuld be ideal if, as an activity separate to this
patch-set, some work was done to use SPDX for this driver.


Return-Path: <netdev+bounces-97203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93418C9E91
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 16:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21031C2129B
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 14:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582EA13664B;
	Mon, 20 May 2024 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yl0zyrE0"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9B245026;
	Mon, 20 May 2024 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716213940; cv=none; b=cMiUCtiWGn/8r8M9YPHkMQ5bgUtjIDwcIFhHmB5CoLHkV5goKF+VJo4Shhf+RPDo6ymbLxv96x1VfyKawU3DRN6toBnsdcEVi3uTOFXSxQR/KPTDp6c5AZjYTbgGv/qb/pTg82u6lQOaP0/h8wQ6oIfax4l0RkU/4aP9D1joX9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716213940; c=relaxed/simple;
	bh=ZCB/XT4/i5g7c4Ik2u1T/Pd2N9bQgzM19SbLCGRSfQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GTYgsN2RxHESDSzCnkMpYsHAaUomhWNO+VB25AUCkhzzF13VJsiNVOfsqL0yucuuyCho/SsWYxRrP6bAXl+cqoFiwAiS4FEib5v+PJ+hAIKxF2F1cA92P0aT8W3R1b+MsaSPl0CAs9ESJgIZmGRwDFOuDAhhuqOJZRFcn6dCJrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yl0zyrE0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=TQIxra1MgAXb7lu/CN8hI1DWPOPjSwrGFScXMMALwKM=; b=yl0zyrE0Q5pvLgOIzkxmRUj2ib
	kISY/cYkKQZA2TqDtD4SKRTcKPyq4GoHREVOqIBfdTpl3nE17+etMeHmHbXuNFDXtaDtGePI4tg3F
	va6ewVJARgvoo041FMQy7l0XyW79fYcsi0rqZvFyqNzb4gNXrbu1hmsLVnfa10GowXa8kA/vKAi3O
	FdaVilbh1CLggI6MXB5Yp3gXihzQ2WxZcHbl8e9QcRJ4wYM27+wXPolZpan106z/0RFpD/QHEVDYJ
	wQY3G9V5P7sOeTCtbUSn0q/gh2OyOT45ronGxhGtDeu4Foyo0wVwaCN0uNRpAuyjBPRlVrgWDpkXq
	CJ6HnE+w==;
Received: from [12.37.163.135] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s93dv-0000000EfD8-21L3;
	Mon, 20 May 2024 14:05:35 +0000
Date: Mon, 20 May 2024 07:05:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [GIT PULL] dma-mapping updates for Linux 6.10
Message-ID: <ZktYriALqC7ZNQpa@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Note that the the dma sync optimizations reach into the networking code
and promptly caused a conflict where the netdev tree constifies the page
argument to page_pool_dma_sync_for_device and this tree renames that
function to page_pool_dma_sync_for_device.  The dma-mapping version of
the merge just works, but you might want to pick the contification
manually if you think it is useful.

The following changes since commit e67572cd2204894179d89bd7b984072f19313b03:

  Linux 6.9-rc6 (2024-04-28 13:47:24 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.10-2024-05-20

for you to fetch changes up to a6016aac5252da9d22a4dc0b98121b0acdf6d2f5:

  dma: fix DMA sync for drivers not calling dma_set_mask*() (2024-05-09 19:00:29 +0200)

----------------------------------------------------------------
dma-mapping updates for Linux 6.10

 - optimize DMA sync calls when they are no-ops (Alexander Lobakin)
 - fix swiotlb padding for untrusted devices (Michael Kelley)
 - add documentation for swiotb (Michael Kelley)

----------------------------------------------------------------
Alexander Lobakin (8):
      dma: compile-out DMA sync op calls when not used
      dma: avoid redundant calls for sync operations
      iommu/dma: avoid expensive indirect calls for sync operations
      page_pool: make sure frag API fields don't span between cachelines
      page_pool: don't use driver-set flags field directly
      page_pool: check for DMA sync shortcut earlier
      xsk: use generic DMA sync shortcut instead of a custom one
      dma: fix DMA sync for drivers not calling dma_set_mask*()

Michael Kelley (3):
      Documentation/core-api: add swiotlb documentation
      swiotlb: remove alloc_size argument to swiotlb_tbl_map_single()
      iommu/dma: fix zeroing of bounce buffer padding used by untrusted devices

 Documentation/core-api/index.rst                   |   1 +
 Documentation/core-api/swiotlb.rst                 | 321 +++++++++++++++++++++
 drivers/iommu/dma-iommu.c                          |  34 ++-
 drivers/net/ethernet/engleder/tsnep_main.c         |   2 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-xsk.c   |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |   2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c           |   2 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c       |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/rx.c    |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |   2 +-
 drivers/net/ethernet/netronome/nfp/nfd3/xsk.c      |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   2 +-
 drivers/xen/swiotlb-xen.c                          |   2 +-
 include/linux/device.h                             |   4 +
 include/linux/dma-map-ops.h                        |  12 +
 include/linux/dma-mapping.h                        | 105 +++++--
 include/linux/iova.h                               |   5 +
 include/linux/swiotlb.h                            |   2 +-
 include/net/page_pool/types.h                      |  25 +-
 include/net/xdp_sock_drv.h                         |   7 +-
 include/net/xsk_buff_pool.h                        |  14 +-
 kernel/dma/Kconfig                                 |   5 +
 kernel/dma/mapping.c                               |  69 +++--
 kernel/dma/swiotlb.c                               |  62 +++-
 net/core/page_pool.c                               |  78 +++--
 net/xdp/xsk_buff_pool.c                            |  29 +-
 27 files changed, 634 insertions(+), 163 deletions(-)
 create mode 100644 Documentation/core-api/swiotlb.rst


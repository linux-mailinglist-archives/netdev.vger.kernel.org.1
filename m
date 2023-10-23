Return-Path: <netdev+bounces-43342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3635D7D29CB
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 07:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9667B20C5F
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 05:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A90D567B;
	Mon, 23 Oct 2023 05:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513B2291A
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 05:50:54 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B0FFC
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 22:50:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6B12A68AA6; Mon, 23 Oct 2023 07:50:48 +0200 (CEST)
Date: Mon, 23 Oct 2023 07:50:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>,
	iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org,
	netdev@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 1/8] dma-direct: add depdenencies to
 CONFIG_DMA_GLOBAL_POOL
Message-ID: <20231023055048.GA11374@lst.de>
References: <20231020054024.78295-1-hch@lst.de> <20231020054024.78295-2-hch@lst.de> <CAMuHMdVNmbMsqBF3gozT7yqUVJZ+9Eg2wjTuQF+1W4jKXdAZVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVNmbMsqBF3gozT7yqUVJZ+9Eg2wjTuQF+1W4jKXdAZVQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 20, 2023 at 09:18:32AM +0200, Geert Uytterhoeven wrote:
> s/depdenencies/dependencies/
> 
> On Fri, Oct 20, 2023 at 7:40 AM Christoph Hellwig <hch@lst.de> wrote:
> > CONFIG_DMA_GLOBAL_POOL can't be combined with other DMA coherent
> > allocators.  Add dependencies to Kconfig to document this, and make
> > kconfig complain about unment dependencies if someone tries.
> 
> unmet

Thanks, I've fixed this up, and also removed the line selecting
ARCH_USE_DMA_ALLOC which snuk back into the second to last patch
after the last rebase and applied the whole series to the dma-mapping
tree now.

The RISC-V dependency fixes still haven't made it to the SOC tree, so
you will see dependency warnings in linux-next until that gets fixed.


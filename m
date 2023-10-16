Return-Path: <netdev+bounces-41331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7961D7CA939
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07AEF281623
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A548E27ED6;
	Mon, 16 Oct 2023 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA9527EC6
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:17:50 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC811F0;
	Mon, 16 Oct 2023 06:17:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9503B6732D; Mon, 16 Oct 2023 15:17:45 +0200 (CEST)
Date: Mon, 16 Oct 2023 15:17:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>,
	iommu@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Conor Dooley <conor@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org,
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH 04/12] soc: renesas: select RISCV_DMA_NONCOHERENT from
 ARCH_R9A07G043
Message-ID: <20231016131745.GB26484@lst.de>
References: <20231016054755.915155-1-hch@lst.de> <20231016054755.915155-5-hch@lst.de> <20231016-pantyhose-tall-7565b6b20fb9@wendy>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-pantyhose-tall-7565b6b20fb9@wendy>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 01:52:57PM +0100, Conor Dooley wrote:
> > +	select RISCV_DMA_NONCOHERENT
> >  	select ERRATA_ANDES if RISCV_SBI
> >  	select ERRATA_ANDES_CMO if ERRATA_ANDES
> 
> Since this Kconfig menu has changed a bit in linux-next, the selects
> are unconditional here, and ERRATA_ANDES_CMO will in turn select
> RISCV_DMA_NONCOHERENT.

Oh, looks like another patch landed there in linux-next.  I had
waited for the previous one go go upstream in -rc6.  Not sure
how to best handle this conflict.


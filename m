Return-Path: <netdev+bounces-47863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499BA7EB995
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 23:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4871F24E02
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 22:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AAA26AD1;
	Tue, 14 Nov 2023 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQG7WK4g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5437326AC0
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 22:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9F8C433C7;
	Tue, 14 Nov 2023 22:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700002215;
	bh=K5UdBgRR6Qec7iBT61wqyndqMtZJrpxGixTMDhhacvM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WQG7WK4gQLfG7P1HGhXD0kTl+Lehta0/BhAKcolxERvWkVLzure3V+27/f4z6tVhN
	 8o0xoiHCmLZdrK3SnwG3CbXanHSMpGgsPpnIBz0sDz2VjkeWuhyPvBhxHVss06+Diw
	 gDSZWoO7ZR7ZPchTfKXEXFFaYe0yPQVe7y0B1ofvQNwbEAC+bnGNQS1PIkaKA3BqQj
	 R1/ARCFivSuBizzrGMcj3kMoEWCOofdfSuuufy66PBQiz1KjKGO69E//X2GUSzmvlb
	 gJEcaHHDpC+2MU1vOwgQ3X7O16ezwlSf2lMzfURBj9c9qbq0c9cuX8uWjQBlN3IkUX
	 ACOhf8bZ4RuFg==
Date: Tue, 14 Nov 2023 17:50:13 -0500
From: Jakub Kicinski <kuba@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <srk@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, <r-gunasekaran@ti.com>, Roger
 Quadros <rogerq@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add entry for TI ICSSG Ethernet driver
Message-ID: <20231114175013.3ab9b056@kernel.org>
In-Reply-To: <20231113094656.3939317-1-danishanwar@ti.com>
References: <20231113094656.3939317-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Nov 2023 15:16:56 +0530 MD Danish Anwar wrote:
> Also add Roger and myself as maintainer.

> +TI ICSSG ETHERNET DRIVER (ICSSG)
> +R:	MD Danish Anwar <danishanwar@ti.com>
> +R:	Roger Quadros <rogerq@kernel.org>

Looks like this got (silently?) merged already, but you added
yourselves as R:eviewers not M:aintainers..


Return-Path: <netdev+bounces-40217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F257C61F6
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 02:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3191C20A1E
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 00:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59297632;
	Thu, 12 Oct 2023 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjbi5eqa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD2862F
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 00:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A453EC433C7;
	Thu, 12 Oct 2023 00:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697071447;
	bh=gii1/SY/IIQ0trlQ2uqpr/lhWhqx2RSOhlKsZb9MFHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mjbi5eqaRXNH3pe4v932grqsl0vVi3OqQtAF6gzwv9ba9dgmTy9bxxB1gl9HDL5tU
	 +h7byR2/28RgO5vK3WIAbf6dbDgC1+T1h2yKrjT8ftknEZjlqfho7k8yA6tLEAkUg8
	 wveMITdldXXDmJ2Z+sFHSM4exaq/LxWHXgfXGqgZRDBU2u9ZfmxBKm2fRPdesDxD+j
	 IsbkdzUFYG94oLEWV8pML48aPj4gpCoJw1uMQMIRR0dnJcWCsSa8TyN3hnu39AdUXG
	 2oJNdZk4uRnMPbyUkgseSIBRTEEHjCuugJeBQqJYHwzQ10ZaWOspWbxEE8ihwLEcM7
	 d40+yzz1jOmrg==
Date: Thu, 12 Oct 2023 08:43:56 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the imx-mxs tree with the net tree
Message-ID: <20231012004356.GR819755@dragon>
References: <20231012101434.1e5e7340@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012101434.1e5e7340@canb.auug.org.au>

On Thu, Oct 12, 2023 at 10:14:34AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the imx-mxs tree got a conflict in:
> 
>   arch/arm64/boot/dts/freescale/imx93.dtsi
> 
> between commit:
> 
>   23ed2be5404d ("arm64: dts: imx93: add the Flex-CAN stop mode by GPR")

Marc,

Is there any particular reason why this dts change needs to go via net
tree?  Otherwise, could you drop it from net and let it go via i.MX tree?

Shawn

> 
> from the net tree and commit:
> 
>   d34d2aa594d0 ("arm64: dts: imx93: add edma1 and edma2")
> 
> from the imx-mxs tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.


Return-Path: <netdev+bounces-209489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BDBB0FB45
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DE31C22F97
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3D6221DB7;
	Wed, 23 Jul 2025 20:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSmhp6Wu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3255D8F0;
	Wed, 23 Jul 2025 20:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753301382; cv=none; b=ZOEBGgHxY16Ifiv07sl0HYyIEx3RIdkQLKzRCvypmG73XLUdXxeiqu58yfP63PQC1tYB7+kTmLXysQF90PXaU+r7OCn2mo30PQax710nmq+ioj+OcnBEPQE8IZRbvpTOY5NXLdeEwHcNhp5QYjZPlBjqUk45guzkgVwRgKqIQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753301382; c=relaxed/simple;
	bh=elfby2ozlx71mk8E9H9uE/KG/7A43FiIZpOdbtogNNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3zUIchmnBi/vXUjxPJcJIB7Vq12tIlfjYqJz84U88Y4KWGDP/rNu5PupS8Js7h/Ulw4nHw9SMlwGoudVIjXuyHotrSywdZIZoi/mAOguNIPq//ZKea6jCwGu0je0qmEDqcD+XRpwbBJGumXx4QWnxkpDFWNKfBoOvXxfsVsImk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSmhp6Wu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F10C4CEE7;
	Wed, 23 Jul 2025 20:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753301381;
	bh=elfby2ozlx71mk8E9H9uE/KG/7A43FiIZpOdbtogNNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PSmhp6WulcBfgH+W2lewcXw0bTTXDrLFWeN0MYDyn6OxeH08djlrQHVhZgT5uZFCc
	 D3w3yaBiqueKTRxjjtv+rMLsEP/MQs40w8gat6EMlZOhSzzsnVNmXDvLTi177DZQb8
	 AZvnK6q2d88wD3BW7tglJ0RH1X/46RbuPpS6RvLP80TzV0jPVr7vi6g2M2ENr7ST+I
	 um1wp1Gfw0xVvv+npFYbqnNt8vwDMOwiA84/Hc8eM+fx3GsJLLDhaJGWwsCcVX60EF
	 KYvziwEbfjF/4ZGNG5vPMcvUYrFYK/7VbLFaOA0eqVm62g/Jqdhjz93CYZjuRzdHpd
	 rkGBHEAJSLaTA==
Date: Wed, 23 Jul 2025 21:09:34 +0100
From: Simon Horman <horms@kernel.org>
To: Yibo Dong <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] net: rnpgbe: Add build support for rnpgbe
Message-ID: <20250723200934.GO1036606@horms.kernel.org>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-2-dong100@mucse.com>
 <20250722112909.GF2459@horms.kernel.org>
 <0E9C9DD4FB65EC52+20250723030111.GA169181@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E9C9DD4FB65EC52+20250723030111.GA169181@nic-Precision-5820-Tower>

On Wed, Jul 23, 2025 at 11:01:11AM +0800, Yibo Dong wrote:
> On Tue, Jul 22, 2025 at 12:29:09PM +0100, Simon Horman wrote:
> > On Mon, Jul 21, 2025 at 07:32:24PM +0800, Dong Yibo wrote:

...

> But I can't get this warning follow steps in my local:
> ---
> - make x86_64_defconfig
> - make menuconfig  (select my driver rnpgbe to *)
> - make W=1 -j 20
> ---
> if I compile it with 'make W=1 C=1 -j 20', some errors like this:
> ---
> ./include/linux/skbuff.h:978:1: error: directive in macro's argument list
> ./include/linux/skbuff.h:981:1: error: directive in macro's argument list
> ........
> Segmentation fault
> ---
> I also tried to use nipa/tests/patch/build_allmodconfig_warn
> /build_allmodconfig.sh (not run the bot, just copy this sh to source
> code). It seems the same with 'make W=1 C=1 -j 20'.
> Is there something wrong for me? I want to get the warnings locally,
> then I can check it before sending patches. Any suggestions to me, please?
> Thanks for your feedback.

I would expect what you are trying to work.
And I certainly would not expect a segmentation fault.

I suspect that the version of Sparse you have is causing this problem
(although it is just a wild guess). I would suggest installing
from git. http://git.kernel.org/pub/scm/devel/sparse/sparse.git

The current HEAD is commit 0196afe16a50 ("Merge branch 'riscv'").
I have exercised it quite a lot.

For reference, I also use:
GCC 15.1.0 from here: https://mirrors.edge.kernel.org/pub/tools/crosstool/
Clang 20.1.8 from here: https://mirrors.edge.kernel.org/pub/tools/llvm/
(Because they are the latest non -rc compilers available there)



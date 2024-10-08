Return-Path: <netdev+bounces-133114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4734C994EB9
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 15:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC991C2545A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC291DEFED;
	Tue,  8 Oct 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJX/dR6I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FA81DE89A;
	Tue,  8 Oct 2024 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393629; cv=none; b=CJV04VDNXmvmEKaYyooMd3SEEnCwqOj5pMuNq4SA/edCnivsaK8Wj8BaZxJSQHKCLLvaA1jt61FYiJXGX/1gLsBKpxZw85iWz5SOAj1KulSb/FfN2QwAVQYR3gO717BgCqnNZSKTsT1SHEjs583BuEgleMcnIvOTHi2WHbZ6AH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393629; c=relaxed/simple;
	bh=8QYTu2R3ELrntIPpNwS8RKOjH7wjZR6yhFMJDm91l7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpABNNCPNao2g6YP6xRzPb57YpaXRiXkHp+QfVk4giQ7m2/8s3bNJEF3OVmb10wmjYN9QZeShheUclTT9skv92C/tTGNKhnrJRpntmDd660eei5I/HpF6emOLEZ3c7TAkEwkGyWDtTQxbBDAqGpkorQO15vCaeYgyrQ4XoHcL3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJX/dR6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A73C4CEC7;
	Tue,  8 Oct 2024 13:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728393628;
	bh=8QYTu2R3ELrntIPpNwS8RKOjH7wjZR6yhFMJDm91l7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hJX/dR6Ijk12GM3SUUecYFxU5IMrnLVyy+pxGkPJJqK+XXOSbRNss7Bmi//ImV0aG
	 uQ/xCfVfz3n5I5DE/7AkIRWmgyYudZA6q82zw/sWX/h7Yqe9kx32fYVjf/d1lEJHbT
	 H4QJII1Ct1lSAoz0ZPMD+TtK4uvMdGKok/XFvgJgdbs2duDwc5Nt1N3GxOCnn06Vbb
	 s+drfZVPQVLgUucDRpv2O8+wIUk7t55KXyykXSirEthkUDp8xuLv+/UAfZQVVKmVMm
	 TVrQ19IH+jVlZPymBxd6BcFUERPpPTwQEC1ucNtrE+Z/yjbKY6YMsgJUHZhxTgVlNp
	 98V0aDhaPGo/A==
Date: Tue, 8 Oct 2024 14:20:24 +0100
From: Simon Horman <horms@kernel.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 0/6] octeontx2-pf: handle otx2_mbox_get_rsp errors
Message-ID: <20241008132024.GN32733@kernel.org>
References: <20241006163832.1739-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006163832.1739-1-kdipendra88@gmail.com>

On Sun, Oct 06, 2024 at 04:38:31PM +0000, Dipendra Khadka wrote:
> This patch series improves error handling in the Marvell OcteonTX2
> NIC driver. Specifically, it adds error pointer checks after
> otx2_mbox_get_rsp() to ensure the driver handles error cases more
> gracefully.
> 
> Changes in v3:
> - Created a patch-set as per the feedback
> - Corrected patch subject
> - Added error handling in the new files
> 
> Dipendra Khadka (6):
>   octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_common.c
>   octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_ethtool.c
>   octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_flows.c
>   octeontx2-pf: handle otx2_mbox_get_rsp errors in cn10k.c
>   octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dmac_flt.c
>   octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dcbnl.c
> 
>  drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c   |  5 +++++
>  .../net/ethernet/marvell/octeontx2/nic/otx2_common.c |  4 ++++
>  .../net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c  |  5 +++++
>  .../ethernet/marvell/octeontx2/nic/otx2_dmac_flt.c   |  9 +++++++++
>  .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c    | 10 ++++++++++
>  .../net/ethernet/marvell/octeontx2/nic/otx2_flows.c  | 12 ++++++++++++
>  6 files changed, 45 insertions(+)

Thanks for bundling this up in a patch-set.

For reference, it does seem that the threading of this patchset is broken.
Perhaps there was some option you passed to git send-email that caused
this. In any case, please look into this for future submissions.

Also, please use ./scripts/get_maintainer.pl patch_file to generate
the CC list for patches.

Lastly, b4 can help with both of the above.


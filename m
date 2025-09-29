Return-Path: <netdev+bounces-227225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CB4BAA8BE
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 22:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433581C5F2B
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 20:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99078227599;
	Mon, 29 Sep 2025 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqw8dMc9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747E017BED0
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759176128; cv=none; b=F7rmGW6BRu1w3d4piulipOi0qtll+b10c0j4reUOthyN6qL3VPrp+7Z2KgGaen/2Y1ZB8QAcDo7/XDFS4uRo8fCR5fIJnUWKFH7BUzj0NSyngo5Chd5a0UEZk6DEUKCSqXBhnUHNY5OGQ3eBGw4sSyQJkasFshLlK3lA+xEaUs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759176128; c=relaxed/simple;
	bh=N/ChDYgBvZGU5MIWCb8Ca1Rjl6cAMp38hbm8uOP9e4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGMdJGTIWBBmmzH8KnNRrsiN/PFJdtiQazWgDWVv1j0ma27Lz4xD+yPQwLPlMTsto/Y/P0m0uYULD28aqUWWfU2xCFCPlVdcr6sfhFA6vI9vj59R5jFWg6hMoglN3763m4N94GvVtW7AFU/6hqiimJPc6bM/t/MuHTE/FuQn0Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqw8dMc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F8CC4CEF4;
	Mon, 29 Sep 2025 20:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759176128;
	bh=N/ChDYgBvZGU5MIWCb8Ca1Rjl6cAMp38hbm8uOP9e4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oqw8dMc9r/XQeiB250lqkOQ/AVOW8u/6MGrpTB4OT+zkGPHOEIt3XUsiFjAlG7oJK
	 Pq2z8GYKgwWXi330x+58CZRGd4e5rlg9mXgRXG8DpnCTWs7f3hbqSMXKH4mauyASL0
	 TGexux7z2p+Gq6977sLDOpuH2ZSoC7xw1TFT7GQjsJZaAV30PZyZxpJwvsVAJFm7Db
	 NEEXpq7ZrP0WXDYlHC4DMAAXTSj75lphiXWcRIKW7rQpdkvTRxw6LIhz3aTX+C9fqk
	 qXSVard8sCv0BbUu2hbTukNDMtLjlP+jsAvM+si7lkStE5nbLKF/4QRe9dDHNgyDXa
	 X3ItrJ8NXJz3Q==
Date: Mon, 29 Sep 2025 23:02:03 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: jgg@ziepe.ca, michael.chan@broadcom.com, dave.jiang@intel.com,
	saeedm@nvidia.com, Jonathan.Cameron@huawei.com, davem@davemloft.net,
	corbet@lwn.net, edumazet@google.com, gospo@broadcom.com,
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v4 0/5]  bnxt_fwctl: fwctl for Broadcom
 Netxtreme devices
Message-ID: <20250929200203.GD324804@unreal>
References: <20250927093930.552191-1-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927093930.552191-1-pavan.chebbi@broadcom.com>

On Sat, Sep 27, 2025 at 02:39:25AM -0700, Pavan Chebbi wrote:
> Introducing bnxt_fwctl which follows along Jason's work [1].
> It is an aux bus driver that enables fwctl for Broadcom
> NetXtreme 574xx, 575xx and 576xx series chipsets by using
> bnxt driver's capability to talk to devices' firmware.
> 
> The first patch moves the ULP definitions to a common place
> inside include/linux/bnxt/. The second and third patches
> refactor and extend the existing bnxt aux bus functions to
> be able to add more than one auxiliary device. The last three
> patches create an additional bnxt aux device, add bnxt_fwctl,
> and the documentation.
> 
> [1] https://lore.kernel.org/netdev/0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com/
> 
> v4: In patch #4, added the missing kfree on error for response
> buffer. Improved documentation in patch #5 based on comments
> from Dave.
> 
> v3: Addressed the review comments as below
> Patch #1: Removed redundant common.h [thanks Saeed]
> Patch #2 and #3 merged into a single patch [thanks Jonathan]
> Patch #3: Addressed comments from Jonathan
> Patch #4 and #5: Addressed comments from Jonathan and Dave
> 
> v2: In patch #5, fixed a sparse warning where a __le16 was
> degraded to an integer. Also addressed kdoc warnings for
> include/uapi/fwctl/bnxt.h in the same patch.
> 
> v1: https://lore.kernel.org/netdev/20250922090851.719913-1-pavan.chebbi@broadcom.com/
> 
> The following are changes since commit fec734e8d564d55fb6bd4909ae2e68814d21d0a1:
>   Merge tag 'riscv-for-linus-v6.17-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
> and are available in the git repository at:
>   https://github.com/pavanchebbi/linux/tree/bnxt_fwctl_v4
> 
> Pavan Chebbi (5):
>   bnxt_en: Move common definitions to include/linux/bnxt/
>   bnxt_en: Refactor aux bus functions to be more generic
>   bnxt_en: Create an aux device for fwctl

Like I said in v0, https://lore.kernel.org/all/20250929190601.GC324804@unreal
I think that aux logic is over engineered and shouldn't exist.

Thanks


>   bnxt_fwctl: Add bnxt fwctl device
>   bnxt_fwctl: Add documentation entries
> 
>  .../userspace-api/fwctl/bnxt_fwctl.rst        |  78 +++
>  Documentation/userspace-api/fwctl/fwctl.rst   |   1 +
>  Documentation/userspace-api/fwctl/index.rst   |   1 +
>  MAINTAINERS                                   |   6 +
>  drivers/fwctl/Kconfig                         |  11 +
>  drivers/fwctl/Makefile                        |   1 +
>  drivers/fwctl/bnxt/Makefile                   |   4 +
>  drivers/fwctl/bnxt/main.c                     | 454 ++++++++++++++++++
>  drivers/infiniband/hw/bnxt_re/debugfs.c       |   2 +-
>  drivers/infiniband/hw/bnxt_re/main.c          |   2 +-
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c      |   2 +-
>  drivers/infiniband/hw/bnxt_re/qplib_res.h     |   2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  30 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  12 +-
>  .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   2 +-
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   4 +-
>  .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |   2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 245 +++++++---
>  .../bnxt_ulp.h => include/linux/bnxt/ulp.h    |  22 +-
>  include/uapi/fwctl/bnxt.h                     |  64 +++
>  include/uapi/fwctl/fwctl.h                    |   1 +
>  21 files changed, 858 insertions(+), 88 deletions(-)
>  create mode 100644 Documentation/userspace-api/fwctl/bnxt_fwctl.rst
>  create mode 100644 drivers/fwctl/bnxt/Makefile
>  create mode 100644 drivers/fwctl/bnxt/main.c
>  rename drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h => include/linux/bnxt/ulp.h (87%)
>  create mode 100644 include/uapi/fwctl/bnxt.h
> 
> -- 
> 2.39.1
> 


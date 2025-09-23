Return-Path: <netdev+bounces-225684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7BEB96D07
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 18:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDCA3B10D9
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088FF2F6198;
	Tue, 23 Sep 2025 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXf3E5MF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D895A322A36
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644726; cv=none; b=FXiDV+7pX+tDRhnfCrHkU2/7upncP3kFxazMESQXyleh2y3wAct8zZD1wDCbTyABCGj1XN5mZqdmCKlBKVkUv5yUSsw0JgR4qPyZhJXfzqWR/mKCApN+lsz6og0nx9xeclARRiiqPc2VURtBYZG35keqeDShs/qdMc57+icUqy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644726; c=relaxed/simple;
	bh=Ksch2+BSpFHugi8K2XfWfnQpzGjm4zc4+6bW101vXvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGtBi21uF40cJvwWlrXEcBdm0XKLkfo52XrRqWSvtp2g7LrJzzHM5JOduDs/YLFEuchUGlmhRJqw8JcHjzH5HdgawS1j7xXVjccqvZYfEbsyGX79XVxZT+1Dc31W4zjY3zJMs0nbODyXjxmp1HZvBYrE33Ddvtzd+HKH3+pZLi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXf3E5MF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF3DC4CEF5;
	Tue, 23 Sep 2025 16:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758644726;
	bh=Ksch2+BSpFHugi8K2XfWfnQpzGjm4zc4+6bW101vXvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BXf3E5MFvN4Z8p/kmbBmdl8hdO/LTu+cmdYKvKzZI0d/5M7qnei4TfjkjqlJ4eVez
	 P45kIYPAkAIij8Nr8E+Ey8P1bQPaNfkpQ6gh8uF/4Ud8IIBh5/nVovWpvMdqMHijei
	 +5boQTHelkl/uB5p4ymU+/fz4DU8Y4suL8RwKGSxNVtqnzC+7PZJEi493iqlAiQXoC
	 xCZ8rezSgljSJrPianoGda8Vc5swIwhXcj0qNiglUB9G/8iJvdePre5GibilJn84Ff
	 pQQMng3KaKud43vu6oWcuPT4sCc0ZSvXamS4nRakalpAKQX35XHInfLRdGS0Yd4Oij
	 LXBI+3aRDjpjg==
Date: Tue, 23 Sep 2025 09:25:24 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: jgg@ziepe.ca, michael.chan@broadcom.com, dave.jiang@intel.com,
	saeedm@nvidia.com, Jonathan.Cameron@huawei.com, davem@davemloft.net,
	corbet@lwn.net, edumazet@google.com, gospo@broadcom.com,
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, selvin.xavier@broadcom.com, leon@kernel.org,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v2 0/6] bnxt_fwctl: fwctl for Broadcom Netxtreme
 devices
Message-ID: <aNLJ9NjHKz93hixO@x130>
References: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250923095825.901529-1-pavan.chebbi@broadcom.com>

On 23 Sep 02:58, Pavan Chebbi wrote:
>Introducing bnxt_fwctl which follows along Jason's work [1].
>It is an aux bus driver that enables fwctl for Broadcom
>NetXtreme 574xx, 575xx and 576xx series chipsets by using
>bnxt driver's capability to talk to devices' firmware.
>
>The first patch moves the ULP definitions to a common place
>inside include/linux/bnxt/. The second and third patches
>refactor and extend the existing bnxt aux bus functions to
>be able to add more than one auxiliary device. The last three
>patches create an additional bnxt aux device, add bnxt_fwctl,
>and the documentation.
>
>[1] https://lore.kernel.org/netdev/0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com/
>
>v2: In patch #5, fixed a sparse warning where a __le16 was
>degraded to an integer. Also addressed kdoc warnings for
>include/uapi/fwctl/bnxt.h in the same patch.
>
>v1: https://lore.kernel.org/netdev/20250922090851.719913-1-pavan.chebbi@broadcom.com/
>
>Pavan Chebbi (6):
>  bnxt_en: Move common definitions to include/linux/bnxt/
>  bnxt_en: Refactor aux bus functions to be generic
>  bnxt_en: Make a lookup table for supported aux bus devices
>  bnxt_en: Create an aux device for fwctl
>  bnxt_fwctl: Add bnxt fwctl device
>  bnxt_fwctl: Add documentation entries
>
> .../userspace-api/fwctl/bnxt_fwctl.rst        |  27 ++
> Documentation/userspace-api/fwctl/fwctl.rst   |   1 +
> Documentation/userspace-api/fwctl/index.rst   |   1 +
> MAINTAINERS                                   |   6 +
> drivers/fwctl/Kconfig                         |  11 +
> drivers/fwctl/Makefile                        |   1 +
> drivers/fwctl/bnxt/Makefile                   |   4 +
> drivers/fwctl/bnxt/main.c                     | 297 ++++++++++++++++++
> drivers/infiniband/hw/bnxt_re/debugfs.c       |   2 +-
> drivers/infiniband/hw/bnxt_re/main.c          |   2 +-
> drivers/infiniband/hw/bnxt_re/qplib_fp.c      |   2 +-
> drivers/infiniband/hw/bnxt_re/qplib_res.h     |   2 +-
> drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  30 +-
> drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  13 +-
> .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   2 +-
> .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   4 +-
> .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |   2 +-
> drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 266 ++++++++++++----
> include/linux/bnxt/common.h                   |  20 ++
> .../bnxt_ulp.h => include/linux/bnxt/ulp.h    |  14 +-
> include/uapi/fwctl/bnxt.h                     |  63 ++++
> include/uapi/fwctl/fwctl.h                    |   1 +
> 22 files changed, 683 insertions(+), 88 deletions(-)
> create mode 100644 Documentation/userspace-api/fwctl/bnxt_fwctl.rst
> create mode 100644 drivers/fwctl/bnxt/Makefile
> create mode 100644 drivers/fwctl/bnxt/main.c
> create mode 100644 include/linux/bnxt/common.h
> rename drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h => include/linux/bnxt/ulp.h (90%)
> create mode 100644 include/uapi/fwctl/bnxt.h
>

We need to better plan the target tree, this series is touching 3
sub-systems, this is very dangerous this late in the release cycle.

To apply this I would recommend a side branch to be pulled into all
subsystems at once before merge window,

 From the patch planing it seems that:
1. First patch infra common code movement. (rdma + netdev)
2. 2nd..4th patches aux refactoring (netdev only)
3. final patch bnxt fwctl (fwctl only)



>-- 
>2.39.1
>
>


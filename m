Return-Path: <netdev+bounces-225206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08280B8FF2D
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 12:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D02D4E02BD
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 10:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99677283FE8;
	Mon, 22 Sep 2025 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vikacqF4"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA512773EF
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536100; cv=none; b=RCgrVjnoYqW3b7Nefo3wJcKj4hR8MCRp0UapzE6eXYspKIpB8UkY/CS/sUbwh1ZahMkaJ+eALJDMXy07nIUBWQ3TxaFHui7kBiqKhnR5lNHbGjUNnkra30lzJbSXaDYNpUs/nKAa1SONuXi9Y0XxcVGk3MyRlSCXUhVcWG3H/WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536100; c=relaxed/simple;
	bh=/C4F1hxd5AEzdt8gJscu0NEPgMNiLJzwg5fUO74CkRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWNzuQPH+R4+vVrDuYG37bJOUoaLA6VDsfyCCfKvl9Lkvah7TkGMBS9BdSQoD6sFRoMV0FrkvqQzX5Tot6AcvDoUxDWNAbNXlTXAhpzqG+NhDiyILLovkAISGqeBCSoCBTsysW443tOEhRzSLn/G5Ga8o839zd5eHSTHqVdutFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vikacqF4; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2e8aaa9b-f783-4fb2-89b5-8e0978edea33@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758536095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PvS7pnVBJGP/Kboa7ZTklGo2lHDaQKSkJiAjzSui8oo=;
	b=vikacqF4pAYnYuetD7En5rb6kSY9PmHR2G2CcvhCmFVb4UDNQaGM3RU2ClvJHMeH1M+fKw
	zQAZYCZt0NLuIMaBfm+OU5XvnP3u+juPdKsblQ3YHI0fCBfWW8UOhDj8uUWVNg9Nx5+C0g
	v2abAQoZWifPHlGai7dI59vId0Ex7B0=
Date: Mon, 22 Sep 2025 11:14:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 0/5] add FEC bins histogram report via ethtool
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org,
 Donald Hunter <donald.hunter@gmail.com>, Carolina Jubran
 <cjubran@nvidia.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <20250919194651.2164987-1-vadim.fedorenko@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250919194651.2164987-1-vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 19/09/2025 20:46, Vadim Fedorenko wrote:
> IEEE 802.3ck-2022 defines counters for FEC bins and 802.3df-2024
> clarifies it a bit further. Implement reporting interface through as
> addition to FEC stats available in ethtool. NetDevSim driver has simple
> implementation as an example while mlx5 has much more complex solution.
> 
> The example query is the same as usual FEC statistics while the answer
> is a bit more verbose:
> 
> [vmuser@archvm9 linux]$ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/ethtool.yaml --do fec-get --json '{"header":{"dev-index": 10, "flags": 4}}'
> {'auto': 0,
>   'header': {'dev-index': 10, 'dev-name': 'eni10np1'},
>   'modes': {'bits': {}, 'nomask': True, 'size': 121},
>   'stats': {'corr-bits': [],
>             'corrected': [123],
>             'hist': [{'bin-high': 0,
>                       'bin-low': 0,
>                       'bin-val': 445,
>                       'bin-val-per-lane': [125, 120, 100, 100]},
>                      {'bin-high': 3, 'bin-low': 1, 'bin-val': 12},
>                      {'bin-high': 7,
>                       'bin-low': 4,
>                       'bin-val': 2,
>                       'bin-val-per-lane': [2, 0, 0, 0]}],
>             'uncorr': [4]}}
> 
> v3 -> v4:
> * update spec to avoid using underscores
> * make core accumulate per-lane errors into bin error counter
> * adjust wording in Documentation
> * improve FEC type check in mlx5
> * add selftest to do sanity check of reported histogram
> * partially carry-over Rb tags from Aleksandr because of logical changes
> v3 Link - https://lore.kernel.org/netdev/20250916191257.13343-1-vadim.fedorenko@linux.dev/
> v2 -> v3:
> * fix yaml spec to use binary array for histogram per-lane values
> * fix spelling
> v1 -> v2:
> * fix memset size of FEC histogram bins in mlx5
> * adjust fbnic driver FEC stats callback
> 
> Links to RFC discussions:
> v1 - https://lore.kernel.org/netdev/20250729102354.771859-1-vadfed@meta.com/
> v2 - https://lore.kernel.org/netdev/20250731231019.1809172-1-vadfed@meta.com/
> v3 - https://lore.kernel.org/netdev/20250802063024.2423022-1-vadfed@meta.com/
> v4 - https://lore.kernel.org/netdev/20250807155924.2272507-1-vadfed@meta.com/
> v5 - https://lore.kernel.org/netdev/20250815132729.2251597-1-vadfed@meta.com/
> 
> Carolina Jubran (3):
>    net/mlx5e: Don't query FEC statistics when FEC is disabled
>    net/mlx5e: Add logic to read RS-FEC histogram bin ranges from PPHCR
>    net/mlx5e: Report RS-FEC histogram statistics via ethtool
> 
> Vadim Fedorenko (2):
>    ethtool: add FEC bins histogram report
>    selftests: net-drv: stats: sanity check FEC histogram
> 
>   Documentation/netlink/specs/ethtool.yaml      |  26 ++++
>   Documentation/networking/ethtool-netlink.rst  |   5 +
>   .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   3 +-
>   .../ethernet/fungible/funeth/funeth_ethtool.c |   3 +-
>   .../ethernet/hisilicon/hns3/hns3_ethtool.c    |   3 +-
>   drivers/net/ethernet/intel/ice/ice_ethtool.c  |   4 +-
>   .../marvell/octeontx2/nic/otx2_ethtool.c      |   3 +-
>   drivers/net/ethernet/mellanox/mlx5/core/en.h  |   1 +
>   .../ethernet/mellanox/mlx5/core/en_ethtool.c  |   5 +-
>   .../net/ethernet/mellanox/mlx5/core/en_main.c |   8 ++
>   .../ethernet/mellanox/mlx5/core/en_stats.c    | 125 +++++++++++++++++-
>   .../ethernet/mellanox/mlx5/core/en_stats.h    |   3 +-
>   .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |   3 +-
>   drivers/net/ethernet/sfc/ethtool.c            |   3 +-
>   drivers/net/ethernet/sfc/siena/ethtool.c      |   3 +-
>   drivers/net/netdevsim/ethtool.c               |  25 +++-
>   include/linux/ethtool.h                       |  25 +++-
>   .../uapi/linux/ethtool_netlink_generated.h    |  11 ++
>   net/ethtool/fec.c                             |  75 ++++++++++-
>   tools/testing/selftests/drivers/net/stats.py  |  35 ++++-
>   20 files changed, 345 insertions(+), 24 deletions(-)

selftest needs fix in error handling path, v5 is on the way---
pw-bot: cr


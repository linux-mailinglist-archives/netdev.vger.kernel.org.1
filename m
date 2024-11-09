Return-Path: <netdev+bounces-143491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258A49C29C5
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 04:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB581F22864
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 03:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D6236124;
	Sat,  9 Nov 2024 03:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtylh00V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F3F139D;
	Sat,  9 Nov 2024 03:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731124659; cv=none; b=d7JzCssApzryrWwLyurba4jleUl3+iim7OIzq7e1Y+N0HfYNYoDd8Rfma2+xs3ItmgsqOF2N8IkH853fbwnDa6BeP2hjbwV+LCH5gJvJADsMrFGrP2vBoEAODEubjoOrS6YWWb3zdzhUxKpC7bOlog4q/wVf5AGP7Jt7/KbBgUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731124659; c=relaxed/simple;
	bh=tkV6VvnHEJejojLw8G956yRUq8BcwODyK/FjCQ9qsyM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+1BT+wssv5GpGPuq/NiEi8zKEbwYwJkyId6KIUcKZC57bTlH4Vof01P+LZCXfhzvtxrUAyfc+Db68I1tQG0dEkAJywgCmFjkqCEJfGTsLqv7WQPGR9P9xQNvvoO9+YIdYZO3ow4uQLZjQogV3CkuvgzVfJ0YWR7RRsfVLJG2X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtylh00V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C677AC4CEC6;
	Sat,  9 Nov 2024 03:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731124658;
	bh=tkV6VvnHEJejojLw8G956yRUq8BcwODyK/FjCQ9qsyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gtylh00VJy/3ou2soflLCaqQK7xkt5ZkRTST4CmQwenNqysV/Kb1aSRGYh9Uvqpin
	 8oyMKKGaTL6ChG2z+9BPy3SC8DtUalHFMmY6V9I9gW74+fpS+pJeBIy6ihDBNMzcE3
	 goHbubYnCa3DpuDgoGWmaPgzehsec8U3ZttV33jIuf3Y9sj7PG2fsyejSjxsjnS4y7
	 zBI7B8ap7cSssrUOmqBjmQXctAtguXmLLS6lv6sYsZ4OPTaezwVv94rSd7L7AZ8cSf
	 yJQaBvdE7S9JzTNh/Lned+fqtLslXLr3x92N9pYnOTdz+F+CGMxzGY3gCvamW+uVnc
	 492apWg1AP+0Q==
Date: Fri, 8 Nov 2024 19:57:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sanman Pradhan <sanman.p211993@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kernel-team@meta.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, mohsin.bashr@gmail.com,
 sanmanpradhan@meta.com, andrew+netdev@lunn.ch, vadim.fedorenko@linux.dev,
 jdamato@fastly.com, sdf@fomichev.me, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] eth: fbnic: Add PCIe hardware statistics
Message-ID: <20241108195736.7b189843@kernel.org>
In-Reply-To: <20241109025905.1531196-1-sanman.p211993@gmail.com>
References: <20241109025905.1531196-1-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Nov 2024 18:59:05 -0800 Sanman Pradhan wrote:
> v4:
> 	- Fix indentations
> 	- Adding missing updates for previous versions

Please don't post multiple versions a day, per:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr

>  .../device_drivers/ethernet/meta/fbnic.rst    |  26 ++++
>  drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  37 ++++++
>  .../net/ethernet/meta/fbnic/fbnic_debugfs.c   |  54 +++++++++
>  .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 114 ++++++++++++++++++
>  .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  12 ++
>  .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   3 +
>  6 files changed, 246 insertions(+)
>  create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c

I just realized that you couldn't have tested this patch properly
because you added a file, did not include it in the Makefile, and
yet the build doesn't break. So you must be calling neither
fbnic_dbg_init() nor fbnic_dbg_exit().

Not great.
-- 
pw-bot: cr


Return-Path: <netdev+bounces-205985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9157B0104B
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 02:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D9F7B7673
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 00:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED67EBA33;
	Fri, 11 Jul 2025 00:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYQwsq6h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54588F77;
	Fri, 11 Jul 2025 00:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752194362; cv=none; b=N2MeEBvBfv9bBxWrZtOBz5suDdaZ4Teve6kOqa11GYI4+6GA5zXK5EfZve6cY4Gi+oFYAH6vfAldZur3TOT1l1tZQoHprsEVAOgNLIsRtfB+dSQ8zyMHuf2d75whZbIaUmuE859HT5TS4Rn9i4V38Z6g3me35Pjoqn1+5pMHZpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752194362; c=relaxed/simple;
	bh=xknLzeXRJnVY09GBHZbVbm9Wpdyc+ZapDCt/jjo14SI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1a7jS+/UbPq3e6505RmyxrxEQj0+MO4g00NLRjDf69+hAEqyCNg9Alnnqg/O5Ti2LYIKm0mUQZyZk3TYFSiTnyTeUZswR1DkhvgA8JBnosFMJPJOxCO6NKABC+R2mWZjpaYGilJ8YDHLnfS9QVkvHvjrHZbgRqqetxW5lAh1AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYQwsq6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922C2C4CEE3;
	Fri, 11 Jul 2025 00:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752194362;
	bh=xknLzeXRJnVY09GBHZbVbm9Wpdyc+ZapDCt/jjo14SI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LYQwsq6hNKyjDYUJEEDi7aGE0iY8aqaMWW7OZzvFhmWstt+v4K0h8YzYKb6zgUyds
	 uYbxOySsv3+zIFJRrLP9VfVoOdnoE4fHjfVBY68qy91R7KXl2Z0DH1ycRddqVT6Gyd
	 s7x50LwtuYhniOWWiJB244k0qa58wAY8O6ISdEbWutGB0zpgCQzCho5haabzzvCLMk
	 PasvN40o/kRlGvsw1xzbP6NsoBst66fWwNkH7ptksCwP+zSgtJUiSil5jJECRAMGL8
	 OTJU63SQnVMjqiMldyCV/jCbmnpk9TshWvnF7cmGuwlBQsrkPmt5DZAL3EzWLJNiU1
	 fNwqBHM1oXnCQ==
Date: Thu, 10 Jul 2025 17:39:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <salil.mehta@huawei.com>, <arnd@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 09/11] net: hns3: use seq_file for files in
 common/ of hclge layer
Message-ID: <20250710173920.501fae25@kernel.org>
In-Reply-To: <20250708130029.1310872-10-shaojijie@huawei.com>
References: <20250708130029.1310872-1-shaojijie@huawei.com>
	<20250708130029.1310872-10-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Jul 2025 21:00:27 +0800 Jijie Shao wrote:
> From: Yonglong Liu <liuyonglong@huawei.com>
> 
> This patch use seq_file for the following nodes:
> mng_tbl/loopback/interrupt_info/reset_info/imp_info/ncl_config/
> mac_tnl_status/service_task_info/vlan_config/ptp_info

Looks like some of the functions removed by the last patch need to be
removed here already, otherwise we get a transient warning:

warning: unused function 'hns3_dbg_common_file_init' [-Wunused-function] 1094 | hns3_dbg_common_file_init(struct hnae3_handle *handle, u32 cmd)
      | ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:731:13: warning: unused function 'hclge_dbg_fill_content' [-Wunused-function]
  731 | static void hclge_dbg_fill_content(char *content, u16 len,
      |             ^~~~~~~~~~~~~~~~~~~~~~

There's another one in patch 10.
-- 
pw-bot: cr


Return-Path: <netdev+bounces-198998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3B4ADE9EC
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2500F7A5165
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8958029B8FE;
	Wed, 18 Jun 2025 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLlpKVfi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4E928000E;
	Wed, 18 Jun 2025 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246170; cv=none; b=qmRGBdr+55CaC9cJ6lthCwMSJurXY+BvOdMla0NPQOQIPxj4fdFDCrGLoOmI9zoRWrtumXc2e3jDzDIey9+Y6saPPRoQAUDES5Y/APzl0GkPLNAolMyzKdrrphZn8ZiHQFsg7FooYxNlckvnMHQ8j7CxHqSxxdKSK8+AYVZ5aRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246170; c=relaxed/simple;
	bh=P/tsJXrIVD/mMrWZkXJV/4fPknL/fAmsPwK62emU3tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtUOUSTasjuv4S3c10E03Z6Ea2kWUmjZ871KifAKVaRSvDwINlqe6TynxLuSs2mRJarytqKEUgrppBHek+9PIeddOmv04KIJekVboZE7Ifc1XIspDTz5GeL2f1d/D+xyMmFucVK/g5IKBEJOdFKSH4meWBec8tiSl6sVva6QRYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLlpKVfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF69EC4CEE7;
	Wed, 18 Jun 2025 11:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750246169;
	bh=P/tsJXrIVD/mMrWZkXJV/4fPknL/fAmsPwK62emU3tQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZLlpKVfi6ntcNnTzpvJJsAOATF5ZUTGn+ajbhoYrVT91ay9MbSwjeVbBI2Je60xPV
	 xwwsDqj9acKEoLAzvfS2Grum2ke6yFC9GGo9ONhm5dWG2Z2P5Z3JoH3CahIAFJQyP4
	 MvZS9qPDU47/oTgCIMDldB+jPS9XtW7+ikXBLufap++tpC0nqimBedA9OXoubLfzpQ
	 w6+XIdkOWmIZj5KlNlwcXi7w6LU3Rl046SmJPtYKfPMYBaq05J3+GkYPmIkdzRmAXN
	 MVyuGTl5t+jhXUPrR1anjqIIztzngGyYZr1GyGmS8cdYIk/bnXA5iVRHTs0Y5cgJVt
	 fXuzvSlq7GJIA==
Date: Wed, 18 Jun 2025 12:29:24 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.swiatkowski@linux.intel.com
Subject: Re: [PATCH V2 net-next 8/8] net: hns3: clear hns alarm: comparison
 of integer expressions of different signedness
Message-ID: <20250618112924.GL1699@horms.kernel.org>
References: <20250617010255.1183069-1-shaojijie@huawei.com>
 <20250617010255.1183069-9-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617010255.1183069-9-shaojijie@huawei.com>

On Tue, Jun 17, 2025 at 09:02:55AM +0800, Jijie Shao wrote:
> From: Peiyang Wang <wangpeiyang1@huawei.com>
> 
> A static alarm exists in the hns and needs to be cleared.

I'm curious to know if you used a tool to flag this.

> 
> The alarm is comparison of integer expressions of different
> signedness including 's64' and 'long unsigned int',
> 'int' and 'long unsigned int', 'u32' and 'int',
> 'int' and 'unsigned int'.
> 
> Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  .../hns3/hns3_common/hclge_comm_cmd.c         |  2 +-
>  .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 22 +++++++-------
>  .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  2 +-
>  .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  4 +--
>  .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 13 ++++----
>  .../hisilicon/hns3/hns3pf/hclge_main.c        | 30 +++++++++----------
>  .../hisilicon/hns3/hns3pf/hclge_mbx.c         |  7 +++--
>  .../hisilicon/hns3/hns3pf/hclge_mdio.c        |  2 +-
>  .../hisilicon/hns3/hns3pf/hclge_ptp.h         |  2 +-
>  .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  2 +-
>  .../hisilicon/hns3/hns3vf/hclgevf_mbx.c       |  2 +-
>  11 files changed, 44 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
> index 4ad4e8ab2f1f..37396ca4ecfc 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
> @@ -348,7 +348,7 @@ static int hclge_comm_cmd_csq_clean(struct hclge_comm_hw *hw)
>  static int hclge_comm_cmd_csq_done(struct hclge_comm_hw *hw)
>  {
>  	u32 head = hclge_comm_read_dev(hw, HCLGE_COMM_NIC_CSQ_HEAD_REG);
> -	return head == hw->cmq.csq.next_to_use;
> +	return head == (u32)hw->cmq.csq.next_to_use;

Can the type of next_to_use be changed to an unsigned type?
It would be nice to avoid casts.

>  }
>

...


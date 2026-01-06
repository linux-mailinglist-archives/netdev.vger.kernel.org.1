Return-Path: <netdev+bounces-247268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD50CF6633
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 02:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7EBE30DB5FD
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 01:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C56731AA8B;
	Tue,  6 Jan 2026 01:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m61wEo2W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F10318138;
	Tue,  6 Jan 2026 01:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663702; cv=none; b=VuCO0AIFhcPSQ8TYSR1M8L9NLouypw5DB/NOnSm8ri0mxTPo4eQp2MHfF90vuAtDqNTj3DS2W4PnPZJJYcBN2Km7MnVoKVtAm5Ez97VKU/ZjaErtV6XS9aAXWbof3Msuy5+OTXRMnmTn2Z0s/ucRkNdb1NSzWafAJHFqL2Txni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663702; c=relaxed/simple;
	bh=ujW7u+Y1VhHmOg9SXX9p5QNo2NFrWNF4bD49udhNf08=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wl0ObbFYArE4it5gviF9Ui7Y1v0Jxi5NA7Oc4OhuqSkJ9cFXfJ6zZ7nlxV0XdqiggP1Xr9f01aCW2biacrCSh9wUHEF65ZqFjYNWZ5/mo+96Yc8S9myCowRZH6QshcwOcps3+bhqoRbxbK5Mi/m9BPOaVEyuIAd6lvFymK7Y5AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m61wEo2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F3EC116D0;
	Tue,  6 Jan 2026 01:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767663701;
	bh=ujW7u+Y1VhHmOg9SXX9p5QNo2NFrWNF4bD49udhNf08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m61wEo2W6z6OO84mN5AWeqYSH8SaZC4Gt6OnuUYLHs4QfYX0rY9cyw7bfKfRflzjE
	 uBo+BL2biShqPQiPMu826cbQyHyRIICAuwpNWGO2S7pd0WRxwB01MSUQXEv4F7s+5K
	 Q3U6coNBuS5v7PcMKnuYLpKHC9IlduyIr1kmdX1pDPhGNzSgqc2EG/ReypR+0Eg4Jk
	 50izazflm3H4b+LaX80+kCqoB8QRZZV9KcGyU6RJG9nu7G+//1iX8ayi/wY26eQwjS
	 BX1fVYzkDctyK/mXsHZST7fj8mk50VaBfoYekBmx8UQ1DJljGiYUGxT5k1PLXPc+Ol
	 4b0xdkOCuEvDw==
Date: Mon, 5 Jan 2026 17:41:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, <netdev@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Markus Elfring <Markus.Elfring@web.de>, Pavan
 Chebbi <pavan.chebbi@broadcom.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
 <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
 <shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
 <wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Luo Yang
 <luoyang82@h-partners.com>
Subject: Re: [PATCH net-next v08 8/9] hinic3: Add mac filter ops
Message-ID: <20260105174140.1c2b9021@kernel.org>
In-Reply-To: <8555005e3263a6de0d43be148f1d20ecab145eb0.1767495881.git.zhuyikai1@h-partners.com>
References: <cover.1767495881.git.zhuyikai1@h-partners.com>
	<8555005e3263a6de0d43be148f1d20ecab145eb0.1767495881.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

AI code review points out:

> +static int hinic3_mac_filter_sync_hw(struct net_device *netdev,
> +				     struct list_head *del_list,
> +				     struct list_head *add_list,
> +				     int *add_count)
> +{
> +	struct hinic3_mac_filter *ftmp;
> +	struct hinic3_mac_filter *f;
> +	int err;
> +
> +	if (!list_empty(del_list)) {
> +		list_for_each_entry_safe(f, ftmp, del_list, list) {
> +			/* ignore errors when deleting mac */
> +			hinic3_filter_addr_unsync(netdev, f->addr);
> +			list_del(&f->list);
> +			kfree(f);
> +		}
> +	}
> +
> +	if (!list_empty(add_list)) {
> +		list_for_each_entry_safe(f, ftmp, add_list, list) {
> +			if (f->state != HINIC3_MAC_HW_SYNCING)
> +				continue;
> +
> +			err = hinic3_filter_addr_sync(netdev, f->addr);
> +			if (err) {
> +				netdev_err(netdev, "Failed to add mac\n");
> +				return err;
> +			}
> +
> +			f->state = HINIC3_MAC_HW_SYNCED;
> +			(*add_count)++;
> +		}
> +	}
> +
> +	return 0;
> +}

[ ... ]

> +	err = hinic3_mac_filter_sync_hw(netdev, &tmp_del_list,
> +					&tmp_add_list, &add_count);
> +	if (err) {
> +		/* there were errors, delete all mac in hw */
> +		hinic3_undo_add_filter_entries(mac_filter_list, &tmp_add_list);

[ ... ]

> +		hinic3_mac_filter_sync_hw(netdev, &tmp_del_list,
> +					  &tmp_add_list, NULL);
                                                  ^^^^

Can this NULL pointer dereference add_count in hinic3_mac_filter_sync_hw()?

When hinic3_filter_addr_sync() fails in the first call to
hinic3_mac_filter_sync_hw(), the function returns early with an error.
At that point tmp_add_list may still contain entries with state
HINIC3_MAC_HW_SYNCING (entries that were not yet processed).

The second call passes NULL for add_count. If tmp_add_list is not empty
and has entries with HINIC3_MAC_HW_SYNCING state, the code will execute
(*add_count)++ with add_count being NULL.


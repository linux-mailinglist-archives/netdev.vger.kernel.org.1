Return-Path: <netdev+bounces-247265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE41CF6597
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 02:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 411F23067DE5
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 01:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450152882CD;
	Tue,  6 Jan 2026 01:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGAko1ab"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1287F280325;
	Tue,  6 Jan 2026 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663597; cv=none; b=tHYYIW6XEOGYjvnrA6larp/KOIrqJygxU2LuYJjpQIcmXkyFfFiQzmtk19uR1KnM9CPJE7rqfuW0DOW/GvLb6s6XDwByWFkAcldM1ug7GT2bBy27m2zrZsNhyRBfkm4NstNzUs70oZLJrYsnwbTkd/IPD8k+UWbTt/4c/QyqgSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663597; c=relaxed/simple;
	bh=13f7JNTyrwKGb5OibgIo3h5Pdebz3QETact3dnNqBdA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxqwtLGVbNZroAgvlI+eUwae8Y1IOEaChca0/Y+XkcPZZ0A1HMHTg3hsk+cFpbXtHjvLsXOFRxfXXe+37eo/cXE4dkoqrz1ZEHWzK5ofEOVI7C0XGPOjTynsRZKQ2tOg2LgzgOrOAuXOgHOY+/suU8kpY/0Cx0jvl+rs3K+1YAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGAko1ab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC4EC116D0;
	Tue,  6 Jan 2026 01:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767663596;
	bh=13f7JNTyrwKGb5OibgIo3h5Pdebz3QETact3dnNqBdA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XGAko1abFtJ3YJoYDVfT51EQyCfYSKROb/aF8ASPS4tCehjJ3oBc5q1x9vTX0fpfb
	 ow84QCRG8QgYZL/ie/kXiScLUd7/dYroTTXh4TtXb5xyJZ4bzgEDDxswZgs060Br99
	 jQqz8KMrUoF7K1ZIuWlyMgUUdRan1dTdSbX4flPl1Cobx6GZ1VrLPq/zHE6AdE+UCj
	 1qmU6zC3ITXJbvlPfRdZgFm1GqXfXzt8zs4pxdoarj4sGwqK9GPZVwseb6BZtMzzYG
	 PlY2JKX+TAEFzgjzu2ZsIZLZX8U2OiWUjY7+YQq4dZBlPdeWpO4/Fx0B1aBibGmumY
	 QBXblUU9JDApg==
Date: Mon, 5 Jan 2026 17:39:54 -0800
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
Subject: Re: [PATCH net-next v08 3/9] hinic3: Add .ndo_tx_timeout and
 .ndo_get_stats64
Message-ID: <20260105173954.7d6ade2d@kernel.org>
In-Reply-To: <44e03785d2aa19ac94bed3bd036e57d1ff9daca8.1767495881.git.zhuyikai1@h-partners.com>
References: <cover.1767495881.git.zhuyikai1@h-partners.com>
	<44e03785d2aa19ac94bed3bd036e57d1ff9daca8.1767495881.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

AI code review points out:

> @@ -329,6 +359,7 @@ static int hinic3_nic_probe(struct auxiliary_device *adev,
>  	if (err)
>  		goto err_uninit_sw;
>
> +	queue_delayed_work(nic_dev->workq, &nic_dev->periodic_work, HZ);
>  	netif_carrier_off(netdev);
>
>  	err = register_netdev(netdev);
> @@ -346,7 +377,8 @@ static int hinic3_nic_probe(struct auxiliary_device *adev,
>
>  err_free_nic_io:
>  	hinic3_free_nic_io(nic_dev);
> -
> +err_free_nic_dev:
> +	hinic3_free_nic_dev(nic_dev);

If register_netdev() fails after the delayed work has been queued, the error
path reaches hinic3_free_nic_dev() which calls destroy_workqueue() without
first cancelling the pending delayed work. The destroy_workqueue()
documentation states that all delayed_work must be cancelled before calling
it.

Should there be a disable_delayed_work_sync() or cancel_delayed_work_sync()
call in the error path before hinic3_free_nic_dev()? The remove path handles
this correctly:

> @@ -368,6 +400,9 @@ static void hinic3_nic_remove(struct auxiliary_device *adev)
>  	netdev = nic_dev->netdev;
>  	unregister_netdev(netdev);
>
> +	disable_delayed_work_sync(&nic_dev->periodic_work);
> +	hinic3_free_nic_dev(nic_dev);

Here in hinic3_nic_remove() the work is properly cancelled before destroying
the workqueue, but the probe error path after queue_delayed_work() does not
have similar protection.


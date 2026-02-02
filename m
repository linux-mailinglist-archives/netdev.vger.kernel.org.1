Return-Path: <netdev+bounces-255835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMJVEeKDgGnE8wIAu9opvQ
	(envelope-from <netdev+bounces-255835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 12:00:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7A7CB636
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 12:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D5F3302EE85
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 10:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD88A35B142;
	Mon,  2 Feb 2026 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kfX+EitI"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160B835A943;
	Mon,  2 Feb 2026 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770029640; cv=none; b=npGgXffgosUeVNz4AZjwnhXPFV4G3Z9ZbfDMz7arZloG3sJQIW8drx8yrxO68aA19k8L/iBdScwdOJwPPRPDP6cBvIBFzle+FIzN+QzAB9en2+Zjtoln0n6p2jLJnFbm2U8Q009ruFxbM8DG6vaeV9Y7FV/kwqcDt1yVNAHVyVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770029640; c=relaxed/simple;
	bh=HwCPtUyDzn3GjIOFIcuEtdzXyFqDrHtJb3bccpySMOE=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HVSApu9nqcZFXmiMDYudFJ2e89ZBFERrObVu4AEC97sDkbJr5S93tx5ogta/+pLZgoQu0v6tUH402FyOWQfVR1b3zum3f6Ah9bZvC6QbaKaLCBLmCdRVzEgfc9TfiG7N4OoPXaewfiiJFAI1PRwCKNixQNeeL/eebRF1QgxT/as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kfX+EitI; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IAB7g4oOle0bWWJEkgpFGulKR8NRIdAGZJceBUD5WTc=;
	b=kfX+EitIJx+3rT9MiKn70t2HWlc1bskbaNbNMHwrgMRMdUia76qxh81DRZIqQ9wEjeJNP2KG6
	0KfitBm7bVxhOACqRXqKy3oAIpiJj5vD3yoy1dPbESJRZmwrCLPZhfNbeNstAbFiYrSZjysmCeS
	J+RfqzGdoxE0Rroi83vvx5I=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4f4Nf33M03zLlTg;
	Mon,  2 Feb 2026 18:49:15 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 4755F4048B;
	Mon,  2 Feb 2026 18:53:48 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 2 Feb 2026 18:53:47 +0800
Message-ID: <df89d793-ee1a-4519-bc36-3a1580a33b12@huawei.com>
Date: Mon, 2 Feb 2026 18:53:46 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <ivecera@redhat.com>, <mschmidt@redhat.com>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Stanislav
 Fomichev <sdf@fomichev.me>, <intel-wired-lan@lists.osuosl.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] iavf: fix deadlock in reset handling
To: Petr Oros <poros@redhat.com>, <netdev@vger.kernel.org>
References: <20260202084820.260033-1-poros@redhat.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260202084820.260033-1-poros@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255835-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9C7A7CB636
X-Rspamd-Action: no action


on 2026/2/2 16:48, Petr Oros wrote:
> Three driver callbacks schedule a reset and wait for its completion:
> ndo_change_mtu(), ethtool set_ringparam(), and ethtool set_channels().
>
> Waiting for reset in ndo_change_mtu() and set_ringparam() was added by
> commit c2ed2403f12c74 ("iavf: Wait for reset in callbacks which trigger
> it") to fix a race condition where adding an interface to bonding
> immediately after MTU or ring parameter change failed because the
> interface was still in __RESETTING state. The same commit also added
> waiting in iavf_set_priv_flags(), which was later removed by commit
> 53844673d55529 ("iavf: kill "legacy-rx" for good").
>
> Waiting in set_channels() was introduced earlier by commit 4e5e6b5d9d13
> ("iavf: Fix return of set the new channel count") to ensure the PF has
> enough time to complete the VF reset when changing channel count, and to
> return correct error codes to userspace.
>
> Commit ef490bbb226702 ("iavf: Add net_shaper_ops support") added
> net_shaper_ops to iavf, which required reset_task to use _locked NAPI
> variants (napi_enable_locked, napi_disable_locked) that need the netdev
> instance lock.
>
> Later, commit 7e4d784f5810 ("net: hold netdev instance lock during
> rtnetlink operations") and commit 2bcf4772e45adb ("net: ethtool: try to
> protect all callback with netdev instance lock") started holding the
> netdev instance lock during ndo and ethtool callbacks for drivers with
> net_shaper_ops.
>
> The combination of waiting for reset and the new locking requirements
> creates a deadlock: the callback holds the lock and waits for reset_task,
> but reset_task is blocked waiting for the same lock:
>
>    Thread 1 (callback)               Thread 2 (reset_task)
>    -------------------               ---------------------
>    netdev_lock()
>    ndo_change_mtu() or ethtool op
>      iavf_schedule_reset()
>      iavf_wait_for_reset()           iavf_reset_task()
>        waiting...                      netdev_lock() <- DEADLOCK
>
> Reproducer:
>
>    # echo 16 > /sys/class/net/$PF/device/sriov_numvfs
>    # ip link set $VF up
>    # ip link set $VF mtu 5000
>    RTNETLINK answers: Device or resource busy
>
>    # dmesg | tail -1
>    iavf: MTU change interrupted waiting for reset
>
> Fix this by temporarily releasing the lock while waiting for reset to
> complete. This follows the pattern used elsewhere in the kernel (e.g.,
> do_set_master() releases rtnl_lock before calling ndo_add_slave()).
>
> Fixes: 7e4d784f5810 ("net: hold netdev instance lock during rtnetlink operations")
> Signed-off-by: Petr Oros <poros@redhat.com>


Reviewed-by: Jijie Shao <shaojijie@huawei.com>

> ---
>   drivers/net/ethernet/intel/iavf/iavf_main.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 8aa6e92c16431f..d7738fb8fa60bc 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -189,13 +189,22 @@ static bool iavf_is_reset_in_progress(struct iavf_adapter *adapter)
>    * iavf_wait_for_reset - Wait for reset to finish.
>    * @adapter: board private structure
>    *
> + * The iavf driver selects NET_SHAPER, so callbacks that trigger reset are
> + * always called with netdev instance lock held, while reset_task also needs
> + * this lock. Release the lock while waiting to avoid deadlock.
> + *
>    * Returns 0 if reset finished successfully, negative on timeout or interrupt.
>    */
>   int iavf_wait_for_reset(struct iavf_adapter *adapter)
>   {
> -	int ret = wait_event_interruptible_timeout(adapter->reset_waitqueue,
> -					!iavf_is_reset_in_progress(adapter),
> -					msecs_to_jiffies(5000));
> +	struct net_device *netdev = adapter->netdev;
> +	int ret;
> +
> +	netdev_unlock(netdev);
> +	ret = wait_event_interruptible_timeout(adapter->reset_waitqueue,
> +					       !iavf_is_reset_in_progress(adapter),
> +					       msecs_to_jiffies(5000));
> +	netdev_lock(netdev);
>   
>   	/* If ret < 0 then it means wait was interrupted.
>   	 * If ret == 0 then it means we got a timeout while waiting


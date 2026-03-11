Return-Path: <netdev+bounces-266545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGwcHVsysWm0rwIAu9opvQ
	(envelope-from <netdev+bounces-266545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 10:14:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B57A0260199
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 10:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA05C301BA71
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B9E3C7DEA;
	Wed, 11 Mar 2026 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a4qDJ89u"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940CE3BD231
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220423; cv=none; b=CiylvtwmtfLOslTVSiyQuMu8CjR9TMU5/vvI04Nbw3WnJy6hQ1xW/i6tL0sQRK0pArVlcIt7HEwHgvn53frgbTuMEju1v3lPjm6d2hlg9LElEcYo94zosvU676r3R6CJQryCmbE4xt2Infpx9lbYm/rKHeHAlSQFa70bROB5ay0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220423; c=relaxed/simple;
	bh=LtEuNdw1/8UfnUOvcSxR9RmkxQ2lvnxXCbaWYrgsrp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U4SD+6wqgjMuYPJR98mklj5nQFPIuy7tpP0y7t/fT+w9Q7Ejj2+RSBkr/Ae1zXaJNgMzeGRAzLz9oVigYKBdC9ZSopJCp4zLLgNeYU0J9WY3umBAKq/pm8DB0zy6Uf03UlwvZTHdk350b5vbYUc1fvU0N/8SwEH9G2Tr8wRU5IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a4qDJ89u; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <94089b74-def5-4dd0-9143-1cfbc722fe73@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773220402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPwtlh8YIGGNtoSsoazXJ8QY55uOAfW2FM+h3RicQNM=;
	b=a4qDJ89uGfHvMYiTQS2jL5B6Wv1nQCYGBVvJ/wEDEjC1T2qgvkA55eAvm2mFjRCIG5RmO/
	XOKCH/3tAjo+VTm/VD65mxcFn8h44U+7xZhb74YywDqLIsIQoc9t43XLapUsrhZK9ARAA9
	RfjPluE1HEGGwoY28ZAkInVi7mg+FWk=
Date: Wed, 11 Mar 2026 17:13:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 __ethtool_get_link_ksettings
To: Jianzhou Zhao <luckd0g@163.com>, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, kuba@kernel.org,
 pabeni@redhat.com, sdf@fomichev.me, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <a3fb1f.6f59.19cdbf3d67d.Coremail.luckd0g@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <a3fb1f.6f59.19cdbf3d67d.Coremail.luckd0g@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: B57A0260199
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266545-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[163.com,google.com,davemloft.net,lunn.ch,kernel.org,redhat.com,fomichev.me,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action


On 3/11/26 4:11 PM, Jianzhou Zhao wrote:
>
> Subject: [BUG] net: kernel NULL pointer dereference in __ethtool_get_link_ksettings
>
> Dear Maintainers,
>
> We are writing to report a NULL pointer dereference vulnerability within the `__ethtool_get_link_ksettings()` function. This bug was found by our custom fuzzing tool, RacePilot. The bug occurs when an internal subsystem (e.g., `smc` routing or `infiniband` querying a hardware port) attempts to retrieve the link speed of an `ipvlan` interface that is layered on top of a virtual or device hierarchy lacking `ethtool_ops`. We observed this bug on the Linux kernel version 6.18.0-08691-g2061f18ad76e-dirty.
>
> Call Trace & Context
> ==================================================================
> BUG: kernel NULL pointer dereference, address: 00000000000001f8
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] SMP NOPTI
> CPU: 0 UID: 0 PID: 8322 Comm: kworker/0:9 Not tainted 6.18.0-08691-g2061f18ad76e-dirty #50 PREEMPT(voluntary)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Workqueue: events smc_ib_port_event_work
> RIP: 0010:__ethtool_get_link_ksettings+0x5c/0x140 net/ethtool/ioctl.c:443
> ...
> Call Trace:
>   <TASK>
>   ipvlan_ethtool_get_link_ksettings+0x2c/0x40 drivers/net/ipvlan/ipvlan_main.c:411
>   __ethtool_get_link_ksettings+0x107/0x140 net/ethtool/ioctl.c:450
>   ib_get_eth_speed+0xd2/0x6d0 drivers/infiniband/core/verbs.c:1999
>   rxe_query_port+0x14a/0x270 drivers/infiniband/sw/rxe/rxe_verbs.c:62
>   __ib_query_port drivers/infiniband/core/device.c:2148 [inline]
>   ib_query_port drivers/infiniband/core/device.c:2180 [inline]
>   ib_query_port+0x310/0x440 drivers/infiniband/core/device.c:2170
>   smc_ib_remember_port_attr net/smc/smc_ib.c:364 [inline]
>   smc_ib_port_event_work+0xfa/0x690 net/smc/smc_ib.c:388
> ...
> ==================================================================
>
> Execution Flow & Code Context
> When backend kernel systems like infiniband (`ib_get_eth_speed`) call `__ethtool_get_link_ksettings()` on a top-level `ipvlan` device to evaluate underlying ethernet capabilities, the execution delegates successfully through the device's mapped proxy routine. However, `ipvlan` triggers a nested fallback lookup to the physical baseline carrier without validating whether the carrier inherently supports ethtool operations:
> ```c
> // drivers/net/ipvlan/ipvlan_main.c
> static int ipvlan_ethtool_get_link_ksettings(struct net_device *dev,
> 					     struct ethtool_link_ksettings *cmd)
> {
> 	const struct ipvl_dev *ipvlan = netdev_priv(dev);
>
> 	return __ethtool_get_link_ksettings(ipvlan->phy_dev, cmd); // <-- Nested fallback call onto phy_dev
> }
> ```
>
> Unfortunately, the exported helper routine `__ethtool_get_link_ksettings()` relies strictly on `dev->ethtool_ops` being a valid populated pointer and makes no assertions defensively prior to calling the callback layout:
> ```c
> // net/ethtool/ioctl.c
> int __ethtool_get_link_ksettings(struct net_device *dev,
> 				 struct ethtool_link_ksettings *link_ksettings)
> {
> 	ASSERT_RTNL();
>
> 	if (!dev->ethtool_ops->get_link_ksettings) // <-- NULL pointer dereference (fault at +0x1f8)
> 		return -EOPNOTSUPP;
> 	...
> }
> ```
>
> Root Cause Analysis
> The bug constitutes a NULL pointer dereference explicitly triggered within `__ethtool_get_link_ksettings()`. Because the API is exported for transparent kernel-centric consumption (e.g. by `ib_get_eth_speed`), it bypasses the robust validation standard userspace calls experience via the `ethtool_ioctl` ioctl wrapper, completely overlooking empty/NULL `dev->ethtool_ops` arrays.
>
> When `ipvlan` bridges the request down to an unyielding backend host (`ipvlan->phy_dev`), and the host operates as a virtual loop or dummy lacking any registered `ethtool_ops`, the fetch targets `dev->ethtool_ops->get_link_ksettings`. Based on the API's pointer offset in `include/linux/ethtool.h`, this lands precisely at structural index `0x1F8`, culminating in a fatal supervisor read fault.
> Unfortunately, we were unable to generate a reproducer for this bug.
>
> Potential Impact
> This memory management gap presents a local kernel panic/Denial of Service (DoS). It manifests silently anytime nested virtual abstractions process asynchronous traffic events requiring network speed capabilities over missing handler arrays, particularly through automated RDMA/IB device initializations.
>
> Proposed Fix
> To universally intercept the validation lapse inside the exported generic handler, we suggest introducing a preliminary null-check protecting the interface invocations:
>
> ```diff
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -440,7 +440,7 @@ int __ethtool_get_link_ksettings(struct net_device *dev,
>   {
>   	ASSERT_RTNL();
>   
> -	if (!dev->ethtool_ops->get_link_ksettings)
> +	if (!dev->ethtool_ops || !dev->ethtool_ops->get_link_ksettings)
>   		return -EOPNOTSUPP;
>   
>   	if (!netif_device_present(dev))
> ```
>
> We would be highly honored if this could be of any help.
>
> Best regards,
> RacePilot Team


Thanks for the report.

The root cause is a use-after-free of ipvlan->phy_dev, not a simple missing
NULL check on ethtool_ops.

In ib_get_eth_speed(), ib_device_get_netdev() obtains a reference to the
ipvlan device *outside* of rtnl_lock(). This creates a race window where
the underlying phy_dev can be unregistered and freed before rtnl_lock() 
is acquired.

Then recurses through ipvlan_ethtool_get_link_ksettings()
into phy_dev, it dereferences freed memory — which happens to read as 
NULL for
ethtool_ops, causing the crash at offset 0x1f8.

Diff below:

diff --git a/drivers/infiniband/core/verbs.c 
b/drivers/infiniband/core/verbs.c
index 575b4a4b200b..f16d11e7c2e3 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2046,11 +2046,13 @@ int ib_get_eth_speed(struct ib_device *dev, u32 
port_num, u16 *speed, u8 *width)
         if (rdma_port_get_link_layer(dev, port_num) != 
IB_LINK_LAYER_ETHERNET)
                 return -EINVAL;

+       rtnl_lock();
         netdev = ib_device_get_netdev(dev, port_num);
-       if (!netdev)
+       if (!netdev) {
+               rtnl_unlock();
                 return -ENODEV;
+       }

-       rtnl_lock();
         rc = __ethtool_get_link_ksettings(netdev, &lksettings);
         rtnl_unlock();



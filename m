Return-Path: <netdev+bounces-213334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1F0B249D0
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 14:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67B261AA17C3
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 12:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1746F27602D;
	Wed, 13 Aug 2025 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q/LhzmOq"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4358315A87C
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755089453; cv=none; b=ECuYn4r5d5OwoDWU0XFZWBmqaMWZLyOxAc+ZTiTflPH3bEqTh8Oo+cG3kXRB4nbBRy/3F2NV+Txb+jIACmLLswZeDv+s6NStM+UJgyaGxl1NgnqzrjvMrXhGPZMHLiQbbaTTAIqA2LNidQQMnrJ3H+NKW9oQ0HHoe+7zOj4pHio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755089453; c=relaxed/simple;
	bh=1mEvOwuGqfTYDuFOmwLuUyhYUugJ+1L9vpE9h3V0eng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cf0XcpfoT8z6bnIzuttqWSpgwrK2OXUz7u4TLVx57K1D4CZHeeRiu0DIX73oxu9JGpIXVnzMmbSDq1AA0eO1/cSxe7Pvv7tQCfkr5LBbxmaU9QKhmgURIchsCv954TKlVV89olBgK06aYl4exHc4gLA7efF66OEOgalLk4DLUjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q/LhzmOq; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <354593d1-2504-407e-98fb-235fcaf61d87@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755089448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ON+Suyp0vdzeVZdTNkxeac41hq4WWrAXP09hCZflvbY=;
	b=q/LhzmOqykaaTSRVE2F2sCxJbH1OwRrsg6Fq+7/6vcTBQkbqF8kOIrJ61lIHgvL/qA+q7/
	wgAI/yICZ+7sxMuvbjo9Vuy3Koi2o497fk1NpX4Gj7jB1EuYErANawjPdlp/WN03FYEKOs
	+cOABvN8HqJxM+BT7LPCEhAczUrKgyM=
Date: Wed, 13 Aug 2025 13:50:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 5/5] net: rnpgbe: Add register_netdev
To: Yibo Dong <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
 danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com, lorenzo@kernel.org,
 geert+renesas@glider.be, Parthiban.Veerasooran@microchip.com,
 lukas.bulwahn@redhat.com, alexanderduyck@fb.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-6-dong100@mucse.com>
 <e410918e-98aa-4a14-8fb4-5d9e73f7375e@linux.dev>
 <B41E833713021188+20250813090405.GC965498@nic-Precision-5820-Tower>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <B41E833713021188+20250813090405.GC965498@nic-Precision-5820-Tower>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/08/2025 10:04, Yibo Dong wrote:
> On Tue, Aug 12, 2025 at 04:32:00PM +0100, Vadim Fedorenko wrote:
>> On 12/08/2025 10:39, Dong Yibo wrote:
>>> Initialize get mac from hw, register the netdev.
>>>
>>> Signed-off-by: Dong Yibo <dong100@mucse.com>
>>> ---
>>>    drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 22 ++++++
>>>    .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 73 ++++++++++++++++++
>>>    drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  1 +
>>>    .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 76 +++++++++++++++++++
>>>    4 files changed, 172 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
>>> index 6cb14b79cbfe..644b8c85c29d 100644
>>> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
>>> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
>>> @@ -6,6 +6,7 @@
>>>    #include <linux/types.h>
>>>    #include <linux/mutex.h>
>>> +#include <linux/netdevice.h>
>>>    extern const struct rnpgbe_info rnpgbe_n500_info;
>>>    extern const struct rnpgbe_info rnpgbe_n210_info;
>>> @@ -86,6 +87,18 @@ struct mucse_mbx_info {
>>>    	u32 fw2pf_mbox_vec;
>>>    };
>>> +struct mucse_hw_operations {
>>> +	int (*init_hw)(struct mucse_hw *hw);
>>> +	int (*reset_hw)(struct mucse_hw *hw);
>>> +	void (*start_hw)(struct mucse_hw *hw);
>>> +	void (*init_rx_addrs)(struct mucse_hw *hw);
>>> +	void (*driver_status)(struct mucse_hw *hw, bool enable, int mode);
>>> +};
>>> +
>>> +enum {
>>> +	mucse_driver_insmod,
>>> +};
>>> +
>>>    struct mucse_hw {
>>>    	void *back;
>>>    	u8 pfvfnum;
>>> @@ -96,12 +109,18 @@ struct mucse_hw {
>>>    	u32 axi_mhz;
>>>    	u32 bd_uid;
>>>    	enum rnpgbe_hw_type hw_type;
>>> +	const struct mucse_hw_operations *ops;
>>>    	struct mucse_dma_info dma;
>>>    	struct mucse_eth_info eth;
>>>    	struct mucse_mac_info mac;
>>>    	struct mucse_mbx_info mbx;
>>> +	u32 flags;
>>> +#define M_FLAGS_INIT_MAC_ADDRESS BIT(0)
>>>    	u32 driver_version;
>>>    	u16 usecstocount;
>>> +	int lane;
>>> +	u8 addr[ETH_ALEN];
>>> +	u8 perm_addr[ETH_ALEN];
>>
>> why do you need both addresses if you have this info already in netdev?
>>
> 
> 'perm_addr' is address from firmware (fixed, can't be changed by user).
> 'addr' is the current netdev address (It is Initialized the same with
> 'perm_addr', but can be changed by user)
> Maybe I should add 'addr' in the patch which support ndo_set_mac_address?

But why do you need 'addr' at all? Current netdev address can be
retrieved from netdev, why do you need to store it within driver's
structure?



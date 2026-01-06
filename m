Return-Path: <netdev+bounces-247279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4185FCF6678
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 03:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E60E130194F4
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 02:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDA222172C;
	Tue,  6 Jan 2026 02:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="K/7apAcx"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C30155C97;
	Tue,  6 Jan 2026 02:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665101; cv=none; b=MPtAiDQl6fcuG5QWYVZhjkr/8y4lpYEVk8dk0iIgWcyOHfA17bKdkop/fldtfbM99nTUblwBXyAKO96yyI5yESXVn+93VYpvufxdVuHbFJfqYgvLoCQweXuJ/ZJewWCCxoYyh/JGLXR+2Srk94mDe2QoaNBDcDAddbvAZqIR/uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665101; c=relaxed/simple;
	bh=6WwNlZhkw3b10ZlAnFD1nireg35g8Dpd/IRlrkkBgiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AFnYOavOJjwUKiROAapjsGL2h0rsRUQsTn4JYasGvofZhcb2UORQsP8+5hlTZ1FmvcW9J5SjLrBIK9t21oay+Dk9UzxWsf7Brq5Ujdh+iHGa9rdAER/7cdRuF2smenPLJkOluRCUsN2xj/gXiIR+ebWxuvWN9/CNEiS0UxHq4tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=K/7apAcx; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6TiA/gxWdsPs5WwCzdmmKu+M8YKtADhnpbQ/EKLRQ9o=;
	b=K/7apAcxEyJGTNBdt1wBZ6yPh11i6M7jal6NDJRwZrEUGry3g0AuTrbVNKiHhZYGZ2Q7r/VpW
	fFnVqieXHPv7UcshQvkrMsv+nHPY3jEigvCvqvZy8nK0Xuoz9JLqhw1qnxvuFXihrGVbQENRGok
	dZy5/smyfrNwE68quH/QA7g=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dlZDR616Zz1T4qx;
	Tue,  6 Jan 2026 10:02:15 +0800 (CST)
Received: from kwepemk500008.china.huawei.com (unknown [7.202.194.93])
	by mail.maildlp.com (Postfix) with ESMTPS id A68F14056A;
	Tue,  6 Jan 2026 10:04:55 +0800 (CST)
Received: from [10.136.112.207] (10.136.112.207) by
 kwepemk500008.china.huawei.com (7.202.194.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 6 Jan 2026 10:04:54 +0800
Message-ID: <3318109a-4f2d-b9ed-8a40-e65ac28fb913@huawei.com>
Date: Tue, 6 Jan 2026 10:04:54 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH net] net: vlan: set header_ops to match hard_header_len
 when hw offload is toggled
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<huyizhen2@huawei.com>, <gaoxingwang1@huawei.com>
References: <20251231035419.23422-1-chenzhen126@huawei.com>
 <20260105162243.59e72816@kernel.org>
From: Chen Zhen <chenzhen126@huawei.com>
In-Reply-To: <20260105162243.59e72816@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500008.china.huawei.com (7.202.194.93)

On 26/1/6 8:22, Jakub Kicinski wrote:
> On Wed, 31 Dec 2025 11:54:19 +0800 Chen Zhen wrote:
>> skbuff: skb_under_panic: text:ffffffff95b33e66 len:90 put:14 head:ffff915ac1967440 data:ffff915ac196743e tail:0x58 end:0x180 dev:br0.10
>> ------------[ cut here ]------------
>> kernel BUG at net/core/skbuff.c:197!
>> Call Trace:
>>  <TASK>
>>  skb_push+0x39/0x40
>>  eth_header+0x26/0xb0
>>  vlan_dev_hard_header+0x58/0x130 [8021q]
>>  neigh_connected_output+0xae/0x100
>>  ip6_finish_output2+0x2cc/0x650
>>  ? nf_hook_slow+0x41/0xc0
>>  ip6_finish_output+0x27/0xd0
>>  ndisc_send_skb+0x1d0/0x370
>>  ? __pfx_dst_output+0x10/0x10
>>  ndisc_send_ns+0x5a/0xb0
>>  addrconf_dad_work+0x2b5/0x380
>>  process_one_work+0x17f/0x320
> 
> Please run this stack trace thru script/decode_stacktrace
> and you can cut off here, no need to include functions
> below process_one_work, they are irrelevant.
> 
>>  worker_thread+0x26d/0x2f0
>>  ? __pfx_worker_thread+0x10/0x10
>>  kthread+0xcc/0x100
>>  ? __pfx_kthread+0x10/0x10
>>  ret_from_fork+0x30/0x50
>>  ? __pfx_kthread+0x10/0x10
>>  ret_from_fork_asm+0x1b/0x30
>>  </TASK>
>>
>> This bug can be easily reproduced by these steps:
>>
>>  ip link add veth0 type veth peer name veth1
>>  ip link set veth0 up
>>  ip link set veth1 up
>>  ethtool -K veth0 tx-vlan-hw-insert off
>>  # vlandev.header_ops = vlan_header_ops, hard_header_len = 18(hard_header_len + VLAN_HLEN)
>>  ip link add link veth0 name veth0.10 type vlan id 10 reorder_hdr off
>>  ip addr add 192.168.10.1/24 dev veth0.10
>>  ip link set veth0.10 up
>>  # vlandev.hard_header_len = 14(hard_header_len)
>>  ethtool -K veth0 tx-vlan-hw-insert on
>>  # Panic!
> 
> Instead of putting this in the commit message please add a selftest
> which will automatically catch re-occurrence of the issue.
> 
>> The reason is that when NETIF_F_HW_VLAN_CTAG_TX is off, vlandev.hard_header_len will be set to
>> dev->hard_header_len since commit 029f5fc31cdb ("8021q: set hard_header_len when VLAN offload features
>> are toggled"), but the header_ops remains unchanged. Then neigh_connected_output() will call
>> vlan_dev_hard_header() and panic in skb_push() because reorder_hdr is off.
> 
> Please wrap commit messages at 70 columns.

Thanks for your patient review and I will send patch v2 soon.

Best regards,
Chen Zhen


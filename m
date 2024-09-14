Return-Path: <netdev+bounces-128299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 183EC978E0A
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 07:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52428B234E8
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 05:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F16049649;
	Sat, 14 Sep 2024 05:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="POBHlhvA"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8E520328
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 05:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726291693; cv=none; b=B+svBdULltxwqUXrQXk+f8iwL9rSb2eStx4RaPmBYIJ1cp1cIB1AQtF4l0eWuLWXn7Isd6b9vP/L7GA8aiqFD9juft2LZSNKpQ6MRPYsDDkcMPcr0pbWvTSO9p2O7uG4ZWewFuBmGsmjzEIHEfA/a4tBiPvxuT4ysGhsn70GwxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726291693; c=relaxed/simple;
	bh=8Ys6nf65I8k6AAOlIAh1FtuN4DjZMkXQvrV5OnXkj9E=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=X4wUTFS0a+BDi8AcfTIfcMpI/dI/YAKSinls4uoKdeP1Ck/TAfkU4pbyu53VxWrdtHtnoZgZg4izksUWO7F/NLWxMPkK5lE4M5AI5HaAMDCx56lbv6ZQxOAbnDmgfTYzfwLLLZH7sY6tAXlSw+GscEzBrllg2xwMO2qXfmdR7hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=POBHlhvA; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D6D70B8005D
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 05:28:02 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.35.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id D306F13C2B0
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 22:27:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D306F13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1726291679;
	bh=8Ys6nf65I8k6AAOlIAh1FtuN4DjZMkXQvrV5OnXkj9E=;
	h=Date:To:From:Subject:From;
	b=POBHlhvAQdbAFkEktvjvziAnWPBe0Fp7UhIJQv7Jrerkz0Xo0SMHMtxrEE0CQyYxi
	 W4QD2bklKQLw6IoESJxigS3qEtGjYLT/vzwFw2R4YyyUBjXKiNmcK2Kt0hcaJTbVaO
	 oIr7DjB6K2XLUX/cXATyt9MCg0wR6supx17YfGrw=
Message-ID: <9ac75ea7-84de-477c-b586-5115ce844dc7@candelatech.com>
Date: Fri, 13 Sep 2024 22:27:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-MW
To: netdev <netdev@vger.kernel.org>
From: Ben Greear <greearb@candelatech.com>
Subject: tcp_ack __list_del crash in 6.10.3+ hacks
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1726291683-uaK2gLLl4QRS
X-MDID-O:
 us5;at1;1726291683;uaK2gLLl4QRS;<greearb@candelatech.com>;0590461a9946a11a9d6965a08c2b2857

Hello,

We found this during a long duration network test where we are using
lots of wifi network devices in a single system, talking with an intel 10g
NIC in the same system (using vrfs and such).  The system ran around
7 hours before it crashed.  Seems to be a null pointer in a list, but
I'm not having great luck understanding where exactly in the large tcp_ack
method this is happening.  Any suggestions for how to get more relevant
info out of gdb?

BUG: kernel NULL pointer dereference, address: 0000000000000008^M
#PF: supervisor write access in kernel mode^M
#PF: error_code(0x0002) - not-present page^M
PGD 115855067 P4D 115855067 PUD 283ed3067 PMD 0 ^M
Oops: Oops: 0002 [#1] PREEMPT SMP^M
CPU: 6 PID: 115673 Comm: btserver Tainted: G           O       6.10.3+ #57^M
Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020^M
RIP: 0010:tcp_ack+0x62e/0x1530^M
Code: 9c 24 80 05 00 00 0f 84 56 09 00 00 49 39 9c 24 50 06 00 00 0f 84 b2 04 00 00 48 8b 53 58 48 8b 43 60 48 89 df 48 8b 74 24 28 <48> 89 42 08 48 89 10 48 c7 
43 60 00 00 00 00 48 c7 43 58 00 00 00^M
RSP: 0018:ffffc9000027c998 EFLAGS: 00010207^M
RAX: 0000000000000000 RBX: ffff8881226a8800 RCX: ffff8881226abe01^M
RDX: 0000000000000000 RSI: ffff888126a3d4c8 RDI: ffff8881226a8800^M
RBP: ffffc9000027ca28 R08: 000000000005edf6 R09: 0000000000000000^M
R10: 0000000000000008 R11: 0000000084d9074f R12: ffff888126a3d340^M
R13: 0000000000000004 R14: ffff8881226aac00 R15: 0000000000000000^M
FS:  00007efc82a2f7c0(0000) GS:ffff88845dd80000(0000) knlGS:0000000000000000^M
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
CR2: 0000000000000008 CR3: 0000000125477006 CR4: 00000000003706f0^M
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000^M
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400^M
Call Trace:^M
  <IRQ>^M
  ? __die+0x1a/0x60^M
  ? page_fault_oops+0x150/0x500^M
  ? exc_page_fault+0x6f/0x160^M
  ? asm_exc_page_fault+0x22/0x30^M
  ? tcp_ack+0x62e/0x1530^M
  ? tcp_ack+0x5f1/0x1530^M
  ? tcp_schedule_loss_probe+0x101/0x1d0^M
  tcp_rcv_established+0x168/0x750^M
  tcp_v4_do_rcv+0x13f/0x270^M
  tcp_v4_rcv+0x1236/0x15f0^M
  ? udp_lib_lport_inuse+0x100/0x100^M
  ? raw_local_deliver+0xc8/0x250^M
  ip_protocol_deliver_rcu+0x1b/0x290^M
  ip_local_deliver_finish+0x6d/0x90^M
  ip_sublist_rcv_finish+0x2d/0x40^M
  ip_sublist_rcv+0x160/0x200^M
  ? __netif_receive_skb_core.constprop.0+0x30d/0xf80^M
  ip_list_rcv+0xca/0x120^M
  __netif_receive_skb_list_core+0x17f/0x1e0^M
  netif_receive_skb_list_internal+0x1c5/0x290^M
  napi_complete_done+0x69/0x180^M
  ixgbe_poll+0xd93/0x13d0 [ixgbe]^M
  __napi_poll+0x20/0x1a0^M
  net_rx_action+0x2af/0x310^M
  handle_softirqs+0xc8/0x2b0^M
__irq_exit_rcu+0x5f/0x80^M
  common_interrupt+0x81/0xa0^M
  </IRQ>^M

(gdb) l *(tcp_ack+0x62e)
0xffffffff81c8601e is in tcp_ack (/home/greearb/git/linux-6.10.dev.y/include/linux/list.h:195).
190	 * This is only for internal list manipulation where we know
191	 * the prev/next entries already!
192	 */
193	static inline void __list_del(struct list_head * prev, struct list_head * next)
194	{
195		next->prev = prev;
196		WRITE_ONCE(prev->next, next);
197	}
198	
199	/*
(gdb) l *(tcp_rcv_established+0x168)
0xffffffff81c88b88 is in tcp_rcv_established (/home/greearb/git/linux-6.10.dev.y/net/ipv4/tcp_input.c:6209).
6204	
6205		if (!tcp_validate_incoming(sk, skb, th, 1))
6206			return;
6207	
6208	step5:
6209		reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
6210		if ((int)reason < 0) {
6211			reason = -reason;
6212			goto discard;
6213		}
(gdb)

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


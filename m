Return-Path: <netdev+bounces-47287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A99E7E966E
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 06:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294E11C2090D
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 05:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1352C2CD;
	Mon, 13 Nov 2023 05:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+fLLwIt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43181F9C7
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 05:17:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A257115
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 21:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699852637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0EKo20azYW2WTjljoSqBOIe0bi/IXBCve7wEZgAe2Q=;
	b=A+fLLwItuJ4Yi/OHauJsYVUs2+URHpRq0ekVdWIUt4vDW/h5CqnJJF4EZOHTShnpK0ORRP
	JX5VVgq2sXBlCukhGMlIgxMIBc3R9lApV1Hi4lsJOl13ytXILAQ3rcAjTRF+VMYIWgwFqH
	YCmdgbK50Z6yTZhA0UaA3UUxcoT7KTI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-Z-qYkSCQMC65EHiqNDxOzg-1; Mon, 13 Nov 2023 00:17:13 -0500
X-MC-Unique: Z-qYkSCQMC65EHiqNDxOzg-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6bf2b098e43so3765423b3a.3
        for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 21:17:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699852632; x=1700457432;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w0EKo20azYW2WTjljoSqBOIe0bi/IXBCve7wEZgAe2Q=;
        b=Ken+Is3exica4iyadO7V5pBzJg/FxjnR+vahy+I1P8eFDXqLJtqvD3/xj0QIxbMEX4
         mGaYjFxZAfd0VoR5mWEsRila0iBg0WEYea/+258Tkf840ttQmK4WByxOVnf56wfeUkZ7
         gm3O/aE0eZ4I2O/Ou+8WO7K/EryRV5AQDuoz/Jpfu3bwN0jLNx+L1+CNUMxhH/kvAzpB
         ovOvqUQuxPXGqLB0J2HRIVaClMqvfFaOvfk0HHX5peI00cq4V8RY8NVxxdF3RhS2G+I1
         iRaQK1F3nY0oAjYgGxmZLNamXb9+KlVWZFXoFVK53CB+xNnlZRn/f8pcqBpZs157n6gy
         GLiw==
X-Gm-Message-State: AOJu0YyMihTHtkFq5Va9TCUeN2dblEENCjLwK+zE91OZ1+X1vAVTt3Jv
	fR6nQwLwf1tC51UEuwAQ3IuNahpOwieNkiYyIjkpw1y6PtP4ZefRNU5n11IUY6E4hrxFyyZgKgq
	tAjHyKievezE9wxml
X-Received: by 2002:a05:6a00:1d9b:b0:6bd:705b:56fb with SMTP id z27-20020a056a001d9b00b006bd705b56fbmr3993734pfw.6.1699852632636;
        Sun, 12 Nov 2023 21:17:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXe+sRI1NklZI0XuaDjOUM9VMGUIGGDjfD9+GOMH5Go/rxfOfDKUbPDfWV+SObWzFXCLG5KA==
X-Received: by 2002:a05:6a00:1d9b:b0:6bd:705b:56fb with SMTP id z27-20020a056a001d9b00b006bd705b56fbmr3993720pfw.6.1699852632315;
        Sun, 12 Nov 2023 21:17:12 -0800 (PST)
Received: from localhost ([240d:1a:c0d:9f00:f0fd:a9ac:beeb:ad24])
        by smtp.gmail.com with ESMTPSA id x26-20020a056a000bda00b0069ee4242f89sm3274216pfu.13.2023.11.12.21.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 21:17:12 -0800 (PST)
Date: Mon, 13 Nov 2023 14:17:06 +0900 (JST)
Message-Id: <20231113.141706.1726048567891462701.syoshida@redhat.com>
To: horms@kernel.org
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tipc: Fix kernel-infoleak due to uninitialized TLV
 value
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <20231112102513.GJ705326@kernel.org>
References: <20231110163947.1605168-1-syoshida@redhat.com>
	<20231112102513.GJ705326@kernel.org>
X-Mailer: Mew version 6.9 on Emacs 28.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun, 12 Nov 2023 10:25:13 +0000, Simon Horman wrote:
> On Sat, Nov 11, 2023 at 01:39:47AM +0900, Shigeru Yoshida wrote:
>> KMSAN reported the following kernel-infoleak issue:
>> 
>> =====================================================
>> BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
>> BUG: KMSAN: kernel-infoleak in copy_to_user_iter lib/iov_iter.c:24 [inline]
>> BUG: KMSAN: kernel-infoleak in iterate_ubuf include/linux/iov_iter.h:29 [inline]
>> BUG: KMSAN: kernel-infoleak in iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
>> BUG: KMSAN: kernel-infoleak in iterate_and_advance include/linux/iov_iter.h:271 [inline]
>> BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x4ec/0x2bc0 lib/iov_iter.c:186
>>  instrument_copy_to_user include/linux/instrumented.h:114 [inline]
>>  copy_to_user_iter lib/iov_iter.c:24 [inline]
>>  iterate_ubuf include/linux/iov_iter.h:29 [inline]
>>  iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
>>  iterate_and_advance include/linux/iov_iter.h:271 [inline]
>>  _copy_to_iter+0x4ec/0x2bc0 lib/iov_iter.c:186
>>  copy_to_iter include/linux/uio.h:197 [inline]
>>  simple_copy_to_iter net/core/datagram.c:532 [inline]
>>  __skb_datagram_iter.5+0x148/0xe30 net/core/datagram.c:420
>>  skb_copy_datagram_iter+0x52/0x210 net/core/datagram.c:546
>>  skb_copy_datagram_msg include/linux/skbuff.h:3960 [inline]
>>  netlink_recvmsg+0x43d/0x1630 net/netlink/af_netlink.c:1967
>>  sock_recvmsg_nosec net/socket.c:1044 [inline]
>>  sock_recvmsg net/socket.c:1066 [inline]
>>  __sys_recvfrom+0x476/0x860 net/socket.c:2246
>>  __do_sys_recvfrom net/socket.c:2264 [inline]
>>  __se_sys_recvfrom net/socket.c:2260 [inline]
>>  __x64_sys_recvfrom+0x130/0x200 net/socket.c:2260
>>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
>>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>> 
>> Uninit was created at:
>>  slab_post_alloc_hook+0x103/0x9e0 mm/slab.h:768
>>  slab_alloc_node mm/slub.c:3478 [inline]
>>  kmem_cache_alloc_node+0x5f7/0xb50 mm/slub.c:3523
>>  kmalloc_reserve+0x13c/0x4a0 net/core/skbuff.c:560
>>  __alloc_skb+0x2fd/0x770 net/core/skbuff.c:651
>>  alloc_skb include/linux/skbuff.h:1286 [inline]
>>  tipc_tlv_alloc net/tipc/netlink_compat.c:156 [inline]
>>  tipc_get_err_tlv+0x90/0x5d0 net/tipc/netlink_compat.c:170
>>  tipc_nl_compat_recv+0x1042/0x15d0 net/tipc/netlink_compat.c:1324
>>  genl_family_rcv_msg_doit net/netlink/genetlink.c:972 [inline]
>>  genl_family_rcv_msg net/netlink/genetlink.c:1052 [inline]
>>  genl_rcv_msg+0x1220/0x12c0 net/netlink/genetlink.c:1067
>>  netlink_rcv_skb+0x4a4/0x6a0 net/netlink/af_netlink.c:2545
>>  genl_rcv+0x41/0x60 net/netlink/genetlink.c:1076
>>  netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
>>  netlink_unicast+0xf4b/0x1230 net/netlink/af_netlink.c:1368
>>  netlink_sendmsg+0x1242/0x1420 net/netlink/af_netlink.c:1910
>>  sock_sendmsg_nosec net/socket.c:730 [inline]
>>  __sock_sendmsg net/socket.c:745 [inline]
>>  ____sys_sendmsg+0x997/0xd60 net/socket.c:2588
>>  ___sys_sendmsg+0x271/0x3b0 net/socket.c:2642
>>  __sys_sendmsg net/socket.c:2671 [inline]
>>  __do_sys_sendmsg net/socket.c:2680 [inline]
>>  __se_sys_sendmsg net/socket.c:2678 [inline]
>>  __x64_sys_sendmsg+0x2fa/0x4a0 net/socket.c:2678
>>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
>>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>> 
>> Bytes 34-35 of 36 are uninitialized
>> Memory access of size 36 starts at ffff88802d464a00
>> Data copied to user address 00007ff55033c0a0
>> 
>> CPU: 0 PID: 30322 Comm: syz-executor.0 Not tainted 6.6.0-14500-g1c41041124bd #10
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
>> =====================================================
>> 
>> tipc_add_tlv() puts TLV descriptor and value onto `skb`. This size is
>> calculated with TLV_SPACE() macro. It adds the size of struct tlv_desc and
>> the length of TLV value passed as an argument, and aligns the result to a
>> multiple of TLV_ALIGNTO, i.e., a multiple of 4 bytes.
>> 
>> If the size of struct tlv_desc plus the length of TLV value is not aligned,
>> the current implementation leaves the remaining bytes uninitialized. This
>> is the cause of the above kernel-infoleak issue.
>> 
>> This patch resolves this issue by clearing data up to an aligned size.
>> 
>> Fixes: d0796d1ef63d ("tipc: convert legacy nl bearer dump to nl compat")
>> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> 
> Thanks Yoshida-san,
> 
> I agree with both your analysis and that the fix is correct.
> I also agree that the problem was introduced by the cited commit.
> 
> I did wonder if there would be an advantage to only zeroing the
> otherwise uninitialised portion of tlv, but I guess that the complexity
> isn't worth any gain: all of TLV likely fits into a single cacheline
> anyway.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Hi Simon,

Thank you so much for always reviewing my work :)

Shigeru

> 
>> ---
>>  net/tipc/netlink_compat.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
>> index 5bc076f2fa74..c763008a8adb 100644
>> --- a/net/tipc/netlink_compat.c
>> +++ b/net/tipc/netlink_compat.c
>> @@ -102,6 +102,7 @@ static int tipc_add_tlv(struct sk_buff *skb, u16 type, void *data, u16 len)
>>  		return -EMSGSIZE;
>>  
>>  	skb_put(skb, TLV_SPACE(len));
>> +	memset(tlv, 0, TLV_SPACE(len));
>>  	tlv->tlv_type = htons(type);
>>  	tlv->tlv_len = htons(TLV_LENGTH(len));
>>  	if (len && data)
>> -- 
>> 2.41.0
>> 
>> 
> 



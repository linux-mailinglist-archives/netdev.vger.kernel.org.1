Return-Path: <netdev+bounces-25502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC8A7745BB
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEAF21C20EA3
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C21614F99;
	Tue,  8 Aug 2023 18:45:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619BA13AFA
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:45:19 +0000 (UTC)
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FC81A58BD
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 11:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691518488; x=1723054488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MV/rudRg4tHDKU0zjcs6eE3WlXWXeqg569eZ1V8bJsw=;
  b=t8ogbPb36YSls358bO8xQT8QfBQnGTnULam9chVM6Ap07KJdrzFWByiG
   Qc4AAfxv5Qw99AEOLougL7EkcLDcsCfKngEkUhkxQyP7sP+gHymeipplE
   Clne4/14bKH8ie3v2sfLoFvGUhlbk7Jf0mgK7gItffeQJYKuPddCzOTg3
   o=;
X-IronPort-AV: E=Sophos;i="6.01,156,1684800000"; 
   d="scan'208";a="299116068"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 18:14:42 +0000
Received: from EX19MTAUWA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com (Postfix) with ESMTPS id A92EE67698;
	Tue,  8 Aug 2023 18:14:39 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 8 Aug 2023 18:14:38 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 8 Aug 2023 18:14:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <syzkaller@googlegroups.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net-next] net: annotate data-races around sock->ops
Date: Tue, 8 Aug 2023 11:14:25 -0700
Message-ID: <20230808181426.3420-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230808135809.2300241-1-edumazet@google.com>
References: <20230808135809.2300241-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.26]
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Eric Dumazet <edumazet@google.com>
Date: Tue,  8 Aug 2023 13:58:09 +0000
> IPV6_ADDRFORM socket option is evil, because it can change sock->ops
> while other threads might read it. Same issue for sk->sk_family
> being set to AF_INET.
> 
> Adding READ_ONCE() over sock->ops reads is needed for sockets
> that might be impacted by IPV6_ADDRFORM.
> 
> Note that mptcp_is_tcpsk() can also overwrite sock->ops.
> 
> Adding annotations for all sk->sk_family reads will require
> more patches :/
> 
> BUG: KCSAN: data-race in ____sys_sendmsg / do_ipv6_setsockopt
> 
> write to 0xffff888109f24ca0 of 8 bytes by task 4470 on cpu 0:
> do_ipv6_setsockopt+0x2c5e/0x2ce0 net/ipv6/ipv6_sockglue.c:491
> ipv6_setsockopt+0x57/0x130 net/ipv6/ipv6_sockglue.c:1012
> udpv6_setsockopt+0x95/0xa0 net/ipv6/udp.c:1690
> sock_common_setsockopt+0x61/0x70 net/core/sock.c:3663
> __sys_setsockopt+0x1c3/0x230 net/socket.c:2273
> __do_sys_setsockopt net/socket.c:2284 [inline]
> __se_sys_setsockopt net/socket.c:2281 [inline]
> __x64_sys_setsockopt+0x66/0x80 net/socket.c:2281
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> read to 0xffff888109f24ca0 of 8 bytes by task 4469 on cpu 1:
> sock_sendmsg_nosec net/socket.c:724 [inline]
> sock_sendmsg net/socket.c:747 [inline]
> ____sys_sendmsg+0x349/0x4c0 net/socket.c:2503
> ___sys_sendmsg net/socket.c:2557 [inline]
> __sys_sendmmsg+0x263/0x500 net/socket.c:2643
> __do_sys_sendmmsg net/socket.c:2672 [inline]
> __se_sys_sendmmsg net/socket.c:2669 [inline]
> __x64_sys_sendmmsg+0x57/0x60 net/socket.c:2669
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> value changed: 0xffffffff850e32b8 -> 0xffffffff850da890
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 4469 Comm: syz-executor.1 Not tainted 6.4.0-rc5-syzkaller-00313-g4c605260bc60 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
> 
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


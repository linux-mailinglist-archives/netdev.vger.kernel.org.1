Return-Path: <netdev+bounces-31679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4A178F87E
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 08:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28C61C20831
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 06:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90970523E;
	Fri,  1 Sep 2023 06:23:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6C03D82
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 06:23:32 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400D010D2
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 23:23:30 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68c0cb00fb3so1394554b3a.2
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 23:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693549409; x=1694154209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tjw92k56Ri2yqyAITH3a1oe12KEblf9XsB4dIokF8Vk=;
        b=LlxDRJvtSTWL5Mx3MEvB/BlJXGCiJ1VgRen5rdvSc41E9wxhvEFTzb7Rkat5g8v1PS
         UNBl5YPAEAVzDRdLr56ZGkSpdpyQlWIjh3ajPyWKUiqcuyozZN2mXw28gecJFxkJdT7K
         jxCaP9r/f1zRTh8f/IpGLQmIJffLJkmBZqanQgssmG2p6YulKdLUwxQUjY10+iIuIeq7
         zrJxbIPnbxvnRe/4VaxO2+MBPSYVyqnEDyrcHMt35N+iXtQbCbeGIjIkna1pyb0Zuad2
         ihqAfmm6ea8F12DG/SghJti24IysLYoF77JNEoQukX7Tqbr5c3qmuFUEeLIUcwa8t2bg
         2f4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693549409; x=1694154209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tjw92k56Ri2yqyAITH3a1oe12KEblf9XsB4dIokF8Vk=;
        b=We2PvN/t+awnP4GVtpdACIi0VuCAZwL/WT8U9+7CkaHoIB0lPHHcu9HxecSr6lhro3
         ZT3grj6WerJ3UOaaG2DCyvdi3MNmMBAZAB7g2+paikzTIRDVhj4Rj2KZzvX0s18kMk79
         WNxZAG6krN6pc7TW0SZk+3Hcvz+G0LmW0QQCjvpgyWrvLu8XJ+8nDfnZO1Sk5etEx+5C
         qQgS1wjjmxmILzvICNw8sRZ0a8eVcp1ZmpeQ8d5th4Q+/A2sE4HtYE4l7lZOEaUJt7dA
         Os1xhHvHsX4vV/SabPWzgQbxPq3yzWnmdqq5e3l3YzQOT+tRfFO5UUbS6xPNBiNjHhez
         qk1A==
X-Gm-Message-State: AOJu0Yzax8Wi7GDRtIKh4IqZfgmazDtv+x0gs/2MIX8z9TGMgP/JqKF+
	DXosZV4I3zNoOOACFSoq3dL0EQ==
X-Google-Smtp-Source: AGHT+IHUbkndcqYN5Fqk+WG8Dl045p7LcRZXXy94NITFmvTlqRnH/O0RmNO1dAmoECbDkkyZszkUQg==
X-Received: by 2002:a05:6a20:431c:b0:137:23a2:2b3c with SMTP id h28-20020a056a20431c00b0013723a22b3cmr2131246pzk.49.1693549409588;
        Thu, 31 Aug 2023 23:23:29 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id fm19-20020a056a002f9300b0068c1ac1784csm2223265pfb.59.2023.08.31.23.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 23:23:29 -0700 (PDT)
From: Abel Wu <wuyun.abel@bytedance.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeelb@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Yu Zhao <yuzhao@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	David Howells <dhowells@redhat.com>,
	Jason Xing <kernelxing@tencent.com>
Cc: linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
Subject: [RFC PATCH net-next 0/3] sock: Be aware of memcg pressure on alloc
Date: Fri,  1 Sep 2023 14:21:25 +0800
Message-Id: <20230901062141.51972-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As a cloud service provider, we encountered a problem in our production
environment during the transition from cgroup v1 to v2 (partly due to the
heavy taxes of accounting socket memory in v1). Say one workload behaves
fine in cgroupv1 with memcg limit configured to 10GB memory and another
1GB tcpmem, but will suck (or even be OOM-killed) in v2 with 11GB memory
due to burst memory usage on socket, since there is no specific limit for
socket memory in cgroupv2 and relies largely on workloads doing traffic
control themselves.

It's rational for the workloads to build some traffic control to better
utilize the resources they bought, but from kernel's point of view it's
also reasonable to suppress the allocation of socket memory once there is
a shortage of free memory, given that performance degradation is usually
better than failure.

This patchset aims to be more conservative on alloc for pressure-aware
sockets under global and/or memcg pressure, to avoid further memstall or
possibly OOM in such case. The patchset includes:

  1/3: simple code cleanup, no functional change intended.
  2/3: record memcg pressure level to enable fine-grained control.
  3/3: throttle alloc for pressure-aware sockets under pressure.

The whole patchset focuses on the pressure-aware protocols, and should
have no/little impact on pressure-unaware protocols like UDP etc.

Tested on Intel Xeon(R) Platinum 8260, a dual socket machine containing 2
NUMA nodes each of which has 24C/48T. All the benchmarks are done inside a
separate memcg in a clean host.

  baseline:	net-next c639a708a0b8
  compare:	baseline + patchset

case            	load    	baseline(std%)	compare%( std%)
tbench-loopback        	thread-24	 1.00 (  0.50)	 -0.98 (  0.87)
tbench-loopback        	thread-48	 1.00 (  0.76)	 -0.29 (  0.92)
tbench-loopback        	thread-72	 1.00 (  0.75)	 +1.51 (  0.14)
tbench-loopback        	thread-96	 1.00 (  4.11)	 +1.29 (  3.73)
tbench-loopback        	thread-192	 1.00 (  3.52)	 +1.44 (  3.30)
TCP_RR          	thread-24	 1.00 (  1.87)	 -0.87 (  2.40)
TCP_RR          	thread-48	 1.00 (  0.92)	 -0.22 (  1.61)
TCP_RR          	thread-72	 1.00 (  2.35)	 +2.42 (  2.27)
TCP_RR          	thread-96	 1.00 (  2.66)	 -1.37 (  3.02)
TCP_RR          	thread-192	 1.00 ( 13.25)	 +0.29 ( 11.80)
TCP_STREAM      	thread-24	 1.00 (  1.26)	 -0.75 (  0.87)
TCP_STREAM      	thread-48	 1.00 (  0.29)	 -1.55 (  0.14)
TCP_STREAM      	thread-72	 1.00 (  0.05)	 -1.59 (  0.05)
TCP_STREAM      	thread-96	 1.00 (  0.19)	 -0.06 (  0.29)
TCP_STREAM      	thread-192	 1.00 (  0.23)	 -0.01 (  0.28)
UDP_RR          	thread-24	 1.00 (  2.27)	 +0.33 (  2.82)
UDP_RR          	thread-48	 1.00 (  1.25)	 -0.30 (  1.21)
UDP_RR          	thread-72	 1.00 (  2.54)	 +2.99 (  2.34)
UDP_RR          	thread-96	 1.00 (  4.76)	 +2.49 (  2.19)
UDP_RR          	thread-192	 1.00 ( 14.43)	 -0.02 ( 12.98)
UDP_STREAM      	thread-24	 1.00 (107.41)	 -0.48 (106.93)
UDP_STREAM      	thread-48	 1.00 (100.85)	 +1.38 (100.59)
UDP_STREAM      	thread-72	 1.00 (103.43)	 +1.40 (103.48)
UDP_STREAM      	thread-96	 1.00 ( 99.91)	 -0.25 (100.06)
UDP_STREAM      	thread-192	 1.00 (109.83)	 -3.67 (104.12)

As patch 3 moves forward traversal of cgroup hierarchy for pressure-aware
protocols, which could turn a conditional overhead into constant, tests
running inside 5-level-depth cgroups are also performed.

case            	load    	baseline(std%)	compare%( std%)
tbench-loopback        	thread-24	 1.00 (  0.59)	 +0.68 (  0.09)
tbench-loopback        	thread-48	 1.00 (  0.16)	 +0.01 (  0.26)
tbench-loopback        	thread-72	 1.00 (  0.34)	 -0.67 (  0.48)
tbench-loopback        	thread-96	 1.00 (  4.40)	 -3.27 (  4.84)
tbench-loopback        	thread-192	 1.00 (  0.49)	 -1.07 (  1.18)
TCP_RR          	thread-24	 1.00 (  2.40)	 -0.34 (  2.49)
TCP_RR          	thread-48	 1.00 (  1.62)	 -0.48 (  1.35)
TCP_RR          	thread-72	 1.00 (  1.26)	 +0.46 (  0.95)
TCP_RR          	thread-96	 1.00 (  2.98)	 +0.13 (  2.64)
TCP_RR          	thread-192	 1.00 ( 13.75)	 -0.20 ( 15.42)
TCP_STREAM      	thread-24	 1.00 (  0.21)	 +0.68 (  1.02)
TCP_STREAM      	thread-48	 1.00 (  0.20)	 -1.41 (  0.01)
TCP_STREAM      	thread-72	 1.00 (  0.09)	 -1.23 (  0.19)
TCP_STREAM      	thread-96	 1.00 (  0.01)	 +0.01 (  0.01)
TCP_STREAM      	thread-192	 1.00 (  0.20)	 -0.02 (  0.25)
UDP_RR          	thread-24	 1.00 (  2.20)	 +0.84 ( 17.45)
UDP_RR          	thread-48	 1.00 (  1.34)	 -0.73 (  1.12)
UDP_RR          	thread-72	 1.00 (  2.32)	 +0.49 (  2.11)
UDP_RR          	thread-96	 1.00 (  2.36)	 +0.53 (  2.42)
UDP_RR          	thread-192	 1.00 ( 16.34)	 -0.67 ( 14.06)
UDP_STREAM      	thread-24	 1.00 (106.55)	 -0.70 (107.13)
UDP_STREAM      	thread-48	 1.00 (105.11)	 +1.60 (103.48)
UDP_STREAM      	thread-72	 1.00 (100.60)	 +1.98 (101.13)
UDP_STREAM      	thread-96	 1.00 ( 99.91)	 +2.59 (101.04)
UDP_STREAM      	thread-192	 1.00 (135.39)	 -2.51 (108.00)

As expected, no obvious performance gain or loss observed. As for the
issue we encountered, this patchset provides better worst-case behavior
that such OOM cases are reduced at some extent. While further fine-
grained traffic control is what the workloads need to think about.

Comments are welcomed! Thanks!

Abel Wu (3):
  sock: Code cleanup on __sk_mem_raise_allocated()
  net-memcg: Record pressure level when under pressure
  sock: Throttle pressure-aware sockets under pressure

 include/linux/memcontrol.h | 39 +++++++++++++++++++++++++----
 include/net/sock.h         |  2 +-
 include/net/tcp.h          |  2 +-
 mm/vmpressure.c            |  9 ++++++-
 net/core/sock.c            | 51 +++++++++++++++++++++++++++++---------
 5 files changed, 83 insertions(+), 20 deletions(-)

-- 
2.37.3



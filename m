Return-Path: <netdev+bounces-33970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77387A0FC0
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 23:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721CD282456
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 21:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D741526E2B;
	Thu, 14 Sep 2023 21:20:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5444526E26
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 21:20:46 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0C42705
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 14:20:45 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b50b45481so18535817b3.1
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 14:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694726445; x=1695331245; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ob3uAvnOoSCrtCSZPkBDgY1akrbFBa78/VkbR/tD3Zk=;
        b=vOINow2YxM/MoSfukFZ+ffrZCGQymL1/8iS4WZMKdLIOjR5lWXaAC7A8DVAmDEuYSJ
         eVarJzpkG9cb+yEJ9ex8zSMdTP5BIxrCgLWVUJJWm+nuz4cuaxe6+ZKRFxf/vuDP1AOO
         Igxca97ZL1BJEgGVbJBDmAIu0+JF09MnlKp6LA4bb0yCKyk2vm8FTWyHVMQMx9bOhPcL
         RSJJwqI4cdBz7jr8JUBRzH3DJyaHjtl9/2b0Lfn4Yw3Hwn94ZF/Ci2oKsJGaHvOIgZhr
         HBhFoU6klN3eTC3QkiE+S58oOHd42DD4sL/C3/mvDNXWdPBu0fIcFFFyGOo3BC7IHyRy
         GU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694726445; x=1695331245;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ob3uAvnOoSCrtCSZPkBDgY1akrbFBa78/VkbR/tD3Zk=;
        b=RDzKMTwAv7q22d65kr5H8OYYkEntO8odT5Has9zLSY53IPXrVTsLiD8e6Yq5XvdWoX
         YoGAreq1pmHV27iZ0SAeMSN6UMA48hbyJ3IkJfvTSDsiA41yg9fyCQEGLT3v+YH3N+4g
         6BAEHB2qvNTqOMK1/StCPMgNRpRiArubppmIm65wJV+9wLA2kdKeGHW4vW0bEWWAuzr5
         Sgng5KHBpbpjV86Ln5jsKhYDHDJ89zyUTXJ6BLHx+KKUmps26cet3sr/h8W9PAv6jKKE
         5HdM2fEevJw/HQ+ZWoEwnAQ7mbQJKvYo11Bwdm3Jw49u/6B+Qjcyqzp0gYuygDK79w7C
         lDoA==
X-Gm-Message-State: AOJu0YxjBNBxBctFC/eXo8I9bTu5wSPtg3ujycW2eeFxOmPCXSnd/Vo8
	jkWt7M+BMQqba3Ug4M7eIm2qyg/MH7R38Q==
X-Google-Smtp-Source: AGHT+IHqKkwRb4VbopLin6Ia5XmxbD4rC+NeBFNXt+55ae4VdsIBmIxgGh8mmlngX1m+Fr0aiJb37+HMAskv5w==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a81:af11:0:b0:565:9bee:22e0 with SMTP id
 n17-20020a81af11000000b005659bee22e0mr176595ywh.0.1694726444854; Thu, 14 Sep
 2023 14:20:44 -0700 (PDT)
Date: Thu, 14 Sep 2023 21:20:42 +0000
In-Reply-To: <20230901062141.51972-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230901062141.51972-1-wuyun.abel@bytedance.com>
Message-ID: <20230914212042.nnubjht3huiap3kk@google.com>
Subject: Re: [RFC PATCH net-next 0/3] sock: Be aware of memcg pressure on alloc
From: Shakeel Butt <shakeelb@google.com>
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Yu Zhao <yuzhao@google.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	David Howells <dhowells@redhat.com>, Jason Xing <kernelxing@tencent.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 01, 2023 at 02:21:25PM +0800, Abel Wu wrote:
> 
[...]
> As expected, no obvious performance gain or loss observed. As for the
> issue we encountered, this patchset provides better worst-case behavior
> that such OOM cases are reduced at some extent. While further fine-
> grained traffic control is what the workloads need to think about.
> 

I agree with the motivation but I don't agree with the solution (patch 2
and 3). This is adding one more heuristic in the code which you yourself
described as helped to some extent. In addition adding more dependency
on vmpressure subsystem which is in weird state. Vmpressure is a cgroup
v1 feature which somehow networking subsystem is relying on for cgroup
v2 deployments. In addition vmpressure acts differently for workloads
with different memory types (mapped, mlocked, kernel memory).

Anyways, have you explored the BPF based approach. You can induce socket
pressure at the points you care about and define memory pressure however
your use-case cares for. You can define memory pressure using PSI or
vmpressure or maybe with MEMCG_HIGH events. What do you think?

thanks,
Shakeel


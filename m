Return-Path: <netdev+bounces-53281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B63801E60
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 21:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8CF281078
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 20:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853FF21108;
	Sat,  2 Dec 2023 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qQJFe4F/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB97711F
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 12:00:58 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d33b70fce8so44625437b3.0
        for <netdev@vger.kernel.org>; Sat, 02 Dec 2023 12:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701547258; x=1702152058; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w6r5diBsYcYog8zy+MKulbNp8/3VXjMUsfSBh0V/6R4=;
        b=qQJFe4F/dabldoPoD7F+81UZPEDZkuRoMtbXfGZX3LE5qqIk23CE7Wk1Jb2nrvPqtD
         T7opxXgpTbgaxzPt+mM3mfkRqidP10mS8Xq77rn6Zb92bdkeV/Prqpyk8LS4IPbYS+hd
         2wKJnu3cOqq9puJ/S8v+zi+qVR0U223PnckekCsa3pjdyTexfhcYv7q4u9dT+IOIrAN4
         CRMPY8JkvmuKQgx72igFPxvD7ia93GJPhTZkkuaLv1Iuv/2KoK4/iAXIUVlV5oXRlxiu
         UMi/YXrVR7RiDW6NcqnXjmku2gxGUNPQtFwixq3Nx5diSjdCCLD8xhx87MHHYAye+e1k
         HQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701547258; x=1702152058;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w6r5diBsYcYog8zy+MKulbNp8/3VXjMUsfSBh0V/6R4=;
        b=I5gZYT4t9WL5ULo0FDntX0dJiMjcJUBQW+Aw0H1w9WGaI21aHtU2VH7v2Oz9lB0dLO
         ZnlLT/lmTGjHdnj2fo+alOz9ALQga/d8VTqWAAt0uWnIO23T4MzNLNqCCIdGlyBmlCKc
         r7Zvcqckvb/BjJPkgVsWEgkkrVi9dBjqqVajsvVXuqf197++kHrpDVr9MWm1J58srTRK
         7Enab9QMV3Zom/fCkb564H5LNFbhPP+Rzf5J78a7THdu0YPV2MvkYszDlPT/hq+H2mzZ
         5yDCXuHqGG8Xpctzz4VOzIqVC8vNQVcXkKeZJffN+666m/nD/SFaJRfRZy9elhHL9lhr
         GPKg==
X-Gm-Message-State: AOJu0YwONZsiSOyEkXFQ0+g2Nr1J7YERiAgNIPvyiGzK9NHCmqNdzuEK
	vGQvV+PwPyW1ybAlT0AwoLM9l9P371qx+A==
X-Google-Smtp-Source: AGHT+IF7XxLA0ZivlM/bFnywVmBhyRxNQIZDMqr1vLFkxD0t4nZZEKYMrBUW6RoqSqrn1xsu3wHax6vfjPpuiA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:690c:10:b0:5d7:efdf:7712 with SMTP id
 bc16-20020a05690c001000b005d7efdf7712mr1512ywb.9.1701547258171; Sat, 02 Dec
 2023 12:00:58 -0800 (PST)
Date: Sat, 2 Dec 2023 20:00:56 +0000
In-Reply-To: <20231129072756.3684495-2-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129072756.3684495-1-lixiaoyan@google.com> <20231129072756.3684495-2-lixiaoyan@google.com>
Message-ID: <20231202195922.a3ekbrdfgqzfm6al@google.com>
Subject: Re: [PATCH v8 net-next 1/5] Documentations: Analyze heavily used
 Networking related structs
From: Shakeel Butt <shakeelb@google.com>
To: Coco Li <lixiaoyan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, 
	David Ahern <dsahern@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Pradeep Nemavat <pnemavat@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 29, 2023 at 07:27:52AM +0000, Coco Li wrote:
> Analyzed a few structs in the networking stack by looking at variables
> within them that are used in the TCP/IP fast path.
> 
> Fast path is defined as TCP path where data is transferred from sender to
> receiver unidirectionally. It doesn't include phases other than
> TCP_ESTABLISHED, nor does it look at error paths.
> 
> We hope to re-organizing 

We plan to reorganize?

> variables that span many cachelines whose fast
> path variables are also spread out, and this document can help future
> developers keep networking fast path cachelines small.
> 
> Optimized_cacheline field is computed as
> (Fastpath_Bytes/L3_cacheline_size_x86), and not the actual organized
> results (see patches to come for these).
> 
> Investigation is done on 6.5
> 
> Name	                Struct_Cachelines  Cur_fastpath_cache Fastpath_Bytes Optimized_cacheline
> tcp_sock	        42 (2664 Bytes)	   12   		396		8
> net_device	        39 (2240 bytes)	   12			234		4
> inet_sock	        15 (960 bytes)	   14			922		14
> Inet_connection_sock	22 (1368 bytes)	   18			1166		18
> Netns_ipv4 (sysctls)	12 (768 bytes)     4			77		2
> linux_mib	        16 (1060)	   6			104		2
> 

Is there any hidden meaning behind the capital I and N for
Inet_connection_sock and Netns_ipv4?

> Note how there isn't much improvement space for inet_sock and
> Inet_connection_sock because sk and icsk_inet respectively takes up so
> much of the struct that rest of the variables become a small portion of
> the struct size.
> 
> So, we decided to reorganize tcp_sock, net_device, netns_ipv4
> 
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Coco Li <lixiaoyan@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

This is really awesome work and motivated me to do something similar for
struct mem_cgroup (and or mm structs) as well.



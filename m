Return-Path: <netdev+bounces-53289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C73A801E82
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 21:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1816A1C208B0
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 20:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDFD8827;
	Sat,  2 Dec 2023 20:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lwMZPPkL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6D1C1
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 12:34:36 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5ca61d84dc3so47924337b3.0
        for <netdev@vger.kernel.org>; Sat, 02 Dec 2023 12:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701549275; x=1702154075; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gTdGmlvI6GLGNXCKVSpo2t6iV30Sx4dAQCLKlfjuvDU=;
        b=lwMZPPkLmWYkTGDYOiljjq1eCViaQpHAqIirkNEOzyWNUV5/997ttVOjZqzoj5QLdn
         a6AgOlEWV7W5FVqhMgUWd+LWtRZ8WPC9EmxywWRGxNbrHE2Q5b72tnacHfIW5TcjnYg5
         LyMICiC09s24vrBQXAMfWhlkj5Jf+mzlOXV/OTVGqWGkLv/9I5KVzgI4oH2dCfmEErmO
         pC1GLhMKl+2lbjHZ3PXJ+tYXT0WgaTFKonaO1ycSocy20SytqEzOKhZTm6jbXwrIED2n
         j+Ubb2iRP9kI7Z3CoHiw2uILN8T1j21VO/vmhPVUbTnzcJHkMY5Wb0lCqlCZHYGwygl+
         NVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701549275; x=1702154075;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gTdGmlvI6GLGNXCKVSpo2t6iV30Sx4dAQCLKlfjuvDU=;
        b=HuqQKxTB7gP8rwdMk7cOeauKO2SV/jxOsa43711F6aU5Tls4SeEoyM1zkI8/5qY9cW
         mHFxcs4bWSXvxdPU/BYRaOrW1kTDm7/2a2Z7x4VvR4KKfufoiJ3EX3bE/lJvXGJJUb76
         kAAuC0UqL/rKCIr1Xkp1GjEcvQpzUn6y4PevRY6PieOC1QHuoju7Sh7E81J2GWWCmr9B
         LiXFJH+kcGbEyyrn7zfeN1l+8j8JDxj6uBiTzwYh5mEwljLJNtP4ZMr3f7PQuwV9Q7OD
         W/qJZuVH32MFVsS2NuRk3EMvs3WfuFFHpwsAzlO9eq36/gxK1FrhKXt3xbND+lol+E1+
         qYig==
X-Gm-Message-State: AOJu0YyjLb+pBuG958ZqzKSIZcFK+N/1DDj3HYCSEi+kZgpnkCTD/pFH
	HMx7r6TP+RNQM+6FM6AIGfYf5gyA77OjSQ==
X-Google-Smtp-Source: AGHT+IHojCeycj47b/3TGASc+6oyH9yXwDZqwGqA3QaB1LuJuPEk5TBI5jHsYfraSenQVkTE44m5cz0wjlIYTQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:3d44:0:b0:d9a:bce6:acf3 with SMTP id
 k65-20020a253d44000000b00d9abce6acf3mr1020661yba.0.1701549275545; Sat, 02 Dec
 2023 12:34:35 -0800 (PST)
Date: Sat, 2 Dec 2023 20:34:33 +0000
In-Reply-To: <20231129072756.3684495-1-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129072756.3684495-1-lixiaoyan@google.com>
Message-ID: <20231202203433.ifi6dn74hgnseq4y@google.com>
Subject: Re: [PATCH v8 net-next 0/5] Analyze and Reorganize core Networking
 Structs to optimize cacheline consumption
From: Shakeel Butt <shakeelb@google.com>
To: Coco Li <lixiaoyan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, 
	David Ahern <dsahern@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Pradeep Nemavat <pnemavat@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 29, 2023 at 07:27:51AM +0000, Coco Li wrote:
> Currently, variable-heavy structs in the networking stack is organized
> chronologically, logically and sometimes by cacheline access.
> 
> This patch series attempts to reorganize the core networking stack
> variables to minimize cacheline consumption during the phase of data
> transfer. Specifically, we looked at the TCP/IP stack and the fast
> path definition in TCP.
> 
> For documentation purposes, we also added new files for each core data
> structure we considered, although not all ended up being modified due
> to the amount of existing cacheline they span in the fast path. In
> the documentation, we recorded all variables we identified on the
> fast path and the reasons. We also hope that in the future when
> variables are added/modified, the document can be referred to and
> updated accordingly to reflect the latest variable organization.
> 
> Tested:
> Our tests were run with neper tcp_rr using tcp traffic. The tests have $cpu
> number of threads and variable number of flows (see below).
> 
> Tests were run on 6.5-rc1
> 
> Efficiency is computed as cpu seconds / throughput (one tcp_rr round trip).
> The following result shows efficiency delta before and after the patch
> series is applied.

If you don't mind, can you provide the exact cmd to run tcp_rr? Also am
I assuming correctly that you ran experiment in root container?



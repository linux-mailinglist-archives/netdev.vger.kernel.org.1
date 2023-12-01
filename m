Return-Path: <netdev+bounces-52792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B28F8003A5
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 07:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62051F20F51
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 06:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C31C15F;
	Fri,  1 Dec 2023 06:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Bu0gX/kZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BEE171A
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 22:20:42 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50bbc36f767so2489442e87.1
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 22:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701411641; x=1702016441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lr1SxrxtjnBwIXeraWPTW6/ftY9gYyhFBASILs735gM=;
        b=Bu0gX/kZUotT/KrYDuNZ3NzsN37pF0BHAOzjoWpopSbRfvPDIcRFVgyOdm/otM4Wei
         iG55L/Na5euAxJ7oyL9iqcmiHveSU0mYkIQYUhT8I2J9D+tltAAlVfiqmvGd4n/OVejm
         UntIlFRJXEaLjOldaO8ULaPUwvvr4ojFsevHQFZa8ZiLSejp2DfhPrRMoFXqM/YeG0mz
         zwke6JmK8chAY0e7i9dMNe2Nm9+iIcsyQHf7SqEk5lAB2wcUslqvztOLiMXbzHCl5DQp
         YoRZbvShS431w+olIGoZEEHpUI2cgQB6NgIU4nGrNOX/622OmsuF0pY4Cn9fg3itUtyV
         YJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701411641; x=1702016441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lr1SxrxtjnBwIXeraWPTW6/ftY9gYyhFBASILs735gM=;
        b=VAStwev2yxC70UONbgJXFzku5wv8XUHVoDT3Lp7XOSyD1U/+JKz0DIaYRcz5m5WiZ6
         5Al7F9GbZRldiAyi2+8t9ZuqesXYE5bKtcmePp59vyF6VBmo0MwndUZBlgwJ5qIy7INV
         LC7a50Ceu14e+Jll2PG7A6g1m78HcPenbrY7xzR6WD+p1udvQS+iwHkDIjHhM0qYpITx
         VgL22isC+QpQNAGHEhj4vaiuA38vCnoxzJpCftmyaC1d7xzxusxtMqbNvu2hDpT+E8Ud
         jsgEf4LK7lKFXmknEgyRqgOvDPIOAAwIDU5NZa8Vbk7QvzdsmI3PvatZYJszGTulNjEg
         O9zA==
X-Gm-Message-State: AOJu0Yxa7iJw9C2BMXLc7xWEEe5mmeRjVQW1qwSyVZO3LW7h6DR9ZtKY
	681dHxN8uCJidxyI6iEuCQHhQr40dM+LA+ZdlCl5uA==
X-Google-Smtp-Source: AGHT+IEuumCPkABaLV/MxgbmMcrswJVGbF+ByC+rsYSy+g2bl3UvowPLpycWs4tprIt/k5f+BCcYB+9a8tnOQdzATiY=
X-Received: by 2002:a05:6512:2205:b0:50b:d764:76e7 with SMTP id
 h5-20020a056512220500b0050bd76476e7mr503276lfu.118.1701411641008; Thu, 30 Nov
 2023 22:20:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <92a355bd-7105-4a17-9543-ba2d8ae36a37@kernel.org>
 <21d05784-3cd7-4050-b66f-bad3eab73f4e@kernel.org> <7f48dc04-080d-f7e1-5e01-598a1ace2d37@iogearbox.net>
 <87fs0qj61x.fsf@toke.dk> <0b0c6538-92a5-3041-bc48-d7286f1b873b@gmail.com>
 <87plzsi5wj.fsf@toke.dk> <1ff5c528-79a8-fbb7-8083-668ca5086ecf@iogearbox.net>
 <871qc72vmh.fsf@toke.dk> <8677db3e-5662-7ebe-5af0-e5a3ca60587f@iogearbox.net> <e3402045-a36f-461f-8eab-bbc51735492d@kernel.org>
In-Reply-To: <e3402045-a36f-461f-8eab-bbc51735492d@kernel.org>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 1 Dec 2023 00:20:30 -0600
Message-ID: <CAO3-PbrQ+LoPYZUN2kpvMHmwW-Opa3pX=g11gdNy1oaXPG6GAg@mail.gmail.com>
Subject: Re: Does skb_metadata_differs really need to stop GRO aggregation?
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Edward Cree <ecree.xilinx@gmail.com>, Stanislav Fomichev <sdf@google.com>, Netdev <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 2:35=E2=80=AFPM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
> We are exploring more options than only XDP metadata area to store
> information.  I have suggested that once an SKB have a socket
> associated, then we can switch into using BPF local socket storage
> tricks. (The lifetime of XDP metadata is not 100% clear as e.g.
> pskb_expand_head clears it via skb_metadata_clear).
> All ideas are welcome, e.g. I'm also looking at ability to store
> auxiliary/metadata data associated with a dst_entry. And SKB->mark is
> already used for other use-cases and isn't big enough. (and then there
> is fun crossing a netns boundry).
>
sk local storage might not work for the cases if packets are purely
forwarded or end up with a tun/tap device. Can we make XDP metadata
life time clear then? It would also be really interesting if we can
sendmsg with metadata, too. We often have a hard time distinguishing
if a kernel event like packet drop/retransmission correlates to a
reported customer problem. It's hard because when the event happens,
there isn't customer specific information in the context to correlate,
usually only multiplexed sockets and the packet triggering such an
event. Allowing carrying some extra information on the packet would
definitely improve this a lot with BPF tracing.

Yan


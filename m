Return-Path: <netdev+bounces-210448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EA4B135DE
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 09:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257E93B7D81
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 07:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3448F1DE4CE;
	Mon, 28 Jul 2025 07:53:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DF819E97A
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 07:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753689181; cv=none; b=JIdBC2MEEEXat6uK08wbhJtdEpYGm1Yhxc5rbqG9L4hTI57fCqsyfEiSut/c5Dhgmv4tzL1uUFu427YAAU8119G0b7xbvBZjJRSBdnURH0EvRJQHpAfJlquYPqtPU4Sw7MGSczRLz0KueU29VRZaSTFZ4C8D0eaVqa+xowuLynI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753689181; c=relaxed/simple;
	bh=ntduMaXwpopoqf4kttUtJxH7m1Wx4PxckCSDxwqphq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQN2IFvc6MFFp18wD7NqcmSj/KAFRs4e3Hy4FKqEjo/3cjBtTGw6ZYt1AzQ5FZZWAp9VKuw4XjixAwJhtJQrvHQ2uiQswlQcbCS0K0ga2A1krUVBUTJtfInpYm8tb1UwdgROtoiNZmzILRYo/2ETyC4R0YABKEZQwONi2ab00KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so6681811a12.1
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 00:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753689178; x=1754293978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzCejkiM1sgPVH19zfgFeH37Ma/GpIBlbrNZ/9CGGQw=;
        b=uYhhIszRED3WpeDlK9gnH0530Qm/2Sk3FpyNynDNqDdS8yg4twUovmWUoRmRfC1zND
         O7a5x7nGQgDlv53AL/r4nQ4DLoiRGqFAluFLru9BbOd8oH44z1kYrQ3j4/y1CGYOdHKs
         Ldc/FbZfZDAD3u0utlf/95d6WadJsN6jF8j7A9FeTY2P2eueqSjEYKZEUDyDGrpCCSXN
         lEMn1dpXawi2U9ncyyemto5D7MtOjOtI78u9O9Ke10kZwNwn7wQT2yMXWTCDqrPEFR/k
         xJ6s7KsLWefh1/mWB/nwKWK+Ruj6gUm0iLIxMuUHuZv/2Z8TNf5+NGpu813ERuFso0hK
         hEuw==
X-Forwarded-Encrypted: i=1; AJvYcCVl7U+RcedjRB06Pp8ot360as/YWseGdekL3uedng4Z5ArJzYuvrzCax1RyvWlFXRs5CZNTNTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5A0/89RBCxOnRYELIl5nWGXDX2uJt8hEc72pUrrPgIuwTVJb9
	0NefgiGXl48rwTN6hhHMT0T7P30zzzu61t5yVpsa/GaA5qchQ0W78uIc
X-Gm-Gg: ASbGncvu+o7OFhME2mjlTAh5Gy61LdI9P7Rle3OUEAV4zbRuhTo43E6vv9dsAQxWnbg
	9xX1zv2x0gx+sMNBQkbWHxK8ewpG7q3ilApUCi/haHyMP1ZRtbNysy3vxvLUwfZl4OnaWgsvvmM
	yYJOBgDLgZHWhNHgxsWQrBrE2b4h0nHmhZx5w9D/OONlnL4DXRkSxJ84wwbvWQAa6D6ama7iW01
	CVm1JvMGeHFZqBrcUb5bAu7Ta1X3OtNr26iE+w5sWFq07C0reW3SEKduOjzuFXw/Lnb1AmLXPKY
	clgzDWxDvJLsMn+Qal8sN7Pet4dV6KF8FLQUo7MCcz/FEIxo79od5Wvam//Oi3oiJcQgMPC7ubP
	pB/NHQUYT6LX6
X-Google-Smtp-Source: AGHT+IHEtNeF3+nDRxshADVKTjS4QTO9SObWgRiY+KFoKvnP+fkKbaCywheZuOo9qhIkyUp0ws9B+g==
X-Received: by 2002:a17:907:3e9f:b0:ae6:ddc2:f9f4 with SMTP id a640c23a62f3a-af61c2b4194mr1235939166b.6.1753689177393;
        Mon, 28 Jul 2025 00:52:57 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af6358e2f09sm389648966b.64.2025.07.28.00.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 00:52:56 -0700 (PDT)
Date: Mon, 28 Jul 2025 00:52:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	Jason Wang <jasowang@redhat.com>, Zigit Zo <zuozhijie@bytedance.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, sdf@fomichev.me
Subject: Re: [PATCH net v2] netpoll: prevent hanging NAPI when netcons gets
 enabled
Message-ID: <a5hzuzvrrkbpxalrfvc64ecrp2ofgx7kgv35aq5mzqxq67tejg@yp4hxt2vjo4u>
References: <20250726010846.1105875-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726010846.1105875-1-kuba@kernel.org>

On Fri, Jul 25, 2025 at 06:08:46PM -0700, Jakub Kicinski wrote:
> Paolo spotted hangs in NIPA running driver tests against virtio.
> The tests hang in virtnet_close() -> virtnet_napi_tx_disable().
> 
> The problem is only reproducible if running multiple of our tests
> in sequence (I used TEST_PROGS="xdp.py ping.py netcons_basic.sh \
> netpoll_basic.py stats.py"). Initial suspicion was that this is
> a simple case of double-disable of NAPI, but instrumenting the
> code reveals:
> 
>  Deadlocked on NAPI ffff888007cd82c0 (virtnet_poll_tx):
>    state: 0x37, disabled: false, owner: 0, listed: false, weight: 64
> 
> The NAPI was not in fact disabled, owner is 0 (rather than -1),
> so the NAPI "thinks" it's scheduled for CPU 0 but it's not listed
> (!list_empty(&n->poll_list) => false). It seems odd that normal NAPI
> processing would wedge itself like this.
> 
> Better suspicion is that netpoll gets enabled while NAPI is polling,
> and also grabs the NAPI instance. This confuses napi_complete_done():
> 
>   [netpoll]                                   [normal NAPI]
>                                         napi_poll()
>                                           have = netpoll_poll_lock()
>                                             rcu_access_pointer(dev->npinfo)
>                                               return NULL # no netpoll
>                                           __napi_poll()
> 					    ->poll(->weight)
>   poll_napi()
>     cmpxchg(->poll_owner, -1, cpu)
>       poll_one_napi()
>         set_bit(NAPI_STATE_NPSVC, ->state)
>                                               napi_complete_done()
>                                                 if (NAPIF_STATE_NPSVC)
>                                                   return false
>                                            # exit without clearing SCHED
> 
> This feels very unlikely, but perhaps virtio has some interactions
> with the hypervisor in the NAPI ->poll that makes the race window
> larger?
> 
> Best I could to to prove the theory was to add and trigger this
> warning in napi_poll (just before netpoll_poll_unlock()):
> 
>       WARN_ONCE(!have && rcu_access_pointer(n->dev->npinfo) &&
>                 napi_is_scheduled(n) && list_empty(&n->poll_list),
>                 "NAPI race with netpoll %px", n);
> 
> If this warning hits the next virtio_close() will hang.
> 
> This patch survived 30 test iterations without a hang (without it
> the longest clean run was around 10). Credit for triggering this
> goes to Breno's recent netconsole tests.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Link: https://lore.kernel.org/c5a93ed1-9abe-4880-a3bb-8d1678018b1d@redhat.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviwed-by: Breno Leitao <leitao@debian.org>


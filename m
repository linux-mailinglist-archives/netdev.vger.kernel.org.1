Return-Path: <netdev+bounces-219788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6A7B42FCA
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 04:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C371BC65BF
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 02:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBBB1F4262;
	Thu,  4 Sep 2025 02:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="p6FvC+TD"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A2C2628D;
	Thu,  4 Sep 2025 02:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756953371; cv=none; b=Pg0Pkph8oqwCEtw4AHXkLvBsPCjqt6duj4rLKDrYaXJD1xf+VUf1gktY8ZtB6vAWjjXXWgd1CsIFrbsKztorLMDmiXBxZU+ZoGbC1YMATdZ1ewM477u/Fy1EcTt4TTqHDvpg7hgiYAUKJQsaTM3IGCbpMeEbBi4w+hRzu4vTbNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756953371; c=relaxed/simple;
	bh=QYB0IwUTuhhfZsNHmrxJTL4PzEY0ll1fj8+65L1JXCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=K5Nc39dkzxryvdWtd74Iba8h89RkV6nEnRyLWSLYJ9WPNwuezpVSOIydfifvUgELWMLG557wMqbVUDdsB07U35QOP6k26GO0E7YOmDo17ORJXH8aM0lXXcU+yoYHdpxOV3+x6X8KoCSmB++kp1tPwYnhCciyn7KOe4JqwR3wnRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=p6FvC+TD; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=OA9Vb3cQLRUlQnsE8aU2oWch3B/9d5PL/UyP8KxyixU=;
	b=p6FvC+TDTsHn02SaoSc7W0s3qv4oN05oNSmpAkaEUn8x6odhydSF1Td8Spj+3Q
	HKI3Ik+vmt0uf0MNJywkmyZ1ks6tJQeuNSDQSE674L/94FKMRtVM2aem0q6lCJkV
	jhPZxHAaMmjQZaLuNVXuQKfK2LNPd4EZSJQyA3/XOOe6Q=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAXU7n5+rhoYiz7Fw--.21177S2;
	Thu, 04 Sep 2025 10:35:39 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: kerneljasonxing@gmail.com,
	willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	ferenc@fejes.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 1/2] net: af_packet: remove last_kactive_blk_num field
Date: Thu,  4 Sep 2025 10:35:37 +0800
Message-Id: <20250904023537.934715-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXU7n5+rhoYiz7Fw--.21177S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zry8CFyUtw4kZry3ZFWxXrb_yoW8Zw1kpa
	yrKF13Cw1DWa1jq3ZrZwn7XryfXw15AF15GrZ5Jry3Ca48XFyIyF9avFW3WFW0vrsxKanI
	qF48G34rAw1q9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRRHqcUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiJQC+Cmi4+UUtBgAAsW

On Thu, Sep 4, 2025 at 10:09 +0800 Jason Xing <kerneljasonxing@gmail.com> wrote:

> > Consider the following case:
> > (before applying this patch)
> > cpu0                                  cpu1
> > tpacket_rcv
> >   ...
> >     prb_dispatch_next_block
> >       prb_freeze_queue (R = 1)
> >                                       prb_retire_rx_blk_timer_expired
> >                                         L != K
> >                                           _prb_refresh_rx_retire_blk_timer
> >                                             refresh timer
> >                                             set L = K
> 
> I do not think the above can happen because:
> 1) tpacket_rcv() owns the sk_receive_queue.lock and then calls
> packet_current_rx_frame()->__packet_lookup_frame_in_block()->prb_dispatch_next_block()
> 2) the timer prb_retire_rx_blk_timer_expired() also needs to acquire
> the same lock first.
> 
> > (after applying this patch)
> > cpu0                                  cpu1
> > tpacket_rcv
> >   ...
> >     prb_dispatch_next_block
> >       prb_freeze_queue (R = 1)
> >                                       prb_retire_rx_blk_timer_expired
> >                                         !forzen is 0
> >                                           check prb_curr_blk_in_use
> >                                             if true
> >                                               same as (before apply)
> >                                             if false
> >                                               prb_open_block
> > Before applying this patch, prb_retire_rx_blk_timer_expired will do nothing
> > but refresh timer and set L = K in the case above. After applying this
> > patch, it will check prb_curr_blk_in_use and call prb_open_block if
> > user-space caught up.
> 
> The major difference after this patch is that even if L != K we would
> call prb_open_block(). So I think the key point is that this patch
> provides another checkpoint to thaw the might-be-frozen block in any
> case. It doesn't have any effect because
> __packet_lookup_frame_in_block() has the same logic and does it again
> without this patch when detecting the ring is frozen. The patch only
> advances checking the status of the ring.


In the prb_dispatch_next_block function, after executing prb_freeze_queue, it
directly returns without executing prb_open_block. As a result, tpacket_rcv
completes and exits the lock, and then callback executes while (L != K).
Perhaps my diagram did not convey this clearly. I think it might be better to
use your description above to replace the flowchart representation.


Thanks
Xin Zhao



Return-Path: <netdev+bounces-219602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B09B4242D
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 16:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1293654636D
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0574B306D4A;
	Wed,  3 Sep 2025 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Cd9fGRh2"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFA72FE588;
	Wed,  3 Sep 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911477; cv=none; b=YYe+B5s6WyBUEKjsaZaBvLIjtgAKPPMjkZIxuOytJpAoxTz7ySjBzd4PTT0bSCTQ9+sOC7ZL8wBaIJgi9GFyM574DmNZJ/sZ6mlRm+Ns1cPQvw4HfgL4QgucU4zpX0LUaGR9EsVBiY9J2prltLTsYqaAm3quQ5LLuwLhLFdsdWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911477; c=relaxed/simple;
	bh=BdwG62fDtg47vvCb4MwKCLyM9BMZmSyZyWT0ZVlVrnM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=X1WJ10vs/MgbDyd38yEBgM3aY3/IHdx7ybpkY+tUYl5O3QcXHxZ5Jl99xwJklYtf6G25nCKsVEgFBlVGB6yAp45OTxMKIK9ZJ/GLMbXd5tlFI505qTwkB+QYYJHo8ruejq0q6l+oTYwnxXMpIdTLym4d0YGBBfs+6ZOUBi+ivgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Cd9fGRh2; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=K8WY9aFD+CUj89iruPgyjiRLIAu3DijEUC4gWKS0H0M=;
	b=Cd9fGRh2gXyapWpgfugzdtLl9dI+PReNtmxWt7uAMWW3pH/DOKycIZCrsGWJQ5
	NUg1oVvDNALjAA7HqRaGqGKqMhY4VonNVsPCmr6vPg2yW0XBZ7sXO1/o35/7yvsj
	3zIkKwIFCS3Y0JJNCGuyFggguOQ3UUUyaYuu6SNk6/7lc=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCnnT4AV7honETyGA--.7418S2;
	Wed, 03 Sep 2025 22:56:01 +0800 (CST)
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
Date: Wed,  3 Sep 2025 22:56:00 +0800
Message-Id: <20250903145600.512627-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnnT4AV7honETyGA--.7418S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXryDZr43Wr4ftrW7tr1UZFb_yoWrJw1DpF
	WrGw13Gw4Du3yjgw47XwnFvryrWw45Ar15Wrn5JFZ5AFy7XryrAFW29FW5XFy8trsxtw42
	vw48GFyxAw1DuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U8uciUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiow29Cmi4Tr6zNAAAs+

On Tue, Sep 2, 2025 at 22:04 PM Jason Xing <kerneljasonxing@gmail.com> wrote:

> > kactive_blk_num (K) is incremented on block close. last_kactive_blk_num (L)
> > is set to match K on block open and each timer. So the only time that they
> > differ is if a block is closed in tpacket_rcv and no new block could be
> > opened.
> > So the origin check L==K in timer callback only skip the case 'no new block
> > to open'. If we remove L==K check, it will make prb_curr_blk_in_use check
> > earlier, which will not cause any side effect.
> 
> I believe the above commit message needs to be revised:
> 1) the above sentence (starting from 'if we remove L....') means
> nothing because your modification doesn't change the behaviour when
> the queue is not frozen.
> 2) lack of proofs/reasons on why exposing the prb_open_block() logic doesn't
> cause side effects. It's the key proof that shows to future readers to
> make sure this patch will not bring trouble.

This diff file may not clearly demonstrate the changes made to the
prb_retire_rx_blk_timer_expired function. We have simply removed the check for
pkc->last_kactive_blk_num == pkc->kactive_blk_num; the other logic remains unchanged.
Therefore, we should only need to explain why removing the check for
pkc->last_kactive_blk_num == pkc->kactive_blk_num will not cause any negative impacts.

I will clarify in the commit that our change to prb_retire_rx_blk_timer_expired only
involves removing the check for pkc->last_kactive_blk_num == pkc->kactive_blk_num,
to ensure that everyone understands this point, as it may not be clearly visible from
the diff file.

The commit may be changed as follow:

kactive_blk_num (K) is only incremented on block close.
In timer callback prb_retire_rx_blk_timer_expired, except delete_blk_timer
is true, last_kactive_blk_num (L) is set to match kactive_blk_num (K) in
all cases. L is also set to match K in prb_open_block.
The only case K not equal to L is when scheduled by tpacket_rcv
and K is just incremented on block close but no new block could be opened,
so that it does not call prb_open_block in prb_dispatch_next_block.
This patch modifies the prb_retire_rx_blk_timer_expired function by simply 
removing the check for L == K. Why can we remove the check for L == K in
timer callback?
In prb_freeze_queue, reset_pending_on_curr_blk (R) is set to 1. If R == 1,
prb_queue_frozen return 1. In prb_retire_rx_blk_timer_expired,
frozen = prb_queue_frozen(pkc); so frozen is 1 when R == 1.

Consider the following case:
(before applying this patch)
cpu0                                  cpu1
tpacket_rcv
  ...
    prb_dispatch_next_block
      prb_freeze_queue (R = 1)
                                      prb_retire_rx_blk_timer_expired
                                        L != K
                                          _prb_refresh_rx_retire_blk_timer
                                            refresh timer
                                            set L = K
(after applying this patch)
cpu0                                  cpu1
tpacket_rcv
  ...
    prb_dispatch_next_block
      prb_freeze_queue (R = 1)
                                      prb_retire_rx_blk_timer_expired
                                        !forzen is 0
                                          check prb_curr_blk_in_use
                                            if true
                                              same as (before apply)
                                            if false
                                              prb_open_block
Before applying this patch, prb_retire_rx_blk_timer_expired will do nothing
but refresh timer and set L = K in the case above. After applying this
patch, it will check prb_curr_blk_in_use and call prb_open_block if
user-space caught up.


Please check if the above description is appropriate. I will change the
description as above in PATCH v11.


> 
> >
> > Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> 
> It was suggested by Willem, so please add:
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>

Okay, I will add it in the PATCH v11.

> 
> So far, it looks good to me as well:
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> 
> And I will finish reviewing the other patch by tomorrow :)


Thanks
Xin Zhao



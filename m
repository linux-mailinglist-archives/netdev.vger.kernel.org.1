Return-Path: <netdev+bounces-292052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HKGO5NNFmqxkgcAu9opvQ
	(envelope-from <netdev+bounces-292052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:49:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7405DE5DA
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0BC6F301387C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EAB2C0285;
	Wed, 27 May 2026 01:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5fa2O2k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC94F2E414
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 01:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846546; cv=none; b=hvEJLXGbykw1zf7YFlPhEfXLzFUXEnXEcRkDLYZwBdhvh5C1K7vR+eFXdZB8paWwwyx3LgVwOPD4udLd2bSCUlKpyzI2QTM+iBCvG1pxwIcXA7kHB3NPg68AV/Wv/upMlo2vzDbt6r9BcuZ7uzXsgReApDB4FlibSRdXG0Myeo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846546; c=relaxed/simple;
	bh=AXTbcZZHlRf9qUFE3M3D4PKuv4PolGh/3zncuZ7Ywso=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qP9wYsPsmWhYCChBiSB59LRiL4An2ZbOo1duXooPYoYAPtj+5ghTfNbJElOyfqDm/4G1B4+9TvnxlptUFFi7sICuS3NQCX/xHr9i462s5hkEKeLx0vF7sRxvCSzshLJvWr4sMcWU2O/8CN0IiDD2wCR33zGRhXyxcXdZBQXgIwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5fa2O2k; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D991F000E9;
	Wed, 27 May 2026 01:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779846544;
	bh=9/Nk0ZKOugITnDUuPngEd75gO6/zdNV+dbP0KNxeiOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A5fa2O2knppuE0RLNgGT4ioImG1eLVvwM48eiH/ySsPwxyLdyr87NURFTE7vh8Gng
	 hsdjOB+ql/zbKig7UHVmlUJxqM6PADdsai6KmodNN3bKpH9mJ3js1XGMbLtQji9MZs
	 pIYmRl7VbT9S7vHTnUDOnHVzK3PeumdexpLzLRK/QgdAPzC8tp9XTl7Hmz8PrVvIQc
	 MocQgGVQV6XfDeCmZkQqemVkWsYI/tpxvZlWP09hE881jkJOCdvi1T0feTQfT4/Yqn
	 332ZP4Bt8scf9ho8IJFfMTLmz+LzKC0UPQaW+csMPWvSVUXRos/Rm4LL3J9lw40m8S
	 m8EbeB5S83oow==
Date: Tue, 26 May 2026 18:49:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v2 3/3] net: libwx: support vf hardware
 statistics
Message-ID: <20260526184903.17bff72b@kernel.org>
In-Reply-To: <20260525101115.13151-4-mengyuanlou@net-swift.com>
References: <20260525101115.13151-1-mengyuanlou@net-swift.com>
	<20260525101115.13151-4-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292052-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9B7405DE5DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 18:11:15 +0800 Mengyuan Lou wrote:
> Add support to show hardware statistics for ethtool -S ethx.

Sadly this does not build. When you repost I think it would be good
to split this patch into two - one for ethtool -S and one for 
the queue stats via the netdev API.

../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:423:16: warning: declaration of 'struct netdev_queue_stats_rx' will not be visible outside of this function [-Wvisibility]
  423 |                                     struct netdev_queue_stats_rx *stats)
      |                                            ^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:428:7: error: incomplete definition of type 'struct netdev_queue_stats_rx'
  428 |         stats->packets = ring->stats.packets;
      |         ~~~~~^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:423:16: note: forward declaration of 'struct netdev_queue_stats_rx'
  423 |                                     struct netdev_queue_stats_rx *stats)
      |                                            ^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:429:7: error: incomplete definition of type 'struct netdev_queue_stats_rx'
  429 |         stats->bytes = ring->stats.bytes;
      |         ~~~~~^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:423:16: note: forward declaration of 'struct netdev_queue_stats_rx'
  423 |                                     struct netdev_queue_stats_rx *stats)
      |                                            ^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:430:7: error: incomplete definition of type 'struct netdev_queue_stats_rx'
  430 |         stats->alloc_fail = wx->alloc_rx_buff_failed;
      |         ~~~~~^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:423:16: note: forward declaration of 'struct netdev_queue_stats_rx'
  423 |                                     struct netdev_queue_stats_rx *stats)
      |                                            ^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:431:7: error: incomplete definition of type 'struct netdev_queue_stats_rx'
  431 |         stats->csum_complete = wx->hw_csum_rx_good;
      |         ~~~~~^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:423:16: note: forward declaration of 'struct netdev_queue_stats_rx'
  423 |                                     struct netdev_queue_stats_rx *stats)
      |                                            ^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:432:7: error: incomplete definition of type 'struct netdev_queue_stats_rx'
  432 |         stats->csum_bad = wx->hw_csum_rx_error;
      |         ~~~~~^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:423:16: note: forward declaration of 'struct netdev_queue_stats_rx'
  423 |                                     struct netdev_queue_stats_rx *stats)
      |                                            ^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:436:16: warning: declaration of 'struct netdev_queue_stats_tx' will not be visible outside of this function [-Wvisibility]
  436 |                                     struct netdev_queue_stats_tx *stats)
      |                                            ^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:441:7: error: incomplete definition of type 'struct netdev_queue_stats_tx'
  441 |         stats->packets = ring->stats.packets;
      |         ~~~~~^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:436:16: note: forward declaration of 'struct netdev_queue_stats_tx'
  436 |                                     struct netdev_queue_stats_tx *stats)
      |                                            ^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:442:7: error: incomplete definition of type 'struct netdev_queue_stats_tx'
  442 |         stats->bytes = ring->stats.bytes;
      |         ~~~~~^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:436:16: note: forward declaration of 'struct netdev_queue_stats_tx'
  436 |                                     struct netdev_queue_stats_tx *stats)
      |                                            ^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:446:12: warning: declaration of 'struct netdev_queue_stats_rx' will not be visible outside of this function [-Wvisibility]
  446 |                                 struct netdev_queue_stats_rx *rx,
      |                                        ^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:447:12: warning: declaration of 'struct netdev_queue_stats_tx' will not be visible outside of this function [-Wvisibility]
  447 |                                 struct netdev_queue_stats_tx *tx)
      |                                        ^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:449:4: error: incomplete definition of type 'struct netdev_queue_stats_rx'
  449 |         rx->bytes = 0;
      |         ~~^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:446:12: note: forward declaration of 'struct netdev_queue_stats_rx'
  446 |                                 struct netdev_queue_stats_rx *rx,
      |                                        ^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:450:4: error: incomplete definition of type 'struct netdev_queue_stats_rx'
  450 |         rx->packets = 0;
      |         ~~^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:446:12: note: forward declaration of 'struct netdev_queue_stats_rx'
  446 |                                 struct netdev_queue_stats_rx *rx,
      |                                        ^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:451:4: error: incomplete definition of type 'struct netdev_queue_stats_rx'
  451 |         rx->alloc_fail = 0;
      |         ~~^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:446:12: note: forward declaration of 'struct netdev_queue_stats_rx'
  446 |                                 struct netdev_queue_stats_rx *rx,
      |                                        ^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:452:4: error: incomplete definition of type 'struct netdev_queue_stats_rx'
  452 |         rx->csum_complete = 0;
      |         ~~^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:446:12: note: forward declaration of 'struct netdev_queue_stats_rx'
  446 |                                 struct netdev_queue_stats_rx *rx,
      |                                        ^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:453:4: error: incomplete definition of type 'struct netdev_queue_stats_rx'
  453 |         rx->csum_bad = 0;
      |         ~~^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:446:12: note: forward declaration of 'struct netdev_queue_stats_rx'
  446 |                                 struct netdev_queue_stats_rx *rx,
      |                                        ^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:454:4: error: incomplete definition of type 'struct netdev_queue_stats_tx'
  454 |         tx->bytes = 0;
      |         ~~^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:447:12: note: forward declaration of 'struct netdev_queue_stats_tx'
  447 |                                 struct netdev_queue_stats_tx *tx)
      |                                        ^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:455:4: error: incomplete definition of type 'struct netdev_queue_stats_tx'
  455 |         tx->packets = 0;
      |         ~~^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:447:12: note: forward declaration of 'struct netdev_queue_stats_tx'
  447 |                                 struct netdev_queue_stats_tx *tx)
      |                                        ^
../drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:458:37: error: variable has incomplete type 'const struct netdev_stat_ops'
  458 | static const struct netdev_stat_ops wxvf_stat_ops = {
      |                                     ^
../include/linux/netdevice.h:2452:15: note: forward declaration of 'struct netdev_stat_ops'
 2452 |         const struct netdev_stat_ops *stat_ops;
      |                      ^
-- 
pw-bot: cr


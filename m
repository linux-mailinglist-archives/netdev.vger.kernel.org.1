Return-Path: <netdev+bounces-260656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MXgHTkRnmlVTQQAu9opvQ
	(envelope-from <netdev+bounces-260656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 21:59:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCC818C8E3
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 21:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BEB630480F0
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 20:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DE133B96F;
	Tue, 24 Feb 2026 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IxTSgKyJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904D433B960;
	Tue, 24 Feb 2026 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771966750; cv=none; b=s36RUDZCyg/K4F6JShog5eVoTCJD2RS5/i/vk7H46zvv97k3zvIwEHw7Fhs5vsVm7hahOrcKSYLFEt9uZe+zZ3vUEWVsXBkVWA/PAv/plWy6nu3WXwi86hYW1AoBqLAh5TxDdwcsJqX57fHYcnR4PYGKVb4hqdSfXw4fO8YDX0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771966750; c=relaxed/simple;
	bh=nkrvCgJax+Hu9YAH/GgCRO+8YstLU1L1lCG4uaQ3Qb4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rDv7CC6GxGa1brPyUjvgpTI+TCF+2S8AS6d5/Sig8ziZmjpC265G1IZlHP1JloXxRt76Ed3U5iETgI0M/B9VlNdeaqkpMynTadYo3LKOXC+U845B7Ob7FyqXtGkrBFOekKuo6O7uVcFxd+dS1Yi3aOTXbJrpsuxdo3Wfyqr5aps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IxTSgKyJ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771966749; x=1803502749;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=nkrvCgJax+Hu9YAH/GgCRO+8YstLU1L1lCG4uaQ3Qb4=;
  b=IxTSgKyJiI4YqwV4n1X8NkMXd3m7jUV6yJEgoBO2I5UQEPn+EUsRWHgB
   3KAgF72DyEEBnvoaNkMcqLRpRoTgcw1xozmlupQRTlzb4nuR2xiA+Xg/7
   col1gZXrZuz7TJkaUGICWx3eh9s7jIY15lW+X9QF4nBi96CoJaAc6S6xi
   TXKoKXt77XBYnP6AVC3PHHdgzwYUDFy3qnZVTRcqk/2eS0o83aNBt11YW
   BWMYhaib0WwwIAA/yh8wm4aOw79XQ4u+ZTt9QgPFPr/RyRRiB86bs7AEC
   a7i3ucm/7/8ROFAn3msdyANTJbi6DTuUe1GAB+RrqyXHREm9HCmerb2qh
   g==;
X-CSE-ConnectionGUID: CX5zkbYrQmyH65VlzcHS/w==
X-CSE-MsgGUID: e8lLbUleQiiKhg23HUDtwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="95610537"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="95610537"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 12:59:09 -0800
X-CSE-ConnectionGUID: RxA1F9doQDK27BfiySCZiQ==
X-CSE-MsgGUID: UFKoOcZFQv2IrUofsLfFzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="215252303"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.144])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 12:59:09 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Zdenek Bouska <zdenek.bouska@siemens.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Richard Cochran <richardcochran@gmail.com>, Song Yoong
 Siang <yoong.siang.song@intel.com>, Lai Peter Jun Ann
 <jun.ann.lai@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Florian Bezdeka
 <florian.bezdeka@siemens.com>, Zdenek Bouska <zdenek.bouska@siemens.com>
Subject: Re: [PATCH] igc: fix page fault in XDP TX timestamps handling
In-Reply-To: <20260224-igc-fix-xdp-tx-tstamp-pagefault-v1-1-7c729ef61ee5@siemens.com>
References: <20260224-igc-fix-xdp-tx-tstamp-pagefault-v1-1-7c729ef61ee5@siemens.com>
Date: Tue, 24 Feb 2026 12:59:08 -0800
Message-ID: <87342p97tv.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260656-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[siemens.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinicius.gomes@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFCC818C8E3
X-Rspamd-Action: no action

Zdenek Bouska <zdenek.bouska@siemens.com> writes:

> If an XDP application that requested TX timestamping is shutting down
> while the link of the interface in use is still up the following kernel
> splat is reported:
>
> [  883.803618] [   T1554] BUG: unable to handle page fault for address: ffffcfb6200fd008
> ...
> [  883.803650] [   T1554] Call Trace:
> [  883.803652] [   T1554]  <TASK>
> [  883.803654] [   T1554]  igc_ptp_tx_tstamp_event+0xdf/0x160 [igc]
> [  883.803660] [   T1554]  igc_tsync_interrupt+0x2d5/0x300 [igc]
> ...
>
> During shutdown of the TX ring the xsk_meta pointers are left behind, so
> that the IRQ handler is trying to touch them.
>
> This issue is now being fixed by cleaning up the stale xsk meta data on
> TX shutdown. TX timestamps on other queues remain unaffected.
>
> Fixes: 15fd021bc427 ("igc: Add Tx hardware timestamp request for AF_XDP zero-copy packet")
> Signed-off-by: Zdenek Bouska <zdenek.bouska@siemens.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h      |  2 ++
>  drivers/net/ethernet/intel/igc/igc_main.c |  7 +++++++
>  drivers/net/ethernet/intel/igc/igc_ptp.c  | 33 +++++++++++++++++++++++++++++++
>  3 files changed, 42 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index a427f05814c1ae7330c6f7034cd0f2b40b74dab6..17236813965d334f14eba928affbd4f91b96ecd4 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -781,6 +781,8 @@ int igc_ptp_hwtstamp_set(struct net_device *netdev,
>  			 struct kernel_hwtstamp_config *config,
>  			 struct netlink_ext_ack *extack);
>  void igc_ptp_tx_hang(struct igc_adapter *adapter);
> +void igc_ptp_clear_xsk_tx_tstamp_queue(struct igc_adapter *adapter,
> +				       u16 queue_id);
>  void igc_ptp_read(struct igc_adapter *adapter, struct timespec64 *ts);
>  void igc_ptp_tx_tstamp_event(struct igc_adapter *adapter);
>  
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 89a321a344d263ace5c66f7ade782b40cc482566..570e90fab67d653bbbb242d242d0b64a49fba602 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -193,6 +193,7 @@ static void igc_unmap_tx_buffer(struct device *dev, struct igc_tx_buffer *buf)
>   */
>  static void igc_clean_tx_ring(struct igc_ring *tx_ring)
>  {
> +	struct igc_adapter *adapter;
>  	u16 i = tx_ring->next_to_clean;
>  	struct igc_tx_buffer *tx_buffer = &tx_ring->tx_buffer_info[i];
>  	u32 xsk_frames = 0;
> @@ -264,6 +265,12 @@ static void igc_clean_tx_ring(struct igc_ring *tx_ring)
>  	/* reset next_to_use and next_to_clean */
>  	tx_ring->next_to_use = 0;
>  	tx_ring->next_to_clean = 0;
> +
> +	/* Clear any lingering XSK TX timestamp requests */
> +	if (test_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags)) {

minor: move the 'adapter' declaration here.

But I will leave that to up to you,

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius


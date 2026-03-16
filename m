Return-Path: <netdev+bounces-268145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LtkBqXzt2mfXQEAu9opvQ
	(envelope-from <netdev+bounces-268145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 13:12:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD482993F4
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 13:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09435300B59C
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 12:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00467392806;
	Mon, 16 Mar 2026 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="FIF7eU2f"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5879229ACFC
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773663138; cv=none; b=OkocIR3G/2f/IfgLcQu2dFC3mEohL4aCqVBS9MibRY7TBj5PrIRH7ELYHkMMcvclbswPv+t8/tGimpDU952KyQr34HoDKz889D4cPDFB2HgRj1j6ad40QemY/aF7WE6wreUo7yhsAZUjTsF9+OX2F/Z3De2OqH1ebNB3Zlvj4zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773663138; c=relaxed/simple;
	bh=yQSYIu4+Eju4v7nQSi+vBDsQglf0NJaCbFR7Kn/xbEE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kgGEqt8xVRwRbCxXsXU062TLR8Crv3V47+5KAoNtDpsrOyO8PbF6rLLvg6/3nyBNS5bKWIdAQUZiNuzLjQeypnprQz3crGGC6zBooenQddMUrOpeI6Pl6Tvk2JUjFwf5n5JeMng9+ZKKn+o6xhw8R/EaOF98ArF4uiVAqc+kqfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=FIF7eU2f; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5A72BA0304;
	Mon, 16 Mar 2026 13:12:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773663132; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1YHrrC9MVomwk7oMjmbXrKxO0G/TtXm+IvFQ88TkZwU=;
	b=FIF7eU2f4WsZhXeDX5DGQX/3OhxcnaV0OpfgKD0hOvm/Rw+x2guB0Xf/3XwCNQ6uRBRK0s
	nWJX7AOjrAxeCWo7wdoNj0CuwsxCIpEB9oTE+/+Zc7YMz1xg5b6+Jyea5IKjxl6h2vqE1y
	C9yjDlmfZmZLIy4UDM1xL+8EWQ4W/nwOVQBglZtGbkFYSOkiBYHfrqPSLzEgi13fQm3MeO
	0U8446dQTysYuqdVvjTmWm0tqpk7wW6wJD1PpJuNYwSn3xS0OwuMSfbQdhGFFf9+O1uZ3w
	Eoh5BlEcvXbmVQStAZRusf7jyfrExgIb3iGT+pBe+W+wmHjIlEOdfbE6iVDdyQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Mar 2026 13:12:09 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Paolo Valerio <pvalerio@redhat.com>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v5 0/8] net: macb: Add XDP support and page pool
 integration
In-Reply-To: <20260313201433.2346119-1-pvalerio@redhat.com>
References: <20260313201433.2346119-1-pvalerio@redhat.com>
Message-ID: <56a9d6993d17fc8b79bd13189af6477e@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268145-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ADD482993F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 13.3.2026 21:14, Paolo Valerio wrote:
> Tested on Raspberry Pi 5.
> With rpi5 is not possible to test the !RSC case. It would be nice
> to test it, as it potentially changes the offset of the first frame
> (hw shifts of NET_IP_ALIGN bytes on rx).
> 
> All the changes are intended for gem only.
> 
> The series consists of two main changes:
> 
> - Migration from netdev_alloc_skb() to page pool allocation model,
>   enabling skb recycling.
>   This also adds support for multi-descriptor frame reception,
>   removing the previous single-descriptor approach and avoiding
>   potentially large contiguous allocations for e.g. jumbo frames
>   with CONFIG_PAGE_SIZE_4KB.
> 
> - XDP support: Initial XDP implementation supporting major
>   verdicts (XDP_PASS, XDP_DROP, XDP_REDIRECT, XDP_TX) along with
>   the ndo_xdp_xmit function for packet redirection.
> 
> The driver now advertises NETDEV_XDP_ACT_BASIC, 
> NETDEV_XDP_ACT_REDIRECT,
> NETDEV_XDP_ACT_NDO_XMIT capabilities.
> 
> Some numbers (Andrew)
> =====================
> 
>   Initially reported numbers (Mbps, w/ drops on the rx side):
> 
>   
> https://lore.kernel.org/netdev/b0bff7a8-a004-4eb7-bf1d-2137182e59f9@lunn.ch/
> 
>   The numbers are essentially always the same with these two packet 
> sizes.
>   cpu0 doesn't appear overloaded. Not sure if there's a bottlneck at 
> the
>   interface level on my hw, but it seems cpu can handle more.
> 
>   Second test run (with no drops on the rx side):
> 
>   tx side: iperf3 sending UDP (256B) packets roughly at line rate (no 
> drops
>   on the receiving side).
> 
>   rx side:
>   - fixed cpu frequency
>   - single rxq on cpu 0
>   - iperf3 server on cpu 1-3
>   - average w/ mpstat 20s interval 20s count
> 
>   Baseline:
> 
>   Average:     CPU    %usr    %sys    %soft  %idle
>   Average:     all    3.64   15.05     0.87  80.42
>   Average:       0    0.05    0.15    10.23  89.56
>   Average:       1    4.20   16.98     0.00  78.81
>   Average:       2    3.67   15.53     0.00  80.79
>   Average:       3    4.07   16.83     0.00  79.09
> 
>   Page pool:
> 
>   Average:     CPU    %usr    %sys    %soft  %idle
>   Average:     all    3.76   14.91     0.74  80.57
>   Average:       0    0.05    0.12     7.81  91.98
>   Average:       1    3.88   15.53     0.00  80.58
>   Average:       2    4.35   17.23     0.00  78.42
>   Average:       3    4.22   16.63     0.00  79.11
> 
> 
> Previous versions
> =================
>   - v4: 
> https://lore.kernel.org/all/20260309144353.1213770-1-pvalerio@redhat.com/
>   - v3: 
> https://lore.kernel.org/netdev/20260302115232.1430640-1-pvalerio@redhat.com/
>   - v2: 
> https://lore.kernel.org/netdev/20260223182632.1681809-1-pvalerio@redhat.com/
>   - v1: 
> https://lore.kernel.org/netdev/20260115222531.313002-1-pvalerio@redhat.com/
>   - RFC v2: 
> https://lore.kernel.org/netdev/20251220235135.1078587-1-pvalerio@redhat.com/
>   - RFC v1: 
> https://lore.kernel.org/netdev/20251119135330.551835-1-pvalerio@redhat.com/
> 
> v4 -> v5
> ========
>   - Call missing macb_tx_lpi_wake() in macb_xdp_submit_frame() (Nicolai 
> Buchwitz)
>   - Restore old_prog (instead of NULL) in gem_xdp_setup() on 
> macb_open() failure
> 
> v3 -> v4
> ========
>   - Remove inline from gem_rx_data_len() (Paolo Abeni)
>   - Rate limit the netdev_{err,warn} in gem_rx() and gem_rx_refill() 
> with to avoid log
>     flooding under error conditions (Paolo Abeni)
>   - Fix missing newline in netdev_err() for MTU validation in 
> ndo_change_mtu (Paolo Abeni)
> 
> v2 -> v3
> ========
>   - Drop mog_init_rings() call in macb_open() reintroduced by mistake 
> while
>     rebasing (Jakub Kicinski)
>   - Move [5/8] down in the series (was [6/8])
>   - s/void/sk_buff for the skb parameter instead of updating the 
> documentation
>     because of its void type as this seems to better fit the scope of 
> the
>     patch (Jakub Kicinski)
>   - Move [6/8] down in the series (was [7/8])
>   - Remove misleading check on tx buff type (MACB_TYPE_SKB) to improve
>     clarity as all buffers are MACB_TYPE_SKB (Jakub Kicinski)
>   - Update commit message to better fit with the patch content
>   - Move [7/8] up in the series (was [5/8]) as XDP_TX has now been 
> folded in
>     this patch honoring the advertised features (Jakub Kicinski)
>   - explicitly return 0 in gem_create_page_pool() instead of err (Jakub 
> Kicinski)
>   - Revisit gem_xdp_valid_mtu() and related helpers lifting the 
> dependency with
>     bp->rx_headroom. It now always uses XDP_PACKET_HEADROOM (Jakub 
> Kicinski)
>   - Use xdp_return_frame() in workqueue context (Jakub Kicinski)
>   - macb_tx_error_task() now locks tx_ptr_lock (Jakub Kicinski)
>   - Remove redundant check for clarity (Jakub Kicinski)
>   - Take into account head adjustment in macb_xdp_submit_frame() while 
> syncing
>     in the XDP_TX path and for the XDP_PASS codepath.
>   - Some helpers renaming for clarity
>   - Do not to leave bp->prog pointer in gem_setup_xdp dangling on 
> failure
>   - Revisit rx_buffer_size to better handle the RSC/non-RSC case
>   - Return error in ndo_xdp_xmit if the interface is not operating
>   - Handle packets count in macb_tx_complete() for the xdp case
> 
> v1 -> v2
> ========
>   - Fix potential NULL pointer dereference in gem_rx() when receiving 
> an
>     unexpected non-starting frame without an active skb (Jakub 
> Kicinski).
>   - Make sure to release both the pending skb and the current buff in 
> fragment
>     overflow error path (Jakub Kicinski).
>   - Reuse the existing page pool instead of creating a new one in HRESP 
> error
>     recovery (Jakub Kicinski).
>   - s/page/buffer/ in netdev_err() print out (Théo Lebrun)
>   - Ensure pending queue->skb is released in gem_free_rx_buffers() 
> (Théo Lebrun).
>   - Use NET_SKB_PAD for the headroom when no xdp program is attached
>   - Add netdev to pp_params (for pp stats)
>   - Move ip_summed handling when RX_EOF is set as RX_SUM may not be 
> reliable when
>     RX_EOF is not set.
>   - Sync for device no longer relies on PP_FLAG_DMA_SYNC_DEV reducing 
> the
>     sync size.
>   - Introduce rx_ip_align field in struct macb
>   - Fix incorrect DMA direction for page pool when attaching XDP 
> program by
>     restoring close/open sequence as in a previous version (Jakub 
> Kicinski).
>   - Rename release_buff() to macb_tx_release_buff() for clarity (Théo 
> Lebrun).
>   - Do not unmap dma for XDP_TX buffers by ensuring tx_buff->mapping is 
> zero for
>     MACB_TYPE_XDP_TX buff_type (Jakub Kicinski).
>   - Always return memory to pool on xdp_convert_buff_to_frame()
>     failure (Jakub Kicinski).
>   - Remove skip_xdp label (Théo, this is a bit different from your 
> suggestion,
>     let me know if you have a strong preference here)
> 
> RFC v2 -> v1
> ============
>   - Removed bp->macbgem_ops.mog_init_rings(bp) call from macb_open()
>   - Fixed includes (remove unneeded, moved one from header to 
> macb_main.c)
>   - Reverse xmas tree ordering (gem_rx, gem_rx_refill)
>   - print_hex_dump_debug() instead of print_hex_dump()
>   - Replaced rx frame length check with MACB_BIT(RX_EOF) for data_len
>     calculation
>   - Removed NET_IP_ALIGN handling in rx buffer size calculation
>   - Updated debug format string to include rx_headroom and total size
>   - Changed types to unsigned int in helper functions and variable
>   - Removed unneeded line break
> 
> RFC v1 -> RFC v2
> ================
>   - Squashed 1/6 and 2/6
>   - Reworked rx_buffer_size computation. It no longer takes into
>     accounts extra room.
>   - A bunch of renaming (rx_offset => rx_headroom, removed 
> MACB_MAX_PAD,
>     MACB_PP_HEADROOM => XDP_PACKET_HEADROOM, data => ptr, xdp_q => 
> xdp_rxq,
>     macb_xdp() => gem_xdp(), macb_xdp_xmit() => gem_xdp_xmit())
>   - Deduplicated buffer size computation in gem_xdp_valid_mtu()
>     and gem_xdp_setup()
>   - gem_xdp_setup() no longer close()/open()
>   - Renaming from rx_skbuff to rx_buff is now got split in a separate 
> commit
>   - Open-coded gem_page_pool_get_buff()
>   - Added missing rx_buff re-initialization in the error path during rx
>   - Page pool creation failure now fails the device open
>   - Moved xdp buff preparation inside gem_xdp_run()
>   - Added missing rcu_access_pointer()
>   - Turned return value in -EOPNOTSUPP for macb_xdp() on failure
>   - moved tx_skb to tx_buff renaming to a separate commit
>   - Removed some unneeded code and set MACB_TYPE_SKB for 
> lp->rm9200_txq[desc].type as well
>   - Replaced !!addr with a dedicated bool in macb_xdp_submit_frame()
> 
> Paolo Valerio (7):
>   net: macb: rename rx_skbuff into rx_buff
>   net: macb: Add page pool support handle multi-descriptor frame rx
>   net: macb: use the current queue number for stats
>   net: macb: make macb_tx_skb generic
>   net: macb: generalize tx buffer handling
>   net: macb: add XDP support for gem
>   net: macb: introduce ndo_xdp_xmit support
> 
> Théo Lebrun (1):
>   net: macb: move Rx buffers alloc from link up to open
> 
>  drivers/net/ethernet/cadence/Kconfig     |   1 +
>  drivers/net/ethernet/cadence/macb.h      |  43 +-
>  drivers/net/ethernet/cadence/macb_main.c | 951 ++++++++++++++++++-----
>  3 files changed, 770 insertions(+), 225 deletions(-)

Tested on Raspberry Pi 5:
- XDP attach/detach
- XDP_PASS (no throughput regression at 938 Mbit/s)
- XDP_DROP
- XDP_TX

The driver survives link flaps and rapid program swaps under iperf3 load 
without errors.
MTU validation correctly rejects XDP when frames would span multiple 
pages.

Tested-by: Nicolai Buchwitz <nb@tipi-net.de>


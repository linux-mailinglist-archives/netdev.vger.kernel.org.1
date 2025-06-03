Return-Path: <netdev+bounces-194709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17562ACC064
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 08:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77013A2F31
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 06:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64662116FE;
	Tue,  3 Jun 2025 06:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QkmexwLb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C347B1F5434
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 06:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748933015; cv=none; b=sxUvrbpklZWMTecMbHpFzNqD08JXRBPF45tjaBApkMWmY3VXiKkkKLqLQcvGubZ7iVLJNGgCvDIy3nqjMC3GxQs2QlWdHkxlvBhrxPp9RDdu4LhY+Q4UKrRu80j6qOeg03baPJxaojgPUMXioOyrLu/MJb2E+4C+7v18JicL1LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748933015; c=relaxed/simple;
	bh=Bq9K0Z3n45x5pQdXF/H6MQFS1CI4urhFkW/yM3pazQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQVsyJ86yEHB0EJARs0DJBzofv8yGHdZUMRQIzm+wXmlOcYwTBkk5BehyDwOEjWzLhAi8g/XrhUeYzVZLQ6XNSb0q9lH3Ena7zCR5zi660/dHIpkzcyog4wa66EHJFQB2k5laKr/Mqw3DX9Odm39VONTD2mcPvUR7tKyDVkr1Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QkmexwLb; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748933014; x=1780469014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bq9K0Z3n45x5pQdXF/H6MQFS1CI4urhFkW/yM3pazQc=;
  b=QkmexwLbWTgC3pHCjiZX1CChBx8Tbwim86MkJcMt8oLhT5aAgtJsI+/Y
   KjN7BOuG31xVBfTLpb+wRE0cYrc1Mp8wpi8IgGte6dVlrNY/hKSGcVeLq
   FnvFZCYNMql5vaHATnun333JRJ+en53UGZfORL2WQ7vZVscVbFCwPasnm
   +oyEPCYbLvdiDtxl7MnYoqv0kADywJG6PMOq5+kEENmPFl3MkQGoq6eoy
   mU9n1xp/GZ1Htb1QIdVovrXASPWf57fv+QIroTraCfbdpwKyDTIUzJVxa
   PmySt2yPRVUVYjjF07raLoIbg0w0y/dup0KAna22H5eUFMft6kzk9A7VN
   A==;
X-CSE-ConnectionGUID: kx9nMIrpS0iqLwQ2fbDxcQ==
X-CSE-MsgGUID: bUJTDNZTTOCLWceAF7dKCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="50875160"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="50875160"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 23:43:33 -0700
X-CSE-ConnectionGUID: 6zJveQaCSeS9GV0o8UjDeg==
X-CSE-MsgGUID: tOPN78CDQZKziKgrra9CuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="145254834"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 23:43:31 -0700
Date: Tue, 3 Jun 2025 08:42:50 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <dqfext@gmail.com>
Subject: Re: [PATCH net 3/5] ovpn: avoid sleep in atomic context in TCP RX
 error path
Message-ID: <aD6ZamCA8eOpMMSu@mev-dev.igk.intel.com>
References: <20250530101254.24044-1-antonio@openvpn.net>
 <20250530101254.24044-4-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530101254.24044-4-antonio@openvpn.net>

On Fri, May 30, 2025 at 12:12:52PM +0200, Antonio Quartulli wrote:
> Upon error along the TCP data_ready event path, we have
> the following chain of calls:
> 
> strp_data_ready()
>   ovpn_tcp_rcv()
>     ovpn_peer_del()
>       ovpn_socket_release()
> 
> Since strp_data_ready() may be invoked from softirq context, and
> ovpn_socket_release() may sleep, the above sequence may cause a
> sleep in atomic context like the following:
> 
>     BUG: sleeping function called from invalid context at ./ovpn-backports-ovpn-net-next-main-6.15.0-rc5-20250522/drivers/net/ovpn/socket.c:71
>     in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 25, name: ksoftirqd/3
>     5 locks held by ksoftirqd/3/25:
>      #0: ffffffe000cd0580 (rcu_read_lock){....}-{1:2}, at: netif_receive_skb+0xb8/0x5b0
>      OpenVPN/ovpn-backports#1: ffffffe000cd0580 (rcu_read_lock){....}-{1:2}, at: netif_receive_skb+0xb8/0x5b0
>      OpenVPN/ovpn-backports#2: ffffffe000cd0580 (rcu_read_lock){....}-{1:2}, at: ip_local_deliver_finish+0x66/0x1e0
>      OpenVPN/ovpn-backports#3: ffffffe003ce9818 (slock-AF_INET/1){+.-.}-{2:2}, at: tcp_v4_rcv+0x156e/0x17a0
>      OpenVPN/ovpn-backports#4: ffffffe000cd0580 (rcu_read_lock){....}-{1:2}, at: ovpn_tcp_data_ready+0x0/0x1b0 [ovpn]
>     CPU: 3 PID: 25 Comm: ksoftirqd/3 Not tainted 5.10.104+ #0
>     Call Trace:
>     walk_stackframe+0x0/0x1d0
>     show_stack+0x2e/0x44
>     dump_stack+0xc2/0x102
>     ___might_sleep+0x29c/0x2b0
>     __might_sleep+0x62/0xa0
>     ovpn_socket_release+0x24/0x2d0 [ovpn]
>     unlock_ovpn+0x6e/0x190 [ovpn]
>     ovpn_peer_del+0x13c/0x390 [ovpn]
>     ovpn_tcp_rcv+0x280/0x560 [ovpn]
>     __strp_recv+0x262/0x940
>     strp_recv+0x66/0x80
>     tcp_read_sock+0x122/0x410
>     strp_data_ready+0x156/0x1f0
>     ovpn_tcp_data_ready+0x92/0x1b0 [ovpn]
>     tcp_data_ready+0x6c/0x150
>     tcp_rcv_established+0xb36/0xc50
>     tcp_v4_do_rcv+0x25e/0x380
>     tcp_v4_rcv+0x166a/0x17a0
>     ip_protocol_deliver_rcu+0x8c/0x250
>     ip_local_deliver_finish+0xf8/0x1e0
>     ip_local_deliver+0xc2/0x2d0
>     ip_rcv+0x1f2/0x330
>     __netif_receive_skb+0xfc/0x290
>     netif_receive_skb+0x104/0x5b0
>     br_pass_frame_up+0x190/0x3f0
>     br_handle_frame_finish+0x3e2/0x7a0
>     br_handle_frame+0x750/0xab0
>     __netif_receive_skb_core.constprop.0+0x4c0/0x17f0
>     __netif_receive_skb+0xc6/0x290
>     netif_receive_skb+0x104/0x5b0
>     xgmac_dma_rx+0x962/0xb40
>     __napi_poll.constprop.0+0x5a/0x350
>     net_rx_action+0x1fe/0x4b0
>     __do_softirq+0x1f8/0x85c
>     run_ksoftirqd+0x80/0xd0
>     smpboot_thread_fn+0x1f0/0x3e0
>     kthread+0x1e6/0x210
>     ret_from_kernel_thread+0x8/0xc
> 
> Fix this issue by postponing the ovpn_peer_del() call to
> a scheduled worker, as we already do in ovpn_tcp_send_sock()
> for the very same reason.
> 
> Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
> Reported-by: Qingfang Deng <dqfext@gmail.com>
> Closes: https://github.com/OpenVPN/ovpn-net-next/issues/13
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>  drivers/net/ovpn/tcp.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
> index 7e79aad0b043..289f62c5d2c7 100644
> --- a/drivers/net/ovpn/tcp.c
> +++ b/drivers/net/ovpn/tcp.c
> @@ -124,14 +124,18 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
>  	 * this peer, therefore ovpn_peer_hold() is not expected to fail
>  	 */
>  	if (WARN_ON(!ovpn_peer_hold(peer)))
> -		goto err;
> +		goto err_nopeer;
>  
>  	ovpn_recv(peer, skb);
>  	return;
>  err:
> +	/* take reference for deferred peer deletion. should never fail */
> +	if (WARN_ON(!ovpn_peer_hold(peer)))
> +		goto err_nopeer;
> +	schedule_work(&peer->tcp.defer_del_work);
>  	dev_dstats_rx_dropped(peer->ovpn->dev);
> +err_nopeer:
>  	kfree_skb(skb);
> -	ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  }
>  
>  static int ovpn_tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> -- 
> 2.49.0


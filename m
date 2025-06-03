Return-Path: <netdev+bounces-194707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB465ACC038
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 08:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826963A4FED
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 06:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0D6267B89;
	Tue,  3 Jun 2025 06:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+ZdawSf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F594267AFC
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748932271; cv=none; b=pmj5z7z3uY0/uaDydDrO1F9/buXAckIsObM43WE8LS0oVjj/hxiga95aZSovq9EizlQx64O686/CuOzsiX7GkCCucTO2PXfhafCmRSIr139s2U/rWZezoa5PSQXul30rlYtB1ShB59dXK2CSesCrU0xIXrIcXN3IRpIZiU0BGUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748932271; c=relaxed/simple;
	bh=0V+XiGibVtBxthWGz0QKy0lpkFkufnlIgYI5Z12qcD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYjUxbElr64itKEG+zFlBwWfUjYm9suDB90YqLszsB/Fl15uTkv4BqYOrZDYvdYHIoGjcvSFT+JB33zexZiNV4+JQKF8S/G0rX+hHyrV6XZTUbraQQSnV3NqUJ6FdXqJdVHh04kiFulYZu524j2JOnKiw6Xb/t8lRQp1qqbn+Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+ZdawSf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748932269; x=1780468269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0V+XiGibVtBxthWGz0QKy0lpkFkufnlIgYI5Z12qcD0=;
  b=a+ZdawSf4miOehj3RF9gxY1kh1o/rxFG8ogJU/PjfXfUNIpBvGBCIHTw
   p5P8yHPIRWSSyRXo4a4vI7WPC/DPYZGU+wC7ub4OCAKSANrf2degwnFxB
   qg3M6ZnFWVj++nVmYVmWqx3AQ3rVJuLhsPr1gmNvUIf6ukm7SZVLhjoGM
   wv07+v51RnHJdA/eEfhuU/Onu57k3yoa03bDb7zLg4Qt/pss06j94k7a9
   XIcL1qkWi+tq/QhPIH3tNqagpUclGpvTUZgN4FeeF3eWw7vTyyyOzqLeZ
   Oqf6eLQ/mwtyJTWXDRmHSRjAfaV6vW1s4s/o84sojqG3JGaXGDBo/Lryl
   Q==;
X-CSE-ConnectionGUID: APm9Lp5pSsaW6p8PQMjhDA==
X-CSE-MsgGUID: ek2kmfQTQOOP9lG35IbxJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="68511443"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="68511443"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 23:31:09 -0700
X-CSE-ConnectionGUID: MQgp7UU9RCS9+BiuUIpMcQ==
X-CSE-MsgGUID: AeIj0zxHRwu+y5ep4GTzsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="145092593"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 23:31:06 -0700
Date: Tue, 3 Jun 2025 08:30:25 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH net 1/5] ovpn: properly deconfigure UDP-tunnel
Message-ID: <aD6WgTvaCU3w8zRr@mev-dev.igk.intel.com>
References: <20250530101254.24044-1-antonio@openvpn.net>
 <20250530101254.24044-2-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530101254.24044-2-antonio@openvpn.net>

On Fri, May 30, 2025 at 12:12:50PM +0200, Antonio Quartulli wrote:
> When deconfiguring a UDP-tunnel from a socket, we cannot
> call setup_udp_tunnel_sock() with an empty config, because
> this helper is expected to be invoked only during setup.
> 
> Get rid of the call to setup_udp_tunnel_sock() and just
> revert what it did during socket initialization..
> 
> Note that the global udp_encap_needed_key and the GRO state
> are left untouched: udp_destroy_socket() will eventually
> take care of them.
> 
> Cc: Sabrina Dubroca <sd@queasysnail.net>
> Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
> Fixes: ab66abbc769b ("ovpn: implement basic RX path (UDP)")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Closes: https://lore.kernel.org/netdev/1a47ce02-fd42-4761-8697-f3f315011cc6@redhat.com
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>  drivers/net/ovpn/udp.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
> index aef8c0406ec9..89bb50f94ddb 100644
> --- a/drivers/net/ovpn/udp.c
> +++ b/drivers/net/ovpn/udp.c
> @@ -442,8 +442,16 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
>   */
>  void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
>  {
> -	struct udp_tunnel_sock_cfg cfg = { };
> +	struct sock *sk = ovpn_sock->sock->sk;
>  
> -	setup_udp_tunnel_sock(sock_net(ovpn_sock->sock->sk), ovpn_sock->sock,
> -			      &cfg);
> +	/* Re-enable multicast loopback */
> +	inet_set_bit(MC_LOOP, sk);
> +	/* Disable CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE conversion */
> +	inet_dec_convert_csum(sk);
> +
> +	udp_sk(sk)->encap_type = 0;
> +	udp_sk(sk)->encap_rcv = NULL;
> +	udp_sk(sk)->encap_destroy = NULL;
> +
> +	rcu_assign_sk_user_data(sk, NULL);
>  }
> -- 
> 2.49.0

LGTM, thanks
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>


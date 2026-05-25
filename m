Return-Path: <netdev+bounces-291366-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECjeFplwFGrNNQcAu9opvQ
	(envelope-from <netdev+bounces-291366-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 17:54:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5995CC8D3
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 17:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B70053007940
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 15:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8963F167C;
	Mon, 25 May 2026 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNH/IEaU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE481344044;
	Mon, 25 May 2026 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779724439; cv=none; b=mnDz5g0JAVOWiPgJfTXNTw9z7Ll7KUG0pjLnbSHV4ze6aWLmoUobav3eH6ip/EZQ4XpRKqPQkxNYnK8WlDGQNhUMQ2zofMT7SGMMegvoXvmPPk6eSsmAplUvIk3WW3/y1o88CEe7E3YTpJZZ+6JX9EhHDS6L0u6T+boodjd0De8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779724439; c=relaxed/simple;
	bh=R8x7b0BoRJsqro+Q0iqx6vIxq/tPQzutQL+LB7c14dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nlyFZsdPMnWr2MTWhBWezUAVNCUlwI7TZUggEyEYAx507pWsg55JnwMnwFU7+NByXPWoGfRXrB68hCbapRBQ+wjmyy9XUhOEfnEhdySUj7EweL/rsHP3hF4kcYO5ED5ScFVmMh+mWATrxwPd6jR+mCIb9rACr+5t3IGmQgE3Esk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNH/IEaU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322A91F000E9;
	Mon, 25 May 2026 15:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779724437;
	bh=kGB2IjjY/lLYpORY+kbNYtc6z1sLvuONsL5JAewsROc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MNH/IEaUoTwzJLyjyJS6GH/nLlkQY24j4gMimV1HNsLY2dwuydam1qB1FbdL9y0G+
	 JoJFJpj4PuOUeO4he8vm9Qmqy59RNEHOJKehflS22810zQIg8ddAtl0D8AlRElmxna
	 h69pacODwcncQlpgmeINbqHEn47kWubbvFlyNscmx/vnnySMMOZ38P+ixkbVD5fx8X
	 QeXMayBIA73BMwarR8wJmdyMdGgmEYP1q3bvhP1UkuIYlWHpMY1bow3CCpvj28SaMX
	 sMatPs5dNRS5qOVsAUGjNlbB0yiccdOU7ItN4RxEqi7G2zuY8e3dEmpNI+iVhWTMgY
	 2lIXmHByHOFUQ==
Date: Mon, 25 May 2026 08:53:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ixgbe: implement get_queue_stats_rx
Message-ID: <20260525085356.5c336491@kernel.org>
In-Reply-To: <20260523144022.36484-1-kshitiz.bartariya@zohomail.in>
References: <20260523144022.36484-1-kshitiz.bartariya@zohomail.in>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291366-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BE5995CC8D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 23 May 2026 20:10:16 +0530 Kshitiz Bartariya wrote:
> The following counters are filled:
> 
>  - alloc_fail: sum of alloc_rx_page_failed and alloc_rx_buff_failed
> 
>  - csum_bad: maps directly to csum_err, which is incremented for both
>    IP header and L4 checksum errors in ixgbe_rx_checksum().
> 
>  - hw_gro_packets and hw_gro_wire_packets: filled only when RSC
>    is enabled on the ring

ixgbe does not advertise hw_gro in netdev features,
how can it report related stats..

> Signed-off-by: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 2646ee6f295f..f40309f6c72b 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -9740,6 +9740,34 @@ static void ixgbe_get_stats64(struct net_device *netdev,
>  	stats->rx_missed_errors	= netdev->stats.rx_missed_errors;
>  }
>  
> +static void ixgbe_get_queue_stats_rx(struct net_device *dev, int idx,
> +				     struct netdev_queue_stats_rx *stats)
> +{
> +	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
> +	struct ixgbe_ring *ring;
> +
> +	if (idx >= adapter->num_rx_queues)
> +		return;
> +
> +	ring = adapter->rx_ring[idx];
> +	if (!ring)
> +		return;

Are these checks really necessary? core already checks against
real_num_rx_queues


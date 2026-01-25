Return-Path: <netdev+bounces-253173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEQxLwYXdml1LgEAu9opvQ
	(envelope-from <netdev+bounces-253173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 14:13:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C408097D
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 14:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13AA83002B7C
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 13:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44062517AC;
	Sun, 25 Jan 2026 13:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="uB8lTu7o"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA77672631
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769346818; cv=none; b=BDg/gbam1dhUfg5tlzgMb8SUHYmiVpaotaT/PY4c90DhtklSwpLEzXEdWNtbWDuo5K+s1Pnp6a+lzEAqehvh4lHQm0uyCKXhHWUmXd4MomiYZcbdpIw0kWyFFaUOE8b4KfcZjuY/axgM6C0ng7hrE4wUlmX2dn0bJFKt4XPHr6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769346818; c=relaxed/simple;
	bh=XjLkVbT3y5QTJl5oD/LP2VjXmxLt6IhVtOpk0x4yZMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVjza5LBcR9F1g0wcp6CbkfbgbDN26QVVdLBFMV3GeorD56VIgQULrT7/KcPSHms136CA00zaRqjQQ9uhXESWJh98PbpqorgVjJHuoamhD+tpIdimraV5MUd/Lx23gDc/ggLhwV2Hw/+4cCljuoJJ4zNYZyRSLJW4qTqK90UngY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=uB8lTu7o; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (188.53.30.125.dy.iij4u.or.jp [125.30.53.188])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60PDDRms093033
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 25 Jan 2026 22:13:28 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=lTKJGbCrPaEbSFAuvPIh6CkaeFRE7NCkoh+SsrCk7jc=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1769346809; v=1;
        b=uB8lTu7ocXcmDtNk/A60xi+YGO/4iaX865u5/sa2MRHW8FHIYlmuDPxli9aaYiNj
         noFuNXbU2hhqfdGIlieuANVIltFmI4TAi7C/Xr5380DJbnzp+qkwHwMJ0UpUcsfN
         xLZG+CQnc+QR+HyDEgaJrs1RGaUncr5cwVzmCxOv0m959J/Kqqp0B0C8t+5NuodI
         ecHtHrD8gacWbNZx+O0my8pi2NagMPYyk0zxiBqo8Xj0AsCacx5gaHJlY4DDtXKm
         MvbtQPNy1wC1OekSZJaB+oiJQPIe6TFnU4J9o7QrPMzZq2uqblwgal/pFskEls9J
         FjKnAp5FPUjnnBnHsMtdHw==
From: Kohei Enju <kohei@enjuk.jp>
To: takkozu@amazon.com
Cc: aleksandr.loktionov@intel.com, andrew+netdev@lunn.ch,
        anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
        enjuk@amazon.com, intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, piotr.kwapulinski@intel.com,
        pmenzel@molgen.mpg.de, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH iwl-next v4 3/3] igb: allow configuring RSS key via ethtool set_rxfh
Date: Sun, 25 Jan 2026 13:12:37 +0000
Message-ID: <20260125131327.4469-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120093441.70075-8-takkozu@amazon.com>
References: <20260120093441.70075-8-takkozu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-253173-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15C408097D
X-Rspamd-Action: no action

On Tue, 20 Jan 2026 18:34:40 +0900, Takashi Kozu wrote:

> Change igc_set_rxfh() to accept and save a userspace-provided
> RSS key. When a key is provided, store it in the adapter and write the
> E1000 registers accordingly.
> 
> This can be tested using `ethtool -X <dev> hkey <key>`.
> 
> Signed-off-by: Takashi Kozu <takkozu@amazon.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h         |  1 +
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 49 +++++++++++---------
>  drivers/net/ethernet/intel/igb/igb_main.c    |  3 +-
>  3 files changed, 30 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index 8c9b02058cec..2509ec30acf3 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -657,6 +657,7 @@ struct igb_adapter {
>  	u32 rss_indir_tbl_init;
>  	u8 rss_indir_tbl[IGB_RETA_SIZE];
>  	u8 rss_key[IGB_RSS_KEY_SIZE];
> +	bool has_user_rss_key;

Hi Kozu-san.

While preparing for testing, I noticed that now 'has_user_rss_key' is
not necessary.

Since netdev_rss_key_fill() is called in igb_sw_init() and igb_sw_init()
is called only once for the adapter's lifetime, adapter->rss_key
wouldn't be changed except for user-intended change.

I'd drop that flag and related code (see below)

>  
>  	unsigned long link_check_timeout;
>  	int copper_tries;
> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> index b387121f0ea7..1db9c2447c91 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> @@ -3357,35 +3357,40 @@ static int igb_set_rxfh(struct net_device *netdev,
>  	u32 num_queues;
>  
>  	/* We do not allow change in unsupported parameters */
> -	if (rxfh->key ||
> -	    (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
> -	     rxfh->hfunc != ETH_RSS_HASH_TOP))
> +	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
> +	    rxfh->hfunc != ETH_RSS_HASH_TOP)
>  		return -EOPNOTSUPP;
> -	if (!rxfh->indir)
> -		return 0;
>  
> -	num_queues = adapter->rss_queues;
> +	if (rxfh->indir) {
> +		num_queues = adapter->rss_queues;
>  
> -	switch (hw->mac.type) {
> -	case e1000_82576:
> -		/* 82576 supports 2 RSS queues for SR-IOV */
> -		if (adapter->vfs_allocated_count)
> -			num_queues = 2;
> -		break;
> -	default:
> -		break;
> -	}
> +		switch (hw->mac.type) {
> +		case e1000_82576:
> +			/* 82576 supports 2 RSS queues for SR-IOV */
> +			if (adapter->vfs_allocated_count)
> +				num_queues = 2;
> +			break;
> +		default:
> +			break;
> +		}
>  
> -	/* Verify user input. */
> -	for (i = 0; i < IGB_RETA_SIZE; i++)
> -		if (rxfh->indir[i] >= num_queues)
> -			return -EINVAL;
> +		/* Verify user input. */
> +		for (i = 0; i < IGB_RETA_SIZE; i++)
> +			if (rxfh->indir[i] >= num_queues)
> +				return -EINVAL;
>  
>  
> -	for (i = 0; i < IGB_RETA_SIZE; i++)
> -		adapter->rss_indir_tbl[i] = rxfh->indir[i];
> +		for (i = 0; i < IGB_RETA_SIZE; i++)
> +			adapter->rss_indir_tbl[i] = rxfh->indir[i];
> +
> +		igb_write_rss_indir_tbl(adapter);
> +	}
>  
> -	igb_write_rss_indir_tbl(adapter);
> +	if (rxfh->key) {
> +		adapter->has_user_rss_key = true;

here

> +		memcpy(adapter->rss_key, rxfh->key, sizeof(adapter->rss_key));
> +		igb_write_rss_key(adapter);
> +	}
>  
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index c703011b19ec..8dab133296ca 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4051,7 +4051,8 @@ static int igb_sw_init(struct igb_adapter *adapter)
>  	pci_read_config_word(pdev, PCI_COMMAND, &hw->bus.pci_cmd_word);
>  
>  	/* init RSS key */
> -	netdev_rss_key_fill(adapter->rss_key, sizeof(adapter->rss_key));
> +	if (!adapter->has_user_rss_key)
> +		netdev_rss_key_fill(adapter->rss_key, sizeof(adapter->rss_key));

and this diff.

>  
>  	/* set default ring sizes */
>  	adapter->tx_ring_count = IGB_DEFAULT_TXD;
> -- 
> 2.52.0


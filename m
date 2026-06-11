Return-Path: <netdev+bounces-297970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M5kvCGhaKmrOnwMAu9opvQ
	(envelope-from <netdev+bounces-297970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:49:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A74966F257
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:49:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PTGog5xY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297970-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297970-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02A983037DCF
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 06:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BEC36E48D;
	Thu, 11 Jun 2026 06:49:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6F737104F
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 06:49:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160547; cv=none; b=I5hNIX7yFZMwhtmxH9GgoSlDRX+0gC6hPnU4mnVlGGcvgtay/1xUuhzXGqF5f7f6TLOXsNCEC9OXJIqjvLqoB1nzb8l2hKz3w/+54TpZiN7fHwXHTDEejtiuoFORSP0LvHFFLyiwcYfgC+Oc32yTmIF8mfz1+pfdp/DlBviJu5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160547; c=relaxed/simple;
	bh=+XP8tEVnmKGDIlRNdwA5ZPi1qKIvI1uWuJPoitDumiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MH4x2NJjZwV+o2SNKJ8c2OT3UAOO9+B3f+MCtgNowlq68SPJe0KA3ytaSbk5autIvAqnnx4qNThFXbD3Q+Kp9uTli54aME4E58rsbXNWIp/gdFnOfWbmxavL76G9SYrOHph10+24bFeLvaym3a/NSkuxvztpWoVYGi5XJIzie7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTGog5xY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2B01F00893;
	Thu, 11 Jun 2026 06:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781160543;
	bh=+w9/seJnUe5JMvKcI6Bs57ZCa4X7FEAtLxTLu5bsTYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PTGog5xYokcTJmuWqKfUOJHM/t76U6pBF7t5SXX6RvO0/hjA9WG09eA40g8HPtDKx
	 RXnMFJmxGfI1P8bX1G15i2zZ8zenqruiUQtEus8oXreo7xNI06ax4DQlxWtDAVaDIe
	 /vyyc6jdioPmf8W672QOcG8dw4J+7T98D13kCqX21um3PbFsviKSpoZbeuFsXrUj0m
	 jEm6b2ScVfCkiHonzTWyetTOxZT4+JSjJVxdgQj/Pk+BpllhDsCAynn3hZlsRCvVMk
	 N/vy5cSFyfum0oIRcAwoXlNgPMpXkpC+VQ7tVtpWh9OO1H0r8ajPsCJEJ7SOozSDb2
	 Xs70BcHI3oJqA==
Date: Thu, 11 Jun 2026 07:48:59 +0100
From: Simon Horman <horms@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com, kuba@kernel.org
Subject: Re: [PATCH net-next v4 3/3] net: libwx: support vf per-queue
 statistics via ethtool -S
Message-ID: <20260611064859.GP3920875@horms.kernel.org>
References: <20260608103946.25786-1-mengyuanlou@net-swift.com>
 <20260608103946.25786-4-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608103946.25786-4-mengyuanlou@net-swift.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mengyuanlou@net-swift.com,m:netdev@vger.kernel.org,m:jiawenwu@trustnetic.com,m:duanqiangwen@net-swift.com,m:kuba@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-297970-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url,vger.kernel.org:from_smtp,sashiko.dev:url,net-swift.com:email,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A74966F257

On Mon, Jun 08, 2026 at 06:39:46PM +0800, Mengyuan Lou wrote:
> Add per-queue TX/RX packet and byte counters to the VF ethtool stats
> table.
> The stats length is now dynamically determined based on whether the
> device is a VF or PF via wx_stats_len().
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
>  .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 48 +++++++++++++++----
>  drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  4 ++
>  .../net/ethernet/wangxun/libwx/wx_vf_common.c |  2 +
>  3 files changed, 44 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> index 30c6ef6103ac..86f6ac63acf7 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> @@ -48,6 +48,10 @@ static const struct wx_stats wx_gstrings_stats[] = {
>  	WX_STAT("rx_hwtstamp_cleared", rx_hwtstamp_cleared),
>  };
>  
> +static const struct wx_stats wx_gstrings_stats_vf[] = {
> +	WX_STAT("non_eop_descs", non_eop_descs),
> +};
> +

The AI-generated review available at https://netdev-ai.bots.linux.dev/sashiko/
flags that this is user-exposed and probably could benefit from a bit
more explanation in the patch description.

>  static const struct wx_stats wx_gstrings_fdir_stats[] = {
>  	WX_STAT("fdir_match", stats.fdirmatch),
>  	WX_STAT("fdir_miss", stats.fdirmiss),
> @@ -69,15 +73,26 @@ static const struct wx_stats wx_gstrings_rsc_stats[] = {
>  #define WX_QUEUE_STATS_LEN ( \
>  		(WX_NUM_TX_QUEUES + WX_NUM_RX_QUEUES) * \
>  		(sizeof(struct wx_queue_stats) / sizeof(u64)))
> -#define WX_GLOBAL_STATS_LEN  ARRAY_SIZE(wx_gstrings_stats)
>  #define WX_FDIR_STATS_LEN  ARRAY_SIZE(wx_gstrings_fdir_stats)
>  #define WX_RSC_STATS_LEN  ARRAY_SIZE(wx_gstrings_rsc_stats)
> -#define WX_STATS_LEN (WX_GLOBAL_STATS_LEN + WX_QUEUE_STATS_LEN)
> +
> +static inline unsigned int wx_global_stats_len(const struct wx *wx)
> +{
> +	return wx->pdev->is_virtfn ?
> +	       ARRAY_SIZE(wx_gstrings_stats_vf) : ARRAY_SIZE(wx_gstrings_stats);
> +}

Please don't use the inline keyword in .c files unless there is a
demonstrable - usually performance - reason to do so. Rather, please
let the compiler inline code (or not).

It is of course fine to use the inline keyword in .h files.

> +
> +static inline unsigned int wx_stats_len(const struct wx *wx)
> +{
> +	struct net_device *netdev = wx->netdev;

netdev seems unused.

Flagged by AI-generated review on sashiko.dev 

> +
> +	return wx_global_stats_len(wx) + WX_QUEUE_STATS_LEN;
> +}
>  
>  int wx_get_sset_count(struct net_device *netdev, int sset)
>  {
>  	struct wx *wx = netdev_priv(netdev);
> -	int len = WX_STATS_LEN;
> +	int len = wx_stats_len(wx);
>  
>  	switch (sset) {
>  	case ETH_SS_STATS:
> @@ -100,8 +115,11 @@ void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
>  
>  	switch (stringset) {
>  	case ETH_SS_STATS:
> -		for (i = 0; i < WX_GLOBAL_STATS_LEN; i++)
> -			ethtool_puts(&p, wx_gstrings_stats[i].stat_string);
> +		for (i = 0; i < wx_global_stats_len(wx); i++)
> +			if (wx->pdev->is_virtfn)
> +				ethtool_puts(&p, wx_gstrings_stats_vf[i].stat_string);
> +			else
> +				ethtool_puts(&p, wx_gstrings_stats[i].stat_string);

The AI-generated review at https://netdev-ai.bots.linux.dev/sashiko/ also
flags that these seem to cover statistics that can be exposed via
netdev_stat_ops, which is preferred.

If consistency with the PF stats is desired for VF stats, then perhaps
netdev_stat_ops can also be implemented for PF queues.

>  		if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) {
>  			for (i = 0; i < WX_FDIR_STATS_LEN; i++)
>  				ethtool_puts(&p, wx_gstrings_fdir_stats[i].stat_string);

...


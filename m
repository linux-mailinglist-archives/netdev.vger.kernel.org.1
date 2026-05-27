Return-Path: <netdev+bounces-292362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GW5FsYWF2px3wcAu9opvQ
	(envelope-from <netdev+bounces-292362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:07:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A623D5E777E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7619D302B774
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3983A381B15;
	Wed, 27 May 2026 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WFmtSNxR"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62FB37C11B
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897524; cv=none; b=DpkaJwVZn83ma3bFLk6vhM0Bx+Utpjwlbmt1e11yS33aWbNYNN+IRjNKUIWxfw5WQKs94FxJfDD/9SYqLU25PEBanpcLAToCIA+BE4VtqLfVmRwGmOrPxC1lYXM4PcUOLSNUuZiO90YV2Xku/5xMJS6FmfKkEQ5rf9uxL8rf9LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897524; c=relaxed/simple;
	bh=ZGaVfRe4pwKSIV3A0DKoI5aIPRxMnxWQp5Scj94gPUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zu6PdeUIqB/5uSz+M5E3qxeo21ewinIvIhs3OsrOGisD368bUiVS92BmECtUtUf22GpsjSnMapLqGdpYo/mJgaSkc7M/Hhg41Tn+3816MTtKsv/9XGU1HcuWDSJxwvNkFxqRzwS0jOrWdaS4HEVZJ+HhD0budJu87XCIxrnhV8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WFmtSNxR; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5b617773-92c4-4d8d-831e-a74ef0c76b33@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779897520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oxn2nvn0dCOHkFr6MxG50HZrEMR0vc9BDbUv8aE3L28=;
	b=WFmtSNxRJPQ2G05aFbgAd5amJDy+kTP2H5QF97iE97dUoMfX5TxBFLHB6KaiZPH7KGknzr
	yWc3404aejcrxF6ngr5r83bkdInXeTfqfzLWcsUL2SZSzZkUm4ExRGUCzpTzev3m6fm1XV
	UbSjAvSxbT7lbMC2/Mo7J2/7qOHKGzg=
Date: Wed, 27 May 2026 16:58:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: remove SIOCSHWTSTAMP and SIOCGHWTSTAMP from
 ndo_eth_ioctl comment
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Florian Fainelli <f.fainelli@gmail.com>
References: <20260527120936.24169-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260527120936.24169-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,nxp.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-292362-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.dev:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A623D5E777E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 27/05/2026 13:09, Xuan Zhuo wrote:
> Since commit 4ee58e1e5680 ("net: promote SIOCSHWTSTAMP and SIOCGHWTSTAMP
> ioctls to dedicated handlers"), SIOCSHWTSTAMP and SIOCGHWTSTAMP are no
> longer dispatched through dev_eth_ioctl() / ndo_eth_ioctl(). They are
> now handled by their own dedicated functions dev_set_hwtstamp() and
> dev_get_hwtstamp() in the ioctl path.
> 
> However, the comment describing ndo_eth_ioctl in netdevice.h still
> lists these two ioctls, which is misleading for driver developers who
> may incorrectly assume they need to handle hardware timestamping
> commands in their ndo_eth_ioctl implementation.
> 
> Remove the stale references from the comment to accurately reflect that
> ndo_eth_ioctl only handles SIOCGMIIPHY, SIOCGMIIREG and SIOCSMIIREG.
> 
> Fixes: 4ee58e1e5680 ("net: promote SIOCSHWTSTAMP and SIOCGHWTSTAMP ioctls to dedicated handlers")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   include/linux/netdevice.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index bf3dd9b2c1a7..7309467d7873 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1149,8 +1149,8 @@ struct netdev_net_notifier {
>    *	SIOCBONDSLAVEINFOQUERY, and SIOCBONDINFOQUERY
>    *
>    * * int (*ndo_eth_ioctl)(struct net_device *dev, struct ifreq *ifr, int cmd);
> - *	Called for ethernet specific ioctls: SIOCGMIIPHY, SIOCGMIIREG,
> - *	SIOCSMIIREG, SIOCSHWTSTAMP and SIOCGHWTSTAMP.
> + *	Called for ethernet specific ioctls: SIOCGMIIPHY, SIOCGMIIREG and
> + *	SIOCSMIIREG.
>    *
>    * int (*ndo_set_config)(struct net_device *dev, struct ifmap *map);
>    *	Used to set network devices bus interface parameters. This interface


Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>


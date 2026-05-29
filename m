Return-Path: <netdev+bounces-293050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAFBLWNSGWpnvAgAu9opvQ
	(envelope-from <netdev+bounces-293050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 10:46:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D485FF69D
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 10:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60A913009993
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C716E351C20;
	Fri, 29 May 2026 08:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Bq/CyM4e"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390FB2FE074
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044203; cv=none; b=QbJySwFpTpK05pHfqzoNQr3sOvWJ+xojUsbGBxUWlCdc15yKfyovWLMSTWP3EEvdT695nPoYftWO//8eMPO3hgW0/ZGXUSAQfnwktLTVUyFMJTL9p6syl5RogKJH5QT5htLf6MWbq9vg49GE9CcPP1yS/CrpEc02mbc3dzmBWwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044203; c=relaxed/simple;
	bh=bP7HlwNOa+zbcUG01FRlzhUrmDFsXC2PUrhS/vC9gLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tcPVLIYwtZv/2zj+OJ3nTh06uSPW4rGteNLFrN56IUH5m/ryORlqL8Xhn0Rc09Xq9SLF1rIXcrx/dN9Fu9wx5+Bllv0fT8dxkrUvoFWsgJKAQUnAA8o6TOUIjDgZ0xvXbC71bUKnrvDX4bNlD9GrpLKTsPJfvKkJMEdIlVdq+Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Bq/CyM4e; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9C6081A372B;
	Fri, 29 May 2026 08:43:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6DBB1601FA;
	Fri, 29 May 2026 08:43:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7E3F110888244;
	Fri, 29 May 2026 10:43:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780044197; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=yBnxYIyle2Z+kSIkOn5qaNybS63aCUh2dLbncTlrnfE=;
	b=Bq/CyM4eIx79wIw4ePl+mANvM7XdmBByGjsZgBrk7mKOHzOBZhZxY2A9/y1BCVJ15ngz3H
	9rUtMkjWj2oupKgBjLVjnFXywnMS9y5FwIl1CT4Ej4Hug9ObIlhz8W7IcVGoeG/OP9OFUG
	+7NCxrtANF3i0Vfc00HZnM9DggBrC/x0js+S3RHPHz7VmDRpDGuxtAVAuDBeZxdOGNgZwE
	CT9TrGBciJWiSLhtccGTw0eaFHw1CA3VVxY0z1ri8nhjougCHECGZXstcKilXkZXCHVkQm
	GEhjSbCfVV9GRQmu+1h/SrgifQakq0ETZwb7f9VyYI5kwXpbbS8zv0e2h0DSUw==
Message-ID: <70c0a3dc-a522-4141-b98c-2ebc231b20ae@bootlin.com>
Date: Fri, 29 May 2026 10:43:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/14] net: ethtool: relax ethnl_req_get_phydev()
 locking assertion
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
 joshwash@google.com, tariqt@nvidia.com, haiyangz@microsoft.com,
 linux@armlinux.org.uk, willemb@google.com, ernis@linux.microsoft.com,
 sdf.kernel@gmail.com, kory.maincent@bootlin.com, danieller@nvidia.com,
 idosch@nvidia.com
References: <20260528231637.251822-1-kuba@kernel.org>
 <20260528231637.251822-5-kuba@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260528231637.251822-5-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293050-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,nvidia.com,microsoft.com,armlinux.org.uk,linux.microsoft.com,gmail.com,bootlin.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 32D485FF69D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/29/26 01:16, Jakub Kicinski wrote:
> phydev <> netdev linking and lifecycle depends on rtnl_lock.
> We want to switch to instance locks for most ethtool ops.
> Let's add an assert that ops locked devices don't use phydev
> today. If one does we can either opt the phy ops out of
> being purely ops locked, or do deeper surgery to make phy
> locking ops-compatible. I don't think there's any fundamental
> challenge to make that work.

Yeah untangling phylink/SFP/phylib from rtnl will be needed soon
indeed, quite the can of worms...

But for the topo part, this change should do the trick.

At some point we'll need to convert a more embeded-oriented MAC
driver to being ops-locked, to get a good idea of the amount of
work in front of us.

Most of the constraints come from the different lifetimes of
phy_device, sfp-bus and net_device, RTNL is the easy way to
guarantee that the netdev doesn't dissapear under our feet.

Andrew and Russell were careful to get people to annotate
the RTNL dependencies with assertions, this should make it easier
to tackle the conversion :)

For now,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   include/linux/phy_link_topology.h   | 5 +++++
>   drivers/net/phy/phy_link_topology.c | 8 ++++++++
>   net/ethtool/netlink.c               | 6 ++++--
>   net/ethtool/phy.c                   | 1 -
>   4 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
> index 68a59e25821c..95575f68d5bc 100644
> --- a/include/linux/phy_link_topology.h
> +++ b/include/linux/phy_link_topology.h
> @@ -36,6 +36,11 @@ struct phy_device_node {
>   	struct phy_device *phy;
>   };
>   
> +static inline bool phy_link_topo_empty(struct net_device *dev)
> +{
> +	return !dev->link_topo;
> +}
> +
>   #if IS_ENABLED(CONFIG_PHYLIB)
>   int phy_link_topo_add_phy(struct net_device *dev,
>   			  struct phy_device *phy,
> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> index 1f1eb5d59b38..aed3b26c1674 100644
> --- a/drivers/net/phy/phy_link_topology.c
> +++ b/drivers/net/phy/phy_link_topology.c
> @@ -10,6 +10,7 @@
>   #include <linux/phy.h>
>   #include <linux/rtnetlink.h>
>   #include <linux/xarray.h>
> +#include <net/netdev_lock.h>
>   
>   static int netdev_alloc_phy_link_topology(struct net_device *dev)
>   {
> @@ -35,6 +36,13 @@ int phy_link_topo_add_phy(struct net_device *dev,
>   	struct phy_device_node *pdn;
>   	int ret;
>   
> +	/* ethtool ops may run without rtnl_lock, and rtnl_lock is what
> +	 * currently protects the PHY topology. No driver currently mixes
> +	 * the two, flag if someone tries. See also ethnl_req_get_phydev().
> +	 */
> +	if (WARN_ON_ONCE(netdev_need_ops_lock(dev)))
> +		return -EOPNOTSUPP;
> +
>   	if (!topo) {
>   		ret = netdev_alloc_phy_link_topology(dev);
>   		if (ret)
> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> index 902ff7d0a71d..a91cc4bc964f 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -226,11 +226,13 @@ struct phy_device *ethnl_req_get_phydev(const struct ethnl_req_info *req_info,
>   {
>   	struct phy_device *phydev;
>   
> -	ASSERT_RTNL();
> -
>   	if (!req_info->dev)
>   		return NULL;
>   
> +	/* If there is no PHY in sight there's no need for assert locking */
> +	if (!phy_link_topo_empty(req_info->dev))
> +		ASSERT_RTNL();
> +
>   	if (!req_info->phy_index)
>   		return req_info->dev->phydev;
>   
> diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
> index ddc6eab701ed..018b0412be86 100644
> --- a/net/ethtool/phy.c
> +++ b/net/ethtool/phy.c
> @@ -78,7 +78,6 @@ static int phy_prepare_data(const struct ethnl_req_info *req_info,
>   	struct phy_device *phydev;
>   	int ret;
>   
> -	/* RTNL is held by the caller */
>   	phydev = ethnl_req_get_phydev(req_info, tb, ETHTOOL_A_PHY_HEADER,
>   				      info->extack);
>   	if (IS_ERR_OR_NULL(phydev))



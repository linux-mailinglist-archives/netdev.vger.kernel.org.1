Return-Path: <netdev+bounces-267336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uF3ODAfNs2n2awAAu9opvQ
	(envelope-from <netdev+bounces-267336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:38:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A24327FD4E
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2373B303514D
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350BC383C9A;
	Fri, 13 Mar 2026 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1srsThrp"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967BC21883E
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 08:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773390955; cv=none; b=J0hNbmno7E0ap3HCI9wfqeBICzhbuG8IP/FM1I4hO3U4LcOKL09/h5en0PX2q/ftjXZZYvrm6jgn4hZymVHY2K/fIfALuMvKuGig60N0hVK6139K4djqKzrc5Qc+AiDRQY532gRMpCAHMLVM5X2wKw8tj7GjmT6Hj33dSGAhHwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773390955; c=relaxed/simple;
	bh=eYEBx60RtXnYPtzwWMtE7tR90Xe3MNGxiCxFs/Re1ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSFmJQK8ofKfGivMjg46NUSZ6RKD8Er+7bFx6JJQdbmMungL8rrCswjqXlNgM14i/vgLqJs2pxLDYVJH+raihPTv7tGv9z9CWSw841sWYtw6/wfnf9DwoIjxMbshPPZKtOTbpCBPCiwkZW6XMSUSPfQv23x9mqFOkX5d/rC3MqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1srsThrp; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2A1234E4265E;
	Fri, 13 Mar 2026 08:35:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F0B6C60027;
	Fri, 13 Mar 2026 08:35:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 66F3510368726;
	Fri, 13 Mar 2026 09:35:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773390950; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=axVqJI0mUqtDA4i2IbYi0xFcUj2DJG1au0Ma8bau+ig=;
	b=1srsThrp0KROveKrJ4ReGik5mYnty55I9aKIWRMkCyDvkx5tjnYLDd5+M2zznLl1NTHhlx
	qgUFStoWosrE2+gaIhUZkrdOZhG/4MlIjC5x4+fZzmtuhhUzoJzhP5ofsaHKGrsBRomxfv
	2/I9c7kybZ8HrR5e7C9d7Knox2aF6A56UHCWheFi0bh31rXTWaILMkEPJvhQWsRNLc8jwh
	qCTl+Ew2mFa65is5kWmh4v7ToVqnlrZe36rhmWDQafnk9+N+zc6/DlkPo+Cf4lKRzunCyk
	kkh+lZVPNySmKq3dmFOypu6HJUZnyEOWAkXTkoSXWHTuDvHnD5ESkWvSST8CCw==
Message-ID: <64ab606f-8beb-40fb-853c-c09ff7d607fa@bootlin.com>
Date: Fri, 13 Mar 2026 09:35:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 10/10] net: ethtool: Introduce ethtool command
 to list ports
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>, =?UTF-8?B?QmrDtnJuIFTDtnBl?=
 =?UTF-8?Q?l?= <bjorn@kernel.org>
References: <20260309152747.702373-1-maxime.chevallier@bootlin.com>
 <20260309152747.702373-11-maxime.chevallier@bootlin.com>
 <20260312190705.0b3a3f78@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260312190705.0b3a3f78@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267336-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A24327FD4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub,

Thanks a lot for taking a look at this :)

On 13/03/2026 03:07, Jakub Kicinski wrote:
> On Mon,  9 Mar 2026 16:27:46 +0100 Maxime Chevallier wrote:
>> Expose the phy_port information to userspace, so that we can know how
>> many ports are available on a given interface, as well as their
>> capabilities. For MDI ports, we report the list of supported linkmodes
>> based on what the PHY that drives this port says.
>> For MII ports, i.e. empty SFP cages, we report the MII linkmodes that we
>> can output on this port.
> 
>> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
>> index 6e5f0f4f815a..90674aed7777 100644
>> --- a/net/ethtool/netlink.c
>> +++ b/net/ethtool/netlink.c
>> @@ -18,6 +18,8 @@ static u32 ethnl_bcast_seq;
>>  			     ETHTOOL_FLAG_OMIT_REPLY)
>>  #define ETHTOOL_FLAGS_STATS (ETHTOOL_FLAGS_BASIC | ETHTOOL_FLAG_STATS)
>>  
>> +char phy_interface_names[PHY_INTERFACE_MODE_MAX][ETH_GSTRING_LEN] __ro_after_init;
>> +
>>  const struct nla_policy ethnl_header_policy[] = {
>>  	[ETHTOOL_A_HEADER_DEV_INDEX]	= { .type = NLA_U32 },
>>  	[ETHTOOL_A_HEADER_DEV_NAME]	= { .type = NLA_NUL_STRING,
>> @@ -421,6 +423,7 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
>>  	[ETHTOOL_MSG_TSCONFIG_SET]	= &ethnl_tsconfig_request_ops,
>>  	[ETHTOOL_MSG_PHY_GET]		= &ethnl_phy_request_ops,
>>  	[ETHTOOL_MSG_MSE_GET]		= &ethnl_mse_request_ops,
>> +	[ETHTOOL_MSG_PORT_GET]		= &ethnl_port_request_ops,
>>  };
>>  
>>  static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
>> @@ -1544,6 +1547,16 @@ static const struct genl_ops ethtool_genl_ops[] = {
>>  		.policy = ethnl_mse_get_policy,
>>  		.maxattr = ARRAY_SIZE(ethnl_mse_get_policy) - 1,
>>  	},
>> +	{
>> +		.cmd	= ETHTOOL_MSG_PORT_GET,
>> +		.doit	= ethnl_default_doit,
>> +		.start	= ethnl_port_dump_start,
>> +		.dumpit	= ethnl_port_dumpit,
>> +		.done	= ethnl_port_dump_done,
>> +		.policy = ethnl_port_get_policy,
>> +		.maxattr = ARRAY_SIZE(ethnl_port_get_policy) - 1,
>> +	},
>> +
> 
> spurious nl
> 
>>  };
>>  
> 
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright 2026 Bootlin
>> + *
>> + */
> 
> so many lines for a copyright :(
> 
>> +#include "common.h"
>> +#include "bitset.h"
>> +#include "netlink.h"
> 
> alpha sort
> 
>> +#define PORT_REQINFO(__req_base) \
>> +	container_of(__req_base, struct port_req_info, base)
>> +
>> +#define PORT_REPDATA(__reply_base) \
>> +	container_of(__reply_base, struct port_reply_data, base)
>> +
>> +const struct nla_policy ethnl_port_get_policy[ETHTOOL_A_PORT_ID + 1] = {
>> +	[ETHTOOL_A_PORT_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
>> +	[ETHTOOL_A_PORT_ID] = { .type = NLA_U32},
> 
> misaligned bracket
> 
>> +};
>> +
>> +static int port_parse_request(struct ethnl_req_info *req_info,
>> +			      struct nlattr **tb,
>> +			      struct netlink_ext_ack *extack)
>> +{
>> +	struct port_req_info *request = PORT_REQINFO(req_info);
>> +
>> +	/* PORT id is required for GET requests */
>> +	if (tb[ETHTOOL_A_PORT_ID])
> 
> GENL_REQ_ATTR_CHECK ?
> I guess you'll have to move it to prepare cause we don't get info 
> here :(
> 
>> +		request->port_id = nla_get_u32(tb[ETHTOOL_A_PORT_ID]);
>> +
>> +	if (!request->port_id) {
> 
> NLA_POLICY_MIN(, 1)
> 
>> +		NL_SET_ERR_MSG(extack, "port id missing");
>> +		return -ENODEV;
>> +	}
>> +
>> +	return 0;
>> +}
> 
>> +	/* ETHTOOL_A_PORT_TYPE */
>> +	size += nla_total_size(sizeof(u8));
> 
> please don't use u8, it wastes 3B on padding
> 
>> +	/* ETHTOOL_A_PORT_VACANT */
>> +	size += nla_total_size(sizeof(u8));
>> +
>> +	return size;
>> +}
>> +
>> +static int port_fill_reply(struct sk_buff *skb,
>> +			   const struct ethnl_req_info *req_info,
>> +			   const struct ethnl_reply_data *reply_data)
>> +{
>> +	bool compact = req_info->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
>> +	struct port_reply_data *reply = PORT_REPDATA(reply_data);
>> +	int ret, port_type = ETHTOOL_PORT_TYPE_MDI;
>> +
>> +	if (nla_put_u32(skb, ETHTOOL_A_PORT_ID, reply->port_id))
>> +		return -EMSGSIZE;
>> +
>> +	if (!reply->mii) {
>> +		ret = ethnl_put_bitset(skb, ETHTOOL_A_PORT_SUPPORTED_MODES,
>> +				       reply->supported, NULL,
>> +				       __ETHTOOL_LINK_MODE_MASK_NBITS,
>> +				       link_mode_names, compact);
>> +		if (ret < 0)
>> +			return -EMSGSIZE;
> 
> return ret?
> 
>> +static int port_dump_all_dev(struct sk_buff *skb, struct netlink_callback *cb)
>> +{
>> +	struct port_dump_ctx *ctx = port_dump_ctx_get(cb);
>> +	struct net *net = sock_net(skb->sk);
>> +	netdevice_tracker dev_tracker;
>> +	struct net_device *dev;
>> +	int ret = 0;
>> +
>> +	rcu_read_lock();
>> +	for_each_netdev_dump(net, dev, ctx->ifindex) {
>> +		netdev_hold(dev, &dev_tracker, GFP_ATOMIC);
>> +		rcu_read_unlock();
>> +
>> +		ctx->req_info->base.dev = dev;
>> +		ret = port_dump_one_dev(skb, cb);
>> +
>> +		rcu_read_lock();
>> +		netdev_put(dev, &dev_tracker);
>> +		ctx->req_info->base.dev = NULL;
>> +
>> +		if (ret < 0 && ret != -EOPNOTSUPP) {
>> +			if (likely(skb->len))
>> +				ret = skb->len;
> 
> Why the skb->len check? netlink plumbing should handle that these days
> if err = -EMSGSIZE during dump.
> 
>> +			break;
>> +		}
>> +		ret = 0;
>> +	}
>> +	rcu_read_unlock();
>> +
>> +	return ret;
>> +}
>> +
>> +int ethnl_port_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>> +{
>> +	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
>> +	struct port_dump_ctx *ctx = port_dump_ctx_get(cb);
>> +	int ret = 0;
>> +
>> +	if (ctx->ifindex) {
>> +		netdevice_tracker dev_tracker;
>> +		struct net_device *dev;
>> +
>> +		dev = netdev_get_by_index(genl_info_net(&info->info),
>> +					  ctx->ifindex, &dev_tracker,
>> +					  GFP_KERNEL);
>> +		if (!dev)
>> +			return -ENODEV;
>> +
>> +		ctx->req_info->base.dev = dev;
>> +		ret = port_dump_one_dev(skb, cb);
>> +		if (ret < 0 && ret != -EOPNOTSUPP && likely(skb->len))
>> +			ret = skb->len;
> 
> ditto
> 
>> +		netdev_put(dev, &dev_tracker);
>> +	} else {
>> +		ret = port_dump_all_dev(skb, cb);
>> +	}
>> +
>> +	return ret;
>> +}

I agree with all you comments, I'll address for next round :)

Maxime




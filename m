Return-Path: <netdev+bounces-41808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9157CBF03
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E47B1C20A64
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A043F4DA;
	Tue, 17 Oct 2023 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="0EZZzVw3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B10381D8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:24:49 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3537107
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:24:47 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4079ed65471so3091945e9.1
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697534686; x=1698139486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3tGOFg7H1TmqXBAfJRaJdeyQCiUlN2QreaijLoKRz5c=;
        b=0EZZzVw3CSiM6qXZRDsYBLaxYTF+gX4P0khQZvGOroYB5pWv5FK/W2YBZcqKKm/nwC
         3nkPl5Z8i/0w+gSKMVI1jYzHNkAa2tTdlGBPib/Q65YniJlEZKbokShgN2LfSCl9Z+xU
         2Mu1XVMnSc0NdeRSWJOtGy6wSUNyWvyghvJpZTcc/u1lPQCqVUuTt3jB2GLrYd4ri/Ob
         xxlwmLXLvNBkK+CThguIUFfDEsP6j04kkKzoFpZlGM0yfVpiRSBFVmQuVmOAP6hsU6pI
         eiaW+pIrAq7EgvfDZk2hmiUnn+Y6csT4MfhRN20cV8ZWndjtMxjtotm5v4ZM9w8mmuL0
         uQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697534686; x=1698139486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3tGOFg7H1TmqXBAfJRaJdeyQCiUlN2QreaijLoKRz5c=;
        b=ve9S4uYDQhCyYRn5VZPc0NogWkXTi/xsxdJZoJ++zNJ3xQf3zB4YcHQigkrYUhXIFC
         /hPeAVJSxyJxQESDHoLjsW/846/Q97BCkN5T7jEtQs74KPcqIdjMm/0+BPS1oGHa0y9P
         g5OjXhcRubEun6EIj2Ti5JLW6axqHon7TBEGJslGBx3NVCiwwYOr8Q/mPmIUAvkaVXdY
         qO1mS6Vs3qVqyqBqmKiedrEPRAuJ7BZIDY74XFjD7Sn4k56xj2++dEhQluXUxYauxRav
         qeIGtuBjTZeEDwPyRroozz2i1clQvBzbvaVlkPVZ7yEl49daW8KNHASM3QYr3wRJjyO3
         iOGQ==
X-Gm-Message-State: AOJu0YytONSKeSdI3CSTM0k4OjY/shPOPmgJJK3k15Q+A5XtHipQYh8X
	gBXlrBxg/szWzG+tWSb6siFgXg==
X-Google-Smtp-Source: AGHT+IGQvKnlNFf1auRtDN5P9Q4PfP+eoxePLcr3PN2FB1Y7ojtRREYaCP6qIk1syUmmwzf2kodwDw==
X-Received: by 2002:a05:600c:3587:b0:407:7e4b:67e7 with SMTP id p7-20020a05600c358700b004077e4b67e7mr1167063wmq.39.1697534686229;
        Tue, 17 Oct 2023 02:24:46 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c234300b0040813e14b49sm775298wmq.30.2023.10.17.02.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:24:45 -0700 (PDT)
Message-ID: <141f0fc1-f024-d437-dae2-e074523c9bf8@blackwall.org>
Date: Tue, 17 Oct 2023 12:24:44 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next 09/13] bridge: mcast: Add MDB get support
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, roopa@nvidia.com, mlxsw@nvidia.com
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-10-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-10-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/16/23 16:12, Ido Schimmel wrote:
> Implement support for MDB get operation by looking up a matching MDB
> entry, allocating the skb according to the entry's size and then filling
> in the response. The operation is performed under the bridge multicast
> lock to ensure that the entry does not change between the time the reply
> size is determined and when the reply is filled in.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_device.c  |   1 +
>   net/bridge/br_mdb.c     | 154 ++++++++++++++++++++++++++++++++++++++++
>   net/bridge/br_private.h |   9 +++
>   3 files changed, 164 insertions(+)
> 
[snip]
> +int br_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid, u32 seq,
> +	       struct netlink_ext_ack *extack)
> +{
> +	struct net_bridge *br = netdev_priv(dev);
> +	struct net_bridge_mdb_entry *mp;
> +	struct sk_buff *skb;
> +	struct br_ip group;
> +	int err;
> +
> +	err = br_mdb_get_parse(dev, tb, &group, extack);
> +	if (err)
> +		return err;
> +
> +	spin_lock_bh(&br->multicast_lock);

Since this is only reading, could we use rcu to avoid blocking mcast 
processing?

> +
> +	mp = br_mdb_ip_get(br, &group);
> +	if (!mp) {
> +		NL_SET_ERR_MSG_MOD(extack, "MDB entry not found");
> +		err = -ENOENT;
> +		goto unlock;
> +	}
> +
> +	skb = br_mdb_get_reply_alloc(mp);
> +	if (!skb) {
> +		err = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	err = br_mdb_get_reply_fill(skb, mp, portid, seq);
> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack, "Failed to fill MDB get reply");
> +		goto free;
> +	}
> +
> +	spin_unlock_bh(&br->multicast_lock);
> +
> +	return rtnl_unicast(skb, dev_net(dev), portid);
> +
> +free:
> +	kfree_skb(skb);
> +unlock:
> +	spin_unlock_bh(&br->multicast_lock);
> +	return err;
> +}



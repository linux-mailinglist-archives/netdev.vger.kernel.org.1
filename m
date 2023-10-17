Return-Path: <netdev+bounces-41922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2497CC3A8
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 14:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFDB6281868
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513A941E2F;
	Tue, 17 Oct 2023 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="bivJYBeU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D741E2A
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 12:53:12 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6EBEA
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 05:53:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32d9552d765so4432284f8f.2
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 05:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697547188; x=1698151988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XLx6w5DXGZb9mtKdzl0gzgCnw3UsE+8g0Kr5B/l31qs=;
        b=bivJYBeU8av1fe+TZ60S6z2ocBYMl6gpw+jXOeU739T8X3BsBzmV/lwahtShtjNEWH
         pT2VZJE2mDFtgf6v+N9BxZuRw+LT0n+vm248MF5P0cmOKNh2a41aUfUqKuoUpl9qNL3u
         nlGTNrBXTVrhNfHA/lJ4pEAvsV/1wQLOZWZ/Lv8TvkJ+PvOAsizvmWEgv9+duEkn/qO8
         CoyE/FQiBCDq0JG4MHb5gGovJ8c0hOonDKWu7SG/xHLZ4eCuIoAPjap9Axkqr9JsG8Mk
         T/lpRUHaV1Ueel9uXcnap33JxiEGCPUFck/Fhu25lVgtPUQin3zR+Whf2bq8H+k1H/Z2
         3U1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697547188; x=1698151988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XLx6w5DXGZb9mtKdzl0gzgCnw3UsE+8g0Kr5B/l31qs=;
        b=uk9+mYnTrB0PleAYih2TzMNUze+dYheiQjQX0+tjMei7bLfxY1EO6XUhWqp5pI5+RS
         /fG9IJreld6AluQlCxuGHoi07+UEXeQSvU3CV6mjM0ubId3aTRtMGNzzV+N7XBYzM7jc
         n11g/WJgHk+oVU30yhixV8IYKXMUouZS8onSDdFG2msPWqlXAVfTosZnuNhcO6fignRP
         NVxbDql+iJqjygGAFqcPa8hYkf+8GtkEFnuxNbiScHkaqt7L3TP+DRCbMQlHyjr7ftsU
         Kz0dw95iM1fGUKDhjiqXmmR8iydZF2BpJll3IQSRJPY9GhP3128wlck1UZSG4KYMWs4R
         oUbA==
X-Gm-Message-State: AOJu0Yz8KdZAocHOB3+kS+YUBb1EMSMYNdNzPtAo/1hjSrgDErj/Oklg
	nBIlJ//mNB4v2lAZyRFP3MpenQ==
X-Google-Smtp-Source: AGHT+IH0iL2J+xKXPRvnk3+qd/oP9a6lxrmAFhMp4lRBX3pvKnaACGLwdcOpqokMhS0Z/UFzNKm33w==
X-Received: by 2002:a5d:66d0:0:b0:32d:be3e:db6f with SMTP id k16-20020a5d66d0000000b0032dbe3edb6fmr1891390wrw.24.1697547187872;
        Tue, 17 Oct 2023 05:53:07 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d62ce000000b0031779a6b451sm1618216wrv.83.2023.10.17.05.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 05:53:07 -0700 (PDT)
Message-ID: <bb71b086-b60e-c130-8484-5a71d0a07f19@blackwall.org>
Date: Tue, 17 Oct 2023 15:53:05 +0300
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
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, roopa@nvidia.com, mlxsw@nvidia.com
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-10-idosch@nvidia.com>
 <141f0fc1-f024-d437-dae2-e074523c9bf8@blackwall.org>
 <ZS5qE3ou0iceLsp2@shredder>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZS5qE3ou0iceLsp2@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/17/23 14:03, Ido Schimmel wrote:
> On Tue, Oct 17, 2023 at 12:24:44PM +0300, Nikolay Aleksandrov wrote:
>> On 10/16/23 16:12, Ido Schimmel wrote:
>>> Implement support for MDB get operation by looking up a matching MDB
>>> entry, allocating the skb according to the entry's size and then filling
>>> in the response. The operation is performed under the bridge multicast
>>> lock to ensure that the entry does not change between the time the reply
>>> size is determined and when the reply is filled in.
>>>
>>> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
>>> ---
>>>    net/bridge/br_device.c  |   1 +
>>>    net/bridge/br_mdb.c     | 154 ++++++++++++++++++++++++++++++++++++++++
>>>    net/bridge/br_private.h |   9 +++
>>>    3 files changed, 164 insertions(+)
>>>
>> [snip]
>>> +int br_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid, u32 seq,
>>> +	       struct netlink_ext_ack *extack)
>>> +{
>>> +	struct net_bridge *br = netdev_priv(dev);
>>> +	struct net_bridge_mdb_entry *mp;
>>> +	struct sk_buff *skb;
>>> +	struct br_ip group;
>>> +	int err;
>>> +
>>> +	err = br_mdb_get_parse(dev, tb, &group, extack);
>>> +	if (err)
>>> +		return err;
>>> +
>>> +	spin_lock_bh(&br->multicast_lock);
>>
>> Since this is only reading, could we use rcu to avoid blocking mcast
>> processing?
> 
> I tried to explain this choice in the commit message. Do you think it's
> a non-issue?
> 

Unless you really need a stable snapshot, I think it's worth
not blocking igmp processing for a read. It's not critical,
if you do need a stable snapshot then it's ok.

>>
>>> +
>>> +	mp = br_mdb_ip_get(br, &group);
>>> +	if (!mp) {
>>> +		NL_SET_ERR_MSG_MOD(extack, "MDB entry not found");
>>> +		err = -ENOENT;
>>> +		goto unlock;
>>> +	}
>>> +
>>> +	skb = br_mdb_get_reply_alloc(mp);
>>> +	if (!skb) {
>>> +		err = -ENOMEM;
>>> +		goto unlock;
>>> +	}
>>> +
>>> +	err = br_mdb_get_reply_fill(skb, mp, portid, seq);
>>> +	if (err) {
>>> +		NL_SET_ERR_MSG_MOD(extack, "Failed to fill MDB get reply");
>>> +		goto free;
>>> +	}
>>> +
>>> +	spin_unlock_bh(&br->multicast_lock);
>>> +
>>> +	return rtnl_unicast(skb, dev_net(dev), portid);
>>> +
>>> +free:
>>> +	kfree_skb(skb);
>>> +unlock:
>>> +	spin_unlock_bh(&br->multicast_lock);
>>> +	return err;
>>> +}
>>



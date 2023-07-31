Return-Path: <netdev+bounces-22937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 349BE76A1CE
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 22:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64C721C20CB2
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 20:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC061DDE8;
	Mon, 31 Jul 2023 20:21:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308A01D31E
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 20:21:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FFE1728
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 13:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690834883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rIiRhUiYwbCYwYApjA1wKDyw4ibZatrzqSxqS0d8SCY=;
	b=FR+Tznu4nfFlg1mZPHSrEP3XBj62H6ZaIkMTZ7ISbJ/aTAtgo5X4pxvsZeuPp1LS6jS2Qb
	jNeQBrevd5Yb3eQIzxhTGcEJBci9CZHStWOuHdman82Yd80453Rx9DGcQekFBPvLIKsGry
	8pQz/Nttmns8zjY+4fmjSUHNgCPrXGc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-_iTeQ0ixO_KytQ1_-UTx1w-1; Mon, 31 Jul 2023 16:21:21 -0400
X-MC-Unique: _iTeQ0ixO_KytQ1_-UTx1w-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fdf1798575so4016742e87.2
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 13:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690834879; x=1691439679;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rIiRhUiYwbCYwYApjA1wKDyw4ibZatrzqSxqS0d8SCY=;
        b=F35xJ0s31NdsgcaHvRZ9p/fCDRbpQmW8MESjyuCpnSCg7pNO0oX5zcGs3j3f2T2qBS
         1ZUZdRboAvq2biZfQHa3f8l2auaUrjm3ICFscDeeZs8OEyalV708Dzoqjk1dM405dMsd
         NLAscBA+ODu8BLcXe7ccwtfLyGD9hHbBjLq2wjXLNDcsIdyL+8SBrfKNfJGq77bjSMnX
         ztyTEmVRtTgiCeGnsfPzR8z12rswOYU2l7rtvs0fTT0jk0fX6R14LaOBWHKCrNXTyy8u
         FJMvYWjE1BjNytlQ73h8N+cNsxZsBYyTfR46MrhH4+w2OlvKSPjj5AKWOKgw/ewKrWio
         1pQA==
X-Gm-Message-State: ABy/qLZtOdhIU9PNRsi3PVqfRTVeId2jgT1ZYeiFJy20NnRycTSel4cQ
	rrLAF2F0Udiufp5VbhQ8MyeIm4QztE+LYeY8cv30wyzCmJ/csiGME16Qsejlb8Ql90kEr19ALcd
	1hX3ki0Zf8YojdxX+dybAM3QVKVZwvcukDaMvGOnV6+SMdGJX8OAH35LrS7XtDeohJ3lvUKhV
X-Received: by 2002:ac2:4301:0:b0:4f8:7781:9875 with SMTP id l1-20020ac24301000000b004f877819875mr632425lfh.60.1690834879784;
        Mon, 31 Jul 2023 13:21:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEhW6gcMPhFR8HbzoGSFjuqbfT7zUH8rXS+uswwzpQ2sluaQqki8TghFu2UigERulYI2zLEnQ==
X-Received: by 2002:ac2:4301:0:b0:4f8:7781:9875 with SMTP id l1-20020ac24301000000b004f877819875mr632406lfh.60.1690834879397;
        Mon, 31 Jul 2023 13:21:19 -0700 (PDT)
Received: from ?IPV6:2001:1711:fa41:6a0a::628? ([2001:1711:fa41:6a0a::628])
        by smtp.gmail.com with ESMTPSA id f25-20020a1709067f9900b009934855d8f1sm6564908ejr.34.2023.07.31.13.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 13:21:18 -0700 (PDT)
Message-ID: <d191a2a0-cbaf-df3a-0b5c-04d98788a4f3@redhat.com>
Date: Mon, 31 Jul 2023 22:21:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next,v4] bonding: support balance-alb with openvswitch
Content-Language: en-GB
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Andy Gospodarek <andy@greyhouse.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jay Vosburgh <jay.vosburgh@canonical.com>
References: <96a1ab09-7799-6b1f-1514-f56234d5ade7@redhat.com>
 <18961.1690757506@famine>
From: Mat Kowalski <mko@redhat.com>
In-Reply-To: <18961.1690757506@famine>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 31/07/2023 00:51, Jay Vosburgh wrote:
> Mat Kowalski <mko@redhat.com> wrote:
> 
>> Commit d5410ac7b0ba ("net:bonding:support balance-alb interface with
>> vlan to bridge") introduced a support for balance-alb mode for
>> interfaces connected to the linux bridge by fixing missing matching of
>> MAC entry in FDB. In our testing we discovered that it still does not
>> work when the bond is connected to the OVS bridge as show in diagram
>> below:
>>
>> eth1(mac:eth1_mac)--bond0(balance-alb,mac:eth0_mac)--eth0(mac:eth0_mac)
>>                         |
>>                       bond0.150(mac:eth0_mac)
>>                         |
>>                       ovs_bridge(ip:bridge_ip,mac:eth0_mac)
>>
>> This patch fixes it by checking not only if the device is a bridge but
>> also if it is an openvswitch.
> 
> 	What changed between v3 and v4?
> 
> 	-J

v4 changes:
- Fix additional space at the beginning of the line

v3 changes:
- Fix tab chars converted to spaces

v2 changes:
- Fix line wrapping

> 
>> Signed-off-by: Mateusz Kowalski <mko@redhat.com>
>> ---
>> drivers/net/bonding/bond_alb.c | 2 +-
>> include/linux/netdevice.h      | 5 +++++
>> 2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
>> index b9dbad3a8af8..cc5049eb25f8 100644
>> --- a/drivers/net/bonding/bond_alb.c
>> +++ b/drivers/net/bonding/bond_alb.c
>> @@ -668,7 +668,7 @@ static struct slave *rlb_arp_xmit(struct sk_buff *skb, struct bonding *bond)
>>
>> 	dev = ip_dev_find(dev_net(bond->dev), arp->ip_src);
>> 	if (dev) {
>> -		if (netif_is_bridge_master(dev)) {
>> +		if (netif_is_any_bridge_master(dev)) {
>> 			dev_put(dev);
>> 			return NULL;
>> 		}
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index 84c36a7f873f..27593c0d3c15 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -5103,6 +5103,11 @@ static inline bool netif_is_ovs_port(const struct net_device *dev)
>> 	return dev->priv_flags & IFF_OVS_DATAPATH;
>> }
>>
>> +static inline bool netif_is_any_bridge_master(const struct net_device *dev)
>> +{
>> +	return netif_is_bridge_master(dev) || netif_is_ovs_master(dev);
>> +}
>> +
>> static inline bool netif_is_any_bridge_port(const struct net_device *dev)
>> {
>> 	return netif_is_bridge_port(dev) || netif_is_ovs_port(dev);
>> -- 
>> 2.41.0
> 
> ---
> 	-Jay Vosburgh, jay.vosburgh@canonical.com
> 



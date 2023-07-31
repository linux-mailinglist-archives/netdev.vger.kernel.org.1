Return-Path: <netdev+bounces-22691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 029FF768D1D
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 09:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D5C1C20959
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 07:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EA8211C;
	Mon, 31 Jul 2023 07:07:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5899A2117
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 07:07:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE532105
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 00:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690787161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5+UDKffrf+GUepmIenVn8c5aLdWnPnYO28G4K9i3Hk=;
	b=L3pwS2gvYXeTbPNoeAq/bEBKJ44eRV370hZxNwg8MjqJZPwanQW2fmjup09LVG+SpT9IiF
	kgsQ8uwy+yMDqEZ8rOVwH8VbQUZBBM4tYzi7838uf3sfbwx62tnbIx4jwbFEkpSSv38Vpp
	fymihH6Ecj8cJ0X6hOO0h4kKoGArXJ0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-VSJq6ZV5Px2xROwiUL4GMA-1; Mon, 31 Jul 2023 03:05:59 -0400
X-MC-Unique: VSJq6ZV5Px2xROwiUL4GMA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a355cf318so316743066b.2
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 00:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690787158; x=1691391958;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j5+UDKffrf+GUepmIenVn8c5aLdWnPnYO28G4K9i3Hk=;
        b=k+iGIKpLlz3/R+feK/gSoUlql00lg4VVoMBBo9Ixf3zlHXa8xzEWRgI2YDCpjaY/lh
         aIAeS7zF5szG7jg/GEA8H2J0LiaQwenS+udhalNoAwJ5dpygY7Q26m8jvYhh6Zineg4R
         Exur160VFmdCzgAsqJl4BwuH8AQN8vvmY62suLHjQJKugPm5+Q9UrHTrU8QtK0HglWm1
         CMEcAUfNqtd5cUdVNbIeGZU6eVxrtTmibtO1VmUcwpj73KNPWRyeCc9FnpNv7BAYR3lV
         L/XSlnuSYTUkJC3J7yqXQUmXX0IFo+yK2iyNo5OSnNYPg9bL/19e+S1Mjxjy1/vksCyG
         de7w==
X-Gm-Message-State: ABy/qLbcc5+G/UMP9QSX00faeDHk4gd75TC+B7ECARcFPubnzPxZtl1v
	nch+/vn1ok7Q20P6qYawAkwrELhkCzqZP01bk50rGy9N445LHw0Bep3g59lYNgNRNeLn5FyW3IV
	zZv883oFWKJGSt4lx
X-Received: by 2002:a17:906:254:b0:988:9b29:5653 with SMTP id 20-20020a170906025400b009889b295653mr6081433ejl.77.1690787158429;
        Mon, 31 Jul 2023 00:05:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF4FszLEGLvSyRhET/c1fijSlFhFOvi3TNzC6S0MaYaR9X/xeK4EA5HyEUJShXOdiVKu22oyw==
X-Received: by 2002:a17:906:254:b0:988:9b29:5653 with SMTP id 20-20020a170906025400b009889b295653mr6081414ejl.77.1690787158006;
        Mon, 31 Jul 2023 00:05:58 -0700 (PDT)
Received: from [192.168.149.71] (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
        by smtp.gmail.com with ESMTPSA id r15-20020a1709067fcf00b009937dbabbdasm5695036ejs.217.2023.07.31.00.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 00:05:57 -0700 (PDT)
Message-ID: <3f12244c-3047-41b2-d6de-03b9e777bfa3@redhat.com>
Date: Mon, 31 Jul 2023 09:05:56 +0200
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
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andy Gospodarek <andy@greyhouse.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
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

All the changes were only about whitespaces and formatting of the diff itself. The code itself is the same in v1-v4

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




Return-Path: <netdev+bounces-199941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4C9AE2772
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 07:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F93D3ACC68
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 05:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A34F13C8EA;
	Sat, 21 Jun 2025 05:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="nkeBOM87"
X-Original-To: netdev@vger.kernel.org
Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24042F2E
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 05:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750482053; cv=none; b=tvxtU4/YKJFdasRUJNu2NC0Zyi16Unr4XFxI54W6f0zeg9nYXv7u+oC6XA2kddi9o4gXV7LBejSUeNbucqBjumiwGUfwmjqg+VF1AYX+E1BifOSrxZYaflSnFKTsazNME41VRPRD6/2bu+96gxfsfIgOqhNmc/kMLrReGfhS/ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750482053; c=relaxed/simple;
	bh=XpJ4hKrh8tC3aNm1mzdDU/eTnrbV1HgdXdY0xATeBDk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y+MJaq7r6DV2el94kdpizU4GMoDPjFoyyBol30Ng0d+I2VK+CZ1PXYjrHBsHUdb8JmC4KE85BIVScHfoBgPSovktyUHUJ7pUHW/L3JRIA4vbu9aI2XUYNf9CC1PhQpJ/WYq76VKQ0UWeDmYHPKlMCs2jQE+vp+qchfQgrt3nN5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=nkeBOM87 reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Received: from [192.168.201.189] (210-129-16-52.radian.jp-east.compute.idcfcloud.net [210.129.16.52])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 55L50dJU087502
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 21 Jun 2025 14:00:40 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=iuANZcQC02bboaHqJb432KWqx0G0sP7vFG1opEDuV9o=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=Message-ID:Date:From:Subject:To;
        s=rs20250326; t=1750482042; v=1;
        b=nkeBOM87BhwA9CcdRvOKW9BknQTlfE5rjXQ+HpTIToPPL8LiPe6H3skFwZ9v+gKZ
         KavLsiZZCPXe4Hrfvcy9CnVHq8auK2QBMmjUXviwdH3lfEb81X/BIonqFIq42vBp
         3ajMNhJNPfC5+QceitXZvDtO40H9TyHuqn6JY0PplWOsYATLuJGCdonuE1mRvcRc
         tS5UQYHWEaxq5A4oXVdlsvBTR0d9SR4nL1NvVQFRVNQvPiM6g6jlaj+f8c/bcxSz
         GrdJEAL9bAuoO4fJ30E1yD6AWaAQSUPH+J5s64VmXC4RYop9s0XQd99g5z49fGoY
         31j5TftS9oIDYGj/eTBSnw==
Message-ID: <3b8846da-d163-4e89-8c93-f50c333841d8@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 21 Jun 2025 14:00:38 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH v4 net-next 7/8] tun: enable gso over UDP tunnel support.
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Yuri Benditovich <yuri.benditovich@daynix.com>
References: <cover.1750176076.git.pabeni@redhat.com>
 <1c6ffd4bd0480ecc4c8442cef7c689fbfb5e0e56.1750176076.git.pabeni@redhat.com>
 <6505a764-a3d2-4c98-b2b3-acc2bb7b1aae@daynix.com>
 <4e0a0a37-9164-465a-b18b-7d97c88d444e@redhat.com>
 <bc579418-646f-4ccc-bf9c-976b264c4da2@daynix.com>
 <74f6f0ea-6f2d-4520-b103-d4388a0916d6@redhat.com>
Content-Language: en-US
In-Reply-To: <74f6f0ea-6f2d-4520-b103-d4388a0916d6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/06/20 2:27, Paolo Abeni wrote:
> On 6/19/25 5:46 PM, Akihiko Odaki wrote:
>> On 2025/06/19 23:52, Paolo Abeni wrote:
>>> On 6/19/25 4:42 PM, Akihiko Odaki wrote:
>>>> On 2025/06/18 1:12, Paolo Abeni wrote:
>>>>> @@ -1721,7 +1733,12 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>>>>>     	if (tun->flags & IFF_VNET_HDR) {
>>>>>     		int vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
>>>>>     
>>>>> -		hdr_len = tun_vnet_hdr_get(vnet_hdr_sz, tun->flags, from, &gso);
>>>>> +		if (vnet_hdr_sz >= TUN_VNET_TNL_SIZE)
>>>>> +			features = NETIF_F_GSO_UDP_TUNNEL |
>>>>> +				   NETIF_F_GSO_UDP_TUNNEL_CSUM;
>>>>
>>>> I think you should use tun->set_features instead of tun->vnet_hdr_sz to
>>>> tell if these features are enabled.
>>>
>>> This is the guest -> host direction. tun->set_features refers to the
>>> opposite one. The problem is that tun is not aware of the features
>>> negotiated in the guest -> host direction.
>>>
>>> The current status (for baremetal/plain offload) is allowing any known
>>> feature the other side send - if the virtio header is consistent.
>>> This code follows a similar schema.
>>>
>>> Note that using 'tun->set_features' instead of 'vnet_hdr_sz' the tunz
>>> driver will drop all the (legit) GSO over UDP packet sent by the guest
>>> when the VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO has been negotiated and
>>> VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO has not.
>>
>> This explanation makes sense. In that case I suggest:
>> - creating a new function named tun_vnet_hdr_tnl_get() and
>> - passing vnet_hdr_sz to tun_vnet_hdr_tnl_to_skb()
>>
>> tun_vnet.h contains the virtio-related logic for better code
>> organization and reuse with tap.c. tap.c can reuse the conditionals on
>> vnet_hdr_sz when tap.c gains the UDP tunneling support.
> 
> Instead of repeating the test twice (in both tun_vnet_hdr_tnl_to_skb()
> and tun_vnet_hdr_tnl_to_skb(), what about creating a new helper:
> 
> tun_vnet_hdr_guest_features(unsigned int vnet_hdr_len)
> 
> encapsulating the above logic? That will make also easier to move to the
> 'correct' solution of having the tun/tap devices aware of the features
> negotiated in the guest -> host direction.

netdev_features_t is not used in the other part of the user-to-skb path 
so we only need the condition "vnet_hdr_sz >= TUN_VNET_TNL_SIZE";
"features = NETIF_F_GSO_UDP_TUNNEL | NETIF_F_GSO_UDP_TUNNEL_CSUM" can be 
simply skipped.

The condition itself is trivial so probably you don't need a helper for it.

For the skb-to-user path, tun_vnet.h already absorbs the reference to 
netdev_feature_t in tun_vnet_hdr_tnl_from_skb() and allows reusing it 
with tap.c, which is a nice example.

Regards,
Akihiko Odaki


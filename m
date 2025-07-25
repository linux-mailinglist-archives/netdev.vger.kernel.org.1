Return-Path: <netdev+bounces-209970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E22B1196C
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 09:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DD0AA45EA
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 07:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBD522DA1F;
	Fri, 25 Jul 2025 07:55:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D8322577C;
	Fri, 25 Jul 2025 07:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753430124; cv=none; b=LkWdn6HM4guROx6NF+CbKOhoR3FnPmlKGJ2z21CcZ8R4vysAQkIWQE14+HT+WDqeMofpmV6TFUBaubDX7/FTdNQ5I4BEpaKXmISBzP4/a3ZPOoe+2JZjbBr/crZOtEsHOi7FTdkCFCZUKED3RwJHU2WbYlSwFagRpVsDqpn3ayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753430124; c=relaxed/simple;
	bh=dkLDUErdQqDtqWWpzqfVlXVVNCgpMZAZKx0UhRIwXEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eggq64CVdGf7nuh+CoWFEfEqnESEcqXGEWBnD/HXJhEIyDXMmEqD2HNzj//BT0Gc80DqBwhKwnvNK/nNLZL/eDRYTeNoJhH8Vfhdcdg3mzAqXpB41/n26jq/I8So/XvGiTShyXl3tC4bkWEKIsm7hcmpCOpD9F/XMMCEKjnrbNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bpKmN3SDzz14M01;
	Fri, 25 Jul 2025 15:50:28 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B0C6180B66;
	Fri, 25 Jul 2025 15:55:19 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 25 Jul 2025 15:55:18 +0800
Message-ID: <bef878c0-4d7f-4e9a-a05d-30f6fde31e3c@huawei.com>
Date: Fri, 25 Jul 2025 15:55:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: check the minimum value of gso size in
 virtio_net_hdr_to_skb()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, <mst@redhat.com>,
	<jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>,
	<pabeni@redhat.com>, <davem@davemloft.net>, <willemb@google.com>,
	<atenart@kernel.org>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <steffen.klassert@secunet.com>
References: <20250724083005.3918375-1-wangliang74@huawei.com>
 <688235273230f_39271d29430@willemb.c.googlers.com.notmuch>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <688235273230f_39271d29430@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/7/24 21:29, Willem de Bruijn 写道:
> Wang Liang wrote:
>> When sending a packet with virtio_net_hdr to tun device, if the gso_type
>> in virtio_net_hdr is SKB_GSO_UDP and the gso_size is less than udphdr
>> size, below crash may happen.
>>
> gso_size is the size of the segment payload, excluding the transport
> header.
>
> This is probably not the right approach.
>
> Not sure how a GSO skb can be built that is shorter than even the
> transport header. Maybe an skb_dump of the GSO skb can be elucidating.
>>   			return -EINVAL;
>>   
>>   		/* Too small packets are not really GSO ones. */
>> -- 
>> 2.34.1
>>

Thanks for your review!

Here is the skb_dump result:

     skb len=4 headroom=98 headlen=4 tailroom=282
     mac=(64,14) mac_len=14 net=(78,20) trans=98
     shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
     csum(0x8c start=140 offset=0 ip_summed=1 complete_sw=0 valid=1 level=0)
     hash(0x0 sw=0 l4=0) proto=0x0800 pkttype=2 iif=4
     priority=0x0 mark=0x0 alloc_cpu=0 vlan_all=0x0
     encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
     dev name=tun0 feat=0x00002000000048c1
     skb headroom: 00000000: 20 00 00 00 10 00 05 00 c4 2c 83 68 00 00 00 00
     skb headroom: 00000010: 00 00 00 00 04 00 00 00 01 00 00 00 01 00 00 00
     skb headroom: 00000020: 08 00 1d 00 09 00 00 00 09 00 03 00 74 75 6e 30
     skb headroom: 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     skb headroom: 00000040: 01 80 c2 00 00 00 ff ff ff ff ff ff 08 00 45 00
     skb headroom: 00000050: 00 18 00 00 20 00 00 11 ba d4 00 00 00 00 e0 00
     skb headroom: 00000060: 00 01
     skb linear:   00000000: 00 9c d0 90
     skb tailroom: 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     skb tailroom: 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     skb tailroom: 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     skb tailroom: 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     skb tailroom: 00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     skb tailroom: 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     skb tailroom: 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     skb tailroom: 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     skb tailroom: 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     skb tailroom: 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     skb tailroom: 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     skb tailroom: 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     skb tailroom: 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     skb tailroom: 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     skb tailroom: 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     skb tailroom: 000000f0: 00 00 00 00 00 00 00 00 00 00 00 0b 0e 04 80 88
     skb tailroom: 00000100: ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     skb tailroom: 00000110: 00 00 00 00 00 00 00 00 00 00

The following C code can reproduce this issue:

     #include <string.h>
     #include <fcntl.h>
     #include <sys/ioctl.h>
     #include <linux/if.h>
     #include <linux/if_tun.h>
     #include <linux/virtio_net.h>
     #include <netinet/ip.h>
     #include <netinet/udp.h>

     int main(void)
     {
         // create udp socket, set option UDP_ENCAP_ESPINUDP
         int udp_fd = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
         struct sockaddr_in server_addr = {
             .sin_family = AF_INET,
             .sin_port = htons(20004),
             .sin_addr.s_addr = inet_addr("224.0.0.1"),
         };
         bind(udp_fd, (struct sockaddr *)&server_addr, sizeof(server_addr));
         int val = UDP_ENCAP_ESPINUDP;
         setsockopt(udp_fd, IPPROTO_UDP, UDP_ENCAP, &val, sizeof(val));

         // send udp packet to tun/tap dev
         system("ip tuntap add dev tun0 mode tap");
         system("ip link set dev tun0 up");
         int fd = open("/dev/net/tun", O_RDWR);
         struct ifreq ifr = {
             .ifr_flags = IFF_TAP | IFF_NAPI | IFF_NAPI_FRAGS | 
IFF_ONE_QUEUE | IFF_VNET_HDR,
             .ifr_name  = "tun0",
         };
         ioctl(fd, TUNSETIFF, &ifr);
         struct tun_pi pi = { 0 };
         struct virtio_net_hdr gso = {
             .flags = VIRTIO_NET_HDR_F_NEEDS_CSUM,
             .gso_type = VIRTIO_NET_HDR_GSO_UDP,
             .hdr_len = 64,
             .gso_size = 4,
             .csum_start = 76,
             .csum_offset = 0,
         };
         struct ethhdr eth = {
             .h_dest   = {0x01, 0x80, 0xc2, 0x00, 0x00, 0x00},
             .h_source = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
             .h_proto  = htons(0x0800),
         };
         struct iphdr iph = {
             .version = 4,
             .ihl = 5,
             .tot_len = htons(176),
             .protocol = IPPROTO_UDP,
             .saddr = 0,
             .daddr = inet_addr("224.0.0.1"),
             .check = 0x3cda,
         };
         struct udphdr uh = {
             .source = 0,
             .dest = htons(20004),
             .len = htons(156),
             .check = 0x2363,
         };
         char buf[204] = { 0 };
         memcpy(buf, &pi, 4);
         memcpy(buf + 4, &gso, 10);
         memcpy(buf + 14, &eth, 14);
         memcpy(buf + 28, &iph, 20);
         memcpy(buf + 48, &uh, 8);
         write(fd, buf, sizeof(buf));
         close(fd);
         return 0;
     }

------
Best regards
Wang Liang

>


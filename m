Return-Path: <netdev+bounces-220068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1D0B445CA
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E4D5A1311
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8908F25A340;
	Thu,  4 Sep 2025 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="vZPR2D2N"
X-Original-To: netdev@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B504F2586C8
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012046; cv=none; b=PIoe12KqP2rOMzSXbK7tRpoinsywarAfdREHpyoxzAeE88pDaSKcZcPNgs7GCE+imNcaxHrb+za0DEPnnH4R4oW+g2vFYftoE3gcyTQsRXQYrce4DHadjHxaJRmiop7BD0BVGsiQ4wpUxfgrSmkZQKRxVBGOf/CiOw5qEZYa4OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012046; c=relaxed/simple;
	bh=/+TxCId6Qc+S9WBxBAOnD/dGe/EmWoIS8g9KP8hpmpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iaf+wqXZvOPS20S+e+Zxa7AeweqMt+80eNg7b7BZ38YWxDVcfKw96ZSFPnVFnwawBAHdh7TgEKFNFqszur0NZt5uEWMBIPr1jOc7KplvxaV/jdU5V+yR7eqnDUolSaKPr1wrYAMHifEOIeGza/fPo2S3fXB6tmyvu+EvySQztLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=vZPR2D2N; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5006b.ext.cloudfilter.net ([10.0.29.217])
	by cmsmtp with ESMTPS
	id uDslu7aofKXDJuF5puFKsu; Thu, 04 Sep 2025 18:53:57 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id uF5nuwvw2cL7DuF5ouIIwR; Thu, 04 Sep 2025 18:53:56 +0000
X-Authority-Analysis: v=2.4 cv=Xqb6OUF9 c=1 sm=1 tr=0 ts=68b9e044
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=XW3vq5T86JFyMsJaYQInbg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=OEGTK3V8_EHZPOkUKuUA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=l4b5xHsdLB1Ea4PM9V69zCzRZeNs/fQSbYqHkj2rS6k=; b=vZPR2D2NpGkKs/9NBrtXncsQoq
	JX6Cj70CgtFwv1zJw1FMk81Dn6BdVTktQSEeHKEUuOP8ySrlBk3T8omuWqbVpF/n/NrgKfvj9KndE
	O+hbqiM7q/lcIjc7lWZr0RBz+dl9XCeKeOklCkW1ua8LbKNWop71GAf+sQ4+2NxgmfHCEjVdLxhQ4
	vYgCGDXIZrim04V46gXypdACPTCZA3YclOK7H5HDMU3V7yZrc412gHwLoAOsilQ3Pr3n6oj7PnW5x
	YRvbwNnQJ7I9BYt9tYDKCbD0zc7HiXl0kgKR1sdH7ANZyPgMNJPqvnoOI7X5PToJrl2PAr15m38ok
	1M515mdQ==;
Received: from d4b26982.static.ziggozakelijk.nl ([212.178.105.130]:53694 helo=[10.52.79.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uuF5k-00000002QRs-1vlo;
	Thu, 04 Sep 2025 13:53:53 -0500
Message-ID: <cac19beb-eefb-4a6a-9eec-b414199ce339@embeddedor.com>
Date: Thu, 4 Sep 2025 20:53:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] virtio_net: Fix alignment and avoid
 -Wflex-array-member-not-at-end warning
To: Simon Horman <horms@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aLiYrQGdGmaDTtLF@kspp> <20250904091315.GB372207@horms.kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250904091315.GB372207@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 212.178.105.130
X-Source-L: No
X-Exim-ID: 1uuF5k-00000002QRs-1vlo
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: d4b26982.static.ziggozakelijk.nl ([10.52.79.44]) [212.178.105.130]:53694
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfH91JM4wfdjvkUWHNQ4d6emz6n5Oz/LwAf2rKkqmw+NFj/aNcjgfP7IvokP+/8+91iyRIl3PL4mpuHqucxj4i9y+qbEPWR2xO8TfpF5Y7O+CGFbUjJWQ
 nXRe9A3KhaT+3XyEAeV3KoIRzwu3RHQjlYnh0SsCg7mKhrpEcwOiNpITMBGotRPE8QttHXG9KtQx5xPosuMmgs5xixyy1qClgFk=



On 9/4/25 11:13, Simon Horman wrote:
> On Wed, Sep 03, 2025 at 09:36:13PM +0200, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Use the new TRAILING_OVERLAP() helper to fix the following warning:
>>
>> drivers/net/virtio_net.c:429:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> This helper creates a union between a flexible-array member (FAM)
>> and a set of members that would otherwise follow it (in this case
>> `u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
>> overlays the trailing members (rss_hash_key_data) onto the FAM
>> (hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
>> The static_assert() ensures this alignment remains, and it's
>> intentionally placed inmediately after `struct virtnet_info` (no
>> blank line in between).
>>
>> Notice that due to tail padding in flexible `struct
>> virtio_net_rss_config_trailer`, `rss_trailer.hash_key_data`
>> (at offset 83 in struct virtnet_info) and `rss_hash_key_data` (at
>> offset 84 in struct virtnet_info) are misaligned by one byte. See
>> below:
>>
>> struct virtio_net_rss_config_trailer {
>>          __le16                     max_tx_vq;            /*     0     2 */
>>          __u8                       hash_key_length;      /*     2     1 */
>>          __u8                       hash_key_data[];      /*     3     0 */
>>
>>          /* size: 4, cachelines: 1, members: 3 */
>>          /* padding: 1 */
>>          /* last cacheline: 4 bytes */
>> };
>>
>> struct virtnet_info {
>> ...
>>          struct virtio_net_rss_config_trailer rss_trailer; /*    80     4 */
>>
>>          /* XXX last struct has 1 byte of padding */
>>
>>          u8                         rss_hash_key_data[40]; /*    84    40 */
>> ...
>>          /* size: 832, cachelines: 13, members: 48 */
>>          /* sum members: 801, holes: 8, sum holes: 31 */
>>          /* paddings: 2, sum paddings: 5 */
>> };
>>
>> After changes, those members are correctly aligned at offset 795:
>>
>> struct virtnet_info {
>> ...
>>          union {
>>                  struct virtio_net_rss_config_trailer rss_trailer; /*   792     4 */
>>                  struct {
>>                          unsigned char __offset_to_hash_key_data[3]; /*   792     3 */
>>                          u8         rss_hash_key_data[40]; /*   795    40 */
>>                  };                                       /*   792    43 */
>>          };                                               /*   792    44 */
>> ...
>>          /* size: 840, cachelines: 14, members: 47 */
>>          /* sum members: 801, holes: 8, sum holes: 35 */
>>          /* padding: 4 */
>>          /* paddings: 1, sum paddings: 4 */
>>          /* last cacheline: 8 bytes */
>> };
>>
>> As a last note `struct virtio_net_rss_config_hdr *rss_hdr;` is also
>> moved to the end, since it seems those three members should stick
>> around together. :)
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>
>> This should probably include the following tag:
>>
>> 	Fixes: ed3100e90d0d ("virtio_net: Use new RSS config structs")
>>
>> but I'd like to hear some feedback, first.
> 
> I tend to agree given that:
> 
> On the one hand:
> 
> 1) in virtnet_init_default_rss(), netdev_rss_key_fill() is used
>     to write random data to .rss_hash_key_data
> 
> 2) In virtnet_set_rxfh() key data written to .rss_hash_key_data
> 
> While
> 
> 3) In virtnet_commit_rss_command() virtio_net_rss_config_trailer,
>     including the contents of .hash_key_data based on the length of
>     that data provided in .hash_key_length is copied.
> 
> It seems to me that step 3 will include 1 byte of uninitialised data
> at the start of .hash_key_data. And, correspondingly, truncate
> .rss_hash_key_data by one byte.
> 
> It's unclear to me what the effect of this - perhaps they key works
> regardless. But it doesn't seem intended. And while the result may be
> neutral, I do  suspect this reduces the quality of the key. And I more
> strongly suspect it doesn't have any positive outcome.
> 
> So I would lean towards playing it safe and considering this as a bug.
> 
> Of course, other's may have better insight as to the actual effect of this.

Yeah, in the meantime I'll prepare v2 with both the 'Fixes' and 'stable'
tags.

Thanks for the feedback!
-Gustavo





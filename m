Return-Path: <netdev+bounces-270624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YM36J+V6wWkQTQQAu9opvQ
	(envelope-from <netdev+bounces-270624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:39:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9DC2FA237
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C303C30F322C
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F643C5DD0;
	Mon, 23 Mar 2026 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sePzIDaY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2849D3BF684;
	Mon, 23 Mar 2026 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285855; cv=none; b=f91rUStCAPlgytH1BUMT5etaqyhVQeHy1FhZOcncZvo6Y/rYA+1ldlOnY/vbNnzhpEayvR4+8CAX+21rKotKwhDWMPDv3du7ZKP1PKZecXLzLOy+dEjQ6rfrP6vJl2/7MNjaFFQG2pP0ZqnAnKT2IqwLFU5czfPQBsqfGc5U4fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285855; c=relaxed/simple;
	bh=8ZyEzQ/n1XLBuoS3HQbvgUedqGfJIKNbqNvtnMerTeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8MO+LPll1WNhzIzvFUByw2WtOhyba/pXR3F00hoe9s/PnNips/YlOqIfu2Qr4OTAQZBkuOAn5sw+aEQbFGfL85ZJkLCpHGsdIo/TmX6bINf4FGXBPSgOSHR3e6oU8fkFJjyAAHlphvqSMmZNRYy4bmA2KBJJpgvCzQoFsnBF7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sePzIDaY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NA3FRR3303794;
	Mon, 23 Mar 2026 17:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sGIQpd
	+0YQByhqpmpHdMT9aXFS/OuI+DGHkCJzu/Bik=; b=sePzIDaYo34+7pPXAq4MVA
	9Q3oUM7hYNvvLLfPyvoK+omAUYJPQ5GOWvsHhImc9liStqe361UjkUAxmSJN3yvY
	9Chj912d4AoO+YiL/MC0z+R+K4IkrNWTE9MnqiTUa0C1lvlGJz/FwzRwH7O1UsKA
	azXsEAIucfsbGIiiKMvFd/CvyxrqcF1kLuHfXgi9y637wawq+LERw7J5EkSMSeN1
	Nl06rjGOv9AM/uXusyFGc+kw69jOL1b6yzJt/VzjR+SDp+df5CE8DMikZ68rpNgh
	i9vhY1d8CEOOuGudaZeoqdLFZsx4BrRrFGk07RvLvJ+GlU5CbLK6PPHKL1zpNnPw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumfmss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 17:09:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NDUfH7004392;
	Mon, 23 Mar 2026 17:09:21 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c1x0cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 17:09:21 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NH9KgL29950574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 17:09:20 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AB9C5805E;
	Mon, 23 Mar 2026 17:09:20 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC21858051;
	Mon, 23 Mar 2026 17:09:18 +0000 (GMT)
Received: from [9.61.247.188] (unknown [9.61.247.188])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 23 Mar 2026 17:09:18 +0000 (GMT)
Message-ID: <6b6bea74-4bff-4301-8dbf-a9c162456185@linux.ibm.com>
Date: Mon, 23 Mar 2026 13:09:18 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for buffer
 allocation
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: vishs@meta.com, andrew+netdev@lunn.ch, davem@davemloft.net, dw@davidwei.uk,
        edumazet@google.com, eperezma@redhat.com, ilias.apalodimas@linaro.org,
        jasowang@redhat.com, kernel-team@meta.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, technoboy85@gmail.com,
        virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
References: <20260310183107.2822016-1-vishs@meta.com>
 <20260323150136.14452-1-oelghoul@linux.ibm.com>
 <20260323114313-mutt-send-email-mst@kernel.org>
 <20260323122728-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <20260323122728-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: vl1sPc5niOoy2yc9PGPa18ivm6OcCHz4
X-Proofpoint-ORIG-GUID: G_hNhiuqJ4fKe83POMP5eM4XYkQNQSPn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEyNSBTYWx0ZWRfX3woWb0X0kSzo
 OyjqkBqylKbGu/47T5mQWFhvRmgEtNVXmGVyP5vXc0yHih3OSfzpGt3+gu0fDPmfHArbnEKr3Ot
 VH6lE4AtXalGzbqzrx9JEndjAAffA1ipq3h8lArliLCUHVxV10bRCVVuKuaxKS9Mt/mbQhCIhUz
 +80dyvI0B03M+NDiSXt3Ew9KgZHjH/JJUikKt4BExrUH8aD78g74SEpAk8hYJUPcu0nKFGbRVgO
 PqnN6F9l0I5Y+UQB5HI71n4YOmil18jVZQZqPCBHq7ldy6+vIQqqQoKQ3j+zpN1V/P4KbrucIJV
 tg6UzLzRdl4SiLW7FA0Pesu3e4DWMJ46hD2eRLHkH6hn5hN4L/244dJEnFU3J7D20c6S00jeP4G
 178cmGX+BfxRrhwB+8XbEHuhHl/E8WQGQU/t7D4g6zrPgFA4xyP/HPXzUCpe6s8IKYeV+W7vkRn
 KbUD31K82uVWHujT6Gw==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c173c2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=8t8qfG4fJsVaZRtajm4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230125
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270624-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[meta.com,lunn.ch,davemloft.net,davidwei.uk,google.com,redhat.com,linaro.org,kernel.org,vger.kernel.org,gmail.com,lists.linux.dev,linux.alibaba.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oelghoul@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 3B9DC2FA237
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 12:58 PM, Michael S. Tsirkin wrote:

> On Mon, Mar 23, 2026 at 11:52:34AM -0400, Michael S. Tsirkin wrote:
>> On Mon, Mar 23, 2026 at 11:01:31AM -0400, Omar Elghoul wrote:
>>> [...]
>> Well... I am not sure how I missed it. Obvious in hindsight:
>>
>> static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>                          void *buf, unsigned int len, void **ctx,
>>                          unsigned int *xdp_xmit,
>>                          struct virtnet_rq_stats *stats)
>> {
>>          struct net_device *dev = vi->dev;
>>          struct sk_buff *skb;
>>          u8 flags;
>>                  
>>          if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>>                  pr_debug("%s: short packet %i\n", dev->name, len);
>>                  DEV_STATS_INC(dev, rx_length_errors);
>>                  virtnet_rq_free_buf(vi, rq, buf);
>>                  return;
>>          }
>>          
>>          /* About the flags below:
>>           * 1. Save the flags early, as the XDP program might overwrite them.
>>           * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID
>>           * stay valid after XDP processing.
>>           * 2. XDP doesn't work with partially checksummed packets (refer to
>>           * virtnet_xdp_set()), so packets marked as
>>           * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP processing.
>>           */
>>                  
>>          if (vi->mergeable_rx_bufs) {
>>                  flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
>>                  skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
>>                                          stats);
>>          } else if (vi->big_packets) {
>>                  void *p = page_address((struct page *)buf);
>>                  
>>                  flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
>>                  skb = receive_big(dev, vi, rq, buf, len, stats);
>>          } else {
>>                  flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
>>                  skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
>>          }
>>
>>
>> So we are reading the header, before dma sync, which is within
>> receive_mergeable and friends:
>>
>> static struct sk_buff *receive_mergeable(struct net_device *dev,
>>                                           struct virtnet_info *vi,
>>                                           struct receive_queue *rq,
>>                                           void *buf,
>>                                           void *ctx,
>>                                           unsigned int len,
>>                                           unsigned int *xdp_xmit,
>>                                           struct virtnet_rq_stats *stats)
>> {
>>          struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
>>          int num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
>>          struct page *page = virt_to_head_page(buf);
>>          int offset = buf - page_address(page);
>>          struct sk_buff *head_skb, *curr_skb;
>>          unsigned int truesize = mergeable_ctx_to_truesize(ctx);
>>          unsigned int headroom = mergeable_ctx_to_headroom(ctx);
>>                  
>>          head_skb = NULL;
>>                  
>>          if (rq->use_page_pool_dma)
>>                  page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
>>                  
>>
>>
>> Just as a test, the below should fix it (compiled only), but the real
>> fix is more complex since we need to be careful to avoid expensive syncing
>> twice.
>>
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 97035b49bae7..57b4f5954bed 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -931,9 +931,19 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>   
>>   static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
>>   {
>> +	void *buf;
>> +
>>   	BUG_ON(!rq->page_pool);
>>   
>> -	return virtqueue_get_buf_ctx(rq->vq, len, ctx);
>> +	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
>> +	if (buf && rq->use_page_pool_dma && *len) {
>> +		struct page *page = virt_to_head_page(buf);
>> +		int offset = buf - page_address(page);
>> +
>> +		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, *len);
>> +	}
>> +
>> +	return buf;
>>   }
>>   
>>   static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>>
>>
>>
>>
>> -- 
>> MST
> or maybe like this:
Both of these patches resolve the issue on my end.
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 97035b49bae7..835f52651006 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1956,13 +1956,6 @@ static struct sk_buff *receive_small(struct net_device *dev,
>   	 */
>   	buf -= VIRTNET_RX_PAD + xdp_headroom;
>   
> -	if (rq->use_page_pool_dma) {
> -		int offset = buf - page_address(page) +
> -			     VIRTNET_RX_PAD + xdp_headroom;
> -
> -		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
> -	}
> -
>   	len -= vi->hdr_len;
>   	u64_stats_add(&stats->bytes, len);
>   
> @@ -2398,9 +2391,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>   
>   	head_skb = NULL;
>   
> -	if (rq->use_page_pool_dma)
> -		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
> -
>   	u64_stats_add(&stats->bytes, len - vi->hdr_len);
>   
>   	if (check_mergeable_len(dev, ctx, len))
> @@ -2563,6 +2553,13 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>   		return;
>   	}
>   
> +	if (rq->use_page_pool_dma) {
> +		struct page *page = virt_to_head_page(buf);
> +		int offset = buf - page_address(page);
> +
> +		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
> +	}
> +
>   	/* About the flags below:
>   	 * 1. Save the flags early, as the XDP program might overwrite them.
>   	 * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID
>


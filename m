Return-Path: <netdev+bounces-270617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKlEOPp1wWkQTQQAu9opvQ
	(envelope-from <netdev+bounces-270617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:18:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB822F9B85
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B19930973AF
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38723BF682;
	Mon, 23 Mar 2026 16:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U2aDbEUv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06381A3029;
	Mon, 23 Mar 2026 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284938; cv=none; b=Np9skH7IDiXnP7uYg52huTw172BChYiiDCNx88qxEgAXtiJrUJjPRM8dImG9iqm7lf/P1u5r5pEWqYbWryVRp+bYeoXtqXA1UWboYZhDiAmzRDj2XBhMKWvN45jddtjPeyPGGlH6RTy70UuWX3PE27HOKsZnf3LZIowCr6vtCJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284938; c=relaxed/simple;
	bh=B6l0kh39O9yLQYeypAEf4hibEOjQg7qDRhpBfi4ccFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UD2JDiKupByg45xu3bo4enPCgKHS1H1TdCVyDrs6MARtQ9bMOGHiOHmO1deWcHHdeI1sozsH/Lb0udVOs+/uRWqcWcJkQpdTpaj8Y5gGWh4PQ3DtZewcErlQ6pHuezh7HLqofTLHDeZIb7f/6S+aV978wYAEUMobM1e/bLsW+p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U2aDbEUv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NBxGMA3835046;
	Mon, 23 Mar 2026 16:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=27cANW
	RTfgqaXiP8gRd4PwTEU9pTJUqVC48fwjcISl8=; b=U2aDbEUvNjvYWm9quIU5eX
	Z6OkizI2HDVheM20skeg1y9/YM8EfI2OVhXywwYgSvfaUjMGdLTkAknOUAkfv//P
	FX5vj1l4BEXTh6ZpXa0bb7rvX9OSkDbNPOyMB5jWr1vairtYmWdzjELBEUplWmPE
	NAlMNp003iW3sicrOPGrE2CJlyla3EVZv6U6GSNHUlDIo/ZQWW5uNA1mpiwFf4OI
	HuxWXBOsqOua09VF/QaCyf3COmAQCFXKdpMSyefjVObV6fFjVehGHM0Jkma5tVnA
	5i/lC/wDf9FTP4OTPrOP6fei53B93b1KYpOp+ZOF06bfBxlfsy5ALdsn/yHzqmyw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktuqj34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 16:54:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NCgHAK026797;
	Mon, 23 Mar 2026 16:54:06 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275kp427-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 16:54:06 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NGs5Lc19989184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 16:54:06 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFB4D58051;
	Mon, 23 Mar 2026 16:54:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BF785805F;
	Mon, 23 Mar 2026 16:54:04 +0000 (GMT)
Received: from [9.61.247.188] (unknown [9.61.247.188])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 23 Mar 2026 16:54:04 +0000 (GMT)
Message-ID: <8e0a5562-4511-41df-9993-a77e51025e95@linux.ibm.com>
Date: Mon, 23 Mar 2026 12:54:03 -0400
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
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <20260323114313-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: jC1cegtA_skgwjP0ZQ_5d_FQq9Fi1ifB
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c1702f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=YViDtvoEOCPqYsW2n6MA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEyNSBTYWx0ZWRfX/eUOA8fELL3m
 Sv4GjZEC9rY0KavYq9fLlYeoxMlN/xFUJfh01SeBWCg6Cg/f1PkIdeRlfLGNGuKlonBmztbgcy+
 v1JBo5BjPoqiai3kRgmtJlr9dVO24rY1wnTfy4aoa2SYqE7GdXwQqRo4CxZJlUOLsZL6eg0zZq/
 oBhDYE0UOETFfnDCv8ltM64vQUp5sqcRUFVe0AsQI2PHjVZ/TxYMjRmFz03LVEhuCXvjYxA2mQ4
 P8DHPCdOZNaTozIrUIiRwbbe5DHj0KM4K4bmx7DfyClRodLfa0CjuEryQS9KBocXIYFXJTKfTzF
 72L3uQ8KW+HGiUsAhhaCpO2iErTffjkTLv3soA0IPGNInjZ5pavBJAwsN4uBEjd/0uKIrvieGs8
 0n+b5L0kbhIlOa6YcYe6CGonhsUSqMXbXRfTwndObONgiqJlaXZ037cTozW5wjT/UVASPfYIxPm
 vz8ns5aVlr5IB+rKbMA==
X-Proofpoint-GUID: 8_wUtNM7PdHPKzpZjWDg0Mt7OFV0rqP8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230125
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[meta.com,lunn.ch,davemloft.net,davidwei.uk,google.com,redhat.com,linaro.org,kernel.org,vger.kernel.org,gmail.com,lists.linux.dev,linux.alibaba.com];
	TAGGED_FROM(0.00)[bounces-270617-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oelghoul@linux.ibm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 8AB822F9B85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 11:52 AM, Michael S. Tsirkin wrote:
> On Mon, Mar 23, 2026 at 11:01:31AM -0400, Omar Elghoul wrote:
>> [...]
> Well... I am not sure how I missed it. Obvious in hindsight:
>
> static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>                          void *buf, unsigned int len, void **ctx,
>                          unsigned int *xdp_xmit,
>                          struct virtnet_rq_stats *stats)
> {
>          struct net_device *dev = vi->dev;
>          struct sk_buff *skb;
>          u8 flags;
>                  
>          if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>                  pr_debug("%s: short packet %i\n", dev->name, len);
>                  DEV_STATS_INC(dev, rx_length_errors);
>                  virtnet_rq_free_buf(vi, rq, buf);
>                  return;
>          }
>          
>          /* About the flags below:
>           * 1. Save the flags early, as the XDP program might overwrite them.
>           * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID
>           * stay valid after XDP processing.
>           * 2. XDP doesn't work with partially checksummed packets (refer to
>           * virtnet_xdp_set()), so packets marked as
>           * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP processing.
>           */
>                  
>          if (vi->mergeable_rx_bufs) {
>                  flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
>                  skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
>                                          stats);
>          } else if (vi->big_packets) {
>                  void *p = page_address((struct page *)buf);
>                  
>                  flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
>                  skb = receive_big(dev, vi, rq, buf, len, stats);
>          } else {
>                  flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
>                  skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
>          }
>
>
> So we are reading the header, before dma sync, which is within
> receive_mergeable and friends:
Thank you for your analysis and explanation.
>
> static struct sk_buff *receive_mergeable(struct net_device *dev,
>                                           struct virtnet_info *vi,
>                                           struct receive_queue *rq,
>                                           void *buf,
>                                           void *ctx,
>                                           unsigned int len,
>                                           unsigned int *xdp_xmit,
>                                           struct virtnet_rq_stats *stats)
> {
>          struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
>          int num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
>          struct page *page = virt_to_head_page(buf);
>          int offset = buf - page_address(page);
>          struct sk_buff *head_skb, *curr_skb;
>          unsigned int truesize = mergeable_ctx_to_truesize(ctx);
>          unsigned int headroom = mergeable_ctx_to_headroom(ctx);
>                  
>          head_skb = NULL;
>                  
>          if (rq->use_page_pool_dma)
>                  page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
>                  
>
>
> Just as a test, the below should fix it (compiled only), but the real
> fix is more complex since we need to be careful to avoid expensive syncing
> twice.

I applied your patch and tested it on my system. With this change, I 
could not reproduce the same error anymore. I would be happy to test a 
proper fix once you have one.

>
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 97035b49bae7..57b4f5954bed 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -931,9 +931,19 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>   
>   static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
>   {
> +	void *buf;
> +
>   	BUG_ON(!rq->page_pool);
>   
> -	return virtqueue_get_buf_ctx(rq->vq, len, ctx);
> +	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> +	if (buf && rq->use_page_pool_dma && *len) {
> +		struct page *page = virt_to_head_page(buf);
> +		int offset = buf - page_address(page);
> +
> +		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, *len);
> +	}
> +
> +	return buf;
>   }
>   
>   static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>
>
>
>


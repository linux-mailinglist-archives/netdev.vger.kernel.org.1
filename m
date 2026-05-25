Return-Path: <netdev+bounces-291296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAtQHR0yFGqUKgcAu9opvQ
	(envelope-from <netdev+bounces-291296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:27:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8595C9F07
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0871A300616E
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EFC37DE80;
	Mon, 25 May 2026 11:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="R7NbcLOk"
X-Original-To: netdev@vger.kernel.org
Received: from mx4.sberdevices.ru (mx4.sberdevices.ru [152.89.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F713603C2;
	Mon, 25 May 2026 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.89.196.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779708380; cv=none; b=Nman0wKi2WbzBLjMmJnUtZKElieaC1tnqHI7206gqKlpSNmGHLSYOsHl3qhgIOb+E2WgBuP+ZUD8tYZqwS6XFIfWKitcsoN39pYKoUNsqsjMZ9DrWmu1seQR1g4aRRRyARTyzRfEor5MnP41Aye+bjQ3eAhy38gWPHzn6UIFpG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779708380; c=relaxed/simple;
	bh=+7lrnusKGJys61jus0yfPMx3RY0wCJsrZ4PSZBrHzzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oY9VX0w7c8P6dGqU1cNRBmOy8RXM+9R5qMFYTQzJmoDmBP1OZuGJLSY7O3BrKcm8AK7DyFRwk8MtITSoU3r56CqunsLZteGJ23KQ1RC/RvJ3w7Cw6iYsNwXGsqRx2KP+gnb6pBWHj6+CetKBI9x4zc0TRPpkZrzgXN6o6WkWPx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=R7NbcLOk; arc=none smtp.client-ip=152.89.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-antispam-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx4.sberdevices.ru (Postfix) with ESMTP id 820E940007;
	Mon, 25 May 2026 14:25:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx4.sberdevices.ru 820E940007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1779708327;
	bh=6G03KsF8U9FZPAjusQcm8JvvbLhsu4jxVRnCewWEwkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=R7NbcLOkliJzA0Qobaf4sDvGiqUSoJxFwSdqhhkje39fBUphzZV50jqgC1MGxcQnj
	 j4sIyqzg173C7IUcBiFu/btuJr7jNF7SIF/ab892iRLhFt9ZPFlm1Trd/cB4sAXiYC
	 qeBLeubv1/JaOSdkNC/XFlC4FIJjB+79i4FMeXF+ldwByLQur/5qzGFk9WgTQI2n7u
	 U/7AE70UDuccalQfzkC2EZ2hovY/DephrArFzy90TH4nTKQYb4SqW9YXDNhtv3Lfk7
	 n4jHlFfw9ACV+92un1pIK47uQ6JPDJyfwwctxvaQq00P94JAr0vlRr7XJnRki5dLbO
	 4UcauBB/J63pQ==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R12" (not verified))
	by mx4.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 25 May 2026 14:25:24 +0300 (MSK)
Message-ID: <fb071f63-2ba8-4cb8-bf18-331fa078653f@salutedevices.com>
Date: Mon, 25 May 2026 14:25:19 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vsock/virtio: bind uarg before filling zerocopy skb
To: "malin (R)" <malin89@huawei.com>, tanjingguo <tanjingguo@huawei.com>,
	"mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>, "sgarzare@redhat.com"
	<sgarzare@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>
CC: Chenzhe <chenzhe@huawei.com>, cenxianlong <cenxianlong@huawei.com>,
	cuirongzhen <cuirongzhen@huawei.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <9fece5ea269049f883f367642c07eaa0@huawei.com>
Content-Language: ru
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <9fece5ea269049f883f367642c07eaa0@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-exch-cas-s-m1.sberdevices.ru (172.16.210.2) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 105 0.3.105 c7fb587251b1312ef0d9243823bef7335f8fcbef, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 203399 [May 25 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/05/25 06:10:00 #28194981
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[salutedevices.com,quarantine];
	R_DKIM_ALLOW(-0.20)[salutedevices.com:s=post];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[salutedevices.com:+];
	TAGGED_FROM(0.00)[bounces-291296-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@salutedevices.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,salutedevices.com:email,salutedevices.com:mid,salutedevices.com:dkim]
X-Rspamd-Queue-Id: DA8595C9F07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 25/05/2026 14:15, malin (R) wrote:
> From 9eea4f61a4dca97f56c23e12267219bf791a20d1 Mon Sep 17 00:00:00 2001
> From: Jingguo Tan <tanjingguo@huawei.com>
> Date: Fri, 22 May 2026 19:53:45 +0800
> Subject: [PATCH net] vsock/virtio: bind uarg before filling zerocopy skb
> 
> virtio_transport_send_pkt_info() allocates or reuses the zerocopy uarg
> before entering the send loop, but virtio_transport_alloc_skb() still
> fills the skb before it inherits that uarg. When fixed-buffer vectored
> zerocopy hits MAX_SKB_FRAGS, io_sg_from_iter() may partially attach
> managed frags and return -EMSGSIZE. The rollback path calls kfree_skb()
> to free an skb that carries SKBFL_MANAGED_FRAG_REFS but no uarg, so
> skb_release_data() falls through to ordinary frag unref.
> 
> Pass the uarg into virtio_transport_alloc_skb() and bind it immediately
> before virtio_transport_fill_skb(). This keeps control or no-payload skbs
> untouched while ensuring success and rollback share one lifetime rule.
> 
> Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
> Signed-off-by: Lin Ma <malin89@huawei.com>
> Signed-off-by: Rongzhen Cui <cuirongzhen@huawei.com>
> Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>

Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>

> ---
> 
>  net/vmw_vsock/virtio_transport_common.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index df3b418e0392..73f58925ff72 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -205,6 +205,7 @@ static u16 virtio_transport_get_type(struct sock *sk)
>  static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
>  						  size_t payload_len,
>  						  bool zcopy,
> +						  struct ubuf_info *uarg,
>  						  u32 src_cid,
>  						  u32 src_port,
>  						  u32 dst_cid,
> @@ -245,6 +246,11 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
>  	if (info->msg && payload_len > 0) {
>  		int err;
>  
> +		/* Bind the zerocopy lifetime before filling frags so error rollback
> +		 * frees managed fixed-buffer pages through the uarg-aware path.
> +		 */
> +		skb_zcopy_set(skb, uarg, NULL);
> +
>  		err = virtio_transport_fill_skb(skb, info, payload_len, zcopy);
>  		if (err)
>  			goto out;
> @@ -364,6 +370,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  		skb_len = min(max_skb_len, rest_len);
>  
>  		skb = virtio_transport_alloc_skb(info, skb_len, can_zcopy,
> +						 uarg,
>  						 src_cid, src_port,
>  						 dst_cid, dst_port);
>  		if (!skb) {
> @@ -371,8 +378,6 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  			break;
>  		}
>  
> -		skb_zcopy_set(skb, uarg, NULL);
> -
>  		virtio_transport_inc_tx_pkt(vvs, skb);
>  
>  		ret = t_ops->send_pkt(skb, info->net);
> @@ -1183,7 +1188,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
>  	if (!t)
>  		return -ENOTCONN;
>  
> -	reply = virtio_transport_alloc_skb(&info, 0, false,
> +	reply = virtio_transport_alloc_skb(&info, 0, false, NULL,
>  					   le64_to_cpu(hdr->dst_cid),
>  					   le32_to_cpu(hdr->dst_port),
>  					   le64_to_cpu(hdr->src_cid),



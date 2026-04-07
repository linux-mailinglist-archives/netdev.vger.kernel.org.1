Return-Path: <netdev+bounces-276150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDK9KUZi1Wk85gcAu9opvQ
	(envelope-from <netdev+bounces-276150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 22:00:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA043B4276
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 22:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5AD63003805
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 19:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15C533F38B;
	Tue,  7 Apr 2026 19:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ovYykCZu"
X-Original-To: netdev@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A4C126C17
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775591930; cv=none; b=BYtPrzVVVjBkYX5ZvEfTy1KPjEj7T2gQhVBewJQ5SwX+ZgUVV7LIgDZEGm+nHTkbhrfiC26s5rAGOB+6tR9MfQ2hgX1ByNweZcHXXjO7P/KvKOIEfkc+SZd3RHd0X9rLcpMRu7nAAXmunKH8djqeo2caWH0JpxInG3Qs/gvmJGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775591930; c=relaxed/simple;
	bh=Z6velnEz/B2uUTLmaqxbse9s2ja6/VD05qH9aqa+eGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EIbnMuzL2F6bgNEUZQnepBCgMsfMGia2YE0Ay5xIQYvvQ6v7M8pjkcsr9Hk7T7eRFoORrIsCvtMpzBCO88ic5Z/Tvnj3xC5jmvXgWbcmmoylypox6F57NfB5o4AhNL+Ei1W08Tqwgdkt5nADH4PWoVX4vwuk61h1JUoxNvqSOso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=ovYykCZu; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id A62Hw7gR14RkpACZNwMwVo; Tue, 07 Apr 2026 19:58:41 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id ACZMwMjGK36heACZNwMgAO; Tue, 07 Apr 2026 19:58:41 +0000
X-Authority-Analysis: v=2.4 cv=PN8P+eqC c=1 sm=1 tr=0 ts=69d561f1
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=chC0KcwHAXg1M6QkddG+Hg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=e9iTn1YT0ADnaAsSjdMA:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ftx1xvaens4tD60bx30l+0J5ZoIN5FuIm41gSlSbF7M=; b=ovYykCZudC5eWXWUoETHRq3Jh+
	9h56ItZnoxviFExq4NOVyR276Jy4LzgQ8yDpWw0QMvZKS2k31LYVaP0SwudkrsM0olfV7q3y8VXv3
	AT2zbKvPvCU34hE9GVynQ6Nzo1bUYnlGPC9cz+ZS9ULbR61xxg/kU2va4eok8lprH+ctJ8vEIOE+j
	bmz37MuAqP0j3WBFPlPHXTIVA4aio1+SgPfVFfAGfN8CSB3sbul6eK3kJggYOS9DeCIbaNUbErmMj
	rCsn8lMZBwWyCrfZl8lVrrpgyjhtyByKRvYCk7s01EABm74swPB6QWZBwFkdHSwYh54xgZLxOGAZ6
	bQWz3S3w==;
Received: from [177.238.18.219] (port=37324 helo=[192.168.0.36])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1wACZL-00000003Nk6-0Fqb;
	Tue, 07 Apr 2026 14:58:39 -0500
Message-ID: <d04e11af-5c1b-44a2-aebc-a0ee4fb79802@embeddedor.com>
Date: Tue, 7 Apr 2026 13:57:00 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] Bluetooth: hci.h: Avoid a couple
 -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aZ1FrL8qvvKuktBF@kspp>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <aZ1FrL8qvvKuktBF@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.18.219
X-Source-L: No
X-Exim-ID: 1wACZL-00000003Nk6-0Fqb
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.36]) [177.238.18.219]:37324
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLNYe7hf7MtB1h2Z9rADpohw7k1P2FEC9gR3FzcPuTaIq8mEVMRqPHxFZsrFYts+pcZgu/nLzil4WAnqyo26cC0jz78R0LWE2yXG8/3xnXzc4iljEIx0
 YME9/lILVGKQlstZeftMnbJSh+FLAkB9P2A3Y+vOypz4MTwjCqtl6tFQ/c8y3CbOIyqZJsowMO34QdYcw6P83oLvIvryw+gW0Is=
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[embeddedor.com:s=default];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276150-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[embeddedor.com];
	FREEMAIL_TO(0.00)[kernel.org,holtmann.org,gmail.com,davemloft.net,google.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_SOURCE(0.00)[];
	HAS_X_ANTIABUSE(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gustavo@embeddedor.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[embeddedor.com:-];
	NEURAL_HAM(-0.00)[-0.500];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,embeddedor.com:mid]
X-Rspamd-Queue-Id: CFA043B4276
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

Friendly ping: who can take this, please?

Thanks
-Gustavo

On 2/24/26 00:31, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> struct hci_std_codecs and struct hci_std_codecs_v2 are flexible
> structures, this is structures that contain a flexible-array member
> (__u8 codec[]; and struct hci_std_codec_v2 codec[];, correspondingly.)
> 
> Since struct hci_rp_read_local_supported_codecs and struct
> hci_rp_read_local_supported_codecs_v2 are defined by hardware, we
> create the new struct hci_std_codecs_hdr and struct hci_std_codecs_v2_hdr
> types, and use them to replace the object types causing trouble in
> struct hci_rp_read_local_supported_codecs and struct
> hci_rp_read_local_supported_codecs_v2, namely struct hci_std_codecs
> std_codecs; and struct hci_std_codecs_v2_hdr std_codecs;.
> 
> Also, once -fms-extensions is enabled, we can use transparent struct
> members in both struct hci_std_codecs and struct hci_std_codecs_v2_hdr.
> 
> Notice that the newly created types does not contain the flex-array
> member `codec`, which is the object causing the -Wfamnae warnings.
> 
> After these changes, the size of struct hci_rp_read_local_supported_codecs
> and struct hci_rp_read_local_supported_codecs_v2, along with their
> member's offsets remain the same, hence the memory layouts don't
> change:
> 
> Before changes:
> struct hci_rp_read_local_supported_codecs {
>          __u8                       status;               /*     0     1 */
>          struct hci_std_codecs      std_codecs;           /*     1     1 */
>          struct hci_vnd_codecs      vnd_codecs;           /*     2     1 */
> 
>          /* size: 3, cachelines: 1, members: 3 */
>          /* last cacheline: 3 bytes */
> } __attribute__((__packed__));
> 
> struct hci_rp_read_local_supported_codecs_v2 {
>          __u8                       status;               /*     0     1 */
>          struct hci_std_codecs_v2   std_codecs;           /*     1     1 */
>          struct hci_vnd_codecs_v2   vendor_codecs;        /*     2     1 */
> 
>          /* size: 3, cachelines: 1, members: 3 */
>          /* last cacheline: 3 bytes */
> } __attribute__((__packed__));
> 
> After changes:
> struct hci_rp_read_local_supported_codecs {
> 	__u8                       status;               /*     0     1 */
> 	struct hci_std_codecs_hdr  std_codecs;           /*     1     1 */
> 	struct hci_vnd_codecs      vnd_codecs;           /*     2     1 */
> 
> 	/* size: 3, cachelines: 1, members: 3 */
> 	/* last cacheline: 3 bytes */
> } __attribute__((__packed__));
> 
> struct hci_rp_read_local_supported_codecs_v2 {
> 	__u8                       status;               /*     0     1 */
> 	struct hci_std_codecs_v2_hdr std_codecs;         /*     1     1 */
> 	struct hci_vnd_codecs_v2   vendor_codecs;        /*     2     1 */
> 
> 	/* size: 3, cachelines: 1, members: 3 */
> 	/* last cacheline: 3 bytes */
> } __attribute__((__packed__));
> 
> With these changes fix the following warnings:
> 
> include/net/bluetooth/hci.h:1490:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/net/bluetooth/hci.h:1525:34: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   include/net/bluetooth/hci.h | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 89ad9470fa71..572b1c620c5d 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1468,8 +1468,12 @@ struct hci_rp_read_data_block_size {
>   } __packed;
>   
>   #define HCI_OP_READ_LOCAL_CODECS	0x100b
> -struct hci_std_codecs {
> +struct hci_std_codecs_hdr {
>   	__u8	num;
> +} __packed;
> +
> +struct hci_std_codecs {
> +	struct hci_std_codecs_hdr;
>   	__u8	codec[];
>   } __packed;
>   
> @@ -1487,7 +1491,7 @@ struct hci_vnd_codecs {
>   
>   struct hci_rp_read_local_supported_codecs {
>   	__u8	status;
> -	struct hci_std_codecs std_codecs;
> +	struct hci_std_codecs_hdr std_codecs;
>   	struct hci_vnd_codecs vnd_codecs;
>   } __packed;
>   
> @@ -1504,8 +1508,12 @@ struct hci_std_codec_v2 {
>   	__u8	transport;
>   } __packed;
>   
> -struct hci_std_codecs_v2 {
> +struct hci_std_codecs_v2_hdr {
>   	__u8	num;
> +} __packed;
> +
> +struct hci_std_codecs_v2 {
> +	struct hci_std_codecs_v2_hdr;
>   	struct hci_std_codec_v2 codec[];
>   } __packed;
>   
> @@ -1522,7 +1530,7 @@ struct hci_vnd_codecs_v2 {
>   
>   struct hci_rp_read_local_supported_codecs_v2 {
>   	__u8	status;
> -	struct hci_std_codecs_v2 std_codecs;
> +	struct hci_std_codecs_v2_hdr std_codecs;
>   	struct hci_vnd_codecs_v2 vendor_codecs;
>   } __packed;
>   



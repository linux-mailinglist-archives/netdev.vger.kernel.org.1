Return-Path: <netdev+bounces-286278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id n1NcFhdrAGoyIwEAu9opvQ
	(envelope-from <netdev+bounces-286278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 13:25:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD900503C92
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 13:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99BDC3001FE1
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D6E3815DE;
	Sun, 10 May 2026 11:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b="OVodw1+l"
X-Original-To: netdev@vger.kernel.org
Received: from mail.rulkc.org (mail.rulkc.org [155.212.184.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895BE37EFEE
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.212.184.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778412307; cv=none; b=gPNZHoZ9OoMag5/im6oxhd4mPCpHaL1/13h9kHErAnE7HoMiAd/aFfHIwxFHl5CFiDjtcPvhs9T4g1BrIJkjG80xwiqKR7lDgdsSUuuEjzEoYvGspcJ7gGn3KURFiz9fFZ/elpLuA0IqZoVCLRiLwYvHhYgb0I/ENXy1WX4+r/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778412307; c=relaxed/simple;
	bh=D4oY4WIKD/WxGvs6FKO2PEooOp5PF8Q4mnVVUfY8cyM=;
	h=Message-ID:Date:MIME-Version:In-Reply-To:To:From:Subject:
	 Content-Type; b=KORONORCdSHfNg/Zpx6dEVc/SSXZwXj8/4St8mh/PnRRHdl5U2LdNvmhLROEGmz+nRagNP7zqYPZ+JwH7k+naIb0Es/D00YKPcnYSTNrxKFaCkFivqaxP8evdsl9At9Ju5nF/X6p2B+jMnWjqP65qIHG27+0StEUchgQv5/5KGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org; spf=pass smtp.mailfrom=rulkc.org; dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b=OVodw1+l; arc=none smtp.client-ip=155.212.184.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rulkc.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9500F1001B4
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 14:24:54 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rulkc.org; s=dkim;
	t=1778412295; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to;
	bh=x/Sch+GmytFMCdVl/PqwWKEPL8uiyPycTlOryDKFjP4=;
	b=OVodw1+lVnTIt/Nz6cDLE++MU1qrjE5cunzEM4yfK1gl5AME3gcKFM3XvZwBs1ptpJ2keE
	I9Ya4EGU/3F+V2fdmjXMoFnAc+5ymcDSvUJ4uMFei+60SztjQRT9sStRPpf8I7nVJ/5OGR
	RI5zISbVR59Yzo/TkqR6wQl350/Cnw6J/Z6ukkv7uN2Xtk6BNAht43X2LmDmCrDQS3OplA
	yO2a0oGTSQs63eetdjdEkSRilB56uz2PYjrKNvKPuxoV6z2M0bvfa6F1UJQDHKCBKk7Yhq
	F0aIMMS61NUVSzZlgSIaO3DLqRjGWkYdnWoQi5jAi1FXTrHpoQCkRdRaBirT6Q==
Message-ID: <d81cdc6d-f8fa-4e7e-b60e-519ec6852d80@rulkc.org>
Date: Sun, 10 May 2026 14:24:49 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: ru
In-Reply-To: <20260508164411.261440-2-sgarzare@redhat.com>
To: netdev@vger.kernel.org
From: Arseniy Krasnov <avkrasnov@rulkc.org>
Subject: Arseniy Krasnov
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: CD900503C92
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rulkc.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[rulkc.org:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286278-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[rulkc.org:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@rulkc.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rulkc.org:email,rulkc.org:mid,rulkc.org:dkim]
X-Rspamd-Action: no action

> From: Stefano Garzarella <sgarzare@redhat.com>
>
> virtio_transport_build_skb() builds a new skb to be delivered to the
> vsockmon tap device. To build the new skb, it uses the original skb
> data length as payload length, but as the comment notes, the original
> packet stored in the skb may have been split in multiple packets, so we
> need to use the length in the header, which is correctly updated before
> the packet is delivered to the tap, and the offset for the data.
>
> This was also similar to what we did before commit 71dc9ec9ac7d
> ("virtio/vsock: replace virtio_vsock_pkt with sk_buff") where we probably
> missed something during the skb conversion.
>
> Also update the comment above, which was left stale by the skb
> conversion and still mentioned a buffer pointer that no longer exists.
>
> Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 9b8014516f4f..a678d5d75704 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -166,12 +166,12 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
>  	struct sk_buff *skb;
>  	size_t payload_len;
>  
> -	/* A packet could be split to fit the RX buffer, so we can retrieve
> -	 * the payload length from the header and the buffer pointer taking
> -	 * care of the offset in the original packet.
> +	/* A packet could be split to fit the RX buffer, so we use
> +	 * the payload length from the header, which has been updated
> +	 * by the sender to reflect the fragment size.
>  	 */
>  	pkt_hdr = virtio_vsock_hdr(pkt);
> -	payload_len = pkt->len;
> +	payload_len = le32_to_cpu(pkt_hdr->len);
>  
>  	skb = alloc_skb(sizeof(*hdr) + sizeof(*pkt_hdr) + payload_len,
>  			GFP_ATOMIC);
> @@ -219,7 +219,8 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
>  
>  			virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
>  		} else {
> -			skb_put_data(skb, pkt->data, payload_len);
> +			skb_put_data(skb, pkt->data + VIRTIO_VSOCK_SKB_CB(pkt)->offset,
> +				     payload_len);
>  		}
>  	}
>  
> -- 2.54.0

Reviewed-by: Arseniy Krasnov <avkrasnov@rulkc.org>


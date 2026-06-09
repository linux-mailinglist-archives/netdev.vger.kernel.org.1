Return-Path: <netdev+bounces-297262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bXPvEBlwKGrYEgMAu9opvQ
	(envelope-from <netdev+bounces-297262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:57:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1C2663F69
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:57:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=iogearbox.net header.s=default2302 header.b=YhMXw2Oo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297262-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297262-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=iogearbox.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25B483064B27
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 19:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F16376A03;
	Tue,  9 Jun 2026 19:52:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9064ADDA8
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 19:52:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034761; cv=none; b=riinnJCbjx8IRT1IAPhR8G0sID1PqtXZmel0+Um83xN1sgqi0KfRf6GKZmv4rLUe0TheBNJuJdXhRNL0PCC7wiqDB8WI9apBFMsCVnHV4vhFf3u5TOoz0HiqP1BNAkBfDOOIS/7uNegWik1PaLQWIaaL/bboIbRFbGuqafVItTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034761; c=relaxed/simple;
	bh=+4IUeBKAh2XI6VD6ap07Oetg6YVT2Xbh1M0B6mgBpgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q6QNsAsuqrQRsK7kT2wjj3JasStEiuRUDU1eWGUoNsIWO3o+ko44XvoTNL5PptJtvipWcPd/J+JDnhELRrZZIjduvtnwe2SA4pdve9l1Wonc0j8L6wKw0CN0aMa086xbW4NkYOm4yqc28BD/0x9okf9ojHhC5WEeW7n91yNIiGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=YhMXw2Oo; arc=none smtp.client-ip=213.133.104.62
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=C3Li/RVM0wb3b++4xIwjz1jl9fQ7gU1E5LJCKYCtnO8=; b=YhMXw2OoSShthQV9BLVjyXBsBJ
	KreYKVPr889sTiC3abhGP/9Q0te9KvDLy747velPt+OEg1EYh2a9dRy1gCOWb92NLQEl6vVPVSCfj
	Bj5ckDFL2u2F9nJ0w1O1VqXHLrwzn77wvukl8PTbFtbl5oLCSrMGJLaXBFsh1YekTFLMQe7vOr5uI
	parYrEcx72/4helCb5nI5sQer19+QbRrrtDpKNCMU+eY08DXT7qrE9gNl5/V/QJlWXneG/+txNTp5
	J5u6k7HjfTXJUZxNweMwC1FRXZzCFk7X9G56Ha81S9JkN9fUkcodJOc2HFjFdcX9WkJldvIatncPW
	HPFXkQOQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wX2Us-0008Tl-19;
	Tue, 09 Jun 2026 21:52:26 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wX2Ur-0008P7-01;
	Tue, 09 Jun 2026 21:52:25 +0200
Message-ID: <15c024cd-7ab1-47b4-94e5-90db0f74227f@iogearbox.net>
Date: Tue, 9 Jun 2026 21:52:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] netdev: check for nla_put_u32() failures
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, dw@davidwei.uk,
 razor@blackwall.org, sdf@fomichev.me, dtatulea@nvidia.com,
 bobbyeshleman@meta.com
References: <20260609190804.1137085-1-kuba@kernel.org>
 <20260609190804.1137085-2-kuba@kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 xsFNBGNAkI0BEADiPFmKwpD3+vG5nsOznvJgrxUPJhFE46hARXWYbCxLxpbf2nehmtgnYpAN
 2HY+OJmdspBntWzGX8lnXF6eFUYLOoQpugoJHbehn9c0Dcictj8tc28MGMzxh4aK02H99KA8
 VaRBIDhmR7NJxLWAg9PgneTFzl2lRnycv8vSzj35L+W6XT7wDKoV4KtMr3Szu3g68OBbp1TV
 HbJH8qe2rl2QKOkysTFRXgpu/haWGs1BPpzKH/ua59+lVQt3ZupePpmzBEkevJK3iwR95TYF
 06Ltpw9ArW/g3KF0kFUQkGXYXe/icyzHrH1Yxqar/hsJhYImqoGRSKs1VLA5WkRI6KebfpJ+
 RK7Jxrt02AxZkivjAdIifFvarPPu0ydxxDAmgCq5mYJ5I/+BY0DdCAaZezKQvKw+RUEvXmbL
 94IfAwTFA1RAAuZw3Rz5SNVz7p4FzD54G4pWr3mUv7l6dV7W5DnnuohG1x6qCp+/3O619R26
 1a7Zh2HlrcNZfUmUUcpaRPP7sPkBBLhJfqjUzc2oHRNpK/1mQ/+mD9CjVFNz9OAGD0xFzNUo
 yOFu/N8EQfYD9lwntxM0dl+QPjYsH81H6zw6ofq+jVKcEMI/JAgFMU0EnxrtQKH7WXxhO4hx
 3DFM7Ui90hbExlFrXELyl/ahlll8gfrXY2cevtQsoJDvQLbv7QARAQABzSZEYW5pZWwgQm9y
 a21hbm4gPGRhbmllbEBpb2dlYXJib3gubmV0PsLBkQQTAQoAOxYhBCrUdtCTcZyapV2h+93z
 cY/jfzlXBQJjQJCNAhsDBQkHhM4ACAsJCAcNDAsKBRUKCQgLAh4BAheAAAoJEN3zcY/jfzlX
 dkUQAIFayRgjML1jnwKs7kvfbRxf11VI57EAG8a0IvxDlNKDcz74mH66HMyhMhPqCPBqphB5
 ZUjN4N5I7iMYB/oWUeohbuudH4+v6ebzzmgx/EO+jWksP3gBPmBeeaPv7xOvN/pPDSe/0Ywp
 dHpl3Np2dS6uVOMnyIsvmUGyclqWpJgPoVaXrVGgyuer5RpE/a3HJWlCBvFUnk19pwDMMZ8t
 0fk9O47HmGh9Ts3O8pGibfdREcPYeGGqRKRbaXvcRO1g5n5x8cmTm0sQYr2xhB01RJqWrgcj
 ve1TxcBG/eVMmBJefgCCkSs1suriihfjjLmJDCp9XI/FpXGiVoDS54TTQiKQinqtzP0jv+TH
 1Ku+6x7EjLoLH24ISGyHRmtXJrR/1Ou22t0qhCbtcT1gKmDbTj5TcqbnNMGWhRRTxgOCYvG0
 0P2U6+wNj3HFZ7DePRNQ08bM38t8MUpQw4Z2SkM+jdqrPC4f/5S8JzodCu4x80YHfcYSt+Jj
 ipu1Ve5/ftGlrSECvy80ZTKinwxj6lC3tei1bkI8RgWZClRnr06pirlvimJ4R0IghnvifGQb
 M1HwVbht8oyUEkOtUR0i0DMjk3M2NoZ0A3tTWAlAH8Y3y2H8yzRrKOsIuiyKye9pWZQbCDu4
 ZDKELR2+8LUh+ja1RVLMvtFxfh07w9Ha46LmRhpCzsFNBGNAkI0BEADJh65bNBGNPLM7cFVS
 nYG8tqT+hIxtR4Z8HQEGseAbqNDjCpKA8wsxQIp0dpaLyvrx4TAb/vWIlLCxNu8Wv4W1JOST
 wI+PIUCbO/UFxRy3hTNlb3zzmeKpd0detH49bP/Ag6F7iHTwQQRwEOECKKaOH52tiJeNvvyJ
 pPKSKRhmUuFKMhyRVK57ryUDgowlG/SPgxK9/Jto1SHS1VfQYKhzMn4pWFu0ILEQ5x8a0RoX
 k9p9XkwmXRYcENhC1P3nW4q1xHHlCkiqvrjmWSbSVFYRHHkbeUbh6GYuCuhqLe6SEJtqJW2l
 EVhf5AOp7eguba23h82M8PC4cYFl5moLAaNcPHsdBaQZznZ6NndTtmUENPiQc2EHjHrrZI5l
 kRx9hvDcV3Xnk7ie0eAZDmDEbMLvI13AvjqoabONZxra5YcPqxV2Biv0OYp+OiqavBwmk48Z
 P63kTxLddd7qSWbAArBoOd0wxZGZ6mV8Ci/ob8tV4rLSR/UOUi+9QnkxnJor14OfYkJKxot5
 hWdJ3MYXjmcHjImBWplOyRiB81JbVf567MQlanforHd1r0ITzMHYONmRghrQvzlaMQrs0V0H
 5/sIufaiDh7rLeZSimeVyoFvwvQPx5sXhjViaHa+zHZExP9jhS/WWfFE881fNK9qqV8pi+li
 2uov8g5yD6hh+EPH6wARAQABwsF8BBgBCgAmFiEEKtR20JNxnJqlXaH73fNxj+N/OVcFAmNA
 kI0CGwwFCQeEzgAACgkQ3fNxj+N/OVfFMhAA2zXBUzMLWgTm6iHKAPfz3xEmjtwCF2Qv/TT3
 KqNUfU3/0VN2HjMABNZR+q3apm+jq76y0iWroTun8Lxo7g89/VDPLSCT0Nb7+VSuVR/nXfk8
 R+OoXQgXFRimYMqtP+LmyYM5V0VsuSsJTSnLbJTyCJVu8lvk3T9B0BywVmSFddumv3/pLZGn
 17EoKEWg4lraXjPXnV/zaaLdV5c3Olmnj8vh+14HnU5Cnw/dLS8/e8DHozkhcEftOf+puCIl
 Awo8txxtLq3H7KtA0c9kbSDpS+z/oT2S+WtRfucI+WN9XhvKmHkDV6+zNSH1FrZbP9FbLtoE
 T8qBdyk//d0GrGnOrPA3Yyka8epd/bXA0js9EuNknyNsHwaFrW4jpGAaIl62iYgb0jCtmoK/
 rCsv2dqS6Hi8w0s23IGjz51cdhdHzkFwuc8/WxI1ewacNNtfGnorXMh6N0g7E/r21pPeMDFs
 rUD9YI1Je/WifL/HbIubHCCdK8/N7rblgUrZJMG3W+7vAvZsOh/6VTZeP4wCe7Gs/cJhE2gI
 DmGcR+7rQvbFQC4zQxEjo8fNaTwjpzLM9NIp4vG9SDIqAm20MXzLBAeVkofixCsosUWUODxP
 owLbpg7pFRJGL9YyEHpS7MGPb3jSLzucMAFXgoI8rVqoq6si2sxr2l0VsNH5o3NgoAgJNIg=
In-Reply-To: <20260609190804.1137085-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28026/Tue Jun  9 08:25:31 2026)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297262-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:dw@davidwei.uk,m:razor@blackwall.org,m:sdf@fomichev.me,m:dtatulea@nvidia.com,m:bobbyeshleman@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,iogearbox.net:dkim,iogearbox.net:mid,iogearbox.net:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF1C2663F69

On 6/9/26 9:08 PM, Jakub Kicinski wrote:
> Make sure we check if nla_put_u32(id) was successful after creating
> objects. This is theoretical today, the skbs are large enough to
> always fit the ID.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   net/core/netdev-genl.c | 21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index b4d48f3672a5..a10d353d5eab 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -1091,7 +1091,10 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>   			goto err_unbind;
>   	}
>   
> -	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
> +	err = nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
> +	if (err)
> +		goto err_unbind;
> +

Not sure about these three tbh... if the skbs are guaranteed to be
large enough, would a more straight forward ...

   WARN_ON_ONCE(err);

... suffice? Unwinding at this point feels a bit excessive. Is there
any other way we could assert this earlier before we do all the ops
that need to be unwound?

>   	genlmsg_end(rsp, hdr);
>   
>   	err = genlmsg_reply(rsp, info);
> @@ -1227,7 +1230,10 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
>   		goto err_unlock_bind_dev;
>   	}
>   
> -	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
> +	err = nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
> +	if (err)
> +		goto err_unbind;
> +
>   	genlmsg_end(rsp, hdr);
>   
>   	if (bind_dev != netdev)
> @@ -1237,6 +1243,8 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
>   
>   	return genlmsg_reply(rsp, info);
>   
> +err_unbind:
> +	net_devmem_unbind_dmabuf(binding);
>   err_unlock_bind_dev:
>   	if (bind_dev != netdev)
>   		netdev_unlock(bind_dev);
> @@ -1394,7 +1402,12 @@ int netdev_nl_queue_create_doit(struct sk_buff *skb, struct genl_info *info)
>   
>   	netdev_rx_queue_lease(rxq, rxq_lease);
>   
> -	nla_put_u32(rsp, NETDEV_A_QUEUE_ID, queue_id);
> +	err = nla_put_u32(rsp, NETDEV_A_QUEUE_ID, queue_id);
> +	if (err) {
> +		WARN_ON_ONCE(1); /* we can't delete the queue, ID must fit in */
> +		goto err_unlease;
> +	}

.. in particular here :/ would be nicer if we could solve it differently

> +
>   	genlmsg_end(rsp, hdr);
>   
>   	netdev_unlock(dev_lease);
> @@ -1404,6 +1417,8 @@ int netdev_nl_queue_create_doit(struct sk_buff *skb, struct genl_info *info)
>   
>   	return genlmsg_reply(rsp, info);
>   
> +err_unlease:
> +	netdev_rx_queue_unlease(rxq, rxq_lease);
>   err_unlock_dev_lease:
>   	netdev_unlock(dev_lease);
>   err_put_netns:



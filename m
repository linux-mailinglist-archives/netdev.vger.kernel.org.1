Return-Path: <netdev+bounces-26916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 662467796EC
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 20:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFFD9282458
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 18:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B21219EA;
	Fri, 11 Aug 2023 18:16:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5A663B6
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 18:16:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6347A30E7
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 11:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691777805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDRwvUP7ZvvOnTnjPmWed7nc7Q0OGl3eaf80R3oTgFc=;
	b=cBto9cweuJRkdmKlGIW8HRVLROrlkLyaem48B89Y/OAOUpJxWy1NRy5C08U6dBHKTmzySu
	bXPw0UmLpXe4efyyCtLTggPx/+zTuqMcX0ZgKlDYy5ygFmta/i7HXWbJkHVcYzpwAxPTqJ
	9wViVdwF70GbL8coz+lPYoCoMEksp2U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-1_-1tn0tPgilzovU6V4QrQ-1; Fri, 11 Aug 2023 14:16:44 -0400
X-MC-Unique: 1_-1tn0tPgilzovU6V4QrQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-993d41cbc31so158090866b.1
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 11:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691777803; x=1692382603;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDRwvUP7ZvvOnTnjPmWed7nc7Q0OGl3eaf80R3oTgFc=;
        b=YW/f0gOaCISh0Dn2au/mOSnuX5iHRUkFRkZadVleO7MhMkoHHZ0rSR+el4imFR89yf
         ZNKmzufZoH3wC+gnoj4BwJA/9mqPQ4fDMqUn/mHU/IF6AJeDCzCMMLczhDprzUV22e5e
         plrWE5oSdKYq+H6YnxxlF96ehlRJrLk28aBi89+HfwsXg/YNFVanIkSiXcAs1xxTkDNW
         /Enu3uFn6TM+CzS1F2HpOz+yYJz97eeHeUNYZon1pp7WjXSobm7m14jdTccOZbDYmkn9
         Z3Acb57gxdDSUvz7MCKUl5a6uQVLa3JsnP9UqNA0X/MhaeGnsMBdynrr9l22virTJGET
         vshw==
X-Gm-Message-State: AOJu0YyxuKSI8eEnJlPaLMKvkfx/zTQWejDuebpsJLJGocIlL7iUKg80
	6FRhlNMQHVrOx1CqlZsfgnhjJoZ5/tYu+Zv8oqqjuvG1AqkHaqn82bsHYKhJEpmDEGAV93IMfoU
	e8zZq1hlRYgT91q86
X-Received: by 2002:a17:906:3098:b0:99b:d2a9:9a01 with SMTP id 24-20020a170906309800b0099bd2a99a01mr2692613ejv.0.1691777803261;
        Fri, 11 Aug 2023 11:16:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6fb2EnSpd5nauipUevv2M6hdh3TMAaXuIJ6hXB13ZazgTq1S6Kg2qAcjjn3hkzy3FirxzlA==
X-Received: by 2002:a17:906:3098:b0:99b:d2a9:9a01 with SMTP id 24-20020a170906309800b0099bd2a99a01mr2692598ejv.0.1691777802893;
        Fri, 11 Aug 2023 11:16:42 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id u17-20020a1709064ad100b00988c0c175c6sm2518962ejt.189.2023.08.11.11.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 11:16:42 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <b5b9df4f-35d8-f20d-6507-3c6c3fafb386@redhat.com>
Date: Fri, 11 Aug 2023 20:16:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: brouer@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next v2 2/2] net: veth: Improving page pool pages
 recycling
Content-Language: en-US
To: Liang Chen <liangchen.linux@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linyunsheng@huawei.com
References: <20230801061932.10335-1-liangchen.linux@gmail.com>
 <20230801061932.10335-2-liangchen.linux@gmail.com>
In-Reply-To: <20230801061932.10335-2-liangchen.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 01/08/2023 08.19, Liang Chen wrote:
[...]
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 509e901da41d..ea1b344e5db4 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
[...]
> @@ -848,6 +850,7 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
>   		goto out;
>   	}
>   
> +	skb_orig = skb;
>   	__skb_push(skb, skb->data - skb_mac_header(skb));
>   	if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb))
>   		goto drop;
> @@ -862,9 +865,18 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
>   	case XDP_PASS:
>   		break;
>   	case XDP_TX:
> -		veth_xdp_get(xdp);
> -		consume_skb(skb);
> -		xdp->rxq->mem = rq->xdp_mem;
> +		if (skb != skb_orig) {
> +			xdp->rxq->mem = rq->xdp_mem_pp;
> +			kfree_skb_partial(skb, true);
> +		} else if (!skb->pp_recycle) {
> +			xdp->rxq->mem = rq->xdp_mem;
> +			kfree_skb_partial(skb, true);
> +		} else {
> +			veth_xdp_get(xdp);
> +			consume_skb(skb);
> +			xdp->rxq->mem = rq->xdp_mem;
> +		}
> +

Above code section, and below section looks the same.
It begs for a common function.

>   		if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
>   			trace_xdp_exception(rq->dev, xdp_prog, act);
>   			stats->rx_drops++;
> @@ -874,9 +886,18 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
>   		rcu_read_unlock();
>   		goto xdp_xmit;
>   	case XDP_REDIRECT:
> -		veth_xdp_get(xdp);
> -		consume_skb(skb);
> -		xdp->rxq->mem = rq->xdp_mem;
> +		if (skb != skb_orig) {
> +			xdp->rxq->mem = rq->xdp_mem_pp;
> +			kfree_skb_partial(skb, true);
> +		} else if (!skb->pp_recycle) {
> +			xdp->rxq->mem = rq->xdp_mem;
> +			kfree_skb_partial(skb, true);
> +		} else {
> +			veth_xdp_get(xdp);
> +			consume_skb(skb);
> +			xdp->rxq->mem = rq->xdp_mem;
> +		}
> +

The common function can be named to reflect what the purpose of this 
code section is.  According to my understanding, the code steals the 
(packet) data section from the SKB and free the SKB.  And 
prepare/associate the correct memory type in xdp_buff->rxq.

Function name proposals:
  __skb_steal_data
  __free_skb_and_steal_data
  __free_skb_and_steal_data_for_xdp
  __free_skb_and_xdp_steal_data
  __skb2xdp_steal_data

When doing this in a function, it will also allow us to add some 
comments explaining the different cases and assumptions.  These 
assumptions can get broken as a result of (future) changes in 
surrounding the code, thus we need to explain our assumptions/intent (to 
help our future selves).

For code readability, I think we should convert (skb != skb_orig) into a 
boolean that says what this case captures, e.g. local_pp_alloc.

Func prototype:
  __skb2xdp_steal_data(skb, xdp, rq, bool local_pp_alloc)


Always feel free to challenge my view,
--Jesper



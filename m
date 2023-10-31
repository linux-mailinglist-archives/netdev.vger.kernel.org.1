Return-Path: <netdev+bounces-45459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505B97DD3A7
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 18:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C935CB20E2F
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 17:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51152031C;
	Tue, 31 Oct 2023 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="XbZK8yxe"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B07200D4
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 17:01:01 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CECF35B3
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 09:58:50 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c54c8934abso82177691fa.0
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 09:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1698771528; x=1699376328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q5huLM+ruuR9r8bhIQkyby3oySC0L2SsIXLHU8PQQvs=;
        b=XbZK8yxeSGH9D8WwMS7kFbOCYK/cOSYAxSV1cBsiIFiQ65IUSmi1y9ydHb6I7vPlb+
         DC2MFlw2fESVX3Iyv8B6WgJ5bcRAxTzdxMco8I1NOr24SubpEaVWfEUn1K157LR2+PDZ
         twF3N9XdXBtX5J3eWGKKAtvNx70yOAcLffBRqQsumIxiYeumcJByUJ+JBJtX/X209q7u
         vgY05Jnzgmt8B1qJQcfXwrMzisKOKfk6RRGYo5FbQD0Zn6iwwnP8Tx4WuqqUA3auonVt
         IeLHARCiN08OeajEuMsI+x4SfWouLWyHHOfBCuwq4K8AsV3cAnRGBN9K4EsPDk2WkXe0
         JlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698771528; x=1699376328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5huLM+ruuR9r8bhIQkyby3oySC0L2SsIXLHU8PQQvs=;
        b=PwEdHniIaWwp5UKiaSkvMDSe3wZ+kv7XMkNn5xJjXy9ya75i+y7yieUgJ0UGdkamQz
         rppvyKzGTtqOlcp4xpvZZ8fcZrxmDd+FsHgxNFNDHrNNR15jPrC+/ruTGXFcYNAA2ZKa
         17Nd0hADnhF67PrJsoB6F+N2LYLeGtrY2/Id5h2ZzDA2enkvKRLXHCNYy1PnSExn8b58
         mFI8uawP5XnP5icGR6uN+Nx+cPIccAF2psgub9aPIrmWPHJDNqqs9nFm+vbaST8OFUR2
         YVDoKpdzY02Z/RGsNUh0GPF5opiLQRDl9Tn5dEwPI4hD4OdABWYoaugEPktakZtn+Uha
         Q+Fw==
X-Gm-Message-State: AOJu0YwkOmZjo3mzNG7K+pX5UhTuufrZmGNHnZQatXKDDyzxS472dOlR
	k+ScW49JANIqLC4No++uj8jLLw==
X-Google-Smtp-Source: AGHT+IH9dgjnNtj2krBlBhHyGbG5mxlYMKSxONczPYvNzDWasZVNvqdZZIXCzFLOURVs3cZCaNYIWw==
X-Received: by 2002:a2e:b817:0:b0:2c5:994:ed72 with SMTP id u23-20020a2eb817000000b002c50994ed72mr9596540ljo.21.1698771522970;
        Tue, 31 Oct 2023 09:58:42 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c19cb00b0040535648639sm2240865wmq.36.2023.10.31.09.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 09:58:42 -0700 (PDT)
Message-ID: <64cded2c-f939-4df9-ac14-f17dd1a1378f@arista.com>
Date: Tue, 31 Oct 2023 16:58:43 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/tcp_sigpool: Fix some off by one bugs
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <ce915d61-04bc-44fb-b450-35fcc9fc8831@moroto.mountain>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <ce915d61-04bc-44fb-b450-35fcc9fc8831@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dan,

On 10/31/23 09:51, Dan Carpenter wrote:
> The "cpool_populated" variable is the number of elements in the cpool[]
> array that have been populated.  It is incremented in
> tcp_sigpool_alloc_ahash() every time we populate a new element.
> Unpopulated elements are NULL but if we have populated every element then
> this code will read one element beyond the end of the array.
> 
> Fixes: 8c73b26315aa ("net/tcp: Prepare tcp_md5sig_pool for TCP-AO")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Yeah, those are barriers for any issues in the caller-code, so that's
not too critical but nice to have. Thanks for the patch!

Reviewed-by: Dmitry Safonov <dima@arista.com>

> ---
> From static analysis and review.
> 
>  net/ipv4/tcp_sigpool.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/tcp_sigpool.c b/net/ipv4/tcp_sigpool.c
> index 65a8eaae2fec..55b310a722c7 100644
> --- a/net/ipv4/tcp_sigpool.c
> +++ b/net/ipv4/tcp_sigpool.c
> @@ -231,7 +231,7 @@ static void cpool_schedule_cleanup(struct kref *kref)
>   */
>  void tcp_sigpool_release(unsigned int id)
>  {
> -	if (WARN_ON_ONCE(id > cpool_populated || !cpool[id].alg))
> +	if (WARN_ON_ONCE(id >= cpool_populated || !cpool[id].alg))
>  		return;
>  
>  	/* slow-path */
> @@ -245,7 +245,7 @@ EXPORT_SYMBOL_GPL(tcp_sigpool_release);
>   */
>  void tcp_sigpool_get(unsigned int id)
>  {
> -	if (WARN_ON_ONCE(id > cpool_populated || !cpool[id].alg))
> +	if (WARN_ON_ONCE(id >= cpool_populated || !cpool[id].alg))
>  		return;
>  	kref_get(&cpool[id].kref);
>  }
> @@ -256,7 +256,7 @@ int tcp_sigpool_start(unsigned int id, struct tcp_sigpool *c) __cond_acquires(RC
>  	struct crypto_ahash *hash;
>  
>  	rcu_read_lock_bh();
> -	if (WARN_ON_ONCE(id > cpool_populated || !cpool[id].alg)) {
> +	if (WARN_ON_ONCE(id >= cpool_populated || !cpool[id].alg)) {
>  		rcu_read_unlock_bh();
>  		return -EINVAL;
>  	}
> @@ -301,7 +301,7 @@ EXPORT_SYMBOL_GPL(tcp_sigpool_end);
>   */
>  size_t tcp_sigpool_algo(unsigned int id, char *buf, size_t buf_len)
>  {
> -	if (WARN_ON_ONCE(id > cpool_populated || !cpool[id].alg))
> +	if (WARN_ON_ONCE(id >= cpool_populated || !cpool[id].alg))
>  		return -EINVAL;
>  
>  	return strscpy(buf, cpool[id].alg, buf_len);

Thanks,
            Dmitry



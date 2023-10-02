Return-Path: <netdev+bounces-37518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9687B5C13
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 22:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id B54D7B20A09
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 20:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE121F184;
	Mon,  2 Oct 2023 20:30:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FF82031E
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 20:30:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C41B8
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 13:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696278640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w8f6DdK1GdbJ9qglZe36tie4rL6xJEQDl6yTedgx1kc=;
	b=ZxJUvglUqbHJ09ME0u8L0n/53qwCWEVGcPoIleUMyGyuo4/P1jMVO7YlzU6v/AlwG4Vrs7
	FRkSAKxyfvmQqWf4mg3taqAE9arskrI/SMm3n3lP12ygtNhD927MuLNhU1z2ZqUyCES7wK
	S/b0hE/ftX4cQTBntQjtBIF/hpTsCwU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-y_u-gNzCPBeWu2xhMasIaA-1; Mon, 02 Oct 2023 16:30:39 -0400
X-MC-Unique: y_u-gNzCPBeWu2xhMasIaA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66216e7385fso3763746d6.3
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 13:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696278639; x=1696883439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w8f6DdK1GdbJ9qglZe36tie4rL6xJEQDl6yTedgx1kc=;
        b=xApq+ETP9fO07B7Qe9ozrNk6rRtXEJXQLXONZQ6aqEegEuOH4e70fR+Ioys9SAYTlu
         gAFzdJn/M/qrkUmQxPWKqsL+QzL56F7s6eTk//jtSDyVoXRO+MHO9aRXC+nP/HETL/6f
         0RGVnd4TzrsdR9OmrE2EcA8m2qShIx2bLbLig7Q6/dDdzOOvlchy3mCiG99US4TQ7b9J
         mrVnTFnvotlwSpyWDimnFvOOB6BC6yfRALYYQeHGaf5d8ItiZp2YUDHxZ6mjtvFeX85N
         N1UaLfJJ4VOmljRmqLv6HXkxyaUvG7z1vigfUe2s8+R3eWPSqa8hoxCpXgNk1IIwCfLT
         4a0g==
X-Gm-Message-State: AOJu0YwbpW5xb23KpQDqFTr6C9GaLY1ZBRy6sLdhu6KYnXg0B9JkJkbx
	EV0BXxHSItn1ddhGBMrQ10o/2S8vQ/RSnsB2pfc/odCtXeJI8Q03Ru5MqUPT9fWT+CygqkEwfLf
	eK5N/3j4Sr7VXhYut
X-Received: by 2002:a05:6214:500b:b0:65d:343:8e50 with SMTP id jo11-20020a056214500b00b0065d03438e50mr17919982qvb.3.1696278639171;
        Mon, 02 Oct 2023 13:30:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEBzcp3LOMaX+vRfy6OADLYWwS1aUlqXi3WUStAokU3G7oCq11ynu1Wreo7RqMGIcieUkl6A==
X-Received: by 2002:a05:6214:500b:b0:65d:343:8e50 with SMTP id jo11-20020a056214500b00b0065d03438e50mr17919965qvb.3.1696278638861;
        Mon, 02 Oct 2023 13:30:38 -0700 (PDT)
Received: from [10.0.0.97] ([24.225.234.80])
        by smtp.gmail.com with ESMTPSA id h3-20020a0cf403000000b00655d711180dsm4844123qvl.17.2023.10.02.13.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 13:30:38 -0700 (PDT)
Message-ID: <a2a43d5a-678d-129b-d258-d559df42431f@redhat.com>
Date: Mon, 2 Oct 2023 16:30:37 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] tipc: fix a potential deadlock on &tx->lock
Content-Language: en-US
To: Chengfeng Ye <dg573847474@gmail.com>, ying.xue@windriver.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
References: <20230927181414.59928-1-dg573847474@gmail.com>
From: Jon Maloy <jmaloy@redhat.com>
In-Reply-To: <20230927181414.59928-1-dg573847474@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023-09-27 14:14, Chengfeng Ye wrote:
> It seems that tipc_crypto_key_revoke() could be be invoked by
> wokequeue tipc_crypto_work_rx() under process context and
> timer/rx callback under softirq context, thus the lock acquisition
> on &tx->lock seems better use spin_lock_bh() to prevent possible
> deadlock.
>
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock.
>
> tipc_crypto_work_rx() <workqueue>
> --> tipc_crypto_key_distr()
> --> tipc_bcast_xmit()
> --> tipc_bcbase_xmit()
> --> tipc_bearer_bc_xmit()
> --> tipc_crypto_xmit()
> --> tipc_ehdr_build()
> --> tipc_crypto_key_revoke()
> --> spin_lock(&tx->lock)
> <timer interrupt>
>     --> tipc_disc_timeout()
>     --> tipc_bearer_xmit_skb()
>     --> tipc_crypto_xmit()
>     --> tipc_ehdr_build()
>     --> tipc_crypto_key_revoke()
>     --> spin_lock(&tx->lock) <deadlock here>
>
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> ---
>   net/tipc/crypto.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
> index 302fd749c424..43c3f1c971b8 100644
> --- a/net/tipc/crypto.c
> +++ b/net/tipc/crypto.c
> @@ -1441,14 +1441,14 @@ static int tipc_crypto_key_revoke(struct net *net, u8 tx_key)
>   	struct tipc_crypto *tx = tipc_net(net)->crypto_tx;
>   	struct tipc_key key;
>   
> -	spin_lock(&tx->lock);
> +	spin_lock_bh(&tx->lock);
>   	key = tx->key;
>   	WARN_ON(!key.active || tx_key != key.active);
>   
>   	/* Free the active key */
>   	tipc_crypto_key_set_state(tx, key.passive, 0, key.pending);
>   	tipc_crypto_key_detach(tx->aead[key.active], &tx->lock);
> -	spin_unlock(&tx->lock);
> +	spin_unlock_bh(&tx->lock);
>   
>   	pr_warn("%s: key is revoked\n", tx->name);
>   	return -EKEYREVOKED;
Acked-by: Jon Maloy <jmaloy@redhat.com>



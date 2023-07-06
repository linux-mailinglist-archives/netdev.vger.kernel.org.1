Return-Path: <netdev+bounces-15743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C30749753
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 10:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7642808DD
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 08:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57DE1FB5;
	Thu,  6 Jul 2023 08:19:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EC615B8
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 08:19:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFB1171A
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 01:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688631540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lx+lBJ29CFsk81sGY8QIW/lXN8O5LUUJoAktsDtK8dk=;
	b=FzitJ6+8f7c1o4hQR1zoWkg0sZqF12jPsIxtq8uNLlgVjz9K3wmPLqoxFl8IrY5gZZzFx5
	4nyc2t6qBB1jDC0ncLCU5+LaFkB3tNFxP/ZHfHzq78f5MfzwrKiSkBAhLsdVlvyW0DJQgN
	hUghHf3F7vmQhlXxL31/VjVEwPtAH3U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-PmB6DqrjN42BsX2Boc3yyw-1; Thu, 06 Jul 2023 04:18:59 -0400
X-MC-Unique: PmB6DqrjN42BsX2Boc3yyw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-765ad67e690so11744385a.1
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 01:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688631539; x=1691223539;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lx+lBJ29CFsk81sGY8QIW/lXN8O5LUUJoAktsDtK8dk=;
        b=GacAMTGBn+Ewclm1plNnuTKx4Fp+zhHjGQHhKEhZ4Rn4OeUMMsPT166F+50quG6fWO
         FU9jXVQ4/e6k5vZi/QvuM8374cbEd2JqO8RCHBZj6RRNCvvazD3IEIlx3NsGYbpolCFL
         8W1zte7VT9UXoxh43ZJO303dBxZBE5Ds6+1J8B45fLauuL8612j5ZpjXNGTswll2B4Qu
         F3/G6wKLnDDC0qkCDkBBXFqZqkobuf48nKOwIsrzPUjSIpQUs5yU6VOqhloj9c5SQx3J
         vVK6TNcNUMh79mSqLp0wSVTLJbzLUnR3cCfTi6IKfHF+xAXbpUIhZLlJk78pC21N95yF
         SfxQ==
X-Gm-Message-State: ABy/qLYJg6dmKE/zRZyjOzXEHgX7UBBHHakv+UQCTYNtuk/n8bNiC+JW
	cnqyH4bpb+WyAEQrNpvVf3mwsM0HCOs0b1y8RflDN5kBA+Nlu++SRkSU8T13KfPxLLK5SJ886gQ
	UNHqD5tGY1h+915pQ
X-Received: by 2002:a05:6214:411c:b0:62b:5410:322d with SMTP id kc28-20020a056214411c00b0062b5410322dmr1222411qvb.6.1688631539319;
        Thu, 06 Jul 2023 01:18:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHlIzKkGbc7Mhe75o6I7OvXujWZEcDlXrKdSN6nbMjmBM78UrxpGipZsStzvrEN62Vz4TceNw==
X-Received: by 2002:a05:6214:411c:b0:62b:5410:322d with SMTP id kc28-20020a056214411c00b0062b5410322dmr1222386qvb.6.1688631538999;
        Thu, 06 Jul 2023 01:18:58 -0700 (PDT)
Received: from gerbillo.redhat.com (host-95-248-55-118.retail.telecomitalia.it. [95.248.55.118])
        by smtp.gmail.com with ESMTPSA id e4-20020a0caa44000000b006300e92ea02sm591634qvb.121.2023.07.06.01.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 01:18:58 -0700 (PDT)
Message-ID: <062d9a4a0ec07e0c498fb7c6b8aab9d27177b21a.camel@redhat.com>
Subject: Re: [PATCH V5 net] net: mana: Fix MANA VF unload when hardware is
 unresponsive
From: Paolo Abeni <pabeni@redhat.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, 
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com,  davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, longli@microsoft.com,  sharmaajay@microsoft.com,
 leon@kernel.org, cai.huoqing@linux.dev,  ssengar@linux.microsoft.com,
 vkuznets@redhat.com, tglx@linutronix.de,  linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
Cc: stable@vger.kernel.org, schakrabarti@microsoft.com
Date: Thu, 06 Jul 2023 10:18:51 +0200
In-Reply-To: <1688544973-2507-1-git-send-email-schakrabarti@linux.microsoft.com>
References: 
	<1688544973-2507-1-git-send-email-schakrabarti@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-07-05 at 01:16 -0700, Souradeep Chakrabarti wrote:
> When unloading the MANA driver, mana_dealloc_queues() waits for the MANA
> hardware to complete any inflight packets and set the pending send count
> to zero. But if the hardware has failed, mana_dealloc_queues()
> could wait forever.
>=20
> Fix this by adding a timeout to the wait. Set the timeout to 120 seconds,
> which is a somewhat arbitrary value that is more than long enough for
> functional hardware to complete any sends.
>=20
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network=
 Adapter (MANA)")
> ---
> V4 -> V5:
> * Added fixes tag
> * Changed the usleep_range from static to incremental value.
> * Initialized timeout in the begining.
> ---
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>

the changelog should come after the SoB tag, and there should be no '--
- ' separator before the SoB.

Please double-check your patch with the checkpatch script before the
next submission, it should catch trivial issues as the above one.

> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 30 ++++++++++++++++---
>  1 file changed, 26 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index a499e460594b..56b7074db1a2 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2345,9 +2345,13 @@ int mana_attach(struct net_device *ndev)
>  static int mana_dealloc_queues(struct net_device *ndev)
>  {
>  	struct mana_port_context *apc =3D netdev_priv(ndev);
> +	unsigned long timeout =3D jiffies + 120 * HZ;
>  	struct gdma_dev *gd =3D apc->ac->gdma_dev;
>  	struct mana_txq *txq;
> +	struct sk_buff *skb;
> +	struct mana_cq *cq;
>  	int i, err;
> +	u32 tsleep;
> =20
>  	if (apc->port_is_up)
>  		return -EINVAL;
> @@ -2363,15 +2367,33 @@ static int mana_dealloc_queues(struct net_device =
*ndev)
>  	 * to false, but it doesn't matter since mana_start_xmit() drops any
>  	 * new packets due to apc->port_is_up being false.
>  	 *
> -	 * Drain all the in-flight TX packets
> +	 * Drain all the in-flight TX packets.
> +	 * A timeout of 120 seconds for all the queues is used.
> +	 * This will break the while loop when h/w is not responding.
> +	 * This value of 120 has been decided here considering max
> +	 * number of queues.
>  	 */
> +
>  	for (i =3D 0; i < apc->num_queues; i++) {
>  		txq =3D &apc->tx_qp[i].txq;
> -
> -		while (atomic_read(&txq->pending_sends) > 0)
> -			usleep_range(1000, 2000);
> +		tsleep =3D 1000;
> +		while (atomic_read(&txq->pending_sends) > 0 &&
> +		       time_before(jiffies, timeout)) {
> +			usleep_range(tsleep, tsleep << 1);
> +			tsleep <<=3D 1;
> +		}
>  	}
> =20
> +	for (i =3D 0; i < apc->num_queues; i++) {
> +		txq =3D &apc->tx_qp[i].txq;
> +		cq =3D &apc->tx_qp[i].tx_cq;

The above variable is unused, and causes a build warning. Please remove
the assignment and the variable declaration.

Thanks,

Paolo



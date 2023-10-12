Return-Path: <netdev+bounces-40341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 403447C6D61
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 13:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93D028253E
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 11:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A6924A04;
	Thu, 12 Oct 2023 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROADgrZH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B02624213
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 11:53:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761CC3A9C
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 04:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697111444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bDXs32bIFljFLB3BizuC8Qgv2eOciC1P7puQyz2ihO4=;
	b=ROADgrZHTgIIbIDHHwlqWUBcBBbRruRsCi1VI3Ra9NjEWoqk6zRmVXrzs4C4cPy4bHSOaB
	P/O2iI5NbFFCQSq3Qixy/Mf8ZjMmbgThxauXHGe9yrMJkj+Us7arV3h+dXdjqV30iv/Olz
	Ato/wZEUH2JneoWYlbz9UhDXJn21Bs8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-WoA3iPg3M3-497qHD1Pdbw-1; Thu, 12 Oct 2023 07:50:43 -0400
X-MC-Unique: WoA3iPg3M3-497qHD1Pdbw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9ae6afce33fso20218166b.0
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 04:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697111442; x=1697716242;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bDXs32bIFljFLB3BizuC8Qgv2eOciC1P7puQyz2ihO4=;
        b=tSIdjTAsS0hMJNv0QGFFmVWasGad8ytiU06YO/F61KMu3kKAYGA8iIYTplWU4g6ZAJ
         hWF4U6KK53P11h91//r0+7dWsXwV5YdYgrtVXA99W5g4dCRRcPG8Ntzl0qPykD2Olry7
         lX3QwbeV7dc35Yu7ApcV2viA4EdtO5gKRh0Pr53hlKSxLXqS6g1WM62HVNFi+yXSb9Ux
         VlQC/eQxtvu4/bkEk/bcjoCvFGHyrCT0rHV++Q1ZLcVY3wIbV5BCnV3nL0NSkaaNRbj1
         IffG7jnjO4H1DbUqYaqFx2UvvF+Bb/+uMnopY+JLXnC7I8IPGwT+gXRCXUN1vZ6T0emj
         4a4w==
X-Gm-Message-State: AOJu0Yywq+3TvPodt/2nTfyanEeNpUTTDw8BV3DK2dg2d9cHDhBwzDTr
	NBI58pRUbvm9OGJdXEFDadki3UB6XBX1iQe3GS5U8b4em0RBxHLRYenqZpUNXWqB1Tev0Jk04Xv
	ecBKajuxDZYLmVdY7
X-Received: by 2002:a50:cd81:0:b0:53e:1f8d:84ff with SMTP id p1-20020a50cd81000000b0053e1f8d84ffmr900943edi.4.1697111441953;
        Thu, 12 Oct 2023 04:50:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGILmsF//spivhREAdLAZ2FzBOeke68a6oyeQ/jW1i/MVexUg0ZO3nc/Cy71sg5eFpFdclJ4w==
X-Received: by 2002:a50:cd81:0:b0:53e:1f8d:84ff with SMTP id p1-20020a50cd81000000b0053e1f8d84ffmr900924edi.4.1697111441580;
        Thu, 12 Oct 2023 04:50:41 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-181.dyn.eolo.it. [146.241.228.181])
        by smtp.gmail.com with ESMTPSA id ee48-20020a056402293000b0053120f313cbsm3282462edb.39.2023.10.12.04.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 04:50:41 -0700 (PDT)
Message-ID: <e704c45bc3c81d45541b82bded0618380d81634f.camel@redhat.com>
Subject: Re: [PATCH net-next v5 3/3] mctp i3c: MCTP I3C driver
From: Paolo Abeni <pabeni@redhat.com>
To: Matt Johnston <matt@codeconstruct.com.au>,
 linux-i3c@lists.infradead.org,  netdev@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,  Eric Dumazet <edumazet@google.com>, Jeremy Kerr
 <jk@codeconstruct.com.au>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  miquel.raynal@bootlin.com
Date: Thu, 12 Oct 2023 13:50:39 +0200
In-Reply-To: <20231009025451.490374-4-matt@codeconstruct.com.au>
References: <20231009025451.490374-1-matt@codeconstruct.com.au>
	 <20231009025451.490374-4-matt@codeconstruct.com.au>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-10-09 at 10:54 +0800, Matt Johnston wrote:

> +static int mctp_i3c_setup(struct mctp_i3c_device *mi)
> +{
> +	bool ibi_set =3D false, ibi_enabled =3D false;
> +	const struct i3c_ibi_setup ibi =3D {
> +		.max_payload_len =3D 1,
> +		.num_slots =3D MCTP_I3C_IBI_SLOTS,
> +		.handler =3D mctp_i3c_ibi_handler,
> +	};
> +	struct i3c_device_info info;
> +	int rc;
> +
> +	i3c_device_get_info(mi->i3c, &info);
> +	mi->have_mdb =3D info.bcr & BIT(2);
> +	mi->addr =3D info.dyn_addr;
> +	mi->mwl =3D info.max_write_len;
> +	mi->mrl =3D info.max_read_len;
> +	mi->pid =3D info.pid;
> +
> +	rc =3D i3c_device_request_ibi(mi->i3c, &ibi);
> +	if (rc =3D=3D 0) {
> +		ibi_set =3D true;
> +	} else if (rc =3D=3D -ENOTSUPP) {
> +		/* This driver only supports In-Band Interrupt mode
> +		 * (ENOTSUPP is from the i3c layer, not EOPNOTSUPP).
> +		 * Support for Polling Mode could be added if required.
> +		 */
> +		dev_warn(i3cdev_to_dev(mi->i3c), "Failed, bus driver doesn't support I=
n-Band Interrupts");
> +		goto err;
> +	} else {
> +		dev_err(i3cdev_to_dev(mi->i3c),
> +			"Failed requesting IBI (%d)\n", rc);
> +		goto err;
> +	}
> +
> +	if (ibi_set) {
> +		/* Device setup must be complete when IBI is enabled */
> +		rc =3D i3c_device_enable_ibi(mi->i3c);
> +		if (rc < 0) {
> +			/* Assume a driver supporting request_ibi also
> +			 * supports enable_ibi.
> +			 */
> +			dev_err(i3cdev_to_dev(mi->i3c),
> +				"Failed enabling IBI (%d)\n", rc);
> +			goto err;
> +		}
> +		ibi_enabled =3D true;
> +	}
> +
> +	return 0;
> +err:
> +	if (ibi_enabled)
> +		i3c_device_disable_ibi(mi->i3c);

Apparently no error code path can reach here with 'ibi_enabled =3D=3D
true', if so please drop the above lines.

> +	if (ibi_set)
> +		i3c_device_free_ibi(mi->i3c);
> +	return rc;
> +}
> +
> +/* Adds a new MCTP i3c_device to a bus */
> +static int mctp_i3c_add_device(struct mctp_i3c_bus *mbus,
> +			       struct i3c_device *i3c)
> +__must_hold(&busdevs_lock)
> +{
> +	struct mctp_i3c_device *mi =3D NULL;
> +	int rc;
> +
> +	mi =3D kzalloc(sizeof(*mi), GFP_KERNEL);
> +	if (!mi) {
> +		rc =3D -ENOMEM;
> +		goto err;
> +	}
> +	mi->mbus =3D mbus;
> +	mi->i3c =3D i3c;
> +	mutex_init(&mi->lock);
> +	list_add(&mi->list, &mbus->devs);
> +
> +	i3cdev_set_drvdata(i3c, mi);
> +	rc =3D mctp_i3c_setup(mi);
> +	if (rc < 0)
> +		goto err;

You can make the code simpler with:

		goto free;
> +
> +	return 0;

and here:

free:
	list_del(&mi->list);
	kfree(mi);

err:
	dev_warn(i3cdev_to_dev(i3c), "Error adding mctp-i3c device, %d\n", rc);
	return rc;

> +err:
> +	dev_warn(i3cdev_to_dev(i3c), "Error adding mctp-i3c device, %d\n", rc);
> +	if (mi) {
> +		list_del(&mi->list);
> +		kfree(mi);
> +	}
> +	return rc;
> +}
> +
> +static int mctp_i3c_probe(struct i3c_device *i3c)
> +{
> +	struct mctp_i3c_bus *b =3D NULL, *mbus =3D NULL;
> +	int rc;
> +
> +	/* Look for a known bus */
> +	mutex_lock(&busdevs_lock);
> +	list_for_each_entry(b, &busdevs, list)
> +		if (b->bus =3D=3D i3c->bus) {
> +			mbus =3D b;
> +			break;
> +		}
> +	mutex_unlock(&busdevs_lock);
> +
> +	if (!mbus) {
> +		/* probably no "mctp-controller" property on the i3c bus */
> +		return -ENODEV;
> +	}
> +
> +	rc =3D mctp_i3c_add_device(mbus, i3c);
> +	if (!rc)
> +		goto err;

This is confusing: if 'rc' is zero (!rc) the function will return 0
('return rc' later), and otherwise it will return zero again.

Either ignore the return code, or more likely the error path need some
change.

> +static void mctp_i3c_xmit(struct mctp_i3c_bus *mbus, struct sk_buff *skb=
)
> +{
> +	struct net_device_stats *stats =3D &mbus->ndev->stats;
> +	struct i3c_priv_xfer xfer =3D { .rnw =3D false };
> +	struct mctp_i3c_internal_hdr *ihdr =3D NULL;
> +	struct mctp_i3c_device *mi =3D NULL;
> +	unsigned int data_len;
> +	u8 *data =3D NULL;
> +	u8 addr, pec;
> +	int rc =3D 0;
> +	u64 pid;
> +
> +	skb_pull(skb, sizeof(struct mctp_i3c_internal_hdr));
> +	data_len =3D skb->len;
> +
> +	ihdr =3D (void *)skb_mac_header(skb);
> +
> +	pid =3D get_unaligned_be48(ihdr->dest);
> +	mi =3D mctp_i3c_lookup(mbus, pid);
> +	if (!mi) {
> +		/* I3C endpoint went away after the packet was enqueued? */
> +		stats->tx_dropped++;
> +		goto out;
> +	}
> +
> +	if (WARN_ON_ONCE(data_len + 1 > MCTP_I3C_MAXBUF))
> +		goto out;
> +
> +	if (data_len + 1 > (unsigned int)mi->mwl) {
> +		/* Route MTU was larger than supported by the endpoint */
> +		stats->tx_dropped++;
> +		goto out;
> +	}
> +
> +	/* Need a linear buffer with space for the PEC */
> +	xfer.len =3D data_len + 1;
> +	if (skb_tailroom(skb) >=3D 1) {
> +		skb_put(skb, 1);
> +		data =3D skb->data;
> +	} else {
> +		// TODO: test this

I hope this comment is a left over? In any case please avoid c++ style
comments.

> +		/* Otherwise need to copy the buffer */
> +		skb_copy_bits(skb, 0, mbus->tx_scratch, skb->len);
> +		data =3D mbus->tx_scratch;
> +	}
> +
> +	/* PEC calculation */
> +	addr =3D mi->addr << 1;
> +	pec =3D i2c_smbus_pec(0, &addr, 1);
> +	pec =3D i2c_smbus_pec(pec, data, data_len);
> +	data[data_len] =3D pec;
> +
> +	xfer.data.out =3D data;
> +	rc =3D i3c_device_do_priv_xfers(mi->i3c, &xfer, 1);
> +	if (rc =3D=3D 0) {
> +		stats->tx_bytes +=3D data_len;
> +		stats->tx_packets++;
> +	} else {
> +		stats->tx_errors++;
> +	}
> +
> +out:
> +	if (mi)
> +		mutex_unlock(&mi->lock);
> +}
> +
> +static int mctp_i3c_tx_thread(void *data)
> +{
> +	struct mctp_i3c_bus *mbus =3D data;
> +	struct sk_buff *skb;
> +	unsigned long flags;
> +
> +	for (;;) {
> +		if (kthread_should_stop())
> +			break;
> +
> +		spin_lock_irqsave(&mbus->tx_lock, flags);
> +		skb =3D mbus->tx_skb;
> +		mbus->tx_skb =3D NULL;
> +		spin_unlock_irqrestore(&mbus->tx_lock, flags);
> +
> +		if (netif_queue_stopped(mbus->ndev))
> +			netif_wake_queue(mbus->ndev);
> +
> +		if (skb) {
> +			mctp_i3c_xmit(mbus, skb);
> +			kfree_skb(skb);
> +		} else {
> +			wait_event_idle(mbus->tx_wq,
> +					mbus->tx_skb || kthread_should_stop());
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static netdev_tx_t mctp_i3c_start_xmit(struct sk_buff *skb,
> +				       struct net_device *ndev)
> +{
> +	struct mctp_i3c_bus *mbus =3D netdev_priv(ndev);
> +	unsigned long flags;
> +	netdev_tx_t ret;
> +
> +	spin_lock_irqsave(&mbus->tx_lock, flags);

Why are you using the _irqsave variant? The only other path acquiring
this lock is mctp_i3c_tx_thread(), in process context, while here we
have BH disabled. Plain spin_lock should suffice here, paired with _BH
variant in mctp_i3c_tx_thread.

> +	netif_stop_queue(ndev);
> +	if (mbus->tx_skb) {
> +		dev_warn_ratelimited(&ndev->dev, "TX with queue stopped");
> +		ret =3D NETDEV_TX_BUSY;
> +	} else {
> +		mbus->tx_skb =3D skb;
> +		ret =3D NETDEV_TX_OK;
> +	}
> +	spin_unlock_irqrestore(&mbus->tx_lock, flags);
> +
> +	if (ret =3D=3D NETDEV_TX_OK)
> +		wake_up(&mbus->tx_wq);
> +
> +	return ret;
> +}

[...]

> +/* Returns an ERR_PTR on failure */
> +static struct mctp_i3c_bus *mctp_i3c_bus_add(struct i3c_bus *bus)
> +__must_hold(&busdevs_lock)
> +{
> +	struct mctp_i3c_bus *mbus =3D NULL;
> +	struct net_device *ndev =3D NULL;
> +	char namebuf[IFNAMSIZ];
> +	u8 addr[PID_SIZE];
> +	int rc;
> +
> +	if (!mctp_i3c_is_mctp_controller(bus))
> +		return ERR_PTR(-ENOENT);
> +
> +	snprintf(namebuf, sizeof(namebuf), "mctpi3c%d", bus->id);
> +	ndev =3D alloc_netdev(sizeof(*mbus), namebuf, NET_NAME_ENUM,
> +			    mctp_i3c_net_setup);
> +	if (!ndev) {
> +		rc =3D -ENOMEM;
> +		goto err;
> +	}
> +
> +	mbus =3D netdev_priv(ndev);
> +	mbus->ndev =3D ndev;
> +	mbus->bus =3D bus;
> +	INIT_LIST_HEAD(&mbus->devs);
> +	list_add(&mbus->list, &busdevs);
> +
> +	rc =3D mctp_i3c_bus_local_pid(bus, &mbus->pid);
> +	if (rc < 0) {
> +		dev_err(&ndev->dev, "No I3C PID available\n");
> +		goto err;
> +	}
> +	put_unaligned_be48(mbus->pid, addr);
> +	dev_addr_set(ndev, addr);
> +
> +	init_waitqueue_head(&mbus->tx_wq);
> +	spin_lock_init(&mbus->tx_lock);
> +	mbus->tx_thread =3D kthread_run(mctp_i3c_tx_thread, mbus,
> +				      "%s/tx", ndev->name);
> +	if (IS_ERR(mbus->tx_thread)) {
> +		dev_warn(&ndev->dev, "Error creating thread: %pe\n",
> +			 mbus->tx_thread);
> +		rc =3D PTR_ERR(mbus->tx_thread);
> +		mbus->tx_thread =3D NULL;
> +		goto err;
> +	}
> +
> +	rc =3D mctp_register_netdev(ndev, NULL);
> +	if (rc < 0) {
> +		dev_warn(&ndev->dev, "netdev register failed: %d\n", rc);
> +		goto err;
> +	}
> +	return mbus;
> +err:
> +	/* uninit will not get called if a netdev has not been registered,
> +	 * so we perform the same mbus cleanup manually.
> +	 */
> +	if (mbus)
> +		mctp_i3c_bus_free(mbus);
> +	if (ndev)
> +		free_netdev(ndev);

A more conventional way of handling the error paths would be using
multiple labels, e.g.:

err_free_bus:
	mctp_i3c_bus_free(mbus);

err_free_ndev:
	free_netdev(ndev);

err:

> +	return ERR_PTR(rc);
> +}

Cheers,

Paolo



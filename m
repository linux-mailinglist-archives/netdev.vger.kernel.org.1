Return-Path: <netdev+bounces-36742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539A77B1881
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 12:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 70CC51C20926
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 10:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3E934CE6;
	Thu, 28 Sep 2023 10:47:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28F7347B4
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 10:47:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59E7180
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 03:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695898063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ln7nBtbB3HSzrs824SPmjJNYFlMaVQ56dKj3tSW3060=;
	b=D/bS60PhBUvZbrhswIJMiQcT596jyXo1a3j4u/BYywK83YiEBULHxuAVeQfpuDNTTi/LBR
	vQlT5X8ETzd9G8qsu2+uDRKYSAuxCSDMWmcIF5T1kvI9he7BonuQr3Q2tvpfO0TxKurAc9
	ewvteUd5jKssEv5c42J1JQVf5bBCRsw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-0LKhdzaHMCObiTy5vAI_9A-1; Thu, 28 Sep 2023 06:47:41 -0400
X-MC-Unique: 0LKhdzaHMCObiTy5vAI_9A-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-65623d0075aso43728896d6.0
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 03:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695898061; x=1696502861;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ln7nBtbB3HSzrs824SPmjJNYFlMaVQ56dKj3tSW3060=;
        b=ED5FVERJvrTkpwwxC0pRw6UIHrmDqDjh3VZsFK4tkvTlS4UsWLCehVau9d9VlPY1YJ
         Qnf0x/OjhuzpqRuhQdec6YKyxxWA4gLNzUZ5n/BwWpLMO0luV5eK698n7Hh4excRHcft
         tUA/yv/mLRh6F70/hjPg4MwFR7DCoyQOidIhySc9U3WZRnwKqxDci6fdyYMtdNdsQhBX
         8LcCsVh84mSEvmAlFAmkaPe4Z68MVxE5KatPEh3Vr++BvGkVr4U53d+a6aiHxqGbaJlP
         AFylbY35uUqOK/Q75uRnTnuuQjX64g9kG3TZURRASZzLYl6fJ07DLnFyAHmr2n5UT5j4
         fG1Q==
X-Gm-Message-State: AOJu0YxXcQ+UHNBzEBqUaBweuZiF1GJVsldgcTz1yGEUD+9np4DFiD2A
	8PlSwpU1Hy82CmuktnwfIJ6Qu0Xr/c9wiXs5YE6iD7tY0VQPODikB1QoFQH7dFRyjvPY5yeC/jo
	vHZzA+DPawEX8tRphXE+aYtG7zHE=
X-Received: by 2002:a05:6214:19e9:b0:658:305f:d81d with SMTP id q9-20020a05621419e900b00658305fd81dmr772065qvc.0.1695898061157;
        Thu, 28 Sep 2023 03:47:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkTXv5wvFKkXMHtEiBwdWYCDh5WhCZHVsgRXgsbtiF24MsT5CvY1aiZUYVR3Fb8VwyKurvnA==
X-Received: by 2002:a05:6214:19e9:b0:658:305f:d81d with SMTP id q9-20020a05621419e900b00658305fd81dmr772047qvc.0.1695898060797;
        Thu, 28 Sep 2023 03:47:40 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-183.dyn.eolo.it. [146.241.233.183])
        by smtp.gmail.com with ESMTPSA id e5-20020a0cb445000000b0063d5d173a51sm4192103qvf.50.2023.09.28.03.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 03:47:40 -0700 (PDT)
Message-ID: <52204e24f0578871e699a60bbe8186f27600c4e5.camel@redhat.com>
Subject: Re: [net-next PATCH v3 02/10] net: Add queue and napi association
From: Paolo Abeni <pabeni@redhat.com>
To: Amritha Nambiar <amritha.nambiar@intel.com>, netdev@vger.kernel.org, 
	kuba@kernel.org
Cc: sridhar.samudrala@intel.com
Date: Thu, 28 Sep 2023 12:47:38 +0200
In-Reply-To: <169516244584.7377.16939532936643936800.stgit@anambiarhost.jf.intel.com>
References: 
	<169516206704.7377.12938469824609831999.stgit@anambiarhost.jf.intel.com>
	 <169516244584.7377.16939532936643936800.stgit@anambiarhost.jf.intel.com>
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

On Tue, 2023-09-19 at 15:27 -0700, Amritha Nambiar wrote:
> Add the napi pointer in netdev queue for tracking the napi
> instance for each queue. This achieves the queue<->napi mapping.
>=20
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  include/linux/netdevice.h     |    5 +++++
>  include/net/netdev_rx_queue.h |    2 ++
>  net/core/dev.c                |   34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+)
>=20
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index db3d8429d50d..69e363918e4b 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -657,6 +657,8 @@ struct netdev_queue {
> =20
>  	unsigned long		state;
> =20
> +	/* NAPI instance for the queue */
> +	struct napi_struct      *napi;

This should be probably moved into the 'read-mostly' section, before
the '_xmit_lock' field,=20

>  +/**
> + * netif_napi_add_queue - Associate queue with the napi
> + * @napi: NAPI context
> + * @queue_index: Index of queue
> + * @type: queue type as RX or TX
> + *
> + * Add queue with its corresponding napi context
> + */
> +int netif_napi_add_queue(struct napi_struct *napi, unsigned int queue_in=
dex,
> +			 enum netdev_queue_type type)

Very minor nit and others may have different opinion, but I feel like
this function name is misleading, since at this point both the rx and
tx queue should already exist. Perhaps 'netif_napi_link_queue' ?

Cheers,

Paolo



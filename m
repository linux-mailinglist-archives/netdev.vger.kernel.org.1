Return-Path: <netdev+bounces-14510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE0074226E
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 10:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9AD1280D3B
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 08:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FFF5253;
	Thu, 29 Jun 2023 08:42:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6507184
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 08:42:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF59294E
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 01:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688028159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7uH2v60++wlSFd3mdA5C25peNy3bqIH/P5Zip2EcJY=;
	b=Alr/EKmhy79bwZ4O9Q7RJfYzqgYu7h5Af1xyuy8aVNI1RCX674wCfylb/e5nxm7S1sBPIf
	M/+pIMQ5unn9KQ2tSpBxLCbCwazE8QO9w4nk70IJ25SSfoHh7EpKl0cbshZRZkbF9NBEt7
	XFcJaXoUnBQBj9WFzQPWquMapAQXY5A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-5HN0utTyNPSZVsfbJ0DDqA-1; Thu, 29 Jun 2023 04:42:38 -0400
X-MC-Unique: 5HN0utTyNPSZVsfbJ0DDqA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-313ecc94e23so41574f8f.0
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 01:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688028157; x=1690620157;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y7uH2v60++wlSFd3mdA5C25peNy3bqIH/P5Zip2EcJY=;
        b=RDoncShatadP3zKD3B31unQBUm7NJNzCk8HyjB/5evvOgahW6nLURS35YeyU3Eb8qM
         DfU7rZDUPMOn0/w72PwIB0QIcX7vGbtvsgan/zba1dmudx1rWweSiD5wsVbHNObBbnTH
         C5AOtTxpHzbiujFTCkSNS8+Uhr+36U0ug6eRdw+OaXniv5dV4ZNyDBYIHVmtv/EnptbR
         xZG/APxmlhEI/zqgZqZTf3tiPVqFD88N1Pk4pIcbAVKyDfX60vJXsnFLVD/kaf139yxA
         N7q2bgqoiN76+IXzqgOfeehLpa4VC6NNSkPMjYvm1y6OCgTejrvTEdqYn+9w6APBXwJC
         GxzQ==
X-Gm-Message-State: AC+VfDy6XFSTOaBZC625IKNPawKnmfYzPANNvea7HDv8NDivDaQh5+Fx
	WwYRRNFasA8CU0l/D5f+UQR4JkNUyglybY3CLHLfcl0JK3U3WgpqUoviz0LsUwwjfHlpvn296Us
	mcSx754uyfiqTXjMW
X-Received: by 2002:a1c:ed17:0:b0:3f5:f543:d81f with SMTP id l23-20020a1ced17000000b003f5f543d81fmr38947298wmh.3.1688028157032;
        Thu, 29 Jun 2023 01:42:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6+iH2URekcBBIFaPW3s8y3AcFdwpt0qhkGkVRHNjX6kI62bNLzHfSyF8zFoO0Ym2TuJLWyPg==
X-Received: by 2002:a1c:ed17:0:b0:3f5:f543:d81f with SMTP id l23-20020a1ced17000000b003f5f543d81fmr38947276wmh.3.1688028156751;
        Thu, 29 Jun 2023 01:42:36 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-196.dyn.eolo.it. [146.241.231.196])
        by smtp.gmail.com with ESMTPSA id r15-20020adfe68f000000b003111025ec67sm15279253wrm.25.2023.06.29.01.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 01:42:36 -0700 (PDT)
Message-ID: <36c95dd6babb2202f70594d5dde13493af62dcad.camel@redhat.com>
Subject: Re: [Patch v3] net: mana: Batch ringing RX queue doorbell on
 receiving packets
From: Paolo Abeni <pabeni@redhat.com>
To: longli@linuxonhyperv.com, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Ajay Sharma <sharmaajay@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Long Li
	 <longli@microsoft.com>, stable@vger.kernel.org
Date: Thu, 29 Jun 2023 10:42:34 +0200
In-Reply-To: <1687823827-15850-1-git-send-email-longli@linuxonhyperv.com>
References: <1687823827-15850-1-git-send-email-longli@linuxonhyperv.com>
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
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-06-26 at 16:57 -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
>=20
> It's inefficient to ring the doorbell page every time a WQE is posted to
> the received queue. Excessive MMIO writes result in CPU spending more
> time waiting on LOCK instructions (atomic operations), resulting in
> poor scaling performance.
>=20
> Move the code for ringing doorbell page to where after we have posted all
> WQEs to the receive queue during a callback from napi_poll().
>=20
> With this change, tests showed an improvement from 120G/s to 160G/s on a
> 200G physical link, with 16 or 32 hardware queues.
>=20
> Tests showed no regression in network latency benchmarks on single
> connection.
>=20
> While we are making changes in this code path, change the code for
> ringing doorbell to set the WQE_COUNT to 0 for Receive Queue. The
> hardware specification specifies that it should set to 0. Although
> currently the hardware doesn't enforce the check, in the future releases
> it may do.
>=20
> Cc: stable@vger.kernel.org
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network=
 Adapter (MANA)")

Uhmmm... this looks like a performance improvement to me, more suitable
for the net-next tree ?!? (Note that net-next is closed now).

In any case you must avoid empty lines in the tag area.

If you really intend targeting the -net tree, please repost fixing the
above and explicitly specifying the target tree in the subj prefix.

thanks!

Paolo



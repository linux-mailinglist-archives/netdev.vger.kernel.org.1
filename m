Return-Path: <netdev+bounces-40275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DA97C6797
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 10:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0EE282732
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 08:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF9CDF6A;
	Thu, 12 Oct 2023 08:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gqd1awJJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345601DDD0
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 08:31:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ACE91
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 01:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697099503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IDXTErD9yX+SuZgZbDMto+/s3M8gWyq6fvO38E6htEU=;
	b=Gqd1awJJfdhy4IUk4B01LXJdD6SppWwZrUMseSR5stnzW5yaP08z4kIZTwsC7kBuRWsktI
	yTBBOkHd+aSPHuw8S1LVONAAaQx+X8oIBJiXoGNFO1yhaV60/pg0XvKhvL87kiRfHzuFFg
	9pDHRSIPmlMARZlYOO0B2ztJftKQtuo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-50NPzYZYOaWXEir7UWbt0Q-1; Thu, 12 Oct 2023 04:31:37 -0400
X-MC-Unique: 50NPzYZYOaWXEir7UWbt0Q-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-534c9a316cbso100430a12.1
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 01:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697099496; x=1697704296;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IDXTErD9yX+SuZgZbDMto+/s3M8gWyq6fvO38E6htEU=;
        b=HuoD5Fy7Gqr3g0zRqhqKHCtxtmBONSGs5vs8j1nW+SQ99OZwUBti5gLScLMJdq35/W
         LOPgUysCFaD3B+o5FRnIcLbesRAOrPwmHlTaGH5D705T0EuTOpfVwy4z/d1GvyHOeAv2
         PP9iY+uCHB9LhQhdt6Trfcoga2g+ZrZ22/n3pAFWZeuTAAeY2w9GOZvSyzjXCuIm3xm7
         435ieWoWJM4x+S+ZDQtDU4xJsOm7X7sr5HlPKrfd8vu8wPaabpveQfBpXKRAC0/I63gl
         aNy1/CyywVBZsJNmU0WaGNArSdxDP05QTlIBOm+CWGrHwxnfmkkx1aMBbqAJwNEikEyb
         dFfA==
X-Gm-Message-State: AOJu0YxODQmiWBT4LfCkC9Cwk+W47qH3ZYdSOwiMaWMI9gKc2g/MNmRW
	psU702t9QFttuvfHD70GGjzDTYJFIJLLvaT/fcLMu7BtRpdJluwsv/iFpHhu0gq9w7ZEQgq6veQ
	ki9EmPlksExtwBVpw
X-Received: by 2002:a05:6402:290c:b0:53d:aaf5:c49e with SMTP id ee12-20020a056402290c00b0053daaf5c49emr3925140edb.1.1697099495953;
        Thu, 12 Oct 2023 01:31:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsDOMpD2VqYx4OQvPxT4GPKqTdL4UTaNatbTMWJVg2p9WFu8D79ionvNKPMnlR0Lw9tOHV9A==
X-Received: by 2002:a05:6402:290c:b0:53d:aaf5:c49e with SMTP id ee12-20020a056402290c00b0053daaf5c49emr3925127edb.1.1697099495658;
        Thu, 12 Oct 2023 01:31:35 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-181.dyn.eolo.it. [146.241.228.181])
        by smtp.gmail.com with ESMTPSA id cb5-20020a0564020b6500b0053ddbfa71ddsm1660937edb.47.2023.10.12.01.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 01:31:35 -0700 (PDT)
Message-ID: <237ad66815a7988eaf9b0ed2132772c58e868cd8.camel@redhat.com>
Subject: Re: [net PATCH] octeon_ep: update BQL sent bytes before ringing
 doorbell
From: Paolo Abeni <pabeni@redhat.com>
To: Shinas Rasheed <srasheed@marvell.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, hgani@marvell.com
Cc: vimleshk@marvell.com, egallen@redhat.com, mschmidt@redhat.com, 
 Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara
 <sedara@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Satananda Burla
 <sburla@marvell.com>, Abhijit Ayarekar <aayarekar@marvell.com>
Date: Thu, 12 Oct 2023 10:31:33 +0200
In-Reply-To: <20231010115015.2279977-1-srasheed@marvell.com>
References: <20231010115015.2279977-1-srasheed@marvell.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-10-10 at 04:50 -0700, Shinas Rasheed wrote:
> Sometimes Tx is completed immediately after doorbell is updated, which
> causes Tx completion routing to update completion bytes before the
> same packet bytes are updated in sent bytes in transmit function, hence
> hitting BUG_ON() in dql_completed(). To avoid this, update BQL
> sent bytes before ringing doorbell.
>=20
> Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt suppo=
rt")
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/driver=
s/net/ethernet/marvell/octeon_ep/octep_main.c
> index dbc518ff8276..314f9c661f93 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> @@ -718,6 +718,7 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *s=
kb,
>  	/* Flush the hw descriptor before writing to doorbell */
>  	wmb();
> =20
> +	netdev_tx_sent_queue(iq->netdev_q, skb->len);

If tx completion and start_xmit happen on 2 different CPUs, how do you
ensure that xmit_completion will observe the values written here?

Specifically, don't you need to move netdev_tx_sent_queue() before the
above memory barrier?

Thanks,

Paolo



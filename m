Return-Path: <netdev+bounces-19560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4744775B32D
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 17:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAF0281C9E
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 15:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9B718C12;
	Thu, 20 Jul 2023 15:42:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB3718B15
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 15:42:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF74123
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689867721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7OLp1uUmCJ53hOJJpij7zz69GK4KqAF3nfZ2ExV0SM=;
	b=Pb7sfUUYidYTEUqMPlcRmFsQWZU38TiNRdNYs6uEZEspJnKToLp9q6DCp7pIrjoGLjdXzo
	j8wVPEg07J+zRNdPb0xjJiZ6qFqRWZxNE8OdQ4P5wkBncuYQCb/mhpfkmSf+YX9iHYty89
	FZWQhLpwpZ2fNDytTjdVR0302UzU1Qs=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-rVWtcBa_NM2kjesA0mV3Vg-1; Thu, 20 Jul 2023 11:41:41 -0400
X-MC-Unique: rVWtcBa_NM2kjesA0mV3Vg-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-78f229d2217so22518241.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689867696; x=1690472496;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w7OLp1uUmCJ53hOJJpij7zz69GK4KqAF3nfZ2ExV0SM=;
        b=CitJoI7RiZ+vHcBGV6I+7iU2zF/7wFmEdQ69YeBwb7ddvqUsJGm3c/0+axWPdAzBn2
         IS1DtSbdzWPWojMoNr1hYKZUNNaN8Tb5MF6DHiIjXg5Yo/91ScFEF4M0rCV2F/CTIGt4
         RPGbj0/tm5zqpDMIYk9mewJWkdKiRr8HI/UlKOPGy3b+4Q/PbrqyCyDSXraxGXytUDiA
         5uM65GAdN2u7tWYfEKJTc5UrPAGMolf33RYiUbW6m/PPLImctZRm3iuAaW6SKl0PwITF
         9myIC8xVD+OUnTOEERSP4M8/Jpt3cJXV8nqqaB94KTRNwfBC8DlfTxCgHNM7/uzx5UwQ
         c0sQ==
X-Gm-Message-State: ABy/qLY3CvVC71igYuUP1CKw5m1dLA9SaRUg9VlAuSB/HdQ7fgpqKPPy
	m0eMfdQdN/4zwlTyxPj0Ebnxc/CbxFNyucl3Vp1/ACnpPBuSbfLSP5jxHECLCH6jevWKM+KU+S0
	N9CEQ7pUNBrRNtbxt
X-Received: by 2002:a05:6102:f94:b0:443:5da9:457e with SMTP id e20-20020a0561020f9400b004435da9457emr1728230vsv.0.1689867695984;
        Thu, 20 Jul 2023 08:41:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEvkLIyAMDCwQnxtUKTiPdRNTa7tw3VnHB2DwXE3IRgg9ncictWrRgsjiSyp2qC6s7t+ynxvg==
X-Received: by 2002:a05:6102:f94:b0:443:5da9:457e with SMTP id e20-20020a0561020f9400b004435da9457emr1728218vsv.0.1689867695715;
        Thu, 20 Jul 2023 08:41:35 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id k5-20020a05620a142500b00767d05117fesm378884qkj.36.2023.07.20.08.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 08:41:35 -0700 (PDT)
Message-ID: <d2e9982b50ad94915454d7587663496e49a25746.camel@redhat.com>
Subject: Re: [PATCH net-next] tcp: get rid of sysctl_tcp_adv_win_scale
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Soheil Hassas Yeganeh <soheil@google.com>, Neal
 Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>,
 eric.dumazet@gmail.com
Date: Thu, 20 Jul 2023 17:41:32 +0200
In-Reply-To: <20230717152917.751987-1-edumazet@google.com>
References: <20230717152917.751987-1-edumazet@google.com>
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
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Mon, 2023-07-17 at 15:29 +0000, Eric Dumazet wrote:
> +static inline void tcp_scaling_ratio_init(struct sock *sk)
> +{
> +	/* Assume a conservative default of 1200 bytes of payload per 4K page.
> +	 * This may be adjusted later in tcp_measure_rcv_mss().
> +	 */
> +	tcp_sk(sk)->scaling_ratio =3D (1200 << TCP_RMEM_TO_WIN_SCALE) /
> +				    SKB_TRUESIZE(4096);

I'm giving this patch a closer look because mptcp_rcv_space_adjust
needs to be updated on top of it. Should SKB_TRUESIZE(4096) be replaced
with:

4096 + SKB_DATA_ALIGN(sizeof(struct skb_shared_info))=20

to be more accurate? The page should already include the shared info,
right?

Likely not very relevant as the ratio is updated to a more accurate
value with the first packet, mostly to try to understand the code
correctly.

Thanks!

Paolo



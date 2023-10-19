Return-Path: <netdev+bounces-42577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CE17CF650
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E770281C84
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 11:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F89D18C17;
	Thu, 19 Oct 2023 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpSr6XHV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE19D18C0A
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 11:12:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674F5FA
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 04:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697713924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILa4uBjxyobbeoUZ3eypQvETK4zN7IBK5LsP/FR2j6U=;
	b=QpSr6XHVJXQUjG9rg3ofKUVz8mq2CbFPcSiTXxan+HcsJw0vujH6svo+CSx7ncI9RdmMT0
	DA6E2FeQGOLPu7oeLKGIQ2S930KKv0VdWK9bk9jlSnWoQgBRN60lRdk80X3PbeyuhaoEvk
	95xOH43512G3/ADXgE4DX7rwwAspShk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-JsrjqfcCOyqnRblYSAMckg-1; Thu, 19 Oct 2023 07:12:03 -0400
X-MC-Unique: JsrjqfcCOyqnRblYSAMckg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9bfbc393c43so60013566b.1
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 04:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697713922; x=1698318722;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ILa4uBjxyobbeoUZ3eypQvETK4zN7IBK5LsP/FR2j6U=;
        b=WYu6xaTKSChyvxzx8HVwIlZ8ToJ1xok+Pw1Oc48f2o9+fFlDB55qloZeNCPSAndAjW
         3otFIvcnJ7ciOIkfICo0yqK70qzH4ogkFrGh9LV+8TR9eeLSf24VG1g5S5RZDZQOfOjf
         2JAyD+iWlu/m6gitBKyL5KUJFsGbP6m3tiCAUFeqRCpdoNbUoqwr8w6uQ3H0JGiRAIV2
         pfg+Xw2EZLo2NKiV7oWSsZina5xJK2b9tv4dxb045FGKabtMnKlosGMpLuTmY6U7svK6
         mnISME1pVDvOFuBO2chFnuoyn8pdJPEMPpfFLPR1KS+0eO32ae/HeKvwYHQlDl7nxEdO
         jQUA==
X-Gm-Message-State: AOJu0YzIkwNG0LNEifJR8g+Ufj6Pa3d9XESEU1/PdVWxFxsipopEer6t
	wWu0MsnnMB/bpIbj1bnN9dcwK/3t2QWm+OLZO7nYMdZ4Kigavvd+r8REEI0J3RtjRrbB8T+xRUu
	N3/+yfaSkkvTr17Z2
X-Received: by 2002:a17:907:7ea0:b0:9c4:950:92b5 with SMTP id qb32-20020a1709077ea000b009c4095092b5mr1355488ejc.6.1697713922248;
        Thu, 19 Oct 2023 04:12:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmq75eTdlDutovx76QqD73FfTXxhYGwdAZbpCYFonSQooc9aVbsH7S/KyZHpl3Gmr8yHVucg==
X-Received: by 2002:a17:907:7ea0:b0:9c4:950:92b5 with SMTP id qb32-20020a1709077ea000b009c4095092b5mr1355463ejc.6.1697713921866;
        Thu, 19 Oct 2023 04:12:01 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-237-142.dyn.eolo.it. [146.241.237.142])
        by smtp.gmail.com with ESMTPSA id y17-20020a170906519100b009a9fbeb15f5sm3273919ejk.46.2023.10.19.04.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 04:12:01 -0700 (PDT)
Message-ID: <8c74aa6a3fdc417f6573578e084f2a655ddd655b.camel@redhat.com>
Subject: Re: [PATCH net-next] inet: lock the socket in ip_sock_set_tos()
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Christoph Paasch <cpaasch@apple.com>
Date: Thu, 19 Oct 2023 13:12:00 +0200
In-Reply-To: <20231018090014.345158-1-edumazet@google.com>
References: <20231018090014.345158-1-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-10-18 at 09:00 +0000, Eric Dumazet wrote:
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 18ce624bfde2a5a451e42148ec7349d1ead2cec3..59bd5e114392a007a71df5721=
7e0ec357aae8229 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -738,7 +738,7 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_s=
ock *msk, int optname,
>  	mptcp_for_each_subflow(msk, subflow) {
>  		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> =20
> -		ip_sock_set_tos(ssk, val);
> +		__ip_sock_set_tos(ssk, val);

[not introduced by this patch] but I think here we need the locked
version.

As a pre-existent issue, I think it's better handled as a separate
patch - that can go through the mptcp CI.

No additional action needed here, thanks!

Paolo



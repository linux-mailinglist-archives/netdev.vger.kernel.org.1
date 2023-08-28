Return-Path: <netdev+bounces-31024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BC878A9E3
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 12:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33161C208BC
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 10:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B963F6AD7;
	Mon, 28 Aug 2023 10:17:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5A911C8D
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 10:17:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304B4132
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 03:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693217831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KcjP4KV6fMpkBHQo9eR0heg/yFLgiC7gAFcEQzg242c=;
	b=a4OUtWsO9ILdG/8/p2AAbGB7JwSj4d0XldBRmXkCrtEt6gy0oFsBRsDsyn0wnCV1d2VtPC
	iMO88KZpu6AGxZ7+PjAtlE0eNee/rNa13disfatnRJPSnvk4k8B9n5tITDCKDR/Pph9Kzc
	654364z0kHw9llIRqQjFEDEVLyYZjvc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-quEglgcLOeW7HKHMrA6n0A-1; Mon, 28 Aug 2023 06:17:10 -0400
X-MC-Unique: quEglgcLOeW7HKHMrA6n0A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a5b578b1c1so14062266b.1
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 03:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693217829; x=1693822629;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KcjP4KV6fMpkBHQo9eR0heg/yFLgiC7gAFcEQzg242c=;
        b=HrehRioZXVWe8+0wT1/56dxYEoWh0OEHLR5+xNOFb9pKeVpYbvEYH+YyFpQ8XnmRAA
         adMGVRMyKu5thcJl3c/yifG4eRW4o+36N9zDUOH4kwbphJNoVxG4sDNIthZYVXZbXWNT
         skP4EbjEJia4/uhSNN1kjQlZYubO2PwGi1iU1OxLkPdQVuCTkC2kI592xP/1K+dW3pD3
         XHEF/9vpyWB+eR4wX0ZOxiOv7vxQr6aIiRLC9sfqwNPF4uxcc8nNXaPykuvqC3Dtwx52
         K1LJVc5jbJ46mEu5oTLErrnFmS6/G1NxsCZdE5ebW/H9IyKQzAu3wA8MiTe3uNaAreC/
         OPRw==
X-Gm-Message-State: AOJu0YzH7u6Su5fbE99lPoSP0MPATK74DEK2DYT5cMkR0RBklHnoWUNy
	s9VB7vlQtGDuQP+eYa05WdGUVeJL7I/lqvAUd3ySjFKjCZXb5DL6bKrnFa5vd6EMZmRUWJ3aPIb
	fF3gs0L9PWoEeVmGbfsq0r9p/
X-Received: by 2002:a17:906:1dd:b0:99d:ecb4:12fd with SMTP id 29-20020a17090601dd00b0099decb412fdmr18555067ejj.6.1693217828934;
        Mon, 28 Aug 2023 03:17:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuQ1ivUZh5ReTyVNwe4awvJYCZF8Yho2LZZ5LhVYNoBqqt4S+expYzsQCNwkei3qEY6F+NLQ==
X-Received: by 2002:a17:906:1dd:b0:99d:ecb4:12fd with SMTP id 29-20020a17090601dd00b0099decb412fdmr18555055ejj.6.1693217828662;
        Mon, 28 Aug 2023 03:17:08 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-28.dyn.eolo.it. [146.241.242.28])
        by smtp.gmail.com with ESMTPSA id y16-20020a1709064b1000b009a1dbf55665sm4449915eju.161.2023.08.28.03.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 03:17:08 -0700 (PDT)
Message-ID: <bdf7db1a44ab0ee46fc621329ef9bc61734a723a.camel@redhat.com>
Subject: Re: [PATCH net-next] net: annotate data-races around sock->ops
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, syzbot
	 <syzkaller@googlegroups.com>
Date: Mon, 28 Aug 2023 12:17:06 +0200
In-Reply-To: <20230808135809.2300241-1-edumazet@google.com>
References: <20230808135809.2300241-1-edumazet@google.com>
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
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Tue, 2023-08-08 at 13:58 +0000, Eric Dumazet wrote:
> IPV6_ADDRFORM socket option is evil, because it can change sock->ops
> while other threads might read it. Same issue for sk->sk_family
> being set to AF_INET.
>=20
> Adding READ_ONCE() over sock->ops reads is needed for sockets
> that might be impacted by IPV6_ADDRFORM.
>=20
> Note that mptcp_is_tcpsk() can also overwrite sock->ops.
>
> Adding annotations for all sk->sk_family reads will require
> more patches :/

I was unable to give the above a proper look before due to OoO on my
side.

The mptcp code calls mptcp_is_tcpsk() only before the fd for the newly
accepted socket is installed, so we should not have concurrent racing
access to sock->ops?!? Do you have any related splat handy?

Thanks,

Paolo



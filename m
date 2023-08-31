Return-Path: <netdev+bounces-31509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA3C78E76B
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 09:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903321C20978
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 07:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AA06D1B;
	Thu, 31 Aug 2023 07:55:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596611FCC
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 07:55:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B192CE6
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 00:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693468502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AFCBW6rCxzHT8QDxWMfkC1QSjZUNSVMMnANNfOIyICk=;
	b=Qd0WkKzvykxh9S2GzAzJTnFPTYBQvT54R6Os4Zh84GwBTXH8FnGZ0qQxVtUYEXLK03gu+O
	FLwrOY1RJUjghLvO58aq25ECK16E0YbFQKUnWDJyJK9L995EAfC/o/X3tvr6wUOUeijmL5
	eY/kO08wpvN9E1okjuqK85LNzLsH7gQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-ssa1XMIiONWo0qpQWGKhfg-1; Thu, 31 Aug 2023 03:55:00 -0400
X-MC-Unique: ssa1XMIiONWo0qpQWGKhfg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5219df4e8c4so128661a12.1
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 00:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693468499; x=1694073299;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFCBW6rCxzHT8QDxWMfkC1QSjZUNSVMMnANNfOIyICk=;
        b=lK/etfvtK9d4V5d/VE/fD9reZPlKyHMQqJ6/BnONzYbpcfprkKMVxlt6Nfyd0vMx0a
         saF7qZJfyk/OMV7Q5YwZN4rZ87gXUWLWpHV4QNqXOdW+KTkOSlyHRuMpk/s27c2mYvJ7
         xnU9Vvq8iPvhZd+3h6kl/wDHGXQPszIGbiK83IqxhR1vamoTcDH5r9xoBMy1N0ia9u2E
         Sjh9zYG9CWz/MvCcq6keMuG/ZekRoI6dDQhWEnzUqeG6GzU3d6LsZtqfBRHwAfWbN+Uy
         hU0fR6nJwGUWlLwAlOUDmqFxnaciSJI72RGVDFRA4T9gd6/HHSC2dJpQQ9Sx4yQ7XzuR
         pUCQ==
X-Gm-Message-State: AOJu0Yz6zQwYmt9YeUbrn0Z/TG83zADbbKi7kyfM9GOgCOF/PQJKQrm0
	fE+glNTyKV9WMCiYPDiA3w9qzjzlZdbiKatbF8V64AEvqHBqStQUCEy5R9sdyhn7zDm0U4H7Tk9
	kNxfORC/Hy5zYyM0F
X-Received: by 2002:a17:906:212:b0:9a1:d79a:4190 with SMTP id 18-20020a170906021200b009a1d79a4190mr3352790ejd.2.1693468499776;
        Thu, 31 Aug 2023 00:54:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKpUjVqq/t5WzNIiiLqkk0ml1BwVka30lMuIwJV1S0IcEC4PeE+4TVsBIUgwye7EyLlD/gvg==
X-Received: by 2002:a17:906:212:b0:9a1:d79a:4190 with SMTP id 18-20020a170906021200b009a1d79a4190mr3352784ejd.2.1693468499463;
        Thu, 31 Aug 2023 00:54:59 -0700 (PDT)
Received: from gerbillo.redhat.com (host-87-20-178-126.retail.telecomitalia.it. [87.20.178.126])
        by smtp.gmail.com with ESMTPSA id lg16-20020a170906f89000b009a0955a7ad0sm456395ejb.128.2023.08.31.00.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 00:54:58 -0700 (PDT)
Message-ID: <566a0f821ec2fdbcb6b31aae56e478c6d4d59fa3.camel@redhat.com>
Subject: Re: [PATCH net] net/handshake: fix null-ptr-deref in
 handshake_nl_done_doit()
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, syzbot
	 <syzkaller@googlegroups.com>, Chuck Lever <chuck.lever@oracle.com>
Date: Thu, 31 Aug 2023 09:54:57 +0200
In-Reply-To: <20230828091325.2471746-1-edumazet@google.com>
References: <20230828091325.2471746-1-edumazet@google.com>
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

On Mon, 2023-08-28 at 09:13 +0000, Eric Dumazet wrote:
> We should not call trace_handshake_cmd_done_err() if socket lookup has fa=
iled.

I think Chuck would like to have a tracepoint for all the possible
handshake_nl_done_doit() failures, but guess that could be added later
on net-next, possibly refactoring the arguments list (e.g. adding an
explicit fd arg, and passing explicitly a NULL sk).

> Also we should call trace_handshake_cmd_done_err() before releasing the f=
ile,
> otherwise dereferencing sock->sk can return garbage.
>=20
> This also reverts 7afc6d0a107f ("net/handshake: Fix uninitialized local v=
ariable")

I can be low on coffee, but

	struct handshake_req *req =3D NULL;

is still there after this patch ?!?

Cheers,

Paolo



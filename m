Return-Path: <netdev+bounces-35415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139AB7A9644
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D021C20D54
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 17:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D226BBE4A;
	Thu, 21 Sep 2023 17:03:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD85A13FEA
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:03:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FE5211C
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695315615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EitPswhhZZ2vx5zn9ypbN1vdKA00UIWNGb498GcEXDI=;
	b=ZgYZu6x32b1jNBnRdNLy44aaYDJ9JoJaJ5en/Qh2JKaFUNPeDBUXPG66P6Ue74Pb5XAjXr
	yZV2XMSu6OM3JEsAZ8dFMSjLdZnUmhQKGRv91cm82CkBgWrUfTjZBdA5F42A5Tq4CuxZCx
	v2R3jRQdy+oNPRYQx1C/PNWVFjrWrF0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-L1VkZxCLPL2kySG2chpl9w-1; Thu, 21 Sep 2023 04:32:20 -0400
X-MC-Unique: L1VkZxCLPL2kySG2chpl9w-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae3a2a03f7so9221566b.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 01:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695285138; x=1695889938;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EitPswhhZZ2vx5zn9ypbN1vdKA00UIWNGb498GcEXDI=;
        b=pGxfl0hW/BSYuLrb664p3q4HJHLlVfLi4hVqfDtMQaY1O+4GpSY8/joAVUo2A+3f2x
         LoEoblfipMCPh33s4Py9nf9RmL+bkYdNF0Ihw6SRm/DAmuNFWs/7xt8I/CU5gN9YnVqs
         BgzXN2lzE0iYAi2EWTORXh2rvW1dqoRbMktmv0BvxQ7ulrcVzqEVlPngip40eR8T4sL5
         AWwO9xq6894BRR7Wq6+vAUI5RQGX1+w/gp4wyEAknQOzsPj64PgXobsCuYak0F9dPEnY
         SPCZvD9w+zq4oUxJw2PTAOkSCeee9VS2OqGbpWkgkmywsntsUIfvcS2kyypDCWM+dr0t
         Wvow==
X-Gm-Message-State: AOJu0Ywu+AnjRpkrK+OQCg9gYBG5kJi4zTGAf/5A7+crVv6JZMOI9Yh6
	aQgwq28m/FOCfCk4yLqnDFzef/8OKu8aToZX5mPbetpigC6UbA8f9FOTsRj8ns/BQ8ETekVrc8+
	FMS6SSytSHLyOFgPZE/nyWzpv
X-Received: by 2002:a17:906:158:b0:9ae:3f76:1091 with SMTP id 24-20020a170906015800b009ae3f761091mr3696017ejh.0.1695285138618;
        Thu, 21 Sep 2023 01:32:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBDObwM7yL6iv2CUR7KT5fbFcUYmOWkJpB25aa9zsWbCbH2YF1Bu0jxcmAU5QiukkmwCvYfQ==
X-Received: by 2002:a17:906:158:b0:9ae:3f76:1091 with SMTP id 24-20020a170906015800b009ae3f761091mr3695987ejh.0.1695285138233;
        Thu, 21 Sep 2023 01:32:18 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-4.dyn.eolo.it. [146.241.251.4])
        by smtp.gmail.com with ESMTPSA id t2-20020a17090616c200b0099d45ed589csm673419ejd.125.2023.09.21.01.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 01:32:17 -0700 (PDT)
Message-ID: <139933c6013e444047dc685ade53fa3dc1ad68d3.camel@redhat.com>
Subject: Re: [PATCH net v4 2/3] net: prevent rewrite of msg_name in
 sock_sendmsg()
From: Paolo Abeni <pabeni@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jordan Rife
 <jrife@google.com>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  netdev@vger.kernel.org
Cc: dborkman@kernel.org, stable@vger.kernel.org, Jens Axboe
 <axboe@kernel.dk>,  Pavel Begunkov <asml.silence@gmail.com>
Date: Thu, 21 Sep 2023 10:32:16 +0200
In-Reply-To: <650af39492a56_37ac7329469@willemb.c.googlers.com.notmuch>
References: <20230919175254.144417-1-jrife@google.com>
	 <650af39492a56_37ac7329469@willemb.c.googlers.com.notmuch>
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

On Wed, 2023-09-20 at 09:28 -0400, Willem de Bruijn wrote:
> Jordan Rife wrote:
> > Callers of sock_sendmsg(), and similarly kernel_sendmsg(), in kernel
> > space may observe their value of msg_name change in cases where BPF
> > sendmsg hooks rewrite the send address. This has been confirmed to brea=
k
> > NFS mounts running in UDP mode and has the potential to break other
> > systems.
> >=20
> > This patch:
> >=20
> > 1) Creates a new function called __sock_sendmsg() with same logic as th=
e
> >    old sock_sendmsg() function.
> > 2) Replaces calls to sock_sendmsg() made by __sys_sendto() and
> >    __sys_sendmsg() with __sock_sendmsg() to avoid an unnecessary copy,
> >    as these system calls are already protected.
> > 3) Modifies sock_sendmsg() so that it makes a copy of msg_name if
> >    present before passing it down the stack to insulate callers from
> >    changes to the send address.
> >=20
> > Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@goo=
gle.com/
> > Fixes: 1cedee13d25a ("bpf: Hooks for sys_sendmsg")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jordan Rife <jrife@google.com>
>=20
> Reviewed-by: Willem de Bruijn <willemb@google.com>

CC Jens and Pavel, as I guess io_uring likely want to use
__sock_sendmsg(), in a follow-up patch.

Cheers,

Paolo



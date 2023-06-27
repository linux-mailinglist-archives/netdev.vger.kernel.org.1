Return-Path: <netdev+bounces-14252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D2173FC29
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 14:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2A0281074
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 12:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D551417AB4;
	Tue, 27 Jun 2023 12:51:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58E1171C5
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 12:51:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4E7270B
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687870278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1VBXBjZTvnK2Wk6THBLyuE1SAvZbYMw379uCbCug7dM=;
	b=TpPr5lGidziCB/nNmaF5zJz+E0XYt9kq6fzvJMWkwWV5db+gqGf53BR1b8MR9BoFleRvTv
	aIGFoRM9Waq2kJVCvp66VIncBNlP47L5UDkh25XqxqcdVeMRgeV7exe3C+UjKmei9/sGVY
	+NXMPiOs1lGDu51E/CUuG10zl7vgqEw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-KZDv8MT4PeeRc2drYkGCLA-1; Tue, 27 Jun 2023 08:51:16 -0400
X-MC-Unique: KZDv8MT4PeeRc2drYkGCLA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-635e2618aaeso3217806d6.0
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 05:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687870276; x=1690462276;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1VBXBjZTvnK2Wk6THBLyuE1SAvZbYMw379uCbCug7dM=;
        b=fNQlmoKb/rKZTL/1J5XvpcHGLZPgrS1g/tn+ryh1C3KFl/i5RdaJ5tYiOPO+g8SuQe
         d0VIIWXBZujYOdUguO05HV3mdYJRG3TftTeSx8Da6HV3Y4VsxM4KIZwWlTQQGDDXgini
         ox5CibWZPDAg0izSS1M8gheeSjwBpSHDsvKOmc7JF0j9PRlJzqgo9May0Wye9RWqf7nU
         BESFm3XB9zgBTEzL02fAAoK34MJIWVO8mWtihMf4he6UEYN9+R+GuK41T7688zJMVe5j
         94+UaixyIaGtA6Kh9Etbd7ApZaq41CQ0Y1NHr94q3JSt3+XDls5BsteHpoVPEA7I4Ifd
         By5w==
X-Gm-Message-State: AC+VfDzSHo0hr/YRP5+YmJI2G981kOHJdFYs+LQ3gms9RyjBvCvD98dw
	EdBU6LUrQl8l5c4AxaFIfEWroL/pbQRa/HS+V9lsifP8hlB6j8/oUbuemnaumdPlTob7ZYf3m7i
	Ksmxl6hjx740s25rd
X-Received: by 2002:ad4:4eec:0:b0:635:ec47:bfa4 with SMTP id dv12-20020ad44eec000000b00635ec47bfa4mr2878242qvb.4.1687870276525;
        Tue, 27 Jun 2023 05:51:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4gTWjIfL+wjZmdsUf7JwLTLQZrg6rwPJR/TQXtOCe/Cf6jCLoU+HW/e0eIxubgQP4k7rQzpg==
X-Received: by 2002:ad4:4eec:0:b0:635:ec47:bfa4 with SMTP id dv12-20020ad44eec000000b00635ec47bfa4mr2878221qvb.4.1687870276281;
        Tue, 27 Jun 2023 05:51:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-239-6.dyn.eolo.it. [146.241.239.6])
        by smtp.gmail.com with ESMTPSA id mz14-20020a0562142d0e00b006300e92ea02sm4478170qvb.121.2023.06.27.05.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 05:51:15 -0700 (PDT)
Message-ID: <b0a0cb0fac4ebdc23f01d183a9de10731dc90093.camel@redhat.com>
Subject: Re: Is ->sendmsg() allowed to change the msghdr struct it is given?
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, David Howells <dhowells@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
 ceph-devel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2023 14:51:12 +0200
In-Reply-To: <20230626142257.6e14a801@kernel.org>
References: <3112097.1687814081@warthog.procyon.org.uk>
	 <20230626142257.6e14a801@kernel.org>
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
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-06-26 at 14:22 -0700, Jakub Kicinski wrote:
> On Mon, 26 Jun 2023 22:14:41 +0100 David Howells wrote:
> > Do you know if ->sendmsg() might alter the msghdr struct it is passed a=
s an
> > argument? Certainly it can alter msg_iter, but can it also modify,
> > say, msg_flags?
>=20
> I'm not aware of a precedent either way.
> Eric or Paolo would know better than me, tho.

udp_sendmsg() can set the MSG_TRUNC bit in msg->msg_flags, so I guess
that kind of actions are sort of allowed. Still, AFAICS, the kernel
based msghdr is not copied back to the user-space, so such change
should be almost a no-op in practice.

@David: which would be the end goal for such action?

Cheers,

Paolo



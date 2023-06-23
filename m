Return-Path: <netdev+bounces-13350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D0973B521
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A991C20A2A
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 10:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5446110;
	Fri, 23 Jun 2023 10:21:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFC2610D
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 10:21:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F20A1715
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687515684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OeJXYDNz0Ya5c8KMAm3ynsmsenQLqIdnXaadOKfnelU=;
	b=ZDcLAKtkGtskXlASlPDT5YJlVUtarqEWt+dIgN6NtUSCPxsLP+G4dR7kV6/7GIpIbxwJBi
	7gu9+V+AOC+WGbQPiq3VFkEsj2NG+/FOQOreWPbUjxSRMhPvzy9SQbJnWdFiOM2ckSd9u6
	R/ZFxkiQ6ewE0Ulzr5Aa6YZ0Eb1xurE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-pM1iyLTRMjeUYJxbvcNfDg-1; Fri, 23 Jun 2023 06:21:21 -0400
X-MC-Unique: pM1iyLTRMjeUYJxbvcNfDg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7625940fbf3so9950285a.0
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687515681; x=1690107681;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OeJXYDNz0Ya5c8KMAm3ynsmsenQLqIdnXaadOKfnelU=;
        b=gH3aPYvAFZhfnTE5YoTz3Kv8GeZLQlXiSFHMc5syRvL/KYauvUGn3QWsNe09F2o3wf
         Tfnf+AWn+qcnqgKPbO4lqOKQd44Q+gy7G0VCF6gl9Oag+m0BQG5Dsn4ETcajJoRqLIhd
         gx2BLtkVP2HFXkUBN3xC5YMmwRJ0l9hOBx2mqubZRaoKyBXYwapqWvJdsK1xqu1HMKSE
         pVfMnHXLIHKMt+MJNL+Hq81BfcwHmqH9754VqAN1Dp9Bk4HVFFuzQ6XyCU1VVfUJkMHh
         ioYtFuGIQQ8ZRHsLsKEJL921yT9wVd+qepJ8IHC3uCHHbNEtUoieOFxMAicxDBqGyAo7
         wJIQ==
X-Gm-Message-State: AC+VfDwUe6tHLx5pJf8vW2/x37qyzsTKGupghjjSTQIWN96IEWlCuuIz
	XAMq+9ep9MkwZjgbUe/2zCf0JIhiXhShaqhRXp4+/+/68o9TLl+HJ5GtFpV+fSGQV7FXw1Js5Y2
	rV2KCGuLXVRvLrwIT
X-Received: by 2002:a05:6214:401a:b0:62d:eda3:4333 with SMTP id kd26-20020a056214401a00b0062deda34333mr24730660qvb.0.1687515681000;
        Fri, 23 Jun 2023 03:21:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6GxEMCHUc8rROPzQ+6vAoGuDCswIguG8uTkvkLs5Wjm+76AjXJxAgdJPe/v4Nwk/b4qpXo1w==
X-Received: by 2002:a05:6214:401a:b0:62d:eda3:4333 with SMTP id kd26-20020a056214401a00b0062deda34333mr24730644qvb.0.1687515680708;
        Fri, 23 Jun 2023 03:21:20 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-243.dyn.eolo.it. [146.241.231.243])
        by smtp.gmail.com with ESMTPSA id v14-20020a0cdd8e000000b005dd8b9345b9sm4898755qvk.81.2023.06.23.03.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:21:20 -0700 (PDT)
Message-ID: <c6f16229c7b84ff953120a12005c9397e572aa0d.camel@redhat.com>
Subject: Re: [PATCH net-next v3 01/18] net: Copy slab data for
 sendmsg(MSG_SPLICE_PAGES)
From: Paolo Abeni <pabeni@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 netdev@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Menglong Dong
 <imagedong@tencent.com>
Date: Fri, 23 Jun 2023 12:21:16 +0200
In-Reply-To: <2048548.1687514811@warthog.procyon.org.uk>
References: <ccf93f92b2539c9dddd1c45fcfa037bb21ccd808.camel@redhat.com>
	 <20230622191134.54d5cb0b@kernel.org> <20230622132835.3c4e38ea@kernel.org>
	 <20230622111234.23aadd87@kernel.org>
	 <20230620145338.1300897-1-dhowells@redhat.com>
	 <20230620145338.1300897-2-dhowells@redhat.com>
	 <1952674.1687462843@warthog.procyon.org.uk>
	 <1958077.1687474471@warthog.procyon.org.uk>
	 <1969749.1687511298@warthog.procyon.org.uk>
	 <2048548.1687514811@warthog.procyon.org.uk>
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

On Fri, 2023-06-23 at 11:06 +0100, David Howells wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> > I'm unsure I follow the above ?!? I *thought* sendpage could be killed
> > even without patch 1/18 and 2/18, leaving some patches in this series
> > unmodified, and mangling those explicitly leveraging 1/18 to use
> > multiple sendmsg()s with different flags?
>=20
> That's what I meant.
>=20
> With the example, I was showing the minimum needed replacement for a call=
 to
> sendpage.

Thank LGTM!

Thanks,

Paolo



Return-Path: <netdev+bounces-23577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E1376C8F5
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 11:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047341C21214
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A04A5683;
	Wed,  2 Aug 2023 09:06:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B31F1C35
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 09:06:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9113B2721
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 02:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690967215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/dPtVB19ce81u2hOZRl16yTxdvSnScTGj14gE6+a9eo=;
	b=USgfknrdJGIoZ6G6knnx2yOfHFGS4Eyj7UkkpNzuhDrxpFiuSOyb5Qhf64FM+7RxZhyR10
	IdCekMc8p9lnO/77N9hYgiv/6FPTYtWoASJ2W94t7n4x92DFjyXofyaBIowkdv4m2cSu3w
	vvkZqYXhLRGs9YP62vd3v91IwyoBMvY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-YB4QpcP0NvCRqPOGxT9cpw-1; Wed, 02 Aug 2023 05:06:54 -0400
X-MC-Unique: YB4QpcP0NvCRqPOGxT9cpw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99bc7b51672so134467966b.0
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 02:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690967213; x=1691572013;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/dPtVB19ce81u2hOZRl16yTxdvSnScTGj14gE6+a9eo=;
        b=Mk354ICt/ARfq/BL422XJttyLF/h1igflB+hZnW/8NuYByzCEYZ6jFP2KMdmSiutm7
         DkGMviUJ8GWInKh+UjKuL5VaN2L3rFtGwTLKhZA6RXKWfjPET9SRH89YBYMrNouUXX2d
         OoQL1ItBeEbE6kDOjlVIsnpBQ0HZE/PKMzvvEaxEPpTzIf2O0sghUPBTYVMzazI4WaLc
         NACQk8W9UjWRfc6wsL5JsNbrETOn+4XNgWwFP7YitVCdtLm3dzN+mq3sv9VmWDdB46Gi
         mXsncltmLg1TxRJq6GjY1kxvWZw+I15wyFrk3rE1jhCBhcagrjZLv0ZkmYxhjSGVUe06
         5gAw==
X-Gm-Message-State: ABy/qLbK0mTaE6ZEhcCUEF9jtH+OZZE3uygYFNGE9aznbxQKoZmq3iQr
	VHXMa+rsuC8BUJRXT0v9fUmexqe2PWv9hIQxbNlRk1rv4igVggKq41ZCsnSr+qUKnzvmD98Suda
	N8vjlD+prRf8AzBcb
X-Received: by 2002:a17:906:2c6:b0:993:d90e:3102 with SMTP id 6-20020a17090602c600b00993d90e3102mr10355206ejk.6.1690967213294;
        Wed, 02 Aug 2023 02:06:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlErDjMoYSN/INx7fJHojw6xen0L5uiXymEAupCb0Qesoaj2H5J5/ZFi24dGi0dHuIy976AHzg==
X-Received: by 2002:a17:906:2c6:b0:993:d90e:3102 with SMTP id 6-20020a17090602c600b00993d90e3102mr10355193ejk.6.1690967212821;
        Wed, 02 Aug 2023 02:06:52 -0700 (PDT)
Received: from [10.0.0.196] ([37.186.180.70])
        by smtp.gmail.com with ESMTPSA id f5-20020a1709064dc500b0098669cc16b2sm8756945ejw.83.2023.08.02.02.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 02:06:52 -0700 (PDT)
Message-ID: <07fcfd504148b3c721fda716ad0a549662708407.camel@redhat.com>
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
From: Thomas Haller <thaller@redhat.com>
To: Ido Schimmel <idosch@idosch.org>, Hangbin Liu <liuhangbin@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Stephen Hemminger
	 <stephen@networkplumber.org>, netdev@vger.kernel.org, "David S . Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Date: Wed, 02 Aug 2023 11:06:51 +0200
In-Reply-To: <ZLzY42I/GjWCJ5Do@shredder>
References: <20230718080044.2738833-1-liuhangbin@gmail.com>
	 <ZLZnGkMxI+T8gFQK@shredder> <20230718085814.4301b9dd@hermes.local>
	 <ZLjncWOL+FvtaHcP@Laptop-X1> <ZLlE5of1Sw1pMPlM@shredder>
	 <ZLngmOaz24y5yLz8@Laptop-X1>
	 <d6a204b1-e606-f6ad-660a-28cc5469be2e@kernel.org>
	 <ZLobpQ7jELvCeuoD@Laptop-X1> <ZLzY42I/GjWCJ5Do@shredder>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, 2023-07-23 at 10:38 +0300, Ido Schimmel wrote:
> On Fri, Jul 21, 2023 at 01:46:13PM +0800, Hangbin Liu wrote:
>=20
>=20
> I assume NetworkManager already knows how to delete routes given
> RTM_DELLINK events. Can't it be taught to react to RTM_DELADDR events
> as
> well? Then this functionality will always work, regardless of the
> kernel
> version being used.
>=20

Hi,

NetworkManager will already request a full dump of all routes, when an
address gets deleted.

https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/blob/1dff015=
6278594ab171b59885396cf95aff2af7f/src/libnm-platform/nm-linux-platform.c#L7=
437


Thomas



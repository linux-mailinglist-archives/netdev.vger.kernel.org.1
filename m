Return-Path: <netdev+bounces-30297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A00786CD5
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 12:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BB51C20E21
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 10:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6840A1FC5;
	Thu, 24 Aug 2023 10:30:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53528DF5B
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 10:30:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27470198D
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 03:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692873054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eKORO7so6kKJEryC0DHUraVmUzb6avMop5ORchL8eHU=;
	b=VaGZdz27kp4VYNMXqel3CPMt0KwsUmaiRo6B1g9dZKEwePFu9Jz/nlBfEEY4n5IO0y9RLB
	cIDmuYoBScF4k224EI5T5eEgrHnmyk4NsACvk7HyjHAo+eccDH0UztKjMsJruriKT54+y8
	yxxQ1php9aAxrqTOcTumdAurz9ZI8AI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-EffAdIQtMmGoSfTGlsj_eQ-1; Thu, 24 Aug 2023 06:30:53 -0400
X-MC-Unique: EffAdIQtMmGoSfTGlsj_eQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99bc8f1290eso463216866b.3
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 03:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692873052; x=1693477852;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eKORO7so6kKJEryC0DHUraVmUzb6avMop5ORchL8eHU=;
        b=aF9CRIiJp2PSvAZgI2W5CDkDkOFTrnp8pckTyzzK01e8Y/tfeJUrFHSSwDby4rdE9d
         1uEQSzecZDHnKJwLFjTe8mr1UBsw2RhSvpfwWUst0EYnaki9tg6GHL6TpAXq78tGsRI3
         cGFecPlCarVs6hTbHDMGB9hq7ThlUz2rGolrwlybk9NjLtrouxB9Qoj9/UJ/ufENKqhr
         TqznOlfjWuYjdIyem7vXgUHzxM9ANArVoDZjJ6rGrY9FFjd11Bx3RtXQvAylDQsKxtEI
         D9Mr0f738VVkk6WC8t6RYkA8qE0aBvebsj6sX0bOl4QB+eDci2dSOGtf5lI/IvaMtyZR
         6ozw==
X-Gm-Message-State: AOJu0YwbNi/q0AXOPWEXx71z5El06cwWlXNqzk4nW4XCQkqOlrPEaRTB
	Kf9JpclT87F9UyAT3uJ1IFsiZUvBZysxDbbZQkAUPfEzqb85eY/fQZ96LhilEXzHhvhCAqLIe7b
	j0H0oOLGEGfzY2g30
X-Received: by 2002:a17:906:20c7:b0:9a1:ecb5:732e with SMTP id c7-20020a17090620c700b009a1ecb5732emr3236205ejc.71.1692873051822;
        Thu, 24 Aug 2023 03:30:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpJTq1oNyq0LTlFbVnMSj0+nERN4BwfFwO6pT9LpJyUDOA3pnLy9pZMdSiEsL7ytZAnWX27A==
X-Received: by 2002:a17:906:20c7:b0:9a1:ecb5:732e with SMTP id c7-20020a17090620c700b009a1ecb5732emr3236191ejc.71.1692873051348;
        Thu, 24 Aug 2023 03:30:51 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u7-20020a1709067d0700b0099ce188be7fsm10821795ejo.3.2023.08.24.03.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 03:30:50 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 78BC9D3D0AC; Thu, 24 Aug 2023 12:30:50 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 edumazet@google.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, lorenzo@kernel.org, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, mtahhan@redhat.com,
 huangjie.albert@bytedance.com, Yunsheng Lin <linyunsheng@huawei.com>,
 Liang Chen <liangchen.linux@gmail.com>
Subject: Re: [PATCH net-next RFC v1 2/4] veth: use generic-XDP functions
 when dealing with SKBs
In-Reply-To: <169272715407.1975370.3989385869434330916.stgit@firesoul>
References: <169272709850.1975370.16698220879817216294.stgit@firesoul>
 <169272715407.1975370.3989385869434330916.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 24 Aug 2023 12:30:50 +0200
Message-ID: <87msyg91gl.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> The root-cause the realloc issue is that veth_xdp_rcv_skb() code path (that
> handles SKBs like generic-XDP) is calling a native-XDP function
> xdp_do_redirect(), instead of simply using xdp_do_generic_redirect() that can
> handle SKBs.
>
> The existing code tries to steal the packet-data from the SKB (and frees the SKB
> itself). This cause issues as SKBs can have different memory models that are
> incompatible with native-XDP call xdp_do_redirect(). For this reason the checks
> in veth_convert_skb_to_xdp_buff() becomes more strict. This in turn makes this a
> bad approach. Simply leveraging generic-XDP helpers e.g. generic_xdp_tx() and
> xdp_do_generic_redirect() as this resolves the issue given netstack can handle
> these different SKB memory models.

While this does solve the memory issue, it's also a subtle change of
semantics. For one thing, generic_xdp_tx() has this comment above it:

/* When doing generic XDP we have to bypass the qdisc layer and the
 * network taps in order to match in-driver-XDP behavior. This also means
 * that XDP packets are able to starve other packets going through a qdisc,
 * and DDOS attacks will be more effective. In-driver-XDP use dedicated TX
 * queues, so they do not have this starvation issue.
 */

Also, more generally, this means that if you have a setup with
XDP_REDIRECT-based forwarding in on a host with a mix of physical and
veth devices, all the traffic originating from the veth devices will go
on different TXQs than that originating from a physical NIC. Or if a
veth device has a mix of xdp_frame-backed packets and skb-backed
packets, those will also go on different queues, potentially leading to
reordering.

I'm not sure exactly how much of an issue this is in practice, but at
least from a conceptual PoV it's a change in behaviour that I don't
think we should be making lightly. WDYT?

-Toke



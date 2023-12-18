Return-Path: <netdev+bounces-58468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8998168A6
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 09:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFE95B2248B
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 08:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B7010964;
	Mon, 18 Dec 2023 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBHo43vu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429B7101D3
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702889374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=96J1k28J+MjDnv0pl5SmRROhcfWOfBkfzf+7bPvEEpo=;
	b=SBHo43vuVnhWTgtuMcHDXcrelvp79xtt1pfAFtG1YkDxyg4tXcnL+d1MfPtPvSxI5sCFUb
	jQFouZzGU7dj9PWS9hw3XtLKpUcJwAlZVMDkWCt46hrdN6DY1oaqgSroujjZjSTjBiCFN3
	y3wXQev1R4MTOgXPQudmO44EiyOMpfc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-QyAir-xKNSqfQHwdutVLpw-1; Mon, 18 Dec 2023 03:49:32 -0500
X-MC-Unique: QyAir-xKNSqfQHwdutVLpw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50e3de9c2d3so169284e87.2
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 00:49:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702889369; x=1703494169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96J1k28J+MjDnv0pl5SmRROhcfWOfBkfzf+7bPvEEpo=;
        b=r2aXSRH6qP92fIn0WbKv0xz4eP5VUx2HOWiIovjCJdeMxz9NRdWFLt2W5bQpLg2XD9
         lnhDQm+wQ++B7QjQXGfrKiqMAReGbxIZXvgFUDGUebbbif6SB8hKi2VXuTPX66JApoBE
         YgLoAHXmyzcdDzKRw03zsik0B3gdWtdK1w226MgJa8IwYxkfiNwhNPVLgo0OpligHS1J
         5sQEtZcTDnoLRH2DGOWRYb41mf/GW5/sKESdMfbTA9GZx+1XzBTTi6I33sYCuRbS+5OZ
         eTkp12D8cKdURFx83BU5fT38REqtohPDwWSn0XPC8dW1kNNa3jR4UqdjThNc52GgaKR4
         BVsQ==
X-Gm-Message-State: AOJu0Yy2oJ2AmsuFvNxnkvJBQY5p9UV4apL88t6sA7lFkA+mjILCI+a5
	9E2KrIvK/L+KIDPmGtC3JK38WIhevof5kYVg2OQDEFT1bQKRXdtjCa6nM83CKseCpQ7RgHiVBtL
	Eu0YGKbS33ZZ/3F7QQUyRQ4ogVbA=
X-Received: by 2002:ac2:42cd:0:b0:50e:30cf:9adf with SMTP id n13-20020ac242cd000000b0050e30cf9adfmr1053748lfl.109.1702889369688;
        Mon, 18 Dec 2023 00:49:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmAqvDzZZK0X7HUhBeJVDsC7MXCREWAxrZtN2Xk3IIJMSb0xjiL5A8HYGdE7+yn/n9U86NkQ==
X-Received: by 2002:ac2:42cd:0:b0:50e:30cf:9adf with SMTP id n13-20020ac242cd000000b0050e30cf9adfmr1053736lfl.109.1702889369318;
        Mon, 18 Dec 2023 00:49:29 -0800 (PST)
Received: from localhost ([81.56.90.2])
        by smtp.gmail.com with ESMTPSA id op24-20020a170906bcf800b00a2361163cfesm442342ejb.13.2023.12.18.00.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 00:49:28 -0800 (PST)
Date: Mon, 18 Dec 2023 09:49:27 +0100
From: Davide Caratti <dcaratti@redhat.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, mleitner@redhat.com, pctammela@mojatatu.com,
	netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH RFC net-next] net: sched: act_mirred: Extend the cpu
 mirred nest guard with an explicit loop ttl
Message-ID: <ZYAHl3f4+scOdJYc@dcaratti.users.ipa.redhat.com>
References: <20231215180827.3638838-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215180827.3638838-1-victor@mojatatu.com>

hello Victor, thanks for the patch!

On Fri, Dec 15, 2023 at 03:08:27PM -0300, Victor Nogueira wrote:
> As pointed out by Jamal in:
> https://lore.kernel.org/netdev/CAM0EoMn4C-zwrTCGzKzuRYukxoqBa8tyHyFDwUSZYwkMOUJ4Lw@mail.gmail.com/
> 
> Mirred is allowing for infinite loops in certain use cases, such as the
> following:
> 
> ----
> sudo ip netns add p4node
> sudo ip link add p4port0 address 10:00:00:01:AA:BB type veth peer \
>    port0 address 10:00:00:02:AA:BB
> 
> sudo ip link set dev port0 netns p4node
> sudo ip a add 10.0.0.1/24 dev p4port0
> sudo ip neigh add 10.0.0.2 dev p4port0 lladdr 10:00:00:02:aa:bb
> sudo ip netns exec p4node ip a add 10.0.0.2/24 dev port0
> sudo ip netns exec p4node ip l set dev port0 up
> sudo ip l set dev p4port0 up
> sudo ip netns exec p4node tc qdisc add dev port0 clsact
> sudo ip netns exec p4node tc filter add dev port0 ingress protocol ip \
>    prio 10 matchall action mirred ingress redirect dev port0
> 
> ping -I p4port0 10.0.0.2 -c 1
> -----
> 
> To solve this, we reintroduced a ttl variable attached to the skb (in
> struct tc_skb_cb) which will prevent infinite loops for use cases such as
> the one described above.
> 
> The nest per cpu variable (tcf_mirred_nest_level) is now only used for
> detecting whether we should call netif_rx or netif_receive_skb when
> sending the packet to ingress.

looks good to me. Do you think it's worth setting an initial value (0, AFAIU)
for tc_skb_cb(skb)->ttl inside tc_run() ?

other than this,

Acked-by: Davide Caratti <dcaratti@redhat.com>



Return-Path: <netdev+bounces-33736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C926879FD3D
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 09:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763351F21A70
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 07:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DAD79E5;
	Thu, 14 Sep 2023 07:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8F22915
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 07:30:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1E5BF3
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 00:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694676624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrchCxfQCJuTrQ23DXCns9oqiEQxYoVXscKePDfU/VI=;
	b=VwBQXmoVyRxo5noFSCFiUFgJDGU8s4OjWP+NjyhmJ6uTi+ehkFrr1zVpk3V/Zy80j0K697
	jPQCmt9z5RMiPHp8IXTEc5rXPo032DMO+M0Oz9IaDTOvzltbYNqL4hT+QTw3UtPUFJjjCF
	WQ5gTrJvTMOBd6ri98nFeKFBJpTrunE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-xmJswGFxMbeveTGQDAUoDg-1; Thu, 14 Sep 2023 03:30:22 -0400
X-MC-Unique: xmJswGFxMbeveTGQDAUoDg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9aa25791fc7so16412066b.1
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 00:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694676621; x=1695281421;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lrchCxfQCJuTrQ23DXCns9oqiEQxYoVXscKePDfU/VI=;
        b=u95hZbp3Dg309PUCd4HPtCcxtBqJ1sHjsUdPwVb3hGPhsrI5SdvKXE+D/Rf7Xvk6kS
         ZwQb2EzLyfsThOMHyVyUx5yDxp7Gzr1njTyZhn05yNMj7fhZvmczeUoi0HhuL2bLev/5
         g5UsQCjxCKS/+Ryn4Ha/yxjTxNte8MYNGX0HFaqWqI1YF8xb60z9ntVINIfYeSVN4oEC
         6+SDNqmUC0kH8V21PIlFIMQQayosW2EJxGc4ACBpeTq8RoSg4xJo4VLaCCPzk9UbOFH+
         +6pRU2JKER3vixILvLAzw51IDMsehWZLp29pvhMdjBqPVlmwFetEBKeNOVShkziMPZ6G
         mhUg==
X-Gm-Message-State: AOJu0YyNRZF5IwJfA+vQXVD9k93UAAYdCXtRvIZooakqV0x3vDjC7xM9
	5FZMcp6MNXCKRxOOFPlpSd+r4tz683MEUhk8hzyb2zkRNzY0mPRw8xwxCfAJOs6fc7kboSZhsGi
	oYairG+PrlBzN9j5e
X-Received: by 2002:a17:906:2d1:b0:9a1:cad9:4d25 with SMTP id 17-20020a17090602d100b009a1cad94d25mr3429905ejk.7.1694676621244;
        Thu, 14 Sep 2023 00:30:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVtXlZy2MeYSk0+fgElfNzkO5H5pPFnhOWLpGp51ZZ9zFNqN6Ziw2R1CHhVEkJBpIdoZEgpw==
X-Received: by 2002:a17:906:2d1:b0:9a1:cad9:4d25 with SMTP id 17-20020a17090602d100b009a1cad94d25mr3429892ejk.7.1694676620907;
        Thu, 14 Sep 2023 00:30:20 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-187.dyn.eolo.it. [146.241.242.187])
        by smtp.gmail.com with ESMTPSA id bo4-20020a170906d04400b009a9f00bdf8dsm586466ejb.191.2023.09.14.00.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 00:30:20 -0700 (PDT)
Message-ID: <26391932ab935fc0553238c101f6a1ceff0d11a5.camel@redhat.com>
Subject: Re: [PATCH net-next v3 0/3] net/sched: Introduce tc block ports
 tracking and use
From: Paolo Abeni <pabeni@redhat.com>
To: Victor Nogueira <victor@mojatatu.com>, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org
Cc: mleitner@redhat.com, vladbu@nvidia.com, horms@kernel.org, 
	pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com
Date: Thu, 14 Sep 2023 09:30:18 +0200
In-Reply-To: <20230911232749.14959-1-victor@mojatatu.com>
References: <20230911232749.14959-1-victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-09-11 at 20:27 -0300, Victor Nogueira wrote:
> __context__
> The "tc block" is a collection of netdevs/ports which allow qdiscs to sha=
re
> match-action block instances (as opposed to the traditional tc filter per
> netdev/port)[1].
>=20
> Example setup:
> $ tc qdisc add dev ens7 ingress block 22
> $ tc qdisc add dev ens8 ingress block 22
>=20
> Once the block is created we can add a filter using the block index:
> $ tc filter add block 22 protocol ip pref 25 \
>   flower dst_ip 192.168.0.0/16 action drop
>=20
> A packet with dst IP matching 192.168.0.0/16 arriving on the ingress of
> either ens7 or ens8 is dropped.
>=20
> __this patchset__
> Up to this point in the implementation, the block is unaware of its ports=
.
> This patch fixes that and makes the tc block ports available to the
> datapath.
>=20
> For the datapath we provide a use case of the tc block in an action
> we call "blockcast" in patch 3. This action can be used in an example as
> such:
>=20
> $ tc qdisc add dev ens7 ingress block 22
> $ tc qdisc add dev ens8 ingress block 22
> $ tc qdisc add dev ens9 ingress block 22
> $ tc filter add block 22 protocol ip pref 25 \
>   flower dst_ip 192.168.0.0/16 action blockcast
>=20
> When a packet(matching dst IP 192.168.0.0/16) arrives on the ingress of a=
ny
> of ens7, ens8 or ens9 it will be copied to all ports other than itself.
> For example, if it arrives on ens8 then a copy of the packet will be
> "blockcasted";-> to both ens7 and ens9 (unmodified), but not to ens7.

Very minor typo above, "to ens7" should be "to ens8", I guess.

Not worthy reposting for this anyway.

Cheers,

Paolo



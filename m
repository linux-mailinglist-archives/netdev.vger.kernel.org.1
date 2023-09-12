Return-Path: <netdev+bounces-33236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BA979D16F
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 14:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1759C280E26
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E7B17753;
	Tue, 12 Sep 2023 12:54:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386F98F41
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 12:54:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B09710DB
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 05:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694523275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iSZDqdgw9hz6YdoS+8xx8lffHXYeIjmc7LAEd9FSxhc=;
	b=TjJf8tHxpVonl7nT/PlBQWNC51sFMHhXy/RUvssSKs2aAY8VKt+tHAJ+oySTQTXaTpkoDQ
	mYfvpIcM3bvlky//+/UkIMzbyuRrUAYbCwLF/Ka8clMsJ52wmDOATYvtR9HfknCUHTuitU
	3RBNx2PfcSPBY7+4lEMBIzPBs45yE7o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-e-cgbagmML2F5Ex8usO6tQ-1; Tue, 12 Sep 2023 08:54:33 -0400
X-MC-Unique: e-cgbagmML2F5Ex8usO6tQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31ad607d383so3459837f8f.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 05:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694523272; x=1695128072;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSZDqdgw9hz6YdoS+8xx8lffHXYeIjmc7LAEd9FSxhc=;
        b=ZyciOs3+hjVRF31RWCNmRRHROPseDIAtQ6sPm5n4povLq19yHbOdAuV41LfN2FyjY0
         JnvjzOmLOTVm5AkLMY/mCzV455s6XlGPsz5864B06P8SipcQvuGGfkKEEvAq5RUna90U
         sJuA2KPOZc5MrUgSyB75qb7lVRVheSc09XA9Oq8mZKDwjN2HYTyIFxP8WamcmBkLLYRu
         1Zel/ArfiHBm2x+3HXquroKcFRqVfdKpwtL7VY0r/tt+LvyqpavoN0LBVkgxsrkaR0vL
         2qGmTvbpDgTHaE3EbN4ndip7YZoqjWrcUOfzfgjaSxgVd569ayKnFjclReSSZcYFy82N
         wOuA==
X-Gm-Message-State: AOJu0YzDbw3aRnnZggVPZw0eIXYCFKjvC6GgohywGaG96u5XpjuGK37u
	QSe1PGRQj9kk30MICDKIa6OjMET6tnzX+YYHXu65Sq2CuaZkwnnVCDMiWgVK93RE0+Btc+RZLwM
	2W7Gvsio6Q30yJLhM
X-Received: by 2002:a05:6000:156c:b0:31f:8a6d:e527 with SMTP id 12-20020a056000156c00b0031f8a6de527mr10176241wrz.45.1694523271939;
        Tue, 12 Sep 2023 05:54:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvl7ryo1aVNDzD57oNtTaZfFx8xpRkRnxjSFVqBJU6HKBG31TFiyKZdVWi7F+oDn0C2Lh29A==
X-Received: by 2002:a05:6000:156c:b0:31f:8a6d:e527 with SMTP id 12-20020a056000156c00b0031f8a6de527mr10176218wrz.45.1694523271540;
        Tue, 12 Sep 2023 05:54:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7d84f000000b005255f5735adsm5924764eds.24.2023.09.12.05.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 05:54:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 94C14DC7318; Tue, 12 Sep 2023 14:54:30 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Stanislav Fomichev <sdf@google.com>, Gerhard Engleder
 <gerhard@engleder-embedded.com>, Simon Horman <horms@kernel.org>
Cc: Marek Majtyka <alardam@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH net] veth: Update XDP feature set when bringing up device
In-Reply-To: <155aabf8b873bb8cdcafbd6139c42b08513e5fe6.camel@redhat.com>
References: <20230911135826.722295-1-toke@redhat.com>
 <155aabf8b873bb8cdcafbd6139c42b08513e5fe6.camel@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 12 Sep 2023 14:54:30 +0200
Message-ID: <8734zjlfg9.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> writes:

> Hi,
>
> On Mon, 2023-09-11 at 15:58 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> There's an early return in veth_set_features() if the device is in a down
>> state, which leads to the XDP feature flags not being updated when enabl=
ing
>> GRO while the device is down. Which in turn leads to XDP_REDIRECT not
>> working, because the redirect code now checks the flags.
>>=20
>> Fix this by updating the feature flags after bringing the device up.
>>=20
>> Before this patch:
>>=20
>> NETDEV_XDP_ACT_BASIC:		yes
>> NETDEV_XDP_ACT_REDIRECT:	yes
>> NETDEV_XDP_ACT_NDO_XMIT:	no
>> NETDEV_XDP_ACT_XSK_ZEROCOPY:	no
>> NETDEV_XDP_ACT_HW_OFFLOAD:	no
>> NETDEV_XDP_ACT_RX_SG:		yes
>> NETDEV_XDP_ACT_NDO_XMIT_SG:	no
>>=20
>> After this patch:
>>=20
>> NETDEV_XDP_ACT_BASIC:		yes
>> NETDEV_XDP_ACT_REDIRECT:	yes
>> NETDEV_XDP_ACT_NDO_XMIT:	yes
>> NETDEV_XDP_ACT_XSK_ZEROCOPY:	no
>> NETDEV_XDP_ACT_HW_OFFLOAD:	no
>> NETDEV_XDP_ACT_RX_SG:		yes
>> NETDEV_XDP_ACT_NDO_XMIT_SG:	yes
>>=20
>> Fixes: fccca038f300 ("veth: take into account device reconfiguration for=
 xdp_features flag")
>> Fixes: 66c0e13ad236 ("drivers: net: turn on XDP features")
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  drivers/net/veth.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>=20
>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>> index 9c6f4f83f22b..0deefd1573cf 100644
>> --- a/drivers/net/veth.c
>> +++ b/drivers/net/veth.c
>> @@ -1446,6 +1446,8 @@ static int veth_open(struct net_device *dev)
>>  		netif_carrier_on(peer);
>>  	}
>>=20=20
>> +	veth_set_xdp_features(dev);
>> +
>>  	return 0;
>>  }
>
> The patch LGTM, thanks!
>
> I think it would be nice to add some specific self-tests here. Could
> you please consider following-up with them?

Sure! Do you want me to resubmit this as well, or are you just going to
apply it as-is and do the selftest as a follow-up?

-Toke



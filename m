Return-Path: <netdev+bounces-45388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D327DC95B
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 10:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8949B20C81
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 09:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A913D506;
	Tue, 31 Oct 2023 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9nUQSiF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4421D546
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 09:23:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADED18F
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 02:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698744149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dmd8h3KmMTuLMQdZh3MBzTGUulf/MEu6C/sdxdxaqVw=;
	b=T9nUQSiFmKT75V3vEfmPTXpsBYSlm9w76cK7QkYvE8Gfb0KM7mR2mwesgWBHXM14CZWu0G
	M5SLaFJDcfqZUH9mdOSkpqwayB+biB+5tMoNRcKczwrcLYvdk1vIO+yoB2fM6H7clDY/KF
	a+0bLM3bVYXiIBAIVdTWFV4trxRJWBs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-kAS2AG25NqyZ-PPTUM7amw-1; Tue, 31 Oct 2023 05:22:27 -0400
X-MC-Unique: kAS2AG25NqyZ-PPTUM7amw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32d89debaabso485534f8f.1
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 02:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698744145; x=1699348945;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dmd8h3KmMTuLMQdZh3MBzTGUulf/MEu6C/sdxdxaqVw=;
        b=CD67ax+CO6VwOcj19VR2DqPslTwEnzY/Q6of3YUjThTGHs38eaZDLVQVkdDxpIvH0f
         /oXuRORfpU+QLBZ7R/IXNFaPyDzUBunKXQqshiNqsyNUzVhfSgCnZ47WYtvofQfHXWPY
         kc1Vm0GF9vry7qS6ZR8x2uJscuYwDCZC8A0HdI20P108R3JApuymeskOtlMR3Z3gNrgE
         hn1bHsAQc0Zn2jZB4qhGrkdfaqgcFIwmQ8K679GfRxiwSieibNlmzB0K1XN/+K2/RVJi
         pg5/VS8Kjf1QEuScPpw8eNp3hQXDMUZCNAfet4BehSJ/aaOTiOj47TxGyYFlGXO7Al/u
         BrVQ==
X-Gm-Message-State: AOJu0YzIC58HzI4leEL/ievn0GOR849gw+2gqULdUz1CE5r997a346kK
	Xih17gXA72+Vl1bDoc4S04D3YjMBqPuibDrKmShN78K1QSa7+ocz9tWk7IvvIGCStYiSMsrztU1
	Wg7v4zL9I1m/WmoLm
X-Received: by 2002:a5d:6984:0:b0:32f:76bb:a851 with SMTP id g4-20020a5d6984000000b0032f76bba851mr6653854wru.1.1698744145734;
        Tue, 31 Oct 2023 02:22:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3YPSSkH5TbNjuvw0t3bHYUKojT0tYZOUPP9YmmH3AfQTF5JOqLokssO3dUvLJ6/Z8k05axg==
X-Received: by 2002:a5d:6984:0:b0:32f:76bb:a851 with SMTP id g4-20020a5d6984000000b0032f76bba851mr6653837wru.1.1698744145407;
        Tue, 31 Oct 2023 02:22:25 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-179.dyn.eolo.it. [146.241.227.179])
        by smtp.gmail.com with ESMTPSA id n6-20020a5d67c6000000b00323293bd023sm1030605wrw.6.2023.10.31.02.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 02:22:25 -0700 (PDT)
Message-ID: <90def1f008a5c343ad6b0b2151c8ff972d2f468f.camel@redhat.com>
Subject: Re: [PATCH v2] selftests/net: synchronize udpgso_bench rx and tx
From: Paolo Abeni <pabeni@redhat.com>
To: Lucas Karpinski <lkarpins@redhat.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 31 Oct 2023 10:22:23 +0100
In-Reply-To: <6ceki76bcv7qz6de5rxc26ot6aezdmeoz2g4ubtve7qwozmyyw@zibbg64wsdjp>
References: 
	<6ceki76bcv7qz6de5rxc26ot6aezdmeoz2g4ubtve7qwozmyyw@zibbg64wsdjp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-10-30 at 13:40 -0400, Lucas Karpinski wrote:
> The sockets used by udpgso_bench_tx aren't always ready when
> udpgso_bench_tx transmits packets. This issue is more prevalent in -rt
> kernels, but can occur in both. Replace the hacky sleep calls with a
> function that checks whether the ports in the namespace are ready for
> use.
>=20
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
> ---
> https://lore.kernel.org/all/t7v6mmuobrbucyfpwqbcujtvpa3wxnsrc36cz5rr6kzzr=
zkwtj@toz6mr4ggnyp/
>=20
I almost forgot ...
> Changelog v2:=20
> - applied synchronization method suggested by Pablo
                                                ^^^^^ most common typo
since match 2022 ;)

Less irrelevant, please include the target tree in the next submission,
in this case 'net-next'.

Thanks,

Paolo



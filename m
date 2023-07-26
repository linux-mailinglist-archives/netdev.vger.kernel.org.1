Return-Path: <netdev+bounces-21396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AF17637E3
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E336B1C212C6
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 13:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7589512B66;
	Wed, 26 Jul 2023 13:44:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651F7BA43
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 13:44:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6898419B5
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 06:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690379074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wn2jDJiGuVW5obSdP2moup5cJGVSeLTAzm9z2TiK2m0=;
	b=cUL8Xi9xT6LpXVV9nMXC5YYtTfVQGVtRreRwwJorCXo1PlTeTpi+disdHqtNQEuTxMt5Pi
	Ho75lW4ElrhrWaO5/xyKjzW4K+O4qMJf7Uzw/sdUJIJdgFi7GxRt+1ufgRGVSQTRcep0ky
	XX8hECt1Gy2hBEPSkfYbU9JzVocoecs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-pXfiw9dRMh6OS8HI-swAzw-1; Wed, 26 Jul 2023 09:44:33 -0400
X-MC-Unique: pXfiw9dRMh6OS8HI-swAzw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-63cebe9238bso9757416d6.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 06:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690379073; x=1690983873;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wn2jDJiGuVW5obSdP2moup5cJGVSeLTAzm9z2TiK2m0=;
        b=DUBVbOlWg471/U8VRxWscNCSHZY4rxfkhkaQheVGyiIv2kawp4zOpvf/vsn7UJomoC
         hKkdnuUNQgCT9sCwemI5uyDvAIKOWr1XdmLGAyMByvoUl9LPSDx0muLLA6qJ7mEMVBko
         2XseuWVLMvsAh3gRC79awQe2RbaOclBcMnlw0Sul3NFAI8CDXgc5ZJv/RdYSJgwQ4fQq
         SkEI/xKnVySXQg4s9eTNkrerEDJr3eCdi+HRxdfU10F/fmTBMvquIrMATWqH2qqhvne+
         RJEvbsHSXjCPx+XZMjghYuQnZGFfWYoiIZS+HawOm0c5fiEwWv56VutztRqibsAy5Ivg
         N8sA==
X-Gm-Message-State: ABy/qLaQGn2/LiO7JtCG5PS0ujSS1ZWPm3NnA0EYxV6QOCVG92OI2wlh
	Ffm0qjjNzuDLaDs1NE4RSBI13FLQjEtRDrViYUaXi+vXVE2g3PLf6fB0r0YvTJSfVsjmljQGzsL
	upKwgcleqvqLD517NTRfmnKDv
X-Received: by 2002:a05:6214:5003:b0:626:2305:6073 with SMTP id jo3-20020a056214500300b0062623056073mr2376842qvb.4.1690379072881;
        Wed, 26 Jul 2023 06:44:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEY+wPDJIS9P4TfJgVk4WzmK4E9kEih0HHh2jwPuojmzz36OjuqWoIjvCtsFjptNMksebir6Q==
X-Received: by 2002:a05:6214:5003:b0:626:2305:6073 with SMTP id jo3-20020a056214500300b0062623056073mr2376834qvb.4.1690379072631;
        Wed, 26 Jul 2023 06:44:32 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-81.dyn.eolo.it. [146.241.225.81])
        by smtp.gmail.com with ESMTPSA id m10-20020ae9f20a000000b00767e98535b7sm4379577qkg.67.2023.07.26.06.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 06:44:32 -0700 (PDT)
Message-ID: <fce08e76da7e3882319ae935c38e9e2eccf2dcae.camel@redhat.com>
Subject: Re: [PATCH 1/2] Move hash calculation inside udp4_lib_lookup2()
From: Paolo Abeni <pabeni@redhat.com>
To: David Laight <David.Laight@ACULAB.COM>, 
 "'willemdebruijn.kernel@gmail.com'" <willemdebruijn.kernel@gmail.com>,
 "'davem@davemloft.net'" <davem@davemloft.net>,  "'dsahern@kernel.org'"
 <dsahern@kernel.org>, 'Eric Dumazet' <edumazet@google.com>,
 "'kuba@kernel.org'" <kuba@kernel.org>, "'netdev@vger.kernel.org'"
 <netdev@vger.kernel.org>
Date: Wed, 26 Jul 2023 15:44:29 +0200
In-Reply-To: <5eb8631d430248999116ce8ced13e4b2@AcuMS.aculab.com>
References: <fbcaa54791cd44999de5fec7c6cf0b3c@AcuMS.aculab.com>
	 <5eb8631d430248999116ce8ced13e4b2@AcuMS.aculab.com>
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
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-07-26 at 12:05 +0000, David Laight wrote:
> Pass the udptable address into udp4_lib_lookup2() instead of the hash slo=
t.
>=20
> While ipv4_portaddr_hash(net, IP_ADDR_ANY, 0) is constant for each net
> (the port is an xor) the value isn't saved.
> Since the hash function doesn't get simplified when passed zero the hash

Are you sure? could you please objdump and compare the binary code
generated before and after the patch? In theory all the callers up to
__jhash_final() included should be inlined, and the compiler should be
able to optimze at least rol32(0, <n>).

Cheers,

Paolo



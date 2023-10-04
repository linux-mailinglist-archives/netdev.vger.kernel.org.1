Return-Path: <netdev+bounces-37884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CB77B786A
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 09:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id E38A11F21DB2
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 07:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30B36AD9;
	Wed,  4 Oct 2023 07:12:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D7D1856
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 07:12:03 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52037AB
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 00:12:02 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c77449a6daso15232365ad.0
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 00:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696403522; x=1697008322; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unfr2glM4e5rcWyEYwMhlURFjnUIdCG1ShH//sT9JY0=;
        b=JTl7WROrLh8u1apw3mDpQrhuCMnFyyxKyivAo4U0pkRyZECNOLqPnGT3f/SQ5c7x+S
         USLmlBPp7PTcvz3ORbGT8sVmyUk6Mhf8fWnon3SYgV9Dp+ngG20cTZTLW4C4UN6KaZfq
         kfBhXiIZajMv8qW7D7RNuqEuk+obx8xxWBySwu4LlOeNBwSZvRjk7DP/4mXBjfjxQTA0
         7vHsSBWYSnARAr7vUg4gwdBVPAbsAx9KSX09eq1oMwccUb5SMChz5Y/kN7inCzIih9az
         j7Ilx9WseTlRcBv7TRFPP5qjJtnUaoP288PLoUqaZTxOKGjOaHSObwr4+tiHOZg/6ugK
         CWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696403522; x=1697008322;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=unfr2glM4e5rcWyEYwMhlURFjnUIdCG1ShH//sT9JY0=;
        b=fEr4fB2IMoYiNYQRfVpdEdHnCxuVX1eChdO2jQa6KcoZaEyMv6NYZoumwddtUETuZ8
         beVovuP/RpJ1LDWvqUbTNpH0pdcc7M0O2TEUHKE8p24fyxu2333Dfi4faEQttKsfU/J+
         EsBtFI1G3nlAMMmrgMT4IxsF/G/KwdHgoPMEAlZOngxAZYEVVAjNXpBGuvkcI9+0l/Q+
         Th8+0BehBr82aC6qCK20Hcw+hIvIy/e+EZAtjAqxKvu2Ffyoru96bX4ctPDUQxwhZA9j
         NkCfgJHGnSaEdFsVwNFTt9qrzCm9LBrFXxgJD/2Va0N9r5EWM7tMs1ilZOpkNlPrb+Vk
         hLPg==
X-Gm-Message-State: AOJu0YzWHllozq4x6TqLmKnE1E1kRr0eOSbTVnktSF59dUzBCIYR9WxY
	iBZMgulpD7Ja+/uN+HZZOaw=
X-Google-Smtp-Source: AGHT+IGy1YXQnXcqcXfF7VkB4bihpYMG9fIGU9+z0HYrgDYjtoi1omj40trqM3KfspfKz7RHniBxEg==
X-Received: by 2002:a17:903:1208:b0:1c3:92de:1b23 with SMTP id l8-20020a170903120800b001c392de1b23mr2025281plh.59.1696403521611;
        Wed, 04 Oct 2023 00:12:01 -0700 (PDT)
Received: from localhost (193-116-195-242.tpgi.com.au. [193.116.195.242])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090301c800b001c60c8d6b4asm2845267plh.149.2023.10.04.00.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 00:12:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Oct 2023 17:11:56 +1000
Message-Id: <CVZGUWQGYWQX.1W7BH28XB6WKM@wheely>
Cc: "Aaron Conole" <aconole@redhat.com>, <netdev@vger.kernel.org>,
 <dev@openvswitch.org>, "Ilya Maximets" <imaximet@redhat.com>, "Flavio
 Leitner" <fbl@redhat.com>
Subject: Re: [ovs-dev] [RFC PATCH 4/7] net: openvswitch: ovs_vport_receive
 reduce stack usage
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Eelco Chaudron" <echaudro@redhat.com>
X-Mailer: aerc 0.15.2
References: <20230927001308.749910-1-npiggin@gmail.com>
 <20230927001308.749910-5-npiggin@gmail.com> <f7tfs2ymi8y.fsf@redhat.com>
 <CVV7HCQYCVOP.2JVVJCKU57CAW@wheely>
 <34747C51-2F94-4B64-959B-BA4B0AA4224B@redhat.com>
In-Reply-To: <34747C51-2F94-4B64-959B-BA4B0AA4224B@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri Sep 29, 2023 at 6:38 PM AEST, Eelco Chaudron wrote:
>
>
> On 29 Sep 2023, at 9:00, Nicholas Piggin wrote:
>
> > On Fri Sep 29, 2023 at 1:26 AM AEST, Aaron Conole wrote:
> >> Nicholas Piggin <npiggin@gmail.com> writes:
> >>
> >>> Dynamically allocating the sw_flow_key reduces stack usage of
> >>> ovs_vport_receive from 544 bytes to 64 bytes at the cost of
> >>> another GFP_ATOMIC allocation in the receive path.
> >>>
> >>> XXX: is this a problem with memory reserves if ovs is in a
> >>> memory reclaim path, or since we have a skb allocated, is it
> >>> okay to use some GFP_ATOMIC reserves?
> >>>
> >>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >>> ---
> >>
> >> This represents a fairly large performance hit.  Just my own quick
> >> testing on a system using two netns, iperf3, and simple forwarding rul=
es
> >> shows between 2.5% and 4% performance reduction on x86-64.  Note that =
it
> >> is a simple case, and doesn't involve a more involved scenario like
> >> multiple bridges, tunnels, and internal ports.  I suspect such cases
> >> will see even bigger hit.
> >>
> >> I don't know the impact of the other changes, but just an FYI that the
> >> performance impact of this change is extremely noticeable on x86
> >> platform.
> >
> > Thanks for the numbers. This patch is probably the biggest perf cost,
> > but unfortunately it's also about the biggest saving. I might have an
> > idea to improve it.
>
> Also, were you able to figure out why we do not see this problem on
> x86 and arm64? Is the stack usage so much larger, or is there some
> other root cause?

Haven't pinpointed it exactly. ppc64le interrupt entry frame is nearly
3x larger than x86-64, about 200 bytes. So there's 400 if a hard
interrupt (not seen in the backtrace) is what overflowed it. Stack
alignment I think is 32 bytes vs 16 for x86-64. And different amount of
spilling and non-volatile register use and inlining choices by the
compiler could nudge things one way or another. There is little to no
ppc64le specific data structures on the stack in any of this call chain
which should cause much more bloat though, AFAIKS.

So other archs should not be far away from overflowing 16kB I think.

> Is there a simple replicator, as this might help you
> profile the differences between the architectures?

Unfortunately not, it's some kubernetes contraption I don't know how
to reproduce myself.

Thanks,
Nick


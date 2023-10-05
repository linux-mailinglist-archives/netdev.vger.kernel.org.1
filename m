Return-Path: <netdev+bounces-38170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72AE7B99D5
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 04:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A794F1C208FB
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 02:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1661137B;
	Thu,  5 Oct 2023 02:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erpHoSQU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D0B1373
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 02:01:23 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973E79E
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 19:01:21 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c60f1a2652so4257745ad.0
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 19:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696471281; x=1697076081; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Az82CAy1ENEE8ZHSQ5TtIVSgE5eqRRKRJ5V7t2KM+YE=;
        b=erpHoSQUwsqu6mmTSPUcuTld6KITTDKC4MIQRPHLzhtOf7FN3Ymv+K4M0XRRk60l6u
         Kb4m7vXQztyqlasXE5WHkhN7hv7kEx1XUJ7eEhplIG0b1KsbinrhWkCrl8aN/pg8lH/a
         qnjkraNJScljrAcP5bTS1eZc8xSwS09usA/wFcuYUcHoph+vIIRvpgv0DJklaQDymcaM
         g+l1XwxCLpdarxIG9+mfpeVC1tjCBF8a3KJoY7zYhx4n0Orp5UfJzhyzEaP/HzRBbbFm
         1frDk1/TjwiNNEd55MrplxD8oRCsc49IcbBu4ZhOoam8VCGHJA/u2APnhJOJ1popDFfJ
         VTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696471281; x=1697076081;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Az82CAy1ENEE8ZHSQ5TtIVSgE5eqRRKRJ5V7t2KM+YE=;
        b=TbuLlgViuNjlI9r8XfRBAaXBxAoMwHvHfQoy3SW2rXPjPAwh3ssS0/8+At9rS4WgqT
         PVqhhBYroY/MMQ5LKDmjO7BQrfJ2NL8SsJxEtKZywZseySew8tvpugniVvsKAkTWFoFq
         8ucynmu6MuEIxC4Y966umqTo1Zt/Ig9DsX15VlUVQKtchLW67/URcVN0VF8ERUCcxfos
         aNRSAqu8OMsLigl0qf55K7Mk9KFgmpItTbn690tJ8j7E8o8RlP2ftGGfHRb0hpju8SP3
         v+C3Sd7Z5IExKLn4xz0tcwJI6IcpPdI7R3IOl/grHHaE6hlgiQ1NAVb6TG+xQpUcCCqM
         TgWA==
X-Gm-Message-State: AOJu0YylSimy1oySfmZMvj4+DXwfuk1idht3bMEA1XW/mMd2ExekSjrt
	t55vanfIJ8mTy7PoyOiPdm9khfjC/Xk=
X-Google-Smtp-Source: AGHT+IHkSDe9NFUroS5edf/5Zr6JrGi0J614icwqRyqH5PW1BJtdxdeMIc/tuTedqJhiGo/cllqkoQ==
X-Received: by 2002:a17:902:ce86:b0:1c4:4a4d:cc6 with SMTP id f6-20020a170902ce8600b001c44a4d0cc6mr7690plg.19.1696471280937;
        Wed, 04 Oct 2023 19:01:20 -0700 (PDT)
Received: from localhost ([203.221.51.174])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001a9b29b6759sm254064plf.183.2023.10.04.19.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 19:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Oct 2023 12:01:15 +1000
Message-Id: <CW04VKYCMTJE.ZX0TQ1Y6H6VB@wheely>
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
> Also, were you able to figure out why we do not see this problem on x86 a=
nd arm64? Is the stack usage so much larger, or is there some other root ca=
use? Is there a simple replicator, as this might help you profile the diffe=
rences between the architectures?

I found some snippets of equivalent call chain (this is for 4.18 RHEL8
kernels, but it's just to give a general idea of stack overhead
differences in C code). Frame size annotated on the right hand side:

[c0000007ffdba980] do_execute_actions     496
[c0000007ffdbab70] ovs_execute_actions    128
[c0000007ffdbabf0] ovs_dp_process_packet  208
[c0000007ffdbacc0] clone_execute          176
[c0000007ffdbad70] do_execute_actions     496
[c0000007ffdbaf60] ovs_execute_actions    128
[c0000007ffdbafe0] ovs_dp_process_packet  208
[c0000007ffdbb0b0] ovs_vport_receive      528
[c0000007ffdbb2c0] internal_dev_xmit
                                 total =3D 2368
[ff49b6d4065a3628] do_execute_actions     416
[ff49b6d4065a37c8] ovs_execute_actions     48
[ff49b6d4065a37f8] ovs_dp_process_packet  112
[ff49b6d4065a3868] clone_execute           64
[ff49b6d4065a38a8] do_execute_actions     416
[ff49b6d4065a3a48] ovs_execute_actions     48
[ff49b6d4065a3a78] ovs_dp_process_packet  112
[ff49b6d4065a3ae8] ovs_vport_receive      496
[ff49b6d4065a3cd8] netdev_frame_hook
                                 total =3D 1712

That's more significant than I thought, nearly 40% more stack usage for
ppc even with 3 frames having large local variables that can't be
avoided for either arch.

So, x86_64 could be quite safe with its 16kB stack for the same
workload, explaining why same overflow has not been seen there.

Thanks,
Nick


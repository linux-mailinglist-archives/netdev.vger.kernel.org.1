Return-Path: <netdev+bounces-36994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364C17B2DF8
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 10:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 5342F1C209B2
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 08:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA16441B;
	Fri, 29 Sep 2023 08:39:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591E2C8C3
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 08:39:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D97D10F1
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 01:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695976744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mv3VvXIidjOeEXag/GlgvFE386R0iePZWSl1awwvXxU=;
	b=RRYh5Ja9mHMZejaUtgfnbZRtK0kI9Zh9QQOaBbjwQd+xxE/mLDscsMW+X0wlDjPwnevAUc
	dysq3E5SYp0SjlvzCeaXAD5c7ibI5M+dmyFAKakHTAfh2fJ2eXm04x/lfuplXdseaZ9glh
	wvhELbradwNOmey4RJiswyeGGAvFF2c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-XlicqLsYNg2Guj2dif_prQ-1; Fri, 29 Sep 2023 04:39:02 -0400
X-MC-Unique: XlicqLsYNg2Guj2dif_prQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5368aae40d2so619237a12.2
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 01:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695976741; x=1696581541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mv3VvXIidjOeEXag/GlgvFE386R0iePZWSl1awwvXxU=;
        b=D+2lPB3nlVDXMPN5t5XWji1geddg1tEI+dsWYr9bGc97uAI3GqwZ6z1jz/wWxOCkfJ
         ARDD2O+BWH9mr2w0+VTrJvHlKGvd77YlktH39QHLSYN61U7IjlpP0rQTMCkHnhdedgIc
         s2R/GShAgVgPpWbDow7o+JFdUrAmw6YdMRbkn5a+VSK/2+TJsaziY93AdgEcJzIgpNGw
         UcEt0nXreKgmPw69OCP9SSnKnZllWtEc2+NT89IknSqPm7+N+WPmIXEIQ8AforimFFUa
         4+c3zgPq5AAFJXrBBBW//fHflhxcyaYsQxAVDkGMjYJiNtZaxHRximxORciwr9RNGNxL
         DnZA==
X-Gm-Message-State: AOJu0Yz9QnvXlNIsFBB8r/IAjaKpOftKmNgxM+Tvy3pYwS5ZkkZS7V8k
	d5ftoQcMLivFNf+r6sOT+EfKy6SRoDZWr1p/mrYZ7NNtRtAkw2u6l7tJl+6TPOxZZ/pk8mBzjtG
	jEoZ/duerZbTfpnkmNSXxuruu
X-Received: by 2002:aa7:d3cc:0:b0:523:102f:3cdd with SMTP id o12-20020aa7d3cc000000b00523102f3cddmr3436267edr.19.1695976741396;
        Fri, 29 Sep 2023 01:39:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IET42v03zYLgmHlz+amCif2nAFwfLaOuOxzHRrQwfBBTMieH1695m8oakOtQ5GkGr3qUiAmYQ==
X-Received: by 2002:aa7:d3cc:0:b0:523:102f:3cdd with SMTP id o12-20020aa7d3cc000000b00523102f3cddmr3436238edr.19.1695976740967;
        Fri, 29 Sep 2023 01:39:00 -0700 (PDT)
Received: from [10.39.192.46] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id ec20-20020a0564020d5400b005346a263bb1sm4604008edb.63.2023.09.29.01.38.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Sep 2023 01:38:59 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org,
 dev@openvswitch.org, Ilya Maximets <imaximet@redhat.com>,
 Flavio Leitner <fbl@redhat.com>
Subject: Re: [ovs-dev] [RFC PATCH 4/7] net: openvswitch: ovs_vport_receive
 reduce stack usage
Date: Fri, 29 Sep 2023 10:38:59 +0200
X-Mailer: MailMate (1.14r5964)
Message-ID: <34747C51-2F94-4B64-959B-BA4B0AA4224B@redhat.com>
In-Reply-To: <CVV7HCQYCVOP.2JVVJCKU57CAW@wheely>
References: <20230927001308.749910-1-npiggin@gmail.com>
 <20230927001308.749910-5-npiggin@gmail.com> <f7tfs2ymi8y.fsf@redhat.com>
 <CVV7HCQYCVOP.2JVVJCKU57CAW@wheely>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 29 Sep 2023, at 9:00, Nicholas Piggin wrote:

> On Fri Sep 29, 2023 at 1:26 AM AEST, Aaron Conole wrote:
>> Nicholas Piggin <npiggin@gmail.com> writes:
>>
>>> Dynamically allocating the sw_flow_key reduces stack usage of
>>> ovs_vport_receive from 544 bytes to 64 bytes at the cost of
>>> another GFP_ATOMIC allocation in the receive path.
>>>
>>> XXX: is this a problem with memory reserves if ovs is in a
>>> memory reclaim path, or since we have a skb allocated, is it
>>> okay to use some GFP_ATOMIC reserves?
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>
>> This represents a fairly large performance hit.  Just my own quick
>> testing on a system using two netns, iperf3, and simple forwarding rul=
es
>> shows between 2.5% and 4% performance reduction on x86-64.  Note that =
it
>> is a simple case, and doesn't involve a more involved scenario like
>> multiple bridges, tunnels, and internal ports.  I suspect such cases
>> will see even bigger hit.
>>
>> I don't know the impact of the other changes, but just an FYI that the=

>> performance impact of this change is extremely noticeable on x86
>> platform.
>
> Thanks for the numbers. This patch is probably the biggest perf cost,
> but unfortunately it's also about the biggest saving. I might have an
> idea to improve it.

Also, were you able to figure out why we do not see this problem on x86 a=
nd arm64? Is the stack usage so much larger, or is there some other root =
cause? Is there a simple replicator, as this might help you profile the d=
ifferences between the architectures?



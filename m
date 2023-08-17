Return-Path: <netdev+bounces-28386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8644A77F464
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 12:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE9E281E96
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 10:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEE7100A3;
	Thu, 17 Aug 2023 10:42:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315E1DDA5
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 10:42:13 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A162D54;
	Thu, 17 Aug 2023 03:42:12 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so12175628e87.3;
        Thu, 17 Aug 2023 03:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692268931; x=1692873731;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L9wsnYtwCVpsPDaj6w+SIw5IfWLUcYuKsKC7dYAdAlw=;
        b=Uqu/b2E0WlzKd1jO88FmLRWjJKIPlpFCrgXYXK7WNv36ZZfBOlHMTWo01Qh5R7By59
         pgK7PpS1TdIQkvyzHI/AcPeLj2WXUv5bT6K4NxFKJ7binVJ5SlgGbRnxZhfxBMPaDC62
         /c4qZ8t6GNwvBmO6e7uN6KL8hCBQHkGUM2qvAbBJGClH41d00UPWj8tdM0AZLwf2RiYy
         QCgU1M6iWr5Gh89E4XQTpOjLIo2p6YIFuXR6Y8IuBdVJVYRKuM7JWpNOdAEJ8g0zyDiL
         dq+uS/l9Tm7LP+6MyC/ABGEblfTt2oKsYBWq0uO6I8q/gHe0V1ESX4xZ2h1LGSJjS275
         j9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692268931; x=1692873731;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9wsnYtwCVpsPDaj6w+SIw5IfWLUcYuKsKC7dYAdAlw=;
        b=Q8RPqOkDZ95OCSPQDHMcCdZdFktdyhl6evSi5A2U5sceOIsDnn4ydlijyBIzVJhjrZ
         Wfja89r0fPxV/q2VPUTgRnWpqeHIwGt6TMWb+45074bz7vj7u7Guv8lACnn2+K8zjrGx
         AdYO5CnTt0EvAIFR4Wyle2rplq70UHgNi0esntYZj1evNnp0W/VHcJWSYUdgLpODvJ+5
         JOtXlXBNY77gb0M/ydkEhGoCUyNC0+8+IYrFjoTseFR1Bjj6ZIW2nVjYz1QGFfE22Mpr
         lAI7EBkjXnGYujcH0aCK/rZr4+QCXWHJrTQZImVBTRpkIzwc7xgvqaWKHO1n293PMGwJ
         /AkQ==
X-Gm-Message-State: AOJu0Yw87DJpqO5RR9CXmkZX0dINbGq6oorsYZF6RtPaEbWbiuwIMGZW
	twL5BVEkCraVRlwJqnxdsPw=
X-Google-Smtp-Source: AGHT+IERtmHanTnHV0WblGrYYSEzETUJAY96ypq+Y5wUzGIyV/9f/p36vTchNTM3kcHEstvgJeRp+g==
X-Received: by 2002:a19:5010:0:b0:4fe:590:53ca with SMTP id e16-20020a195010000000b004fe059053camr3307535lfb.4.1692268930396;
        Thu, 17 Aug 2023 03:42:10 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:b526:e684:e15e:6a87])
        by smtp.gmail.com with ESMTPSA id t24-20020a1c7718000000b003feae747ff2sm2489969wmi.35.2023.08.17.03.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 03:42:09 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  linux-doc@vger.kernel.org,  Stanislav Fomichev
 <sdf@google.com>,  Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 06/10] tools/net/ynl: Add support for
 netlink-raw families
In-Reply-To: <20230816082908.1365f287@kernel.org> (Jakub Kicinski's message of
	"Wed, 16 Aug 2023 08:29:08 -0700")
Date: Thu, 17 Aug 2023 10:10:35 +0100
Message-ID: <m2cyzmhw50.fsf@gmail.com>
References: <20230815194254.89570-1-donald.hunter@gmail.com>
	<20230815194254.89570-7-donald.hunter@gmail.com>
	<20230816082908.1365f287@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 15 Aug 2023 20:42:50 +0100 Donald Hunter wrote:
>> Refactor the ynl code to encapsulate protocol specifics into
>> NetlinkProtocol and GenlProtocol.
>
> Looks good, but do we also need some extra plumbing to decode extack
> for classic netlink correctly?  Basically shouldn't _decode_extack()
> also move to proto? Or we can parameterize it? All we really need there
> is to teach it how much of fixed headers parser needs to skip to get to
> attributes, really (which, BTW is already kinda buggy for genl families
> with fixed headers).

I have been working on the assumption that extack responses don't
include any fixed headers. I have seen extack messages decoded correctly
for classic netlink, here with RTM_NEWROUTE:

lib.ynl.NlError: Netlink error: Invalid argument
nl_len = 80 (64) nl_flags = 0x300 nl_type = 2
  error: -22  extack: {'msg': 'Invalid prefix for given prefix length'}

Is there something I am missing?


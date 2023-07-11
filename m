Return-Path: <netdev+bounces-16882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB10074F436
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 18:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021951C20F4E
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 16:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C9A19BCA;
	Tue, 11 Jul 2023 16:00:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46F219BBA
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 16:00:30 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7B21997
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:00:13 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-668730696a4so3238794b3a.1
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1689091213; x=1691683213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtgtHmRjQh6peCUcy7ZXormSDT7LV1mIQbv/xli3dTU=;
        b=Mndu4i+Lu4Vror6d6y887i8R7Wo0Z00z+H3fKR6fAoG/C4B3On9jvBSpvrxQx1K0IE
         Edqa4pdXEKndiLJ2rAcDOelzY/vUYoWQ5B6wtla4F1Ajxpv1Afhb61rcqtXHRZ+5RwPg
         a0XQ/rcwUE1BA5sei439JlM670bhTlqZ8tYpY6wOv0xJIKBCCJdtTmjp0Xi981FmMygu
         yzCZObTAWLBX0LT7EVPnzjA7aeYo3lFkRIV8kc9BgnZQX+fFcUHrdE46I4RgZMRHW7uh
         lEBu7vANxKXnibLnj1bMVpDmDOwHENEhmFvOEhEjfMeoL+1T0TQDaOO39E5I4cDOm4aP
         hSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689091213; x=1691683213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtgtHmRjQh6peCUcy7ZXormSDT7LV1mIQbv/xli3dTU=;
        b=DYGM5681p6jhvZkCJ+iPo15we8o0aX7yd1zVIEcTbp7Aff9qse7EPFDkKbFn1dncbO
         r1ygPr0rwqHS//2O1+rB6xcud3zi6B20oDV0XNRkQbHdwpZf7QcUIW9lVSH7FMZnd2II
         DhIoKeIYrBI5eNtHu53bXwDv/+XRY4Jl+CjkUKgwG7WHdnArlHS5rqHma49HZi3RzI4w
         9TfZKwNSGzemDACaECrQ3eT5fwRhRJkjyoH/9xRgEgg67huRsEwICDydhrajRCb7u4H7
         mUjive6OpZQGF5WntH2AdpDdwxsoPtga99TaKLaGCsPgbTm+4EN/rTgY1/uaGmcK7smR
         4aGg==
X-Gm-Message-State: ABy/qLYPurRuLybfN+9CttZHnABYWm6jdZ5GovtP7uol+OPKAh/PNvvF
	5t4CIjGtoET+H+4NIVxEG61vOg==
X-Google-Smtp-Source: APBJJlGsjdNamm25eVwBvUfaxwyfrN2fLgDWAfN0RheKbvWJ3/MrUeGn+uuY0yvIa6K4WaEkI12ZHw==
X-Received: by 2002:a05:6a00:2e09:b0:676:20f8:be41 with SMTP id fc9-20020a056a002e0900b0067620f8be41mr15082380pfb.16.1689091213096;
        Tue, 11 Jul 2023 09:00:13 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id a28-20020a63705c000000b00528513c6bbcsm1772038pgn.28.2023.07.11.09.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 09:00:12 -0700 (PDT)
Date: Tue, 11 Jul 2023 09:00:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, Andrea Claudi
 <aclaudi@redhat.com>, Ying Xu <yinxu@redhat.com>
Subject: Re: [PATCH iproute2] lib: move rtnl_echo_talk from libnetlink to
 utils
Message-ID: <20230711090011.4e4c4fec@hermes.local>
In-Reply-To: <20230711073117.1105575-1-liuhangbin@gmail.com>
References: <20230711073117.1105575-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 11 Jul 2023 15:31:17 +0800
Hangbin Liu <liuhangbin@gmail.com> wrote:

> In commit 6c09257f1bf6 ("rtnetlink: add new function rtnl_echo_talk()"),
> some json obj functions were exported in libnetlink. Which cause build
> error like:
>     /usr/bin/ld: /tmp/cc6YaGBM.o: in function `rtnl_echo_talk':
>     libnetlink.c:(.text+0x25bd): undefined reference to `new_json_obj'
>     /usr/bin/ld: libnetlink.c:(.text+0x25c7): undefined reference to `open_json_object'
>     /usr/bin/ld: libnetlink.c:(.text+0x25e3): undefined reference to `close_json_object'
>     /usr/bin/ld: libnetlink.c:(.text+0x25e8): undefined reference to `delete_json_obj'
>     collect2: error: ld returned 1 exit status
> 
> Commit 6d68d7f85d8a ("testsuite: fix build failure") only fixed this issue
> for iproute building. But if other applications include the libnetlink.a,
> they still have this problem, because libutil.a is not exported to the
> LDLIBS. So let's move the rtnl_echo_talk() from libnetlink.c to utils.c
> to avoid this issue.
> 
> After the fix, we can also remove the update by c0a06885b944 ("testsuite: fix
> testsuite build failure when iproute build without libcap-devel").
> 
> Reported-by: Ying Xu <yinxu@redhat.com>
> Fixes: 6c09257f1bf6 ("rtnetlink: add new function rtnl_echo_talk()")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

I don't see this when iproute2 is built.
Libnetlink is not a public API. And there is no guarantee about
compatibility if an application links with it.  Collect2 should be
using a supported library like libmnl instea.




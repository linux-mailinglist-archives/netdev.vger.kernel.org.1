Return-Path: <netdev+bounces-15557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D1A7487E9
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 17:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079961C20B6F
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 15:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6C211C86;
	Wed,  5 Jul 2023 15:26:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEBFD526
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 15:26:10 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB17170B
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 08:26:07 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666ecf9a0ceso3396292b3a.2
        for <netdev@vger.kernel.org>; Wed, 05 Jul 2023 08:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1688570767; x=1691162767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xa8l5W64uJlvGeV+OrN8NQyDk5eo1H48/yo/RAL/jPM=;
        b=wtRhMYODWW5ptCVw3fLk0aA1jDVnCN2D3TXW/GyxF76M3TKqbLIRLr1JkLsrT8nubJ
         Qz50poPgRue6koZQT0gYGV8idVBIvAAVJyZfI0p4YthpOpMmrFny9AX5rhScFxorqj0j
         MJepXmZ5UimQ3SzY2ZyLDVP5dIUXoOT9oG2UDHI7XMyBBjyIl/9AkzkOEOuKhk2IH4Ga
         zJCv6Tx20j8DRKjlycZnBru76vw+Qtq92JdWhEGKO2tDxjHYRwVMi6HV4F3E+M6Pu1m2
         DybnTJpN6t9Mfo/Oq2hX+srsXDpcJZBAWNHzRZ/TxtF7NGiZmz0HJE/fDLe+4SlFEgRh
         KyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688570767; x=1691162767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xa8l5W64uJlvGeV+OrN8NQyDk5eo1H48/yo/RAL/jPM=;
        b=Lr+0GmnHdU8VBlrA2HgBi8187yhkRLZPgb6CqiqsqusTYhNlRLTsIgEw+/5+ossJ9W
         RGeKfTtE9pGV9IX9vZegXbKqxtULVZJ2oOmORyruyzUSjuojG404zpK0zvs2qrpYlCoK
         e8cpc9RTErqiJhr7aSnObC5rfr4R2Wn2eow/1TNURvFESRCjloQ8x9wGB5LW+zB9LBIJ
         x/A4kN/GyIZJCwnjCSHlgxAvbuw74HWoCtYessAy+z5KRJkQOXXbtF1u73YO2vpp37yq
         jlQ8ezlL2S/weQu9I9geab/ugC58eNP4H7h7vNpcGCMdJHmPb50ISodedyOAuPj3bURz
         KuSA==
X-Gm-Message-State: ABy/qLYNbSFBmSNCALRRoXFpV9WqbD9m2Mtf+4yPIKcrzcm7aLNMPxdX
	FjPk57+WrY6/riXlqlEvr+lTow==
X-Google-Smtp-Source: APBJJlHe03DAPIWSU5hFp5ndbVtx5g2LL1bHur1wfB7oOHBaFZExIoTqYGQzhvHF4K8+cVs6X5sMAQ==
X-Received: by 2002:a62:7b42:0:b0:67e:bf65:ae68 with SMTP id w63-20020a627b42000000b0067ebf65ae68mr12948969pfc.3.1688570767138;
        Wed, 05 Jul 2023 08:26:07 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id q23-20020a62ae17000000b006758ae3952bsm15692092pff.122.2023.07.05.08.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 08:26:06 -0700 (PDT)
Date: Wed, 5 Jul 2023 08:26:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, sergey.senozhatsky@gmail.com, pmladek@suse.com,
 tj@kernel.org, Dave Jones <davej@codemonkey.org.uk>, "open list:NETWORKING
 DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netconsole: Append kernel version to message
Message-ID: <20230705082604.7b104a48@hermes.local>
In-Reply-To: <ZKU1Sy7dk8yESm4d@gmail.com>
References: <20230703154155.3460313-1-leitao@debian.org>
	<20230703113410.6352411d@hermes.local>
	<ZKQ3o6byAaJfxHK+@gmail.com>
	<20230704085800.38f05b56@hermes.local>
	<ZKU1Sy7dk8yESm4d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 5 Jul 2023 02:18:03 -0700
Breno Leitao <leitao@debian.org> wrote:

> The uname is useful if the receiver side is looking (grepping) for
> specific messages (warnings, oops, etc) affecting specific kernel
> versions. If the uname is not available, the receiver needs to read boot
> message and keep a map for source IP to kernel version. This is far from
> ideal at a hyperscale level.

At hyperscale you need a real collector (not just netcat) that can consult
the VM database to based on IP and record the meta data there.  If you allow
random updates and versions, things get out of control real fast and this
won't really help much


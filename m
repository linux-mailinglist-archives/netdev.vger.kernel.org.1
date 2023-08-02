Return-Path: <netdev+bounces-23765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D50F776D75F
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 21:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C126281A06
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 19:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB96100DA;
	Wed,  2 Aug 2023 19:02:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBB4D2E8
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:02:41 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7983CC3
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 12:02:38 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7658752ce2fso8004885a.1
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 12:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691002957; x=1691607757;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BmxVcSv1AUkEFvepEWrjrtduV9BdOX4+MifZ4oZNC0=;
        b=mME1PPc3j2c58c+raSdfN8eZpLRxh29XZIsP6DcSJy1Lrdw1ey1afodbwKH+cuXPaK
         KcybLP2GPJObLLYYnse9Auwa0nsHxWcMEmntI7IRMRJmea6OZEC2oQoiQ5SlRYTsOYxR
         ljOlwrtE+HSOsSbbnLvtMkNibzd6OtHLOj6I++TlViGQKyPPodNnfR7CwpHNRGWtBVJo
         Et5w/x4oyeER7Gr3aQ7xp14DmjDNJnDaNHTIFmdBxP4z3J1yNMVdSwco5Br79LrXoQoO
         KHhvWFX9D7qG2hRJxHfoZxxBHDEiK7QIVQs5SZE6LrCmFVEOKUUscrTQQtsZ3Yk6j5KO
         h+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691002957; x=1691607757;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2BmxVcSv1AUkEFvepEWrjrtduV9BdOX4+MifZ4oZNC0=;
        b=T4CoeYoUiBlh4MEGV/hWShx13Y6+yVvz/YFzO8vsa78+GcBsNtEtTIaAMgWSThE5iN
         lNa5+fn9obBJT0Cqvnx2dmOnXHoijdizRmm9XZ5YSx9ReVMLtvbFdh0Zq6+vXvAnfimn
         JQLaBpCGlgGwat+coXvBi9o9W46j0KBNEflSbRuoCGDo6vwv6MQAkjwpchQuqf//VdyJ
         80iNIi++23/sOCe/cKBqzufFa26wvTMbPi8ymEv6AM6iPPGy/rldcEwBEWKk82O410Bd
         xgFdhQZ/neuC6/Lveppn5V995uH4P9XMCQPA2gb5FO20PPlSprg9GMCiM3eJ+7cBlkaY
         vqtg==
X-Gm-Message-State: ABy/qLZC7aRz6Az74n1PFVz7fA6yNC/supsaP9lr1FmhN9CvHrgq4C1k
	1J0ifw4xckWgevYo8VuTHlMuLte3Obk=
X-Google-Smtp-Source: APBJJlFMCFK27IYSaE0fyq6hY0z1QOZTAOq60SOYcYTdewXWr0wBNAucNVfjLAZtXqmFTp1nnhVUfw==
X-Received: by 2002:a05:620a:1906:b0:767:47dd:15f with SMTP id bj6-20020a05620a190600b0076747dd015fmr17516243qkb.15.1691002957500;
        Wed, 02 Aug 2023 12:02:37 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id o9-20020a05620a110900b0076c84240467sm4449878qkk.52.2023.08.02.12.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 12:02:37 -0700 (PDT)
Date: Wed, 02 Aug 2023 15:02:36 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 Maxim Krasnyansky <maxk@qti.qualcomm.com>, 
 Jason Wang <jasowang@redhat.com>
Message-ID: <64caa84cd823c_2c74a029495@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230802115526.7d2d7c4d@kernel.org>
References: <20230802182843.4193099-1-kuba@kernel.org>
 <64caa3a09cbbb_2c6331294a6@willemb.c.googlers.com.notmuch>
 <20230802115526.7d2d7c4d@kernel.org>
Subject: Re: [PATCH net] MAINTAINERS: update TUN/TAP maintainers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski wrote:
> On Wed, 02 Aug 2023 14:42:40 -0400 Willem de Bruijn wrote:
> > >  W:	http://vtun.sourceforge.net/tun  
> > 
> > Should we drop this URL too?
> 
> No preference here. I checked that it's online so I saw no obvious
> reason to delete it right away. It may also be a good idea to read
> thru the in-tree docs and check that they still make sense.
> I'd rather leave those kind of cleanups to the new maintainers :)

Ha, fair. Sounds good.


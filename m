Return-Path: <netdev+bounces-29846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DD4784EB4
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 04:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707AE28125C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 02:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BC415B1;
	Wed, 23 Aug 2023 02:29:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0DA15AE
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 02:29:07 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A60E4B
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 19:29:06 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-565e395e7a6so2644280a12.0
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 19:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692757746; x=1693362546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xHmjEdWVf9RZilFQZd1OAq7U4+CQ7OZegBXK7PmWo94=;
        b=eBQ+VLOutg4Fa0Rj/l27tL5UyVSW+YOd9z1U9ph2YkLOdIbMZy5zi2QQWgQa+01CuP
         Ku+2dXv+Ww8styF9Uzsu/dMeJMpJfsenRm06KiT7gjg5MMwAfLlsdh+cqd4fuHQIapr5
         10FsntaBq6if4HrahlTIqWjHZ+URZzzLWHN1etc6yy8afKGX007vYbnDuyRzV35wcFTk
         OVw6NFzfTbIa78VpmOJgOLOODBZ4hitoSQoJE7EbuJjbdPL2WMthoITMYyl/H4atOkGF
         mxtMSD3zvcIpijhdjjD0bf1ps53u1p1vRfxR6NoOTafmK1B2oiWgCL9fFwt664deTiv2
         zW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692757746; x=1693362546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHmjEdWVf9RZilFQZd1OAq7U4+CQ7OZegBXK7PmWo94=;
        b=BsvXdYFIk7d9rr+6BZFd2FhpyFJIv8d1K8x0bhrhBODDGbgbId5TrhSv1z5BuAHaXD
         uFKDEOWVXlE+Qaeo0fZ3Z81gtLh7rfJsBJSWAhRq+J4IHBrsLeUSfZ9nhxffHHMhRNke
         PErfI7K9yqJ1MAlpQtPqmFDmzOyRNa6dbY6bmQDbRj0yGA1UDOFf8NLJKwQo2AMpDFSD
         iH/UWBs5BcBqUg3BcFv1JI/ySlhx3Q6BKYkzfi7MNpOlbttIdWLiCAhmmheRMvybx/tx
         StD10s9aWnbVUy1ve3ijrwQ1I5jCrWZ2v2jorJz1bG9n/sNJqqWGAB5f1rt3tSyIjad9
         LmYA==
X-Gm-Message-State: AOJu0YwgOyzEu9feZxLZa5F2g/OW1/mY/cQoN5iNM0NhSsVRAqPhrBlp
	3AF71ETeuXc9VS0mDR8LBVw=
X-Google-Smtp-Source: AGHT+IGJh3CeHnmWYoXO3Q4jEfSRixC2+S8F9gt42hbTKsj4IsNbZg6X4V7YTjC2ToCGzfJHO0D2+Q==
X-Received: by 2002:a17:903:11c6:b0:1bb:98a0:b78a with SMTP id q6-20020a17090311c600b001bb98a0b78amr11842256plh.18.1692757745778;
        Tue, 22 Aug 2023 19:29:05 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 10-20020a170902c14a00b001b8953365aesm9703654plj.22.2023.08.22.19.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 19:29:04 -0700 (PDT)
Date: Wed, 23 Aug 2023 10:29:00 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>, Jiri Pirko <jiri@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCHv2 net 3/3] selftests: bonding: add macvlan over bond
 testing
Message-ID: <ZOVu7PRAH4Kjl8Y/@Laptop-X1>
References: <20230822031225.1691679-1-liuhangbin@gmail.com>
 <20230822031225.1691679-4-liuhangbin@gmail.com>
 <20230822185411.52dad598@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822185411.52dad598@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 06:54:11PM -0700, Jakub Kicinski wrote:
> On Tue, 22 Aug 2023 11:12:25 +0800 Hangbin Liu wrote:
> > Add a macvlan over bonding test with mode active-backup, balance-tlb
> > and balance-alb.
> 
> The pw check you added says you need to add this script to a Makefile :)

Ah..Thanks for your (and the bot's :P) reminding!

Hangbin


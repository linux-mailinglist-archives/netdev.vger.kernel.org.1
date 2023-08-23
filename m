Return-Path: <netdev+bounces-30004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670AE7858DD
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 15:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21BED28136B
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 13:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE2CBE79;
	Wed, 23 Aug 2023 13:17:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109D8BE73
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 13:17:38 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEE210F8
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 06:17:12 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68a40d8557eso2391960b3a.1
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 06:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1692796615; x=1693401415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjkFmCD3y1QDV1rix7RL6AF9UUpNPLzRafTb4/KVlQo=;
        b=1Rr3WZSMfajOBphJRmn8XNfD8UMBRpVOCbqPbjCFiKHbOj4DVsHDiIhEwWpGQNA/9g
         cR8iBF4DNyeUGk7XbpeniApCTNV9yMy1tSif7Jz7PHWpmk1jZbZCYeZ/3LwhIrCl3MJo
         q/k1FWqB8F2T5yK+KQEdwjxVMkxHQEZQO9Sc0no7eXP+sw0+JD6V9/9HbxOixyaHqZcj
         XRqBZ7o3Eh72h0zw4RrR/aBCByqqCL/VQT0Y/xuZU3yzw1ak0DQRj5QtDC/rRAb7P3ao
         0+q9rZPU6Hz0kbPMK43WSatqv6q0FhkrQABEj+pnxXESkyH+Dt89K/JQ6y8PoAcyqAur
         z+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692796615; x=1693401415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjkFmCD3y1QDV1rix7RL6AF9UUpNPLzRafTb4/KVlQo=;
        b=SFN5J5nnCY+Q86X+ceQheh1M7gHYST9pNPNmBagNrhQpFrCfiU4fWmtETTij/f1e5c
         T30RuuW6cl0goEYdCyF0Q533rGmbDb/0t0QKZAgySoniAoQAZdAPITL/+KMVX604DN5d
         KMqYKUMl03H32cXIuL3jkh18jJfo0k/+1/FYau1xj/OioSMGVppOc/OmcNNGxPTtpoHj
         ahQEIadh8MrRVpvN/DXoPy5FEd1FegbRYGsc/cZMTY094aRgBZi5ac09tRQ80BJBgsW1
         lusDcaXorl4xUuMeapn6cpoqsVHUmfvj/88lfSXTKgmNxqHTZZ8xiSzeZHVKMXvO4PzL
         3RHQ==
X-Gm-Message-State: AOJu0Yws3UQ68HPiKyUN4/y2J0E5quXJ8veop1y3RNPzApMKwhuXua+c
	+PS2fVOb3oNMGEcjitdzZLwLH2IYUnEalStmwI0t8Q==
X-Google-Smtp-Source: AGHT+IHrpuJ1vxsba/Ug+upZbED3BBsU61hAyzHPIbwSEKmuabwmE7lHUa+3jpGX/L7pP+g983oN5Q==
X-Received: by 2002:aa7:8c02:0:b0:68a:3eef:1672 with SMTP id c2-20020aa78c02000000b0068a3eef1672mr14361497pfd.5.1692796614996;
        Wed, 23 Aug 2023 06:16:54 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id 9-20020aa79109000000b0065980654baasm9421404pfh.130.2023.08.23.06.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:16:54 -0700 (PDT)
Date: Wed, 23 Aug 2023 06:16:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: francois.michel@uclouvain.be
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH v2 iproute2-next 0/2] tc: support the netem seed
 parameter for loss and corruption events
Message-ID: <20230823061652.41c238dc@hermes.local>
In-Reply-To: <20230823100128.54451-1-francois.michel@uclouvain.be>
References: <20230823100128.54451-1-francois.michel@uclouvain.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 23 Aug 2023 12:01:08 +0200
francois.michel@uclouvain.be wrote:

> From: Fran=C3=A7ois Michel <francois.michel@uclouvain.be>
>=20
> Linux now features a seed parameter to guide and reproduce
> the loss and corruption events. This patch integrates these
> results in the tc CLI.
>=20
> For instance, setting the seed 42424242 on the loopback
> with a loss rate of 10% will systematically drop the 5th,
> 12th and 24th packet when sending 25 packets.
>=20
> v1 -> v2: Address comments and output the seed value
> *after* slot information in netem_print_opt().

Daid will pickup the pkt_sched.h changes as part of regular header update

Acked-by: Stephen Hemminger <stephen@networkplumber.org>


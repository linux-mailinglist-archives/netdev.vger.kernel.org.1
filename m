Return-Path: <netdev+bounces-22930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C24F76A0E7
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 21:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B151C281466
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 19:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DB31DDCA;
	Mon, 31 Jul 2023 19:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA638657
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 19:10:27 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A84FE4B
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 12:10:26 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686efb9ee3cso4626869b3a.3
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 12:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690830625; x=1691435425;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6hJToZEN8HlSrrU9/aO9GhCrt8BQ8vxQnijU8MbUPZA=;
        b=OQ1+VYuRoWIXG6ULQoCtKa6Fq/VLpFvivqC+et89ixrNSJM9nA4OdcN4WR3PbGxgqZ
         zdSx54gA+rz1pGaMfFLrX+MYYZ/uCe8/fSZRAPprebIVeAufl4UP14tiNH9sZds631fQ
         XtP9qeIdEK4RGXxTgyvv9MWHXkGh970pwdPzcNeKBnNY9FI/MxTw5K+6ljUwuV2em1Jf
         vf8RfU1UOHYoZPaASKyU0n+sYMXzqxVHJ8r0vFRjF2vPDfwv0pUXE6eoqsFC5s6vgAC2
         dz1B/MWOb5yRawmkXb0EQYM3HXWPjE0EBV9bCRrjISKSg0TiGsgADSN6EUvJT3H848Lr
         COfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690830625; x=1691435425;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6hJToZEN8HlSrrU9/aO9GhCrt8BQ8vxQnijU8MbUPZA=;
        b=CqkVoyTXXyt8J1YmOtArQvR0m7BvFltyOJk8d+4Hvyds7GhR0ZZCU2YE++7nFVtHVg
         u1IdTNLmmKPYePs/D4xo0OBNNcw2Ew3CzaAn8DBkhwc/9gZWJDOX9uqu++zl+zqB16jQ
         sc8+5yopniOiJgasu53OMIzGXpWLuKo5DWT+AMJHxvP31qTPdwCsA3bpKNEfydj0z4L2
         XYLPQDVkgksFci8B0M6nm74MYG4/YXVIq3mKgPT8uPJ4RipTrQEYuaqMAWqhjPTDtFDJ
         Fb4il00BrYyHwL0vvtqDveQSObk6m2dTQsT38gl6N3LBh9/zUNCQqbDCdIDDmZs8GZLn
         Hgdg==
X-Gm-Message-State: ABy/qLa6AJxTi4egeMT4IFnarW4CULFrV2M5VKpAn8TKbGPYo+uLb8eX
	/FYH/vXjZtlErq/cqLUMqskCMZ6rxJ3AfIfXJohgeBK5MkI=
X-Google-Smtp-Source: APBJJlFj/BGngihkH337O17DLdQSJZoZSkHQ++Qsww8xmhRgM4EXXxr9h46n6XT2oRkp74xti9AnRLR6aMurCy0brFs=
X-Received: by 2002:a17:903:11d0:b0:1b8:c972:606a with SMTP id
 q16-20020a17090311d000b001b8c972606amr11624110plh.51.1690830624922; Mon, 31
 Jul 2023 12:10:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Taht <dave.taht@gmail.com>
Date: Mon, 31 Jul 2023 12:10:13 -0700
Message-ID: <CAA93jw6OM9hzT2Okk4_tuLg_f=M-TXz+a17ZrRB2CL9uzm_eig@mail.gmail.com>
Subject: RFC: making sch_cake multicore?
To: Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The ongoing, everlasting feature request for CAKE has been to speed it
up on now common multicore embedded hardware. 4 and 8 cores are
increasingly common in my world. I am really out of date on how
feasible this would be, in fact I don't know if older efforts to
remove the locks from pfifo_fast ever succeeded. Similarly, on inbound
shaping, we remain dependent on a tc filter matchall... mirred  into
an ifb, which is quite slow and apparently still single threaded.
Leveraging some shared memory area for some shared parameters in a
mqprio-like design is on my mind, but somehow that would have to share
some data with sub-qdiscs.

Over here is a design document talking about two approaches to this so
far. Please comment there. Thx!

https://docs.google.com/document/d/1tTYBPeaRdCO9AGTGQCpoiuLORQzN_bG3TAkEolJ=
Ph28/edit#heading=3Dh.1d4d73u2m8nx

--=20
Podcast: https://www.youtube.com/watch?v=3DbxmoBr4cBKg
Dave T=C3=A4ht CSO, LibreQos


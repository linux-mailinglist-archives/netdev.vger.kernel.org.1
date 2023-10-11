Return-Path: <netdev+bounces-39807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A767C488D
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 05:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355061C20CD5
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 03:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D515C8FD;
	Wed, 11 Oct 2023 03:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0vEOCkH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B820620EC
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 03:44:01 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FA6C4
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 20:43:55 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3af6cd01323so4490441b6e.3
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 20:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696995834; x=1697600634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IKR9r5Qe6BeqSzLwPuDSIiHAG+X1LtqQDyD9W9cqVb4=;
        b=R0vEOCkH3TCR9nXEHSyUPEnHbiJAFGXAZtOvuU9IQ0EK9hIxJ8U/p8kI3FN348PHWJ
         49XZvQyitwaniWHzOWkSx4JvT4VwfgTQSXNoeohmnSj39843F5lwOe2w00J6rmlPVCov
         DNbyqN2bYgXoGjQIU87/fxyLxWz7b6AuWVy3f5xqiMJW+JLMXAR+J2gGujb+kIlxGADP
         RLEI8e/MXYB092MpCkpRvEWe9DR1okgwLBaVLg+Ltvkkbp1PuTIXOiikGtyEuJU42oZK
         v7YEg8fEDUKxbEYvV+15DtW0YA9ccjKp6XOas7GzQYprOj9N8mX2lutS6425XoASX+Nb
         yUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696995834; x=1697600634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKR9r5Qe6BeqSzLwPuDSIiHAG+X1LtqQDyD9W9cqVb4=;
        b=YLmuX9uqR4ugGvHWMEAhTwpoe3YexVCJmuJF57PNFnuadVFfEwpvtXjYbN98d4w1Jj
         vKsM5Y4PFHgPsGD2+Dr3EEt+PsvHj0MpmFQoTxM6U7b9DDgwSClo6Z6GncpVweCtmg2Z
         tWFlwoteoxenw2/dXVvTxnktChfYUoTK+RaToqls52vsv997zBkBuMIpF83sS3bBtg6D
         blxKlUa6IY8JHSkDaq6FgJBcD4ZwATeUz/4/qXAi91+sR/3bT/WYDFvgcesDubpm1zgs
         ffmDU3/OD0jzY59o0XgRRA/OokfU5kEhyvazVUNRHYdXRpZNrwP6inv60VsjJuTc+1xh
         HreA==
X-Gm-Message-State: AOJu0YxaIB6Jm4SrWcuw/nV5UmvfgaHF0gT5HnhtEdC16P+XN0Tz1/jC
	/whh8ENxOe8R51N40IRWVv/lexonHiuhqA==
X-Google-Smtp-Source: AGHT+IGBFwWnHJUX2e/FxWq1XqcG+zSQWmJr34PbyQu+nEcI4GneQ+mbYRrGVMo0Swq60vW4L6aZfA==
X-Received: by 2002:a54:4d02:0:b0:3a7:b094:8f2 with SMTP id v2-20020a544d02000000b003a7b09408f2mr21535166oix.45.1696995834638;
        Tue, 10 Oct 2023 20:43:54 -0700 (PDT)
Received: from wheely.local0.net ([1.128.220.51])
        by smtp.gmail.com with ESMTPSA id q30-20020a638c5e000000b0058a9621f583sm7873656pgn.44.2023.10.10.20.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 20:43:54 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: netdev@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	dev@openvswitch.org,
	Pravin B Shelar <pshelar@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	"Eelco Chaudron" <echaudro@redhat.com>,
	"Ilya Maximets" <imaximet@redhat.com>,
	"Flavio Leitner" <fbl@redhat.com>
Subject: [PATCH 0/7] net: openvswitch: Reduce stack usage
Date: Wed, 11 Oct 2023 13:43:37 +1000
Message-ID: <20231011034344.104398-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

I'll post this out again to keep discussion going. Thanks all for the
testing and comments so far.

Changes since the RFC
https://lore.kernel.org/netdev/20230927001308.749910-1-npiggin@gmail.com/

- Replace slab allocations for flow keys with expanding the use
  of the per-CPU key allocator to ovs_vport_receive.

- Drop patch 1 with Ilya's since they did the same thing (that is
  added at patch 3).

- Change push_nsh stack reduction from slab allocation to per-cpu
  buffer.

- Drop the ovs_fragment stack usage reduction for now sinc it used
  slab and was a bit more complicated.

I posted an initial version of the per-cpu flow allocator patch in
the RFC thread. Since then I cleaned up some debug code and increased
the allocator size to accommodate the additional user of it.

Thanks,
Nick

Ilya Maximets (1):
  openvswitch: reduce stack usage in do_execute_actions

Nicholas Piggin (6):
  net: openvswitch: generalise the per-cpu flow key allocation stack
  net: openvswitch: Use flow key allocator in ovs_vport_receive
  net: openvswitch: Reduce push_nsh stack usage
  net: openvswitch: uninline action execution
  net: openvswitch: uninline ovs_fragment to control stack usage
  net: openvswitch: Reduce stack usage in ovs_dp_process_packet

 net/openvswitch/actions.c  | 208 +++++++++++++++++++++++--------------
 net/openvswitch/datapath.c |  56 +++++-----
 net/openvswitch/flow.h     |   3 +
 net/openvswitch/vport.c    |  27 +++--
 4 files changed, 185 insertions(+), 109 deletions(-)

-- 
2.42.0



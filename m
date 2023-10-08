Return-Path: <netdev+bounces-38916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25F27BD004
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 22:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E1F2815A8
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 20:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15651A5A2;
	Sun,  8 Oct 2023 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoU7Kt5A"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F07EEB4
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 20:12:50 +0000 (UTC)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8A3AC
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 13:12:48 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4181e268447so26332091cf.1
        for <netdev@vger.kernel.org>; Sun, 08 Oct 2023 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696795967; x=1697400767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mzJciThIRngmszwGOmWtUINb2s0XQcmrrOyo0Wh/vig=;
        b=HoU7Kt5AGI062DJ/Z5yG66wZaxbJiaEBxBlBX+SxxxqqSArwafCWEXkUrLNyI585H7
         TYTcvV2fmk03UzTlgkH7LDB05dO/8h6j0cuqQSgRIeXU/0ZblwQ6yU2+CT1s1tlz9Nyv
         EmRjF2WOr/OaT/RyHX+pHbt29l15+x/B+jN0eNh2XwpHWPdJeu+PTHHHDXmoC1HoX7OW
         M8P6QMzvtwsHO8UcvomHs/IenmYidL7Xn2jDgmzGUzGVxqpiZhSJSS387Zc5VYL2LvcP
         buLTCtRlz5XWoKpuf64QtHqGyfiZbpW4MAXTXYgKMMq1LQkp6Xr2nDNOe+nFkneuhlpj
         Tkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696795967; x=1697400767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzJciThIRngmszwGOmWtUINb2s0XQcmrrOyo0Wh/vig=;
        b=saGjynlWTmvlhJX8Ytz8nKy1rE26hlIezx+5447s1H1F5MxRy2wRwPGI9QgFp1q0D2
         vxzlbbpzkYnhwip44u9TQp0UD/JJSAj1iR4rKUoeV3WDp9LIp8lltQNc48zzRFzHK4N+
         QITKKLdI8RS6lF5YQ9Woc8j2HK+sWySPismSuJdthMPW9ZQR0yhNlEOR4wqO9bMEjnLb
         buSiLlRoaq9oVJ9a/6wh24gtjXhl6wa59XG68s5Y2zqoviWdOCIz0rkZfbT8H0LOeNXX
         BbPTrvYbetpUKftnnfdPmx5/ZXAqauuwbnJqZmBl146uL7hg+3Ma5jVP2tJTxpFOlbj5
         G6EA==
X-Gm-Message-State: AOJu0YyaDM0FlgWFkhIKyJ/TDH55oh2LBLOCU3IOX1Xae/q7mTnn3mME
	RabvhcLo/h3pZQydk9sWgpyNVVL3UzdLbQ==
X-Google-Smtp-Source: AGHT+IEtvU5KztBJM1WIdxEWv5PmizRhbMorIkomPB11iEhX4FdpYdYZNEl7F14HnibEECmzPmjhRg==
X-Received: by 2002:a05:622a:20b:b0:412:2ed3:38ec with SMTP id b11-20020a05622a020b00b004122ed338ecmr15205872qtx.18.1696795967533;
        Sun, 08 Oct 2023 13:12:47 -0700 (PDT)
Received: from willemb.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id v18-20020ac87292000000b00419c9215f0asm3075533qto.53.2023.10.08.13.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 13:12:47 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	alexander.duyck@gmail.com,
	fw@strlen.de,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 0/3] add skb_segment kunit coverage
Date: Sun,  8 Oct 2023 16:12:31 -0400
Message-ID: <20231008201244.3700784-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
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

From: Willem de Bruijn <willemb@google.com>

As discussed at netconf last week. Some kernel code is exercised in
many different ways. skb_segment is a prime example. This ~350 line
function has 49 different patches in git blame with 28 different
authors.

When making a change, e.g., to fix a bug in one specific use case,
it is hard to establish through analysis alone that the change does
not break the many other paths through the code. It is impractical to
exercise all code paths through regression testing from userspace.

Add the minimal infrastructure needed to add KUnit tests to networking,
and add code coverage for this function.

Patch 1 adds the infra and the first simple test case: a linear skb
Patch 2 adds variants with frags[]
Patch 3 adds variants with frag_list skbs

Changes v1->v2 in the individual patches.

Willem de Bruijn (3):
  net: add skb_segment kunit test
  net: parametrize skb_segment unit test to expand coverage
  net: expand skb_segment unit test with frag_list coverage

 net/Kconfig         |   9 ++
 net/core/Makefile   |   1 +
 net/core/gso_test.c | 274 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 284 insertions(+)
 create mode 100644 net/core/gso_test.c

-- 
2.42.0.609.gbb76f46606-goog



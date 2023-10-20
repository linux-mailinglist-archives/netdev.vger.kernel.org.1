Return-Path: <netdev+bounces-43103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F307D16B8
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 22:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CFB31C20F84
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 20:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722EA225CA;
	Fri, 20 Oct 2023 20:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wjd0b/se"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAB11E530
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 20:00:58 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1830AD63
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 13:00:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7b9e83b70so10163627b3.0
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 13:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697832055; x=1698436855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EeS42Dpx+2cF/oP833+RALsok7vkr5+iNApok/mFGGM=;
        b=wjd0b/se/T4kKpDkXNxF4IvGVKmjVHDJgt8K/DyYXweyS1zU4u2Ml4xHCbTSOGaLk0
         hs5t/ZFz7A9gkyzIk9VTHY2xLfnldh7iTQSaP3gWNlmfc9/16cFDIA4qfpeNdEMfZfxB
         CHicBShTTt33XMlLeCy39jb1h+nlt/UgcjcXCHbOdrCVe71KQlqCmWSFnQIjb1XnjApI
         +OL1hCOnnAON+OQOV8oAFf2mjG8gX0suz5IP344ho1YZwnvQfsLq6l9OfbCJB+KFsgNG
         jYxC+IVdifU5FC+/b28PWy17bxCERAO5701xiCSKCU73UPL2LpL0jw7DSO0fst4+Ywlo
         WdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697832055; x=1698436855;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeS42Dpx+2cF/oP833+RALsok7vkr5+iNApok/mFGGM=;
        b=qskW3sxkXViaF2LgiON/AOBDG1ruwXa6P3MmpE9meN3cwZkX4PcYUDxy3cB6AJT2uz
         inJiIbBRfyriuOuN5ziaJqnRqcVJ/JbFXhNdL65cvgNyLETSzpGlx5rMfutdgN+f6eDI
         A7vW+CLVnDG2n8UyJ2L2ImQLT9WNMoQJ9Q24ls8DhSMvrc0XwS8l7xlFrI2AGAmGdJfj
         Gtx51URGpI/w6HShyjo8H1NW6bmbfzaM7c2fyGlSpQr47cqLdI/60ejGW5D7+CDxV7wC
         bvTQ76jHCd7aWJXoqRF59OiEMWOiyt3i2Tn8aQyw53xs1CRLyOfcNyWId+OSaZCnVigI
         vIlQ==
X-Gm-Message-State: AOJu0Yxm9zHeBTaK9SSKyYuJZBsyzqMgbb8/qawO9Al7hLbLI8iedWMv
	bePijgHhucXWB62um6smzVbkfZw70tUOUw==
X-Google-Smtp-Source: AGHT+IHsHt0uhFYloK7Z+mjyj+xdjtdvN9IAUHDnMjOLbcaWGLhsN7mzOjlDOlC3zOWGnDKCObZ+Ngi0q6gMbQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:2b8d:b0:5a7:d45d:1223 with SMTP
 id en13-20020a05690c2b8d00b005a7d45d1223mr144855ywb.3.1697832055378; Fri, 20
 Oct 2023 13:00:55 -0700 (PDT)
Date: Fri, 20 Oct 2023 20:00:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231020200053.675951-1-edumazet@google.com>
Subject: [PATCH net-next] net_sched: sch_fq: fix off-by-one error in fq_dequeue()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, kernel test robot <oliver.sang@intel.com>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, Dave Taht <dave.taht@gmail.com>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A last minute change went wrong.

We need to look for a packet in all 3 bands, not only two.

Fixes: 29f834aa326e ("net_sched: sch_fq: add 3 bands and WRR scheduling")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202310201422.a22b0999-oliver.sang@in=
tel.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>
Cc: Dave Taht <dave.taht@gmail.com>
Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 net/sched/sch_fq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 8eacdb54e72f4412af1834bfdb2c387d41516349..f6fd0de293e583ad6ba505060ce=
12c74f349a1a2 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -651,7 +651,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 begin:
 	head =3D fq_pband_head_select(pband);
 	if (!head) {
-		while (++retry < FQ_BANDS) {
+		while (++retry <=3D FQ_BANDS) {
 			if (++q->band_nr =3D=3D FQ_BANDS)
 				q->band_nr =3D 0;
 			pband =3D &q->band_flows[q->band_nr];
--=20
2.42.0.655.g421f12c284-goog



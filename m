Return-Path: <netdev+bounces-35913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5717ABB99
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 00:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 9A94F1C208BD
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 22:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329ED47C6B;
	Fri, 22 Sep 2023 22:04:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71264736C
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 22:03:59 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD7883
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 15:03:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d852a6749baso3961909276.0
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 15:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695420238; x=1696025038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lihguCqmQrO7MN4k6u+r2CqnjSzZDlVBm/BVuMAF3N4=;
        b=gMxCWz1e215LisOjxx0Gj/2YNaqzrIuSwmcVxvJgsQJaahnAtFb1P4C/Zd8fwM5qZ6
         qQHzqLR7izVPSDIizEUHWuUai5GdR+vFeNCEf9BybV57plGFdapTIEGojS4DhGzKPVQI
         do5qBWeTV/7KMVNl1cRfVkr03aNkhie0hy9j4flJi8OGxX6+FdRN9TcRY7D+pdcIEdpL
         kMdjE1/8f/uakIsL9dFrPeXihF2uAUiX4NfUPY0UcjbX6oV7v68XpEvuuOR62cR2o+a1
         wY+v7uTSkRp5oko8vMp+OQ+xxaLnXwlLhsDW713DHBn68fr7Oh22ow8ALUpLgYe/Jp2d
         BK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695420238; x=1696025038;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lihguCqmQrO7MN4k6u+r2CqnjSzZDlVBm/BVuMAF3N4=;
        b=Vdaw8WOQ4+2nDYJEltUcMUF0xV6BGPHS2FcqZy3vNJ8Uw4InF6bKxz9nrfOm8B/iaR
         kJyBUd/DZfVb2O8k5AcCBrX64WWziLjVdWWfFiPlqJJ/iBzIwrnsVz3yUaM1ugwEKoxH
         kY+Ea1l9JGWZfA3+5Ou95Z5ZKMPRtQLxZv1m4h/ZwLwievyhdK12Sxq/Fjiop1v9gyAg
         3RyXd+9F06KrSoBVrkSKZgZU6NpGYcGnn09gp8Uu2uB37hUPEZ9DvgceraTOAvtgXpRI
         2p3S13aj7EgMF9dusFsi28X0n5ZpkqDl4SeFP9ebBeTWI1RVNoU13MZTlq5vmNI64gJW
         ml6Q==
X-Gm-Message-State: AOJu0Yx8ErrFFtI3WUv7rws16sPmg+Zj/MaEPZR2zZoTYTLiakTDDsVp
	sqb9lrdfTrgLtoBa53KddFjWZqxvH2u1Dg==
X-Google-Smtp-Source: AGHT+IEcXopLcguuy0CWevBKFqxjQiBiH/wIteA3v+sfn/Jl4jUt6zznqFHfzDfgSUFeL0M+LZFaqNIf4v+gvg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1105:b0:d81:6637:b5b2 with SMTP
 id o5-20020a056902110500b00d816637b5b2mr7883ybu.0.1695420238020; Fri, 22 Sep
 2023 15:03:58 -0700 (PDT)
Date: Fri, 22 Sep 2023 22:03:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922220356.3739090-1-edumazet@google.com>
Subject: [PATCH net-next 0/4] tcp_metrics: four fixes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Looking at an inconclusive syzbot report, I was surprised
to see that tcp_metrics cache on my host was full of
useless entries, even though I have
/proc/sys/net/ipv4/tcp_no_metrics_save set to 1.

While looking more closely I found a total of four issues.

Eric Dumazet (4):
  tcp_metrics: add missing barriers on delete
  tcp_metrics: properly set tp->snd_ssthresh in tcp_init_metrics()
  tcp_metrics: do not create an entry from tcp_init_metrics()
  tcp_metrics: optimize tcp_metrics_flush_all()

 net/ipv4/tcp_metrics.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

-- 
2.42.0.515.g380fc7ccd1-goog



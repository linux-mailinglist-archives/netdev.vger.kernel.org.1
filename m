Return-Path: <netdev+bounces-28733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 857277806D9
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 10:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8052822B4
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 08:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB310168BC;
	Fri, 18 Aug 2023 08:06:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE8E171A6
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 08:06:23 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5C43A84
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 01:06:22 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-26b56cc7896so422312a91.3
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 01:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692345981; x=1692950781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EpYu+QRC0PRdVcX3+lY5g41/w9vpXEe80YIzSj+EURc=;
        b=r5jA7VItfXaJ7hO1vKMHI60ByzZ3HcUsIAMx+4exgW93ZQsz0V3nCy1GkmsD7yS/Sn
         L2Z32I3iGMzPxZfWnCVWWGtTfyUm4SIhh9XLShnzX59nWdU60sZJEB6zLjw7zBzwdzZo
         O7g56HL8SDA3Lx/7iSF4BsriuPea8zfbWyO+W1kCMOcikVvn1emKfKxZ3UGc6rqdI1vF
         ldLSaXwRL3GRtmKdDz/4CUM9ediz/3n8jSFSMjv5YPhv9D1Kq8fdtpVhF0oHNaxMQJCm
         /xutJsk91ZUnucsUp/+jH2aPSb1EgXvPE5EgLeB2noBOmBy4BaZksslXJlyWwHvp3nTG
         j5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692345981; x=1692950781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EpYu+QRC0PRdVcX3+lY5g41/w9vpXEe80YIzSj+EURc=;
        b=aRHs0x2bsqz1jWdSYWc4wPaaN1GWiP4F7VH+ZIFuRPhH+ArlWGYKBATp5dutcuhAFk
         mtw5c3OMu3KVkhHOZyTlX+6yfjZHZ/naWtsdm5Tgjvdwh1k8iMBCPzZPteTpZKeeVw/i
         SNrUSMa2yWkwo4QPQ/mYl5oj3zaBew2b3GHnwYdZzL9+RHSXWbjWpfVfkAmNp8Z4aOdG
         ArrXodBoziMAw8xKexS04191IeQ9vYXwerDOoWIUuxGI4IQg5y88KNRp3aByL/Zzv6Ry
         /Yq2BZspfxr8bZz4VYH18Qry+cgGw5jGAXqqici5rlJd9B7vYu322ii2Cvkl3Md/oF93
         dqTg==
X-Gm-Message-State: AOJu0YwPB9nJeL7sTBaH8rtqYY9osnRPmQIz8T1s8tnIWQYWmOKwTome
	89tg6Ab83NuRctlPTbyK2xX3JknqTOckx0zE
X-Google-Smtp-Source: AGHT+IG+TapoUMy4cuT88lsvMfcVIps7T+A4UnvrmVGLxCpEGAkOt7d8p7klNUmqt5+ocE/lqMPdhw==
X-Received: by 2002:a17:90a:6806:b0:26b:202f:ff6b with SMTP id p6-20020a17090a680600b0026b202fff6bmr1751720pjj.13.1692345981093;
        Fri, 18 Aug 2023 01:06:21 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 2-20020a17090a194200b00265a7145fe5sm2948547pjh.41.2023.08.18.01.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 01:06:19 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Michael Jeanson <mjeanson@efficios.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next] selftests: vrf_route_leaking: remove ipv6_ping_frag from default testing
Date: Fri, 18 Aug 2023 16:06:13 +0800
Message-Id: <20230818080613.1969817-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
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

As the initial commit 1a01727676a8 ("selftests: Add VRF route leaking
tests") said, the IPv6 MTU test fails as source address selection
picking ::1. Every time we run the selftest this one report failed.
There seems not much meaning  to keep reporting a failure for 3 years
that no one plan to fix/update. Let't just skip this one first. We can
add it back when the issue fixed.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/vrf_route_leaking.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/vrf_route_leaking.sh b/tools/testing/selftests/net/vrf_route_leaking.sh
index 23cf924754a5..dedc52562b4f 100755
--- a/tools/testing/selftests/net/vrf_route_leaking.sh
+++ b/tools/testing/selftests/net/vrf_route_leaking.sh
@@ -565,7 +565,7 @@ EOF
 command -v ping6 > /dev/null 2>&1 && ping6=$(command -v ping6) || ping6=$(command -v ping)
 
 TESTS_IPV4="ipv4_ping_ttl ipv4_traceroute ipv4_ping_frag ipv4_ping_ttl_asym ipv4_traceroute_asym"
-TESTS_IPV6="ipv6_ping_ttl ipv6_traceroute ipv6_ping_frag ipv6_ping_ttl_asym ipv6_traceroute_asym"
+TESTS_IPV6="ipv6_ping_ttl ipv6_traceroute ipv6_ping_ttl_asym ipv6_traceroute_asym"
 
 ret=0
 nsuccess=0
-- 
2.38.1



Return-Path: <netdev+bounces-224014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A48B7EAAB
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679641BC4F13
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 12:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8490336C068;
	Wed, 17 Sep 2025 12:52:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D21432BBE6
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113540; cv=none; b=UFY7lyeLIJJqxCo/MF+CaL+D9KtwF3zEqPU+5OdJJPNtMEHt6HYdwDav6/NkCYtIsPRToBTkieHWavBer3IzIsiMGqnNd3kuM8Vzc8Y2DACVV9FJHqgNzhdYXDr2KlPKPuG7WvryRUatJOlLq5oUSzwYptVwoE1uSFuxS0tMKwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113540; c=relaxed/simple;
	bh=g8Rymja0V72nq6OnDIyWQadzgQlOQaCKBNDvE6hktyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mbGC23VP3Nnc+J/aXecbUuMlvuY2UmMBBCnMYLVrqO/nJh2FUf3daXJpZ80lnCMPQPeOUYNVi+tbqdyEmZ4JW/pJy2ood0wcb2+KIneweCQRTf2JiEEjCGQ3OYjDaMQTQlGoATZSgBcWLtXvtcG3vsVq6/BGLDUjaLuvM1icOI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so12818434a12.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 05:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758113536; x=1758718336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hnf8G2/o1fozlbYtBL0vduYZr+SYz2Fp67m1oGmqTd0=;
        b=gsSfC2eCkqhE0zSKQ9dc8C17S5s0u046GKtyPoaeqSmTWRLTLxP/bsW9hEPtlbRYjB
         Af3c1LQ8zaHLyo5H/DkqA/Inp8crQiPRwqwBWRGrh7tMNAGjqa9dLxrRUQDXpFRP6vDM
         Bx+NoQsXr42HTc+IQIHmT/+osvFwxRQD/cASDezy4hRRkM77z3kCqM4PFa4rFPh3iDY9
         8wWVkFFZLp9qwrNdoCp3kGdBFlWTKCuHhq25bv0R1LnyMybKpUIOEvRaur5svoZDPlH1
         iV2vnz1IL/kCvQf9wUbBSXz7qPEvsYV7S6LkOtaQQaFDy18eqL+7j5j9QOFV+4Ac4oJH
         dLsw==
X-Forwarded-Encrypted: i=1; AJvYcCW5E4m1cil97JdQel71mlqvbkbxgUgMSX5pj7TLeKgcFSP/f/3J15FhzLcVqJhIjcqj1+RBmQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6g0LOyKGIvHzQE54vD4ewyRSR7rWgj3iEMkU+Wbi1iAcoWuBj
	VeDn60GA9t3NAElT9yIPae/CA85Rn7L9Ixlo8IwkdosNWXYyU1BEZpSL
X-Gm-Gg: ASbGncuAI5Mv0/acUznk2mmuLrm7UwJVYckfu3Vjp01AiwlvU1uz3RAvsde+HJZ9EUg
	rd6UIdYoLJ652sTcISD4GA4U5fF389+9V9CCjfQQ8DvOuQbTDL1tVIzhibY7dtPvL6Kk0I3uxXE
	3jucffU5u8aXSZwuSYxePozTlnqcVrsXS34dFdjVFf7Z0UcLaF42OWCUigUr+AWklHRwbh2S3rp
	U4PPZ7V89Ttb18u/0kkiAPfvwSHE1VVYOuz27rSEh+9h4OIomriEGqqYkzncGwn+O8q9jVf+t6g
	dFuephGcqpmjWPohnKdIM/P6Xxr3fLGPvpVY5njiRa0ZLjKV7iO9XNwMlEm9pLQkv3rwuA/l0qE
	nHLdPN/qtLxJT
X-Google-Smtp-Source: AGHT+IHhku+j1T36cuiJ0d0xS73leySID7J8LR0tE9XWMEffbke5MNL3JEXPU6e9cXah2ZqkPOnqwg==
X-Received: by 2002:a05:6402:440b:b0:62f:4040:bf70 with SMTP id 4fb4d7f45d1cf-62f844623abmr2323884a12.24.1758113536187;
        Wed, 17 Sep 2025 05:52:16 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec33ae181sm13708626a12.22.2025.09.17.05.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 05:52:15 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 17 Sep 2025 05:51:43 -0700
Subject: [PATCH net v4 2/4] selftest: netcons: refactor target creation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-netconsole_torture-v4-2-0a5b3b8f81ce@debian.org>
References: <20250917-netconsole_torture-v4-0-0a5b3b8f81ce@debian.org>
In-Reply-To: <20250917-netconsole_torture-v4-0-0a5b3b8f81ce@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, calvin@wbinvd.org, 
 jv@jvosburgh.net, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2478; i=leitao@debian.org;
 h=from:subject:message-id; bh=g8Rymja0V72nq6OnDIyWQadzgQlOQaCKBNDvE6hktyo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoyq77IMhtUQqCc1NMy3UCs+bE/0aGxgsG0YiA8
 DmMgqxfUzOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMqu+wAKCRA1o5Of/Hh3
 bRoYEACuWR2zXSe2VYyFo8PEEJn1uxZuK7cjyF2DM6sRI2XkJ9D2Q3fkIJwoh3eyBqL/1JBFxfB
 dmC0MO3m/91VTRaZlsz/0V4wtxbZa4jIp1H5KqUJzyYJM3i8V6Nfl7P4y2mT0OZl5uljSS4nS4K
 iC1/fK0DFD8CAuCITL/t5CVb1cLNRgCvDtD7r+zqi5KbS8LedlR1a3YfrEWc+xFXPmsWs07H+6p
 kf7/Du8ZyUNSxdJVmi6jCEpFBFi+8fEwQZZvgaDjuinbCgyFcpVpWvgxkWZ9a0yTgvd/PzINR31
 T6U8Ohqb3iAr6kMNg3DhY21ilX4kr9DP0e5H4n18Swg4zHNEz546ZG0U8Aecv5vnjrs6PzFcwNg
 0TfRSuPok/492DnJlhjR9O8NO8k5RQEion/wMJLkB33bY4Ea86TNfEGRqlld7K4LS1RKlt2E61v
 yDLP3iKGake9vzG9FDVUR3MzW+MiWlv6UmqJ5ysUv9bV0tGqTnDsusSVRn+7mJltwDjuI6ApIzu
 ZLGAgtEI1rCmxVpABdLerok/V7c/7Gy2y9pryuhG3Vwtf9PxtieNB7Kb0DZRfaKNcLmuk55enF4
 S9PDa0/5Rg8HXEXMUigcm/HrJOPPoQvMMDYOUoEhxpYeeIGSGKQ/RNMmikDPVLnCl1z204whjuV
 K/ONcQy8cr40z+g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Extract the netconsole target creation from create_dynamic_target(), by
moving it from create_dynamic_target() into a new helper function. This
enables other tests to use the creation of netconsole targets with
arbitrary parameters and no sleep.

The new helper will be utilized by forthcoming torture-type selftests
that require dynamic target management.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 30 ++++++++++++++--------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 8e1085e896472..9b5ef8074440c 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -113,31 +113,39 @@ function set_network() {
 	configure_ip
 }
 
-function create_dynamic_target() {
-	local FORMAT=${1:-"extended"}
+function _create_dynamic_target() {
+	local FORMAT="${1:?FORMAT parameter required}"
+	local NCPATH="${2:?NCPATH parameter required}"
 
 	DSTMAC=$(ip netns exec "${NAMESPACE}" \
 		 ip link show "${DSTIF}" | awk '/ether/ {print $2}')
 
 	# Create a dynamic target
-	mkdir "${NETCONS_PATH}"
+	mkdir "${NCPATH}"
 
-	echo "${DSTIP}" > "${NETCONS_PATH}"/remote_ip
-	echo "${SRCIP}" > "${NETCONS_PATH}"/local_ip
-	echo "${DSTMAC}" > "${NETCONS_PATH}"/remote_mac
-	echo "${SRCIF}" > "${NETCONS_PATH}"/dev_name
+	echo "${DSTIP}" > "${NCPATH}"/remote_ip
+	echo "${SRCIP}" > "${NCPATH}"/local_ip
+	echo "${DSTMAC}" > "${NCPATH}"/remote_mac
+	echo "${SRCIF}" > "${NCPATH}"/dev_name
 
 	if [ "${FORMAT}" == "basic" ]
 	then
 		# Basic target does not support release
-		echo 0 > "${NETCONS_PATH}"/release
-		echo 0 > "${NETCONS_PATH}"/extended
+		echo 0 > "${NCPATH}"/release
+		echo 0 > "${NCPATH}"/extended
 	elif [ "${FORMAT}" == "extended" ]
 	then
-		echo 1 > "${NETCONS_PATH}"/extended
+		echo 1 > "${NCPATH}"/extended
 	fi
 
-	echo 1 > "${NETCONS_PATH}"/enabled
+	echo 1 > "${NCPATH}"/enabled
+
+}
+
+function create_dynamic_target() {
+	local FORMAT=${1:-"extended"}
+	local NCPATH=${2:-"$NETCONS_PATH"}
+	_create_dynamic_target "${FORMAT}" "${NCPATH}"
 
 	# This will make sure that the kernel was able to
 	# load the netconsole driver configuration. The console message

-- 
2.47.3



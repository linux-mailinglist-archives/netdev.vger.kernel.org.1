Return-Path: <netdev+bounces-298778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rjXGC4pZLGoFPwQAu9opvQ
	(envelope-from <netdev+bounces-298778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 21:10:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EA767BEC5
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 21:10:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BL9awbNx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298778-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298778-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24478328C074
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEC1374E66;
	Fri, 12 Jun 2026 19:09:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DE63A7D82
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 19:09:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781291364; cv=none; b=LLOf8e7IbU04JKC6c9LYun2PiqNDTvsjx41K6nulyg4LgLOZ4q31GE5W69q40KctDRyetlQjY2u7RfXQ8Mut6WWcTdvu1/wHO2Kt7MooKKyIUUTHNdU1oACLIjcp6zBUFb7NxzMoicai+MfiqlP2RKL1q1Ds65bWHqbGfWy4kSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781291364; c=relaxed/simple;
	bh=bPlI/2xmJK0Qts5eddw/Vh21IiHuQaslrq963O+3tzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QVILhJ+jGva9G22bSWdMwQfQglDyKO2eO1Lvuwqf+i5niw2e6iUvMVMkXQQ/AEy9kBw7S38iMOYbk51azYDAc4QqazRVKmkJWigJxgPN/ZvRiZcpj0PU+otKlGAh6xiomj0WN4r9gfsex/5xjU9OejC7amtaFsje0bgSNiAXn2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BL9awbNx; arc=none smtp.client-ip=209.85.214.173
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf2e8ccca1so9767605ad.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 12:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781291362; x=1781896162; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XRg96KjMZPBuPn1RKC3qLwa0FZMA6GdGbqmzSwsfaRM=;
        b=BL9awbNxvPfVsNfpQj1luXAl4MFsRWD4d1Lmsue8cB/NHkbz5ybKXADUH3hTU+hFwl
         UxV9IDYhi8T0vQFHz5W0DKsUaaW9rr10E/PCcjm4yiXaAb7bWY3JNtP9jijkkNsZ74Lh
         bfU7euv+Uhr/mT+NNI9R13h85aTTy7DUV1ZBB3HmJkciITv6VZ+Ck9OrL8l1ibGOBn2Y
         imvqTIgxxqTFkY96axUZfo3D8/Z11BQt9DfmsZl72X9qqCuSQ2pfKUy24OnPhT7q/C9b
         UA1JfZA/Is0RZeTW/ektUDIOmww8ISwBwoVohipJFGrwKT73T5eI0oUeYCLck9m8I6Ju
         n0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781291362; x=1781896162;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XRg96KjMZPBuPn1RKC3qLwa0FZMA6GdGbqmzSwsfaRM=;
        b=qS+LKSgReM8BD/WDzV7TotvQJS01bBGb4ALRLpNUhqApgkpDQxHZxb/sp8fsux9MC4
         qGOAAfmpP5Nh/dVzH1APbv9RGzBTrfki+e4hfJBLTReyMaojFzGncgLd0qnrSzQvCxOW
         4lLVulK7s7Z8v3DNYk8Ub9tWJD5RLguKEmxDHGtVQNgyoN6fYTFn3BB0hizE9a0mqARX
         /YgQHjOLrDvAz19rBoxdk2IfmZzwcPcHu0Dx4cfSyaSpnL6thterx03MRCFxWuwB75Wg
         o00pUvyh++6wg7U5/jQKSfRZkE7/3vt8niRqHB9ztDX/jIFH2T6QSErI1EaHLPyISCHb
         Nq2w==
X-Forwarded-Encrypted: i=1; AFNElJ8WNMMTwPlYbjVfm2MIEc0SPYCJvktY7NbUu3khqwSTIH+8+LDo+Kmj7/QZSsrWb5S/XygqLu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyrmBKymeUExGJNFv1p1kpexq0dqNbE2RlvKzM2CainamwdSqF
	Mlyjmi5D6ze1EHm88Go157HZvX38s3CQdLOJqHtkLReSXNyNet1WcPpM
X-Gm-Gg: Acq92OFw/r3QzBdFNEo3lxvUEBzTyxtx0H1T8h4+729mRzSuqGmelEvHIBGDADwKAC5
	ALdsRMnooofNuHDanUFeH2hOjxJa1nsFb21xnLksUmmPQUi2vv8lGfjQ9q8kaJ5Q1ZKWnVJFLKG
	HjAgy4vjsdTqBaeJzBZnG1cSooYUQ/KilqSr/iFL6pIFid/srinhUakIF9+tyI00VyQObgyptbg
	BkcbpsyyzV+NdG+XTKvHQvppx+qZu3yS509HqqZwgz7fE/v+63T/yiTDFpazXg+jKweTAvZAFu/
	9G84wgEEC5yRfhrnubL6zB04y/tUV5hKloRfWbCsQBgHHCPqGUcicmmBEs63CGB9+AwWm2hFwJz
	08CCDpNZilK//AKDYpJfgFqLhufRgkEw8ejB+G34uj1Qk9QBhZIRfru4wkosw3gYWvBsQJwQTCY
	AEDLiUgrbsIFpsFhVTwe4=
X-Received: by 2002:a17:902:ced2:b0:2bd:7684:34b0 with SMTP id d9443c01a7336-2c4105092a4mr52571515ad.15.1781291362268;
        Fri, 12 Jun 2026 12:09:22 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5c::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c433460a60sm34934225ad.76.2026.06.12.12.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 12:09:22 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 12 Jun 2026 12:08:41 -0700
Subject: [PATCH net-next 1/2] selftests/vsock: accept vng 1.33 or >= 1.36
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-vsock-test-update-v1-1-7d7eeed3ac8f@meta.com>
References: <20260612-vsock-test-update-v1-0-7d7eeed3ac8f@meta.com>
In-Reply-To: <20260612-vsock-test-update-v1-0-7d7eeed3ac8f@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298778-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sgarzare@redhat.com,m:shuah@kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bobbyeshleman@meta.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,meta.com:mid,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83EA767BEC5

From: Bobby Eshleman <bobbyeshleman@meta.com>

The current vng version check uses a discrete allowlist of "1.33",
"1.36", and "1.37", which forces a script update on every new release
even though all post-1.36 releases work.

Replace the discrete list with: "1.33", or any version >= 1.36. 1.34
and 1.35 are skipped because they were not tested. Add a version_lt()
helper that compares MAJOR.MINOR numerically, so the check reads as a
straightforward version comparison.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 39 +++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index d97913a6bdc7..ee69ac9dd3dc 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -330,27 +330,34 @@ check_netns() {
 	return 0
 }
 
+# Compare MAJOR.MINOR versions numerically. Returns 0 (true) if $1 < $2.
+version_lt() {
+	local -a a=(${1//./ })
+	local -a b=(${2//./ })
+
+	if [[ "${a[0]}" -lt "${b[0]}" ]]; then
+		return 0
+	elif [[ "${a[0]}" -gt "${b[0]}" ]]; then
+		return 1
+	elif [[ "${a[1]}" -lt "${b[1]}" ]]; then
+		return 0
+	fi
+
+	return 1
+}
+
 check_vng() {
-	local tested_versions
 	local version
-	local ok
 
-	tested_versions=("1.33" "1.36" "1.37")
-	version="$(vng --version)"
+	version="$(vng --version | awk '{print $2}')"
 
-	ok=0
-	for tv in "${tested_versions[@]}"; do
-		if [[ "${version}" == *"${tv}"* ]]; then
-			ok=1
-			break
-		fi
-	done
-
-	if [[ ! "${ok}" -eq 1 ]]; then
-		printf "warning: vng version '%s' has not been tested and may " "${version}" >&2
-		printf "not function properly.\n\tThe following versions have been tested: " >&2
-		echo "${tested_versions[@]}" >&2
+	# Supported: 1.33, or any version >= 1.36. 1.34 and 1.35 are untested.
+	if [[ "${version}" == "1.33" ]] || ! version_lt "${version}" "1.36"; then
+		return
 	fi
+
+	printf "warning: vng version '%s' has not been tested and may " "${version}" >&2
+	printf "not function properly.\n\tSupported: 1.33 or >= 1.36\n" >&2
 }
 
 check_socat() {

-- 
2.53.0-Meta



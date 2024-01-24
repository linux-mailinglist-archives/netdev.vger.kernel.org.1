Return-Path: <netdev+bounces-65652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF5183B42F
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 22:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7521F23FDE
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 21:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3B8135402;
	Wed, 24 Jan 2024 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFShbPuE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EF61353E4
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132494; cv=none; b=AucO85V9cE2MboNUIrWUCLDFsy9JNOzeh7Wl0T4uddqqYAGHOWTjiBds/tareYnaJd86iX3ngpp+rB4+hf0rOOJqV16mLxUt2uFU2fUocDDh6xeWfQ1hJmGazsLU/5aojigI1Xr0rWYd6UcM5gm8v5gdT4o/6xCDPFViib2O6qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132494; c=relaxed/simple;
	bh=+Esq6AUWHOcGoUPb1Baq0b2HH8sfJUH2AjM6ICNdR4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wk4/83RPqY6EcZSeAu2PwvU6rdSFWPPoP/HD46lb80exA16ecq3YFrDCnOhLuMSdQBEm1DL4n4erCISX3aOOxuLM5eg5h3pwDaS425QPhQOS8xQ6H6IVNGnp+VZcTkt2MlHMP2MLtYR2cWkmJZGfnP9EjiM0tH6OnlxUAqOw7xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFShbPuE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D652C433C7;
	Wed, 24 Jan 2024 21:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706132493;
	bh=+Esq6AUWHOcGoUPb1Baq0b2HH8sfJUH2AjM6ICNdR4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PFShbPuEAXnzqAFHImmIN2DEO3hD5o2iuk586DX0JH0fMXD/k0RBVtjEMRJatp2Zv
	 33arzOU7snNBBQlruhKMq1g9u5dVu0+nbzXPffm0842JJm1w6DAU8L/c9q4HWLnfyl
	 fWrq5mJEtPCLn98y9hUyJzmeBqsWM36PnIFpSi2ubEaMzvRv3nnPvmarOOLEuoIjTT
	 otuy67AJI+/ZG984Vlc+YRqrqGF8VfGCWDUzh3zG6rpfEAQsb0VeSOeyBO6tx+LGRn
	 zdILxppw8eXRJUrL5yfkxCpLZx0DlDPjVuiGyOn63C2T1ny7Ijk3r1Z4sayqISDnok
	 LN7qpm2UjDG0g==
From: David Ahern <dsahern@kernel.org>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next 1/3] selftest: Update PATH for nettest in fcnal-test
Date: Wed, 24 Jan 2024 14:41:15 -0700
Message-Id: <20240124214117.24687-2-dsahern@kernel.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240124214117.24687-1-dsahern@kernel.org>
References: <20240124214117.24687-1-dsahern@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow fcnal-test.sh to be run from top level directory in the
kernel repo as well as from tools/testing/selftests/net by
setting the PATH to find the in-tree nettest.

Signed-off-by: David Ahern <dsahern@kernel.org>
---
 tools/testing/selftests/net/fcnal-test.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/selftests/net/fcnal-test.sh
index 0d4f252427e2..3d69fac6bcc0 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -38,6 +38,9 @@
 # server / client nomenclature relative to ns-A
 
 source lib.sh
+
+PATH=$PWD:$PWD/tools/testing/selftests/net:$PATH
+
 VERBOSE=0
 
 NSA_DEV=eth1
-- 
2.39.3 (Apple Git-145)



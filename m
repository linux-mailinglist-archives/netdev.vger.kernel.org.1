Return-Path: <netdev+bounces-182477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F720A88DA6
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11C9174AC4
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CC91F2C3B;
	Mon, 14 Apr 2025 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eL44GCJC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16C91F181F
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665600; cv=none; b=bv1RGGjaWGojkZtExAl21yLcqxKu/K4EL6R2Z9prg7RIiL4obp2pAtNw5BNDHxay1zlrYvo/CB5QWsZlb7QPr20iKzO2IEdO27lml58EARbFhUwpr9smdZejAFBIJdiKkSI65r2cDeSUQtpn/D2JHEz+2WB3j9nRqZSsJJ9gHH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665600; c=relaxed/simple;
	bh=WAI0XRM079hW/aArVcyWZdMKvdyAH6TlcWhdav8Jvdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaJQI3ycOqkXaXUVTGyyVnTkpWXroDIc9YS/Z7yDNTwVVCf70EHOF9xD0Ww29dVt7nCxEC9lAH9jXnEXR2PKqal+vxAsYuz33+YXztpUt37amEWDOYDxNbzdGZyfq5HMfnF8vXRw2n5F8TptK9xCljT2dWgLMivMto7CWUgEJUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eL44GCJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA90C4CEEB;
	Mon, 14 Apr 2025 21:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744665600;
	bh=WAI0XRM079hW/aArVcyWZdMKvdyAH6TlcWhdav8Jvdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eL44GCJCRPg7swJlV7TgugJ48tK6vsAKGAjf3aZlasz10u0VgmvLrEE7SqkixiLbt
	 wzfyiwNJ1dIItVtLx49D4UY1/fVCuAvStK2PCnaIktlL/AWCa8znexWh6oYP+6h1Ik
	 7OBzm8LDEHxn1Uok36QIrYF/rhSJy8tCWgRIyFCeYa49hyOvFI5jtSywswKVQl7aXV
	 5U4JCdAchBL1RlrIADuSgkH3S4mJuFgC6jMojcd1VCiODAm2mKiE7ak0neqyFbzPtu
	 Gez5rDE4jtDxz9miBGO3xSf/4VGOWR5sJiWMSI7YgJoa0/3CCSKIzyMPQNLy9+ZNNU
	 KoSVi6shBtFDg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: donald.hunter@gmail.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	daniel@iogearbox.net,
	sdf@fomichev.me,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 2/8] tools: ynl-gen: move local vars after the opening bracket
Date: Mon, 14 Apr 2025 14:18:45 -0700
Message-ID: <20250414211851.602096-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414211851.602096-1-kuba@kernel.org>
References: <20250414211851.602096-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "function writing helper" tries to put local variables
between prototype and the opening bracket. Clearly wrong,
but up until now nothing actually uses it to write local
vars so it wasn't noticed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 305f5696bc4f..662a925bd9e1 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1399,9 +1399,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
     def write_func(self, qual_ret, name, body, args=None, local_vars=None):
         self.write_func_prot(qual_ret=qual_ret, name=name, args=args)
+        self.block_start()
         self.write_func_lvar(local_vars=local_vars)
 
-        self.block_start()
         for line in body:
             self.p(line)
         self.block_end()
-- 
2.49.0



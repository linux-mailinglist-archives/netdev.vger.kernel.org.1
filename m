Return-Path: <netdev+bounces-221422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34052B507B0
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607481889A49
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B921255F3F;
	Tue,  9 Sep 2025 21:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBGrdNhq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021D02550D0;
	Tue,  9 Sep 2025 21:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452090; cv=none; b=i4jYPaB2s62daQi6m7KDkt1Z7SmgtpWvzGTEJSIZWbbHw3XQwLV3nu6qbFxiRoIQtjBjYMeRzCIEPdFX2nzLmsgWa0Pj2zmQhl55iLuqDOvi627Bx1XtfybtjxdSl2HqOzByEsTgy1915MHIuVNWPvQSeEajRfav3XKDV23qfsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452090; c=relaxed/simple;
	bh=QqTMGVrIbXpL32AsTTbWzre88o17tWgxD0nkKN9e7DM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f3f8FoZ8g9VWDKpf+gwn0vo3OQrgPisV7MxurWHHzHspgkECQGXJQGYLTj+29WsquPzRcGcls9qXpoQYSr8XD9IdvwwZsU0uaKrb/I3g8gjjliOLc5engmgFhKCeqy8LV0IsVadC6oPrnoEfv23HgtkckKx3YFBkSiUtR+MTMBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBGrdNhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCAAC4CEF7;
	Tue,  9 Sep 2025 21:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757452089;
	bh=QqTMGVrIbXpL32AsTTbWzre88o17tWgxD0nkKN9e7DM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uBGrdNhqWDj7eYDl9SuyxZRsDXGNqXfF2WoTo+K+dAyUInyPLPGO5++kk4wvGSH1O
	 QsU+sfThfzU2CBH5++sWXiw00EftdAwXzgMlUycnqza/T7D8tjCLdAkxSE6VF08QUc
	 c2XPw0Qvz07XkCNpygUV4zMkAnjgp3n1kPYRPRAB8DD+ugi4U/4NoV4LFB4Oa+/f8j
	 E25fdYVlnSOAZy20LyZFdP/usODihEixBcM+4CZyFY11ygLwY/0MTqEbauO0FKpSI4
	 duaXxwxItV2W/PfTbH2a9rra8Xrsy1kMeb3m1j1vMPcaAhdwFzURrRg5un97JNjl1w
	 iOOVV1XbyKM2w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 09 Sep 2025 23:07:47 +0200
Subject: [PATCH net-next 1/8] tools: ynl: fix undefined variable name
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-net-next-ynl-ruff-v1-1-238c2bccdd99@kernel.org>
References: <20250909-net-next-ynl-ruff-v1-0-238c2bccdd99@kernel.org>
In-Reply-To: <20250909-net-next-ynl-ruff-v1-0-238c2bccdd99@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1488; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QqTMGVrIbXpL32AsTTbWzre88o17tWgxD0nkKN9e7DM=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGjAly7IggAfKf0faFuaT6tSXzJkg3kl+qjoz9J4fU+6bnjmZ
 4h1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmjAly4ACgkQfCLwwvNHCpfDiwD6Aotr
 c/EFqidOoGQb17En2iBEbRqa+m70/Z/cnYsmt9UA/RScO2MyqaV4UwTscsOtaAOWff9HTEma277
 k9KO9czYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This variable used in the error path was not defined according to Ruff.
msg_format.attr_set is used instead, presumably the one that was
supposed to be used originally.

This is linked to Ruff error F821 [1]:

  An undefined name is likely to raise NameError at runtime.

Fixes: 1769e2be4baa ("tools/net/ynl: Add 'sub-message' attribute decoding to ynl")
Link: https://docs.astral.sh/ruff/rules/undefined-name/ [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes: I don't know if such fix can be queued to 'net'. It is in the
error path, it doesn't seem required to backport it.
---
 tools/net/ynl/pyynl/lib/ynl.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 8244a5f440b2be8f08f8424270a4dbd67a81a80d..15ddb0b1adb63f5853bf58579687d160a9c46860 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -746,7 +746,7 @@ class YnlFamily(SpecFamily):
                 subdict = self._decode(NlAttrs(attr.raw, offset), msg_format.attr_set)
                 decoded.update(subdict)
             else:
-                raise Exception(f"Unknown attribute-set '{attr_space}' when decoding '{attr_spec.name}'")
+                raise Exception(f"Unknown attribute-set '{msg_format.attr_set}' when decoding '{attr_spec.name}'")
         return decoded
 
     def _decode(self, attrs, space, outer_attrs = None):

-- 
2.51.0



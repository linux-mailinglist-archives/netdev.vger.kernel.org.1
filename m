Return-Path: <netdev+bounces-249540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07106D1ABAD
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 18:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D477E306875D
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 17:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586763939C5;
	Tue, 13 Jan 2026 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6fMARB7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3477434D90D;
	Tue, 13 Jan 2026 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768326455; cv=none; b=ZSRKJ+gScGxZQs4X9+/VnRwrBpHD1eT6VsEi3plEi3jjwcM2xUPfEeTKaAGk2Lf6F0BLGo4vtw2vdTd6abbHR/eQjtQUrxNdmNCTopG/MkDFXfDYsWvnhsOkUAwhPmzXys9XlAe7JzLf1eayUkjsH8xHfnh0vtIM7i1ZXVuWWfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768326455; c=relaxed/simple;
	bh=08QBqmZ6vl5jlxbVBid2paYidrcy2skUmee6MBLxCEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=X+JDF4xruI5vRZzw5cmbZt+AZayfj+mlVXvkqJBWyrKbvMsBSTums2xeEP80wNHwovrVqnbiSvFBqxnRgy3DAIOeqCF/dqvOp/TGCHCBuL7IusZF9doAE+0hcoSfj+FOfIJ/jDb3577wBupoPonxBKyASZOBU1ISLBBOuwFElCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6fMARB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782F9C116C6;
	Tue, 13 Jan 2026 17:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768326455;
	bh=08QBqmZ6vl5jlxbVBid2paYidrcy2skUmee6MBLxCEo=;
	h=From:Date:Subject:To:Cc:From;
	b=V6fMARB73crLUQJ3VXRzYWZvy2+J/IlMqbM9xQL8XoBUkWHyFBaPGsTJNDjG+wPF8
	 cOcVEy5aDuQxPOIfqs6S9137QqBP1/txIs1f0d/Gf4XnNQja/5pGMBlKlviT2Xv51H
	 qctFeQdCxemnDgOOyf7l1y623B1k3xaStTe0WgNq/GbHlovvaejezb7YTkAhUG3GNZ
	 idI530vRvAfZhFzDu1i3YVVaVaoAGiH2eIxiBiRKTvvy/IAxb630i8DpFIxiOQQji0
	 rGFbb74hmD/DclXCjeUkQDwDAYKHagUvRbbjWIys2rTQH3PHtV904WZBgh5HigBalu
	 ASmaSy2EYE6mg==
From: Simon Horman <horms@kernel.org>
Date: Tue, 13 Jan 2026 17:47:15 +0000
Subject: [PATCH] docs: netdev: refine 15-patch limit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-15-minutes-of-fame-v1-1-0806b418c6fd@kernel.org>
X-B4-Tracking: v=1; b=H4sIACKFZmkC/x3MQQqAIBBA0avErBtwNCO6SrSIHGsWWmhFEN09a
 fkW/z+QOQln6KsHEl+SZYsFVFcwr1NcGMUVg1a6VUQGyWKQeB6ccfPop8DodWNU56xVTFDCPbG
 X+58O4/t+HT3EdmQAAAA=
X-Change-ID: 20260113-15-minutes-of-fame-f24308d550e1
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, workflows@vger.kernel.org, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.14.2

The 15 patch limit is intended by the maintainers to cover
all outstanding patches on the mailing list, not just those
in a single patchset. Document this practice accordingly.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 Documentation/process/maintainer-netdev.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index 989192421cc9db6c93c816f2dfb7afbe48dd25fc..d98d2f46129eb0eaf55e5106d50b214ddc7bfb67 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -363,6 +363,14 @@ just do it. As a result, a sequence of smaller series gets merged quicker and
 with better review coverage. Re-posting large series also increases the mailing
 list traffic.
 
+Limit patches outstanding on mailing list
+-----------------------------------------
+
+Avoid having more than 15 patches, across all series, outstanding for
+review on the mailing list. This limit is intended to focus developer
+effort on testing patches before upstream review. Aiding the quality of
+upstream submissions, and easing the load on reviewers.
+
 .. _rcs:
 
 Local variable ordering ("reverse xmas tree", "RCS")





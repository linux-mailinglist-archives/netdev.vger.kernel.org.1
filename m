Return-Path: <netdev+bounces-133567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 499BB996492
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 11:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B29E1C24F09
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 09:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E39018A6BC;
	Wed,  9 Oct 2024 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxzonjCg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62753189F55;
	Wed,  9 Oct 2024 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465151; cv=none; b=CyoFNYfIu+wuy2vW10K5dUdUQ+n1V3vXJ6GTXzqK0Ui4gl4Xpl0h+XNSsxAEX3qK172COBVsm8Oo4jFxadDCedPrPWzPTfBoIsNsRSX/cWD4Sw5AxsyXvD4XOwFnJOm3LKlj2vezTgWOIsmAkWuxr5+7tK/BG2mv72J7/jRVlqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465151; c=relaxed/simple;
	bh=FEBmVHNV/Na9j044i78gzDI5htibytqSBw9g3ISvbHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BVBuaI7ear3VLje37Nk+3HMy75oSyk47ZpPeHsJQQJFn1oafS33Uw2S/ojvCrHO3cNI7SxPn90Wpl60+IZePVFXOpPkt1yoR92a+6GdpAb/XTSGnvw8XiU9RTsR+yty2K0U5TASC+mmf9xphZqBaCVc1QYgADRv6SzzQ0tXoBe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxzonjCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A4FC4CEC5;
	Wed,  9 Oct 2024 09:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728465151;
	bh=FEBmVHNV/Na9j044i78gzDI5htibytqSBw9g3ISvbHA=;
	h=From:Date:Subject:To:Cc:From;
	b=lxzonjCggDN4pwWrNz4kZfdJKYesiWdTg5bHSBhj0dRjbBE3HcH47NvYgQ1L6fIu3
	 Rd0dWueSiLzAHzlDzQ6TVwkcxHZgm1+0CyEmDiOhdtRuCp29iJPP++c8VQlnVDLW4p
	 VPBkei7a0SDe4Mw5QrKd0+ql+SJJ84V4bi4NZXFmcud8ChsrIpPEJj0hu2EpX1LtRu
	 HsFRItPCCbd+Aw73JiYeYYQF7a4BGY4ldO2UvIn4t8lZ5qi5LD6FZXnYj9T4nNWz8N
	 CT4XewvSJm3U6KA11q7ssQ59qyIYwcZOC1Q7LVWsqw2KjqMgx4fGPKqDdPr3+PeQBM
	 LYBlg3dJRLHwg==
From: Simon Horman <horms@kernel.org>
Date: Wed, 09 Oct 2024 10:12:19 +0100
Subject: [PATCH net v2] docs: netdev: document guidance on cleanup patches
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-doc-mc-clean-v2-1-e637b665fa81@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPJIBmcC/22NwQ7CIBBEf6XZs2tgBWM8+R+mB4S1JVZooCGah
 n+XcPb4ZjJvdsicPGe4DjskLj77GBrQYQA7mzAxetcYSJCSQih00eLbol3YBGRt1Enos2NiaJM
 18dN/uu4OgTcYWzj7vMX07RdF9uq/rUiUSMLSxdmHcJpuL06Bl2NME4y11h9vmyBcrgAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, workflows@vger.kernel.org, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.14.0

The purpose of this section is to document what is the current practice
regarding clean-up patches which address checkpatch warnings and similar
problems. I feel there is a value in having this documented so others
can easily refer to it.

Clearly this topic is subjective. And to some extent the current
practice discourages a wider range of patches than is described here.
But I feel it is best to start somewhere, with the most well established
part of the current practice.

--
I did think this was already documented. And perhaps it is.
But I was unable to find it after a quick search.

Signed-off-by: Simon Horman <horms@kernel.org>
---
Changes in v2:
- Drop RFC designation
- Correct capitalisation of heading
- Add that:
  + devm_ conversions are also discouraged, outside the context of other work
  + Spelling and grammar fixes are not discouraged
- Reformat text accordingly
- Link to v1: https://lore.kernel.org/r/20241004-doc-mc-clean-v1-1-20c28dcb0d52@kernel.org
---
 Documentation/process/maintainer-netdev.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index c9edf9e7362d..1ae71e31591c 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -355,6 +355,8 @@ just do it. As a result, a sequence of smaller series gets merged quicker and
 with better review coverage. Re-posting large series also increases the mailing
 list traffic.
 
+.. _rcs:
+
 Local variable ordering ("reverse xmas tree", "RCS")
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -391,6 +393,21 @@ APIs and helpers, especially scoped iterators. However, direct use of
 ``__free()`` within networking core and drivers is discouraged.
 Similar guidance applies to declaring variables mid-function.
 
+Clean-up patches
+~~~~~~~~~~~~~~~~
+
+Netdev discourages patches which perform simple clean-ups, which are not in
+the context of other work. For example:
+
+* Addressing ``checkpatch.pl`` warnings
+* Addressing :ref:`Local variable ordering<rcs>` issues
+* Conversions to device-managed APIs (``devm_`` helpers)
+
+This is because it is felt that the churn that such changes produce comes
+at a greater cost than the value of such clean-ups.
+
+Conversely, spelling and grammar fixes are not discouraged.
+
 Resending after review
 ~~~~~~~~~~~~~~~~~~~~~~
 



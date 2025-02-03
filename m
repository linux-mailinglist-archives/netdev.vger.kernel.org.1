Return-Path: <netdev+bounces-162077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A041A25BAC
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A670518859DF
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D4B209F41;
	Mon,  3 Feb 2025 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMnzHkrh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DD6209F31;
	Mon,  3 Feb 2025 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738591197; cv=none; b=MOAGWl2DRiCOa5wJRVMkDp07xpPVLeD68Y8Am9wqowbF4yVCCBqNMZ910CfNcdvI5ZWKalsNMrlPZCTQv0z5N+nLutlLkgGznQz+AH7ORTamxA5fa0DI9rqqNIQkBup9rLMf20A5RyzTYqVlw4XrRGVyCo5fK+7ghlU1qR98zOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738591197; c=relaxed/simple;
	bh=tvkgelAAxWvmQzOprQnll047tkLofY4I+YNTT4L1bb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rtYAHU/maSU42vBFwxmOsyHa+W3CEdH1Mc9hcJJNyWq6H1K+MXPeBupoU75SYUZCIqc+dhTQk2U7WMKo1f0lFkkxg6y23/92t1DGNRy99MwI3VCz5eD9TrnUrYfHWMn5muyUpVmOMu1ij1PYbgGeQ9syKb9cQsgg1gehDC4WcVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMnzHkrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCECC4CED2;
	Mon,  3 Feb 2025 13:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738591196;
	bh=tvkgelAAxWvmQzOprQnll047tkLofY4I+YNTT4L1bb4=;
	h=From:Date:Subject:To:Cc:From;
	b=XMnzHkrhiMunlaj6upYxhGifZZJ/s/eN1zC8yJBmZG7ndyIgv7sD4PCNfYgVoqxy6
	 0FGyqtK3rGLK6tfbHqluDM06cmJj4LyXULLS5oioHz1CzbezzwChflvswaUHf4VtkD
	 CW9GQo0IqbhOqMMg4l/uzLW0PeQP6EbtFks3BMG0njUddDF0dc27cyQX+dCDPAPpCK
	 VzBhP9pwS0tiITZUcOy2hgQC1kOwLGgdeXH6h6CV5lSCTpBGI7xaM63s5Fo/305+3V
	 C/5Jk+yAMnEvXU5SpJL6zTirLnEy/4T+p+b378R7lKLYj02s/UFV+fOIyaLD81mKl4
	 RjnUbnFmBJGpA==
From: Simon Horman <horms@kernel.org>
Date: Mon, 03 Feb 2025 13:59:44 +0000
Subject: [PATCH net] docs: netdev: Document guidance on inline functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-inline-funk-v1-1-2f48418e5874@kernel.org>
X-B4-Tracking: v=1; b=H4sIAM/LoGcC/x3MQQqAIBBA0avErBPUjKCrRIvSsYZiCq0IxLsnL
 d/i/wQRA2GEvkoQ8KFIBxeougK7TrygIFcMWupWatkI4p0Yhb95E6ZzkzVOKzlbKMUZ0NP73wZ
 gvGDM+QOvY+txYgAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>, 
 netdev@vger.kernel.org, workflows@vger.kernel.org, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.14.0

Document preference for non inline functions in .c files.
This has been the preference for as long as I can recall
and I was recently surprised to discover that it is undocumented.

Reported-by: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Closes: https://lore.kernel.org/all/9662e6fe-cc91-4258-aba1-ab5b016a041a@orange.com/
Signed-off-by: Simon Horman <horms@kernel.org>
---
 Documentation/process/maintainer-netdev.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index e497729525d5..1fbb8178b8cd 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -408,6 +408,17 @@ at a greater cost than the value of such clean-ups.
 
 Conversely, spelling and grammar fixes are not discouraged.
 
+Inline functions
+----------------
+
+The use of static inline functions in .c file is strongly discouraged
+unless there is a demonstrable reason for them, usually performance
+related. Rather, it is preferred to omit the inline keyword and allow the
+compiler to inline them as it sees fit.
+
+This is a stricter requirement than that of the general Linux Kernel
+:ref:`Coding Style<codingstyle>`
+
 Resending after review
 ~~~~~~~~~~~~~~~~~~~~~~
 



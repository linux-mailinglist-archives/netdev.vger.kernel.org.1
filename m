Return-Path: <netdev+bounces-98418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F7A8D15E0
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B981F214E5
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 08:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A7813AA32;
	Tue, 28 May 2024 08:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVAgzJ9l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0A750297;
	Tue, 28 May 2024 08:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883789; cv=none; b=ROJumOfvMG0dv3qBf4XgMPSXA3EzsPVq0z7BG3MMe7RXAZbB/9qex1TGP8Kw5WAaKrtMJeHAbhrDdokKPDZC/d9zfMumoFE7xfolbiY8qWiQbIZaFBPwm19K2hSFcWlAwRZhCP4wpXNxXF8YTigngFFG5Q6Gw9xQjD+15HQnmWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883789; c=relaxed/simple;
	bh=mfCXTipakAtKBu2HlqtTfmD9G3DkotUs8mWBAKIrBfo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TvYv4JHX65YAiDq63UmdssJ8zkOmEi8FrjVYDK96nQ0o9icgbSY4BxSjhrTk5j+35h6nHNvqCQqhl0c8UW0mtLRUBblGfhBSeU1ljdAUriDctbUFDiPptPQ9RNgxlkL1/H+Rhy6UX62aRuDVhv9+1eMc6PM0VuXIPo2N5jVIAo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVAgzJ9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA96C3277B;
	Tue, 28 May 2024 08:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716883788;
	bh=mfCXTipakAtKBu2HlqtTfmD9G3DkotUs8mWBAKIrBfo=;
	h=From:Subject:Date:To:Cc:From;
	b=WVAgzJ9l/5CET0C7yY6cYwVgvAU7f0NwkqnupqGJZsz+PepD7VrX4kiU20Un9EQff
	 yn/DhCOcQatFN5FaDCauX5WxkbC/6GjHKw0ZdLnxYqxVtPmxHIFuYArzsHCZewcPNP
	 ZR4hy60p9kZwWz4hD5Cy61hz7RtQ5+0RqgYcsW5T/B/8t9e7Zo+Py6Gm2DwdvCEB64
	 5ZgX0fDgBmNwwvqFrUbqijP/fniVin1sRLui0TZQZ0oLJjZlJcT2TFxSaubIWMcElX
	 N47g4dnjzufvLTYiu7pI960BYZfQ1nbyd73LTOk3X5aEI0TgoBgq38r88biOJXS0YG
	 w0mpqom4L+i7g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next v2 0/3] doc: mptcp: new general doc and fixes
Date: Tue, 28 May 2024 10:09:15 +0200
Message-Id: <20240528-upstream-net-20240520-mptcp-doc-v2-0-47f2d5bc2ef3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACuRVWYC/42NzQ6CMBCEX4Xs2TVlgfhz8j0Mh1pWaJS22VaCI
 by7lYNnj99MZr4FIovlCOdiAeHJRutdBtoVYAbtekbbZQZSVKuGFL5CTMJ6RMcJf+kYkgnYeYP
 cHLSpiLjWBvJLEL7beTNc4btxPCdoczPYmLy8N/VUbv3flqlEhVzpjk51dSRzuzxYHD/3Xnpo1
 3X9ABbBtQvZAAAA
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Gregory Detal <gregory.detal@gmail.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mfCXTipakAtKBu2HlqtTfmD9G3DkotUs8mWBAKIrBfo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmVZFJ1irTJZ1WHShreyDzueOQqLttvCuXjxnOh
 HJqQ9VyOLCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlWRSQAKCRD2t4JPQmmg
 cxZhD/0XTr+lhW/wk+9hBFu11PVQFvcXxsM7LEdWqMKGIzP/dErTC6zFtrczKM/JZ5w3Zz3oSMS
 Qjz8B+nqC0WdiZCuY0/HniMKhQPX/8uGyUoZJideLydTi8L2T+jbHG450cINAUO1bQjt0+27F+E
 wkSEGEvWtOlZpeKtdDiq+uy/W8Dih/CFSFuB/tepAJxc4Qj4r01dIl4d6ggGY/Cz2QxnGysLS1L
 OHGzI+tw+2WYAClPXO/76u2G/mcR9t0IVXJWwMAEULF2VGEJuwQWI5Mjxq5eLruCiYrSZbLztSG
 ugpwxSG/F+yLQG3o8tu4/ksSRiEkjZjser2/h/8nRBbTNnJRwbeFWCQvPiJgfKfeZ5F4qibTpep
 UvltrmrBaGzI/7RIPn9lgd5iQ+Ne0PH2VrPae/R5BOPn+oXzw5qpoUJQssZVdOR8o1hTfWdjswD
 rOSK89UZXZ0H2zVU8hxQe5bKGpk4I0V5VRHDABrqtXNkiKGV2oCERt4YyEHdO9U5JzLDE+c3CNq
 h8647pmycUGSNNpgrf3LNZw760rHKXz4Lv4jMJl3/YV7bLs3omJAZiY8r/5o0XgnirJZy243aoF
 +c/VWIYWDe1xfmgg+sHViYqpa36dgCHC9yRyI6LePOe8IZtnh6vQ0RDoISduU6iczoe0/6+L8bq
 p+U6QcbnrZMPNQw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A general documentation about MPTCP was missing since its introduction
in v5.6. The last patch adds a new 'mptcp' page in the 'networking'
documentation.

The first patch is a fix for a missing sysctl entry introduced in v6.10
rc0, and the second one reorder the sysctl entries.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Patch 3/3: fixed mptcp.dev link syntax.
- Rebased on top of net-next (Paolo).
- Link to v1: https://lore.kernel.org/r/20240520-upstream-net-20240520-mptcp-doc-v1-0-e3ad294382cb@kernel.org

---
Matthieu Baerts (NGI0) (3):
      doc: mptcp: add missing 'available_schedulers' entry
      doc: mptcp: alphabetical order
      doc: new 'mptcp' page in 'networking'

 Documentation/networking/index.rst        |   1 +
 Documentation/networking/mptcp-sysctl.rst |  74 +++++++-------
 Documentation/networking/mptcp.rst        | 156 ++++++++++++++++++++++++++++++
 MAINTAINERS                               |   2 +-
 4 files changed, 197 insertions(+), 36 deletions(-)
---
base-commit: 5233a55a5254ea38dcdd8d836a0f9ee886c3df51
change-id: 20240520-upstream-net-20240520-mptcp-doc-e57ac322e4ac

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>



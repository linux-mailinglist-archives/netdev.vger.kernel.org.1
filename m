Return-Path: <netdev+bounces-76761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE2786ED13
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 00:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19DD51F2398F
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 23:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5194059149;
	Fri,  1 Mar 2024 23:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3ejiH/M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8FB5F473
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 23:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709337373; cv=none; b=QGYhksw87r6/2kGsYCJLQZXx+rT+bxPQI2QEHF0sQnCmaQ/binEm9Su/fXEL26QXysPQLzM8lEyfwnWDSJT2ao6JCyiE++krL4zfAi2r+kNjJjru/8dIlgvHeKMNafP9GZgXFKiq4n+CLmigg8Spg3wamsrf+osznqfzgfhdvpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709337373; c=relaxed/simple;
	bh=Ae4ovdsTmB0HMW6ifPDwpHnY5f5rPhE20XrF1PCPydM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oPrObdiN/qisXfLBbPoIe2bCvhK7Rg9Cf2t9+TcsqNnWQx+JltnzEZTE7QFbXGloVZbu4oU7v+AXcK+J0QFa7YnMfShR5Un0OIO7aqsQQeAOl2OWCBqUIyS1Zl0EhAVGfJ9F6asP23pECjNP3bFd3fdkraj0pCH85j21gSaqc10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3ejiH/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87302C43399;
	Fri,  1 Mar 2024 23:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709337372;
	bh=Ae4ovdsTmB0HMW6ifPDwpHnY5f5rPhE20XrF1PCPydM=;
	h=From:To:Cc:Subject:Date:From;
	b=i3ejiH/M9+I0WiWx20B8WZ7n3a7fk2shK2+TZLIq3DKjH4XDLjZh48uYd4S3IybUm
	 JRcb8jqEdEereH5JUSTZmJJpC6y6dQfaO7Y3sYKfSvnF88j7mSwCV7FIFv9ZjYsuXR
	 /CF0b3lvJSsiQWQCZDDNtvAsQWe+ccaQTOC5RHV2EWTmXbM8kYKATjJWM0A7GWKoZp
	 QcXab1n7K3DC4kEICSa9evjVykiBkQgAmyZ8tCK4r1q3TnabQuRNIxg5am7kt41hWL
	 OP+uyYQ2t7ameW3ckWkB7pl/5Na0RgNTri0EXmf13MnnSynm5kvGA0hIeH4ybKz96g
	 jzTgAhEj+BzVw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/2] tools: ynl: clean up make clean
Date: Fri,  1 Mar 2024 15:56:07 -0800
Message-ID: <20240301235609.147572-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First change renames the clean target which removes build results,
to a more common name. Second one ensures that clean deletes __pycache__. 

Jakub Kicinski (2):
  tools: ynl: rename make hardclean -> distclean
  tools: ynl: remove __pycache__ during clean

 tools/net/ynl/Makefile           | 2 +-
 tools/net/ynl/generated/Makefile | 4 ++--
 tools/net/ynl/lib/Makefile       | 3 ++-
 tools/net/ynl/samples/Makefile   | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.44.0



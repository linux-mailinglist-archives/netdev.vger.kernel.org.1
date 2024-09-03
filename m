Return-Path: <netdev+bounces-124631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 103F496A43E
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2BA9282358
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A591E18BB98;
	Tue,  3 Sep 2024 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUOTpf/3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCE618858F;
	Tue,  3 Sep 2024 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380826; cv=none; b=nwkJBhEQYa3g7zLSZ2tkQ4xOSTMiAdLwdEvdbcpANnnJhHIX9JkDZifUAYoQtRKzatZMYOEAe73L8tlphBAMqQR5ajYZ6RVFY9h602KZBPXUL1WU5NlLw/lKgVEfnwSfUXIbgsCTC9yhQrtp3Jul1NlwaPqK2c+jiAXQCiyoDHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380826; c=relaxed/simple;
	bh=wpuyx68o8/flxPcNBVnFYnKbkR/kuE5X70J8QW218xk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HjrJrLjaAYhFX1NumnO8wQiuBxXRzMngFTE8mRGamiZw7DvLPzwv7o1ZfHvK84hAixmgImDjX8BS4DplgO8G6dmy0R10db2zYhK4HC1ztcFTdWTd5k6idqGUWssiObv4ucseHRSRWR+pU6DL9D/f+laTW0p6Bzrpek6zVScB8pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUOTpf/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05A3C4CEC4;
	Tue,  3 Sep 2024 16:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725380826;
	bh=wpuyx68o8/flxPcNBVnFYnKbkR/kuE5X70J8QW218xk=;
	h=From:Subject:Date:To:Cc:From;
	b=mUOTpf/3ulUCvmcq2vpx0ava3eGAtI0USsqQgJlCiwa3lrWDImGq0yxXxee43ffb+
	 JOlJfc6Inp3acTAziD0ikgNQla4dpMm+5Bt600LDlC9wMfMa6/JNI9xyBr/g6hqd4S
	 5lvSP6OqbpDT1RLJr7eU0EOXMJhGKB/2WDaeQA+6mUQYX7OIJXDZf2j6P+BkW6p4fB
	 zSMOhVkeovfJA8GK5Y2bUg2dR+uUFIlmasnJ5ZCSJJBuOuStjU9ira8Rjkghrh+8FD
	 2QtqGffV6t3kXdOLiXlHiFb6gkHu5PkJXUFJhbVaQfxROdW06X7uWIUQeoVHjGmKCn
	 nmL1Xx1JC6yHg==
From: Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 0/2] octeontx2: Address some Sparse warnings
Date: Tue, 03 Sep 2024 17:26:52 +0100
Message-Id: <20240903-octeontx2-sparse-v1-0-f190309ecb0a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMw412YC/x3MQQqDMBBG4avIrDsQo63oVUoXRv/W2UwkE0pAv
 LvB5bd47yBDEhhNzUEJfzGJWtE+Glq2WX9gWavJO9+70XUcl4youXi2fU4GfrVrwDAOzxAC1Wx
 P+Eq5l29SZFaUTJ/zvADLUidabAAAAA==
To: Sunil Goutham <sgoutham@marvell.com>, 
 Linu Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
 Jerin Jacob <jerinj@marvell.com>, Hariprasad Kelam <hkelam@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 netdev@vger.kernel.org, llvm@lists.linux.dev
X-Mailer: b4 0.14.0

Hi,

This patchset addresses some Sparse warnings that are flagged in files
touched by recent patch submissions.

Although these changes do not alter the functionality of the code, by
addressing them real problems introduced in future which are flagged by
Sparse will stand out more readily.

Compile tested only.

---
Simon Horman (2):
      octeontx2-af: Pass string literal as format argument of alloc_workqueue()
      octeontx2-pf: Make iplen __be16 in otx2_sqe_add_ext()

 drivers/net/ethernet/marvell/octeontx2/af/rvu.c        | 4 ++--
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

base-commit: 54f1a107bd034e8d9052f5642280876090ebe31c



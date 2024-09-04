Return-Path: <netdev+bounces-125238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA0796C66E
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 20:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC160283A59
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 18:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF9B1E1A17;
	Wed,  4 Sep 2024 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3+j3Ta6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFF412BEBB;
	Wed,  4 Sep 2024 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474592; cv=none; b=VCR3QGF1Grx3NKDscRoKLpumFuNJ+ebCoD5xHylDUm6cXiRFuIn7MdUwP6Bxaq2DuWZimyl5EArI7ITNIk9h73UcTCQ2GkdxO6fVRyVL94ZslYkik8LFQ8iIzWtvDABpco9OQ7OKXr5bzYWEwswFCqnj485nNGrCEUR0x0knhIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474592; c=relaxed/simple;
	bh=Ee/uOpTbeXyGEGDg5RzUmhHX88O/8p8BzMH+PG23OOo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NjI0K4uUKTY9Cw0GwhHoRhIGp5UCgsqye+GIzqzBj9jP2OzKdp2zE9xNVBuu4dWN6cIosBBKwomq5RCxSeRfklQsRLvWxDWqLJSTZKfzUyb3Rlp13QdEivWa04/YcaKhOeRREpR/wRAKRVcvbZu24qGAyTI8tweVBmMuhl+6zmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3+j3Ta6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14092C4CEC2;
	Wed,  4 Sep 2024 18:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725474592;
	bh=Ee/uOpTbeXyGEGDg5RzUmhHX88O/8p8BzMH+PG23OOo=;
	h=From:Subject:Date:To:Cc:From;
	b=j3+j3Ta65uGmhMbn+H+ijge53GhI3v2HHEs3hZm62sqSbljpAU2Xv1alD8mGJ0B/x
	 Wjt/nisZFG3xuN7/GuirWjz2sy7UxGKuE/HPOcGOR4Aj4p8LMQyIKrME5RgeR4AFAP
	 oABpw6FppErh6x71ib0neqtO45MSg2AdstPOh/JCSnDMVOe5ZB1/79W/8xrVbMvfVA
	 g2eVKWDgwdhJHaNvRzEIEuYZoQErwYjyEN8waTOvSX6ocqqt+g69jzfMXeObfD6h/d
	 FRmCPh300vpC32ccmOkkysvuTmXXHJ50AYPlEORoR7ePbP7VfFmCSrgdc3ZvGICrCP
	 cGvtVnzTD1mxQ==
From: Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 0/2] octeontx2: Address some warnings
Date: Wed, 04 Sep 2024 19:29:35 +0100
Message-Id: <20240904-octeontx2-sparse-v2-0-14f2305fe4b2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA+n2GYC/3WNywqDMBBFf0Vm3SlJ+hC76n8UF4leNbQkMgliE
 f+9wX2Xh8M9d6ME8Uj0qDYSLD75GAqYU0XdZMMI9n1hMspcVaMuHLuMGPJqOM1WEviue4e6qW/
 OOSqzWTD49Ui+KCBzwJqpLWbyKUf5Hl+LPvz/7KJZ8aCLUw06p+zzDQn4nKOM1O77/gM+RUTJu
 wAAAA==
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

This patchset addresses some warnings flagged by Sparse, gcc-14, and
clang-18 in files touched by recent patch submissions.

Although these changes do not alter the functionality of the code, by
addressing them real problems introduced in future which are flagged by
Sparse will stand out more readily.

Compile tested only.

---
Changes in v2:
- Updated cover letter - it incorrectly claimed both patches
  addressed issues flagged by Sparse
- Added Tested-by tags from Geetha sowjanya. Thanks!
- Link to v1: https://lore.kernel.org/r/20240903-octeontx2-sparse-v1-0-f190309ecb0a@kernel.org

---
Simon Horman (2):
      octeontx2-af: Pass string literal as format argument of alloc_workqueue()
      octeontx2-pf: Make iplen __be16 in otx2_sqe_add_ext()

 drivers/net/ethernet/marvell/octeontx2/af/rvu.c        | 4 ++--
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

base-commit: 54f1a107bd034e8d9052f5642280876090ebe31c



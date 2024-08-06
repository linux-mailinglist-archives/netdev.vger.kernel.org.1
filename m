Return-Path: <netdev+bounces-116027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B43948D49
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 12:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43542B24AB8
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 10:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A6E1C0DD3;
	Tue,  6 Aug 2024 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTfbe3gi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751721C0DCC
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941769; cv=none; b=nuxytAWJ7Hj2QXum0C+7uQQtTwqsOcFidEs5vz/TQ2KMO4eUEK15PVQOT2rbEDLCjp/4pHfRfRx6sOL2bKW1+S43h2KSAJM5MaABurLuE5/EE5cy/dXawZXfSYYrO7OY83RM1pwFX9zd8sZWjNKWjw5XYhddWUFfCutA/Dh1zBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941769; c=relaxed/simple;
	bh=4r6g+j1HuQHkPiMvEa2TStWpC2Wt8o8YOGOxGc9nMrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZgvZ/aMf8V0Ry+tbHwArCgSeh2ksVbfDxoYFyFyKOInzZ6Um9VDaRtMg0w4DEm7CBuCeMYtdtpZNpC4iOIUDry9rn/84X930blZflUBPC0AzLy5bMOJ0S0yDsg/YerdZor9ZPZ94RePxrAaCopPQTN98MvOi3tZ+u8FgdTHSQQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTfbe3gi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB6FC32786;
	Tue,  6 Aug 2024 10:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722941769;
	bh=4r6g+j1HuQHkPiMvEa2TStWpC2Wt8o8YOGOxGc9nMrY=;
	h=From:Date:Subject:To:Cc:From;
	b=CTfbe3gih/rWMZpAmZUqZooktNp+oKf/Qx+DbDXX4IicA9GIvDITr1TXn4m71Ntht
	 gu2mNsPQ7kPpXbbkjcJg92JoTsNC4Jt/T1xedKWTbWEwhP4dNpCyWqI1mwRRik+adm
	 U5zA/Sqx+3DuuNwL3o2xZf0qq+vr9W8SzF/M6/F7pYK/N4ijRRMQn9Ss/BBCmK0Pq8
	 /28JGYlSCty4VcuMnQEHd0bsermxWvApdb9E4ocZO4/kSQlCS/QCJCz+Fjgfs11yya
	 3IuelS78VoF+h4yqMvSHsofcrJ7IHej2j/s/2Xd0DLYT9DghAwJo3LHe1hd2dwzJur
	 ZEUn9WxR9AJgA==
From: Simon Horman <horms@kernel.org>
Date: Tue, 06 Aug 2024 11:56:01 +0100
Subject: [PATCH net-next] bnx2x: Provide declaration of dmae_reg_go_c in
 header
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-bnx2x-dec-v1-1-ae844ec785e4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEABsmYC/x3MTQqAIBBA4avErBsw+7OuEi1Sp5rNFBohRHdPW
 n7weA9ECkwRxuKBQDdHPiSjKgtw+yIbIfts0Eo3yqgWrSSd0JPDtjPKV7br68FA7s9AK6f/NYH
 QhULpgvl9P/daaRdlAAAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Sudarsana Kalluru <skalluru@marvell.com>, 
 Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

Provide declaration of dmae_reg_go_c in header.
This symbol is defined in bnx2x_main.c.
And used in that file and bnx2x_stats.c.

However, Sparse complains that there is no declaration
of the symbol in dmae_reg_go_c nor is the symbol static.

 .../bnx2x_main.c:291:11: warning: symbol 'dmae_reg_go_c' was not declared. Should it be static?

Address this by moving the declaration from bnx2x_stats.c to bnx2x_reg.h.

No functional change intended.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_reg.h   | 2 ++
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_stats.c | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_reg.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_reg.h
index 4e9215bce4ad..a018f251d198 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_reg.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_reg.h
@@ -868,6 +868,8 @@
 #define DORQ_REG_VF_TYPE_VALUE_0				 0x170258
 #define DORQ_REG_VF_USAGE_CT_LIMIT				 0x170340
 
+extern const u32 dmae_reg_go_c[];
+
 /* [RW 4] Initial activity counter value on the load request; when the
    shortcut is done. */
 #define DORQ_REG_SHRT_ACT_CNT					 0x170070
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_stats.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_stats.c
index 2bb133ae61c3..ba6729f2f9c0 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_stats.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_stats.c
@@ -23,8 +23,6 @@
 #include "bnx2x_cmn.h"
 #include "bnx2x_sriov.h"
 
-extern const u32 dmae_reg_go_c[];
-
 /* Statistics */
 
 /*



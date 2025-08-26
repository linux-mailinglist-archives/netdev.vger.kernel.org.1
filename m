Return-Path: <netdev+bounces-216937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 709CAB36331
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB4D464343
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644AD33A03C;
	Tue, 26 Aug 2025 13:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="H17bMRV2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E6wtBwSi"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFA534DCCA
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214230; cv=none; b=RCAATzyDsQmxjDdqPxyQzIn52mkJYDCEiVrZw2RmbNV1BDWGVzUTm1l1CNlotGEW+hTjzMBlPugeRnXbQawfIRPECHUNW+tU9q4Y34Z+NN6k6+kQlaKXm9ugtIAysdgdr8gb+/7akhKjTitw0Z+/Ef5UilCRk8brT4EoE63BfPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214230; c=relaxed/simple;
	bh=o6GgEAaYx++uk9O+nwZ9mbMnDKCneJueqjmjvyDS8gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMMsR4ZTOqXBSAg/1Tf5uggWbjiHtnHxRFCNX+Y6rzFIaIbLrEy4MB6phsoBnwWMKQcFKLE6DiSnnUPjloFotu455p5MfUEkhUVJ2W9CPN/qZDZks+a53pgBIVQOnTgZa3APLep0ivZT09qyqVQwkRvBD1fXXzU87E9k/caWB64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=H17bMRV2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E6wtBwSi; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0730F1D00074;
	Tue, 26 Aug 2025 09:17:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 26 Aug 2025 09:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756214227; x=
	1756300627; bh=RPfcQkzAB0d0c3z3YQWFA91C5zEDLeVo8R1NETNwXnI=; b=H
	17bMRV2L03r4L5cvy/G4rIJFKP3X3Vz/AQ3StGqPOSs018PrhS6IrSfPPi+FDTQx
	Qo4uszpWb1ZcC/T6zwrq16EN0cB+r8HTUh2c/z6yO6BJD895STeGm0zokTywLBR8
	1zjz6Y78DWEi98DOXG4AV6bGyKaojYNCR/OkprXFL39ODTsvvfLxzGk0XXzOvU4L
	tjsTmElQbk6gmitk3KSedw4vjMW+QLaVbvQYxJQLiaIL8zeLfXPHMCpt1I+JCxBQ
	jxq6MtaZyPP/O7YSA3tO9dKFCIHXmFc5s2zl3MyQR164Rvdb9+4bhrYN/SM8hGc1
	s0bnFLm8z1P9+0lFlgpKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756214227; x=1756300627; bh=R
	PfcQkzAB0d0c3z3YQWFA91C5zEDLeVo8R1NETNwXnI=; b=E6wtBwSiv6Qsqb9xH
	emkj3pMmxLYOL3ihlZDWRFMy7f5UTKFFlfqB1ao0WCQflERDFiSrufT+SoBW8evR
	kGU9HrquQMrA8XVtNdV89UJr1uKM9DccGGDzgrD33UXuIRfxplAgQSXEDtjn2GHR
	z8IEAhXD4eIwzeWSu6Y29obaTS5NoJmQkoQ4AQDXAD2RxvRpwlNfKUgLWguvlCp6
	BMpzjgbVbLygpz2nfvHuzmo99MlHFLxrBaNeJJBlRbahH7Rr6Av+s9OJbL8QUdvB
	ms6sSBSnNUkqS1VfE5dVG8roi8mrmLojHnZy1JHh4wZVQdITLjfxT/LCjqDJW/eI
	1l43A==
X-ME-Sender: <xms:07OtaNkJyE30tWZ80Uh1dele1p9DeSoxA6rjmSNe4nJVuvreMCSz0w>
    <xme:07OtaGxw60B7NJINCXOXLdR3I2NGa5HiGbpqWT19oP7KYbEORdlLi0IsB-L-4ECG3
    JCawY7KEfYCDObCj7g>
X-ME-Received: <xmr:07OtaLNjlmDi4zxHOsd11noJcPoZTwghf1YE_QH_08m1vqhwGV_hiYwsRrt2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeehfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhf
    egveeuhfetveeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpeef
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrg
    hshihsnhgrihhlrdhnvght
X-ME-Proxy: <xmx:07OtaKQwN_5lY8P5Mf7EolIJAoxFT_M3MDpcOcdT0j5aKltu0FzTJg>
    <xmx:07OtaJbA970VOXFBvKrrtTjTaM2YbcHtqMEwloHhgT8Kng7v7v-83w>
    <xmx:07OtaH27ncnME60MmPl30r3SC7nrz83UbWamp-Tt2qRAZPFY-t9sAg>
    <xmx:07OtaJUqVQBRCBh5NVjlRpSu1De1EDfcjQTJK6ld9qFafRwq4Cv_wg>
    <xmx:07OtaAhUnvbSDZnFh-ZhftP7EaIX7T5-sV_DKzluUlus0Ogtp-36U3Ga>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 09:17:07 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next v2 08/13] macsec: add NLA_POLICY_MAX for MACSEC_OFFLOAD_ATTR_TYPE and IFLA_MACSEC_OFFLOAD
Date: Tue, 26 Aug 2025 15:16:26 +0200
Message-ID: <37e1f1716f1d1d46d3d06c52317564b393fe60e6.1756202772.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1756202772.git.sd@queasysnail.net>
References: <cover.1756202772.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is equivalent to the existing checks allowing either
MACSEC_OFFLOAD_OFF or calling macsec_check_offload.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/macsec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

v2: rebase on net-next (IFLA_MACSEC_OFFLOAD policy was added)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index ca47c9a95cf4..463fd9650b31 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -1679,7 +1679,7 @@ static const struct nla_policy macsec_genl_sa_policy[NUM_MACSEC_SA_ATTR] = {
 };
 
 static const struct nla_policy macsec_genl_offload_policy[NUM_MACSEC_OFFLOAD_ATTR] = {
-	[MACSEC_OFFLOAD_ATTR_TYPE] = { .type = NLA_U8 },
+	[MACSEC_OFFLOAD_ATTR_TYPE] = NLA_POLICY_MAX(NLA_U8, MACSEC_OFFLOAD_MAX),
 };
 
 /* Offloads an operation to a device driver */
@@ -3771,7 +3771,7 @@ static const struct nla_policy macsec_rtnl_policy[IFLA_MACSEC_MAX + 1] = {
 	[IFLA_MACSEC_SCB] = { .type = NLA_U8 },
 	[IFLA_MACSEC_REPLAY_PROTECT] = { .type = NLA_U8 },
 	[IFLA_MACSEC_VALIDATION] = { .type = NLA_U8 },
-	[IFLA_MACSEC_OFFLOAD] = { .type = NLA_U8 },
+	[IFLA_MACSEC_OFFLOAD] = NLA_POLICY_MAX(NLA_U8, MACSEC_OFFLOAD_MAX),
 };
 
 static void macsec_free_netdev(struct net_device *dev)
-- 
2.50.0



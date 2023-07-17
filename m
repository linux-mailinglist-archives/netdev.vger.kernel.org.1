Return-Path: <netdev+bounces-18172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FDF755A5C
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 05:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA3F1C209B4
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 03:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5BD5228;
	Mon, 17 Jul 2023 03:53:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEF015B4
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 03:53:51 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF651B8
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 20:53:50 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTP id 4R47VM4KzDzBHXlG
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 11:53:47 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
	content-transfer-encoding:content-type:message-id:user-agent
	:references:in-reply-to:subject:to:from:date:mime-version; s=
	dkim; t=1689566027; x=1692158028; bh=yO9olHN2kz9V1S952ve2jmRDX9M
	4YZqbbgOGihKzL/A=; b=REPhoOPHoTqFBQEzX6dM7mSVLpypR5zUS8cM1wFcYwE
	x5Hj+YqFsEpoDcgc+CI1mI7avwU3usGjvUeeYxzjo/F/g8QpyYGRWzlnQEkzAwVP
	jaLN/8Hnu/mawhqocZR7smh9xj4reZrlSKsDvsR74At0gxon3hFXSYPIZoC5Uoqc
	PR3Cx4DHEwifrBAdL6FeT1tFe6ord2bsgMenRuuCJWsH5EDnLTsY8C/SttpBZk1X
	aogS49UuYIHP/i3xWiaWR2XLrkyIl0F7kT5YQMGZOgXDrdPX34Z3M+vVYsIC73CZ
	yPpwohXYoWVkRJR8VjXZtcuCjjZGRphXepLCTp/s/hQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
	by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fIebnRbc1I1p for <netdev@vger.kernel.org>;
	Mon, 17 Jul 2023 11:53:47 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTPSA id 4R47VM0qGMzBHXR9;
	Mon, 17 Jul 2023 11:53:47 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Jul 2023 11:53:47 +0800
From: hanyu001@208suo.com
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
Subject: [PATCH] falcon: Prefer unsigned int to bare use of unsigned
In-Reply-To: <tencent_17776852D0A5AD5787FB7C0652F0628EE206@qq.com>
References: <tencent_17776852D0A5AD5787FB7C0652F0628EE206@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <17542be887f082df63dbe436f1abcac7@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch fixes the checkpatch.pl error:

./drivers/net/ethernet/sfc/falcon/farch.c:274: WARNING: Prefer 'unsigned 
int' to bare use of 'unsigned':

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/net/ethernet/sfc/falcon/farch.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/falcon/farch.c 
b/drivers/net/ethernet/sfc/falcon/farch.c
index c64623c..643ffe1 100644
--- a/drivers/net/ethernet/sfc/falcon/farch.c
+++ b/drivers/net/ethernet/sfc/falcon/farch.c
@@ -271,7 +271,7 @@ static int ef4_alloc_special_buffer(struct ef4_nic 
*efx,
  /* This writes to the TX_DESC_WPTR; write pointer for TX descriptor 
ring */
  static inline void ef4_farch_notify_tx_desc(struct ef4_tx_queue 
*tx_queue)
  {
-    unsigned write_ptr;
+    unsigned int write_ptr;
      ef4_dword_t reg;

      write_ptr = tx_queue->write_count & tx_queue->ptr_mask;


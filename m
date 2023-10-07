Return-Path: <netdev+bounces-38809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD2D7BC916
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 18:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08AB1C2093C
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 16:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7F1522F;
	Sat,  7 Oct 2023 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sembritzki.org header.i=@sembritzki.org header.b="jWaaR47u"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE2F522C
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 16:37:01 +0000 (UTC)
X-Greylist: delayed 356 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 07 Oct 2023 09:36:59 PDT
Received: from smtp.sembritzki.me (smtp.sembritzki.me [5.45.101.249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00263B9;
	Sat,  7 Oct 2023 09:36:59 -0700 (PDT)
Received: from smtp.sembritzki.me (v22018013267558932.luckysrv.de [5.45.101.249])
	by smtp.sembritzki.me (Postfix) with ESMTP id D0D539DBAD;
	Sat,  7 Oct 2023 18:30:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sembritzki.org;
	s=dkim001; t=1696696252;
	bh=/6nMdMcn0y3Q6d91mungNpuVA8MtUc6RPQr6wF32CAI=;
	h=Message-ID:Date:MIME-Version:User-Agent:To:Cc:From:Subject:
	 Content-Transfer-Encoding:subject:to:from:date:cc:reply-to:
	 message-id;
	b=jWaaR47uFiKjStJEbeslT83GMvnq1giElvwDzAMcan1DwgOqSjy3mOtS6xnwJ0NO4
	 65/E9cWOASCAgjVsYwlbEK1qA7yHWpeGDfKHDrdL0KL62msfHV4ss8ltkDuubHkXx6
	 /XvBQ6rUHp5vWYccc80mwbMeOwkvMaeY5OKhTU3y2TQvyHAza5u+BALvnaAbldCpWt
	 KCOXBnxrBd1efmA8hfmL8y0762FjdK9044KgaJPeoQTKQbbKxVQkO984qwWWnCAvMR
	 dgcHMuNuWLBZ2ptjW23MxfnGp2VmjlOa2FPTXdqnmgiUz1LeKakUPKdtKiFgGoa09J
	 fvtwM5cV07D/g==
Received: (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.sembritzki.me (Postfix) with ESMTPSA id D3B149DBB0;
	Sat,  7 Oct 2023 18:30:52 +0200 (CEST)
Message-ID: <78adf50c-e8f9-d1ce-e933-418a850b6a44@sembritzki.org>
Date: Sat, 7 Oct 2023 18:30:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, netdev@vger.kernel.org
From: Yannik Sembritzki <yannik@sembritzki.org>
Subject: [PATCH] Correct list of flags returned by SIOCGIFFLAGS in netdevice.7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As per 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=746e6ad23cd6fec2edce056e014a0eabeffa838c
and https://lkml.org/lkml/2009/5/28/224

Signed-off-by: Yannik Sembritzki <yannik@sembritzki.org>
---
  man7/netdevice.7 | 3 ---
  1 file changed, 3 deletions(-)

diff --git a/man7/netdevice.7 b/man7/netdevice.7
index 0087a8115..01356476d 100644
--- a/man7/netdevice.7
+++ b/man7/netdevice.7
@@ -127,9 +127,6 @@ IFF_AUTOMEDIA:Auto media selection active.
  IFF_DYNAMIC:T{
  The addresses are lost when the interface goes down.
  T}
-IFF_LOWER_UP:Driver signals L1 up (since Linux 2.6.17)
-IFF_DORMANT:Driver signals dormant (since Linux 2.6.17)
-IFF_ECHO:Echo sent packets (since Linux 2.6.25)
  .TE
  .ad
  .PP
-- 
2.41.0



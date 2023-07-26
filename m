Return-Path: <netdev+bounces-21466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D14F763A7F
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD5A280845
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D79BE77;
	Wed, 26 Jul 2023 15:11:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82381DA20
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB90AC433C8;
	Wed, 26 Jul 2023 15:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690384283;
	bh=XiLHsDn5JUHJIq50wmGiHJqBzQCqwg/qbiBjlAfgQpI=;
	h=From:To:Cc:Subject:Date:From;
	b=m5s4sv63z8+2fpaxRUjmqMOlsO9+PjGa3KLdjAPRcpp4llJXoep9o73zyHsnKPCiG
	 711ps8WpqluhMvVszdGAYdrL/0vfVChjbZpwkDvVmnso0vWp7yhTXxwq7naqsB7koJ
	 03XgHN+8f+kFlYjSncqK5waFDNVxh3V23gh2m7xPtC3fnIMCpcWI7WgZwRRt4PjowE
	 h6ZIjF/QqlZ3jri9bneJHmcPQFLPOTN9CYcJB1cBdBLvZRUp2ABtm/4OUHbEsAgkLO
	 1Udfvs5o9utOwGPd7T6s+Ta+ow6piD3TDPM0cXZf0BdjS0/eSLxCiaWTDPY1A4fb1U
	 gLh7Ph2CWtajw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Subject: [PATCH net] MAINTAINERS: stmmac: retire Giuseppe Cavallaro
Date: Wed, 26 Jul 2023 08:11:20 -0700
Message-ID: <20230726151120.1649474-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I tried to get stmmac maintainers to be more active by agreeing with
them off-list on a review rotation. I pinged Peppe 3 times over 2 weeks
during his "shift month", no reviews are flowing.

All the contributions are much appreciated! But stmmac is quite
active, we need participating maintainers :(

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: Giuseppe Cavallaro <peppe.cavallaro@st.com>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: Jose Abreu <joabreu@synopsys.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aee340630eca..2db30d652c4d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20401,7 +20401,6 @@ F:	drivers/pwm/pwm-stm32*
 F:	include/linux/*/stm32-*tim*
 
 STMMAC ETHERNET DRIVER
-M:	Giuseppe Cavallaro <peppe.cavallaro@st.com>
 M:	Alexandre Torgue <alexandre.torgue@foss.st.com>
 M:	Jose Abreu <joabreu@synopsys.com>
 L:	netdev@vger.kernel.org
-- 
2.41.0



Return-Path: <netdev+bounces-17838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC3775330F
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 09:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1EA281EB7
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 07:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC9B6FDD;
	Fri, 14 Jul 2023 07:21:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A081E6FD4
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 07:21:48 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFB73585
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 00:21:29 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTP id 4R2NFK12C5zBR9sx
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 15:21:25 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
	content-transfer-encoding:content-type:message-id:user-agent
	:references:in-reply-to:subject:to:from:date:mime-version; s=
	dkim; t=1689319285; x=1691911286; bh=2KIgooK2dFFh+lYa+cqbbVy+s0Z
	Il/PlmgqMHKtZcZE=; b=koUQAthc+GfsTN5MH2nkvJt11AyhFc2kr7Y0REfIRcN
	hNnXpU3+VHgUfy1P9Dz5KBugwvFpFgcdScO1k1Zs/ZG7XnWuyiJTyyWETep35swP
	mrn6cUs/+QaUob9kKlBrgfzTrDEqbZzThLafPz68hGoNE9sp57CWyCrdk9ygDTni
	GVYYZ84gAr82m6uhW8t/JOS3zoWrJ9gmXuOdQWIybKnZRdO/zQH8s8BzcK1dexUb
	Qe3qbNnr2K7tjc0LTPnSPBi8IbzAlmrKuzZGSHA+A1idtsHtDB2vVjkYhpoxSPLz
	QFFlVhknb7JLcHJXzfAx4fSVutv+bF3LI3XwPPfAjUQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
	by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TybP91xxcLZw for <netdev@vger.kernel.org>;
	Fri, 14 Jul 2023 15:21:25 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTPSA id 4R2NFJ4x9bzBJFS7;
	Fri, 14 Jul 2023 15:21:24 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Jul 2023 15:21:24 +0800
From: hanyu001@208suo.com
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: linux-acpi@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] drivers: net: slip: Add space after that ','
In-Reply-To: <tencent_DFF4CE5F22F12C5628BE86CE05E5D926750A@qq.com>
References: <tencent_DFF4CE5F22F12C5628BE86CE05E5D926750A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <489205707f078c77a9f240f4c7f4bbc9@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix Error reported by checkpatch.pl

./drivers/net/slip/slhc.c:679: ERROR: space required after that ',' 
(ctx:VxV)
./drivers/net/slip/slhc.c:679: ERROR: space required after that ',' 
(ctx:VxV)
./drivers/net/slip/slhc.c:680: ERROR: space required after that ',' 
(ctx:VxV)
./drivers/net/slip/slhc.c:680: ERROR: space required after that ',' 
(ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/acpi/acpica/rslist.c | 2 +-
  drivers/net/slip/slhc.c      | 4 ++--
  2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/rslist.c b/drivers/acpi/acpica/rslist.c
index 164c96e..d7dcd10 100644
--- a/drivers/acpi/acpica/rslist.c
+++ b/drivers/acpi/acpica/rslist.c
@@ -27,7 +27,7 @@
   *
   
******************************************************************************/
  acpi_status
-acpi_rs_convert_aml_to_resources(u8 * aml,
+acpi_rs_convert_aml_to_resources(u8 *aml,
                   u32 length,
                   u32 offset, u8 resource_index, void **context)
  {
diff --git a/drivers/net/slip/slhc.c b/drivers/net/slip/slhc.c
index ba93bab..72e64ee 100644
--- a/drivers/net/slip/slhc.c
+++ b/drivers/net/slip/slhc.c
@@ -676,8 +676,8 @@ struct slcompress *
      /* Update local state */
      cs = &comp->rstate[comp->recv_current = index];
      comp->flags &=~ SLF_TOSS;
-    memcpy(&cs->cs_ip,icp,20);
-    memcpy(&cs->cs_tcp,icp + ihl*4,20);
+    memcpy(&cs->cs_ip, icp, 20);
+    memcpy(&cs->cs_tcp, icp + ihl*4, 20);
      if (ihl > 5)
        memcpy(cs->cs_ipopt, icp + sizeof(struct iphdr), (ihl - 5) * 4);
      if (cs->cs_tcp.doff > 5)


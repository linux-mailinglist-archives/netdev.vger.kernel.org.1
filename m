Return-Path: <netdev+bounces-114345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F309423F5
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 02:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA121F24EF0
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 00:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD85C4C76;
	Wed, 31 Jul 2024 00:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="E/WFrzu2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6EB79DC
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 00:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722387017; cv=none; b=q100so7oo+LOYftcYOjHx656iygVxldZ0WBFlfm8Lx7XewfPLF3mfB6kYkD1MJwg3t7SMVriSEFRCTHmIGI41HBnAeIaowQGT8t6G597NhobMv7jQ5epbTf4bCrVHRpqLaQrkVLO6V/OARM7I5t/CFBf7hBufiyCuKoBwLjJN1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722387017; c=relaxed/simple;
	bh=sjfd9Rz7CjuW74yJY8qocEFznmq70Foz8DU8bv/LOrI=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=jVf1LTIj0Hcvh19vO8T2GKK73VGuXWv5TZBJlXSHQ6a77S7odRpdsLOH7iHRds4Hm4DX8MFsOwCm1BSSbvcDm9joRrMWXWK8zRawb/b9xG1gYRmNpiIxgWKL0J7HdqvFZMXAjxj/69Yr3fAcbq6PxvD1hjY36t0oD4MYLSdIbwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=E/WFrzu2; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 46V0nae5014329
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 31 Jul 2024 02:49:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1722386981; bh=2RrtXHJyIhqeMAnkrsYqmckVvuDncb2i8T+RVfNBZv4=;
	h=Date:From:To:Subject;
	b=E/WFrzu26tEYxlPfE1d7YVkJ/ryMGLJwC42pMJvoIVg+esHj5qVOXH+ibJfD9Gx84
	 cxg9CLfgRCxEESCeU8z5wYZ4N4IltMjhWF9kqIk9mzjZ+ba31/GzH/dE9rkuMmAN6Y
	 o+sAeWqas6jCsrLNpZYhGSjtu6hwIQgNthDY/x64=
Message-ID: <0d2504d1-e150-40bf-8e30-bf6414d42b60@ans.pl>
Date: Tue, 30 Jul 2024 17:49:33 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
To: Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew@lunn.ch>,
        Michal Kubecek <mkubecek@suse.cz>, Moshe Shemesh <moshe@nvidia.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>, tariqt@nvidia.com,
        Dan Merillat <git@dan.merillat.org>
Subject: [PATCH v2 ethtool] qsfp: Better handling of Page 03h netlink read
 failure
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

When dumping the EEPROM contents of a QSFP transceiver module, ethtool
will only ask the kernel to retrieve Upper Page 03h if the module
advertised it as supported.

However, some kernel drivers like mlx4 are currently unable to provide
the page, resulting in the kernel returning an error. Since Upper Page
03h is optional, do not treat the error as fatal. Instead, print an
error message and allow ethtool to continue and parse / print the
contents of the other pages.

Also, clarify potentially cryptic "netlink error: Invalid argument" message.

Before:
 # ethtool -m eth3
 netlink error: Invalid argument

After:
 # ethtool -m eth3
 netlink error: Invalid argument
 Failed to read Upper Page 03h, driver error?
         Identifier                                : 0x0d (QSFP+)
         Extended identifier                       : 0x00
 (...)

Fixes: 25b64c66f58d ("ethtool: Add netlink handler for getmodule (-m)")

Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>
---
 qsfp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/qsfp.c b/qsfp.c
index a2921fb..a3a919d 100644
--- a/qsfp.c
+++ b/qsfp.c
@@ -1038,8 +1038,15 @@ sff8636_memory_map_init_pages(struct cmd_context *ctx,
 
 	sff8636_request_init(&request, 0x3, SFF8636_PAGE_SIZE);
 	ret = nl_get_eeprom_page(ctx, &request);
-	if (ret < 0)
-		return ret;
+	if (ret < 0) {
+		/* Page 03h is not available due to a bug in the driver.
+		 * This is a non-fatal error and sff8636_dom_parse()
+		 * handles this correctly.
+		 */
+		fprintf(stderr, "Failed to read Upper Page 03h, driver error?\n");
+		return 0;
+	}
+
 	map->page_03h = request.data - SFF8636_PAGE_SIZE;
 
 	return 0;
-- 
2.45.2


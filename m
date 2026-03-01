Return-Path: <netdev+bounces-262404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPnCIb1QpGmadQUAu9opvQ
	(envelope-from <netdev+bounces-262404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 15:44:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE6E1D043B
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 15:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE9AD301C15A
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 14:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E453314C3;
	Sun,  1 Mar 2026 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b="H8KiCfaV"
X-Original-To: netdev@vger.kernel.org
Received: from sonic302-20.consmr.mail.ir2.yahoo.com (sonic302-20.consmr.mail.ir2.yahoo.com [87.248.110.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF52C31AF1B
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.248.110.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772376239; cv=none; b=VgR9NcLlLA4XX8ad2RBEp50/SW/P+VI0nBla/CQh6+aH3bzZVCSTI8pdTqjCIpxOuUnrvZ38+u4wkTRVabXzuL1YAabYrn9sGXEHuOL4wj+VUsgfUJIHqc4iJcu3ryvta7P9kcNpl/BmGMMibc6JPgx3N5WIMLFvpr8TKxi4UQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772376239; c=relaxed/simple;
	bh=BC7Al5k0IL0C+Q95hx3z22tF9eGctRqrUwtRCUr+Hgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=NfXqCK7OdR3k9gfh8Dza6klHcf4py77A8W6AtmNHwSjqT8Be7LFK1YTU0knAi026Hc45/KSaPQkdyM7A3piZsi3PJGNj5Iaj8M7dbC6tQLTrU15Pmiqk1SWCqPOHIafao098md7EKK0utU1TmuTxCwnzBNYzLCYTPwViVqzlajw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl; spf=pass smtp.mailfrom=yahoo.pl; dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b=H8KiCfaV; arc=none smtp.client-ip=87.248.110.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048; t=1772376235; bh=bwuM7TC35+Pve4ime1URWoJdkCF51jIreIwed9Um0cg=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=H8KiCfaV0Xgfvkt+sFRRWjhTTwMt/iuviuITts/VpXVOZ8Cw7G6ILa1trMw8ZiOjGK5Wr9OlCZNOv3tEjwb215JNeC/5kguOV5+Yoe0mEf0jerizZ9cfLpeya3ClUI0hs008GAlxwyeCTTd/le452QO0I9th3OapQNGQYkK2DTEXkedEi2gpZ1Tv7vB2YFMXBMp8uQaoDC68fwtDOp+5I58mIDBvFEEzTrtqfvFprE/jLK0VLkx+jsX4n746O2J5VLfKi0nxa/ZO+Zf8KD91Iu9zV9SLESRoCJGcpfz7hsH5jswMdu5WxTGXOAw2lxKw0j0u1LoqmTxzbrV0dQWmkg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772376235; bh=ke5fizv35peF4PgGb5nO7o9OaJr756Oh7xXkYNMM21M=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=sFOTHJVXbq2k2ammr60e2ZgwA0IXcqKco8TUDt7rYBuncRG24wb2GIHnaAju6mi0jNT64ADBRoF7305PjVghsPB5Mez2YtdmTYKQBNPWD8agCDCij62vowoNcigh6i2SjRjcYYUIkJe8wuY/akdG3lZKqE6/cYf8omwHbuYTLRmgu7S9EQ9eTu8hxZvkS1K45r2SWR3amVlC+GpS04yFZEx7RsyTZ7Ir2Q4QmTQn+7+SUPnyOfvCl147Jh+SK2NzfOEVKZKEsUQK0IJaLW26Sll2kpoJEMgpYnz6EBVJ0q3X4rc3PIzS1qA4UA460hNvHckKzrtNiHPG4ztadsCyoQ==
X-YMail-OSG: un4SfLMVM1mF0jG9a4mvkZs_io_LXTYwghZqi_Uvu4UPP0r_JU5cJIhmMzpxRj7
 JtxPZV5dfZhWHjDuGwcZRZMHkvlXDvTzwlA28CK_z0HE5sjX8ie3BQaV8tfLHKNLWwOcz3MsaAZh
 QLYhpnZc0nKg.8085WrK20XlKsDFWq3Uf4ch8auKudhe2064lqXSEakrugIAMcRsW0Ikwa57tqD_
 kqYwvxxgQXtOeMdFfWf60esINm5qsXOtTtEMS0vlQeBo7yi3u9Hvg6vUeV.H48zLAjXqOWsOmCew
 T5BFBI2HPF3_ggo9SHokuUf90ym8.sz6fpiWpXfo1_XDI22tgsnmZu91UUC2A_hHDENu3nlaUqJr
 BZkam78sm_vlImhQdsNbHJW5AnsrTBxohRny3G1NE_wppcT2wg2vyiyXCdrRbCHAI533IMrH4ppK
 Z6PxX13HBtYXE25S9rXzFOjFRnUSJ4i.m_QHIXeQCZpRZwchZXQQhOLJn6ShkHmewyEAojWOwQ28
 noYFMbjm58EUBYm4nRQ87_oSHKsioWqg6HmXoVlsIWDxOOBHjKOHA2yb1v1GWqWLg7smsbiBLe1Z
 9di4EEY2nmDb0KsvzkUtcyU2A5Jdqpac_OPeH1.JyCmI7R_nY9x7AmRGy.eBtZDlowsk4cqy0kBD
 1Iq_pHkDw7bqfPXb5gCNdcG3MLN6QDaR8e.RtWA6INcqFq8TJdvak5J6FegcZijlsdsVSy7QNYQw
 jLkBrUXelbt0VjODn703Sm7eZ.pvwNK_PHgVQbgsGek29B30ZTEd3UncBwKTMYPpooPiLFApgFvN
 6K2cD8gvcQRUuaMgdMFDceOoQ7VpxPypeP3ZdMB9u00qyaxzgWSKimf58.dD1kfy1HsgTPCiCJFz
 hbi.nyBdng9iVsVGmbew76JoKBVEmBMpe_5hZ_u6pWhunqnQBT43_bal7vlk63GnGKQ3ua3g0HTq
 Rn72uoeUL9EdD.lzjyc8Uh.PCYi2ydx5kGAdftJQlYBGmb9MfhkFdcdWezroYSm6OX9ijBBV42KJ
 ZdDHc8YmSfRPN.gKAfIcAMZoUgPScsLQ1N.OiM6gkHGu14cvEmIwR1K.nMi0AfMMuVFIRLLaAhPW
 9L0plEQRsJHEtd.ZaMJkNJbCRVsF8H.cmrcxURL_RwbMm3g0N4O8L2d.KnYsXLO0N1zzsgSrhWRs
 7bnre4DSJ5QJ0A52VjnXy1.h9TqbkqjJbKpqLecJEFcF5NVm.ulj3yfO9UjP3AQ9Prwpab9wiocZ
 9p94qNpqlIB8aUEtHrZ6acIDEA5CRO5W2q2OcJGcGiAkw2ZsDaAMhjLCU6_Z6lp2QqxnMcTGNfjM
 opp4bZ5BDcYYTVFv78XO9.GWUExyzHyP_fApRaoCSViEd5rLmSZnm4fPcpYqs4hDid0pys5aCme3
 QmVGTMNVohzD8pb_0rIb_SYvRZQB978mncmgeJxUW2iqf7_59lkcV2wlCUYiU4YXutljuDjxz9y7
 eIy2wvCRhnHaf7Jr9yog0j765JVaPMFeoHZdHrEbbNm3taOrx5H8ekm9IPPNXBH8vlKd54bex2zg
 W.zwjUhQcPTyWFO5nSDAf01n1BCWicsptffTxCvF_mrMBVxjMXKQ3MGgFBVXiwYSN1JU5p4b9CvH
 wKZeyxsGiruBfWbx1acPRWn5vbFAnLXa__qEsJ4BSNjx_0p9N6Lfxs9a5GpBKWW.4Syjrxh9Ns38
 dTYxxJ5_dCjpCx1oxV6lTBxSLxJI279732hEugjvRGVN48iMLmQhVcsPGjBw87ER8QjDZ6Y50Zgy
 ZFO7XgG.Vslbd7_hRR1QH_41xT0Y1Ka8lTCna9jRc9LkdaUPFg9FvfDNMB14k.jZ4wFTurQjfNI8
 tZCGedpDECCIl.7288y2wpfCuuHirSh.N0KMORcqn246ssTC77oKVI5UUZpgCXCj58v1PomV9OKM
 gf_0uBkgSfo0CmwhNt9OKSYq4XhZUsGMmV_cl9lOHzgEmuVE_4GN63nUPtabmNzZIem0px9KKEaZ
 g.IPNtExuofAamWRWs7qtVjQ8BfBz2Lu3tbqaJ8F.FSL2Om26_bvYM29hvfyyCPfsbnTKIN_sDnY
 HNFug8W1FKPC_v0tB7brYTLtGQxXMugnVGfdlJ4UG93ZznhXIu1pF2DfD1NmOYimFUeiYSGi.mwB
 qbdv7pHUoql6lMKpokU2gcNhzfCIDAnIm8ohpDJ6_F18ETyjZ0BOv.MiQ1sAVNO2I5nCiYPRoskO
 54M.PzMkE7PdQtbXKbKbg8PbYxq4DYa_J7mvEqeNkW21eUQbewJxPuld0dueymg--
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: 9b714052-bd40-474d-bc1c-f63d63386608
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Sun, 1 Mar 2026 14:43:55 +0000
Received: by hermes--production-ir2-bbcfb4457-d9ssk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b2a53ab9754a05d99e5ff1810d7cd1fb;
          Sun, 01 Mar 2026 14:43:52 +0000 (UTC)
From: tomasz.unger@yahoo.pl
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Tomasz Unger <tomasz.unger@yahoo.pl>
Subject: [PATCH net-next v1] NFC: nfcmrvl: Replace strcpy() with strscpy()
Date: Sun,  1 Mar 2026 15:43:45 +0100
Message-ID: <20260301144345.218628-1-tomasz.unger@yahoo.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260301144345.218628-1-tomasz.unger.ref@yahoo.pl>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.pl,reject];
	R_DKIM_ALLOW(-0.20)[yahoo.pl:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.pl];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-262404-lists,netdev=lfdr.de];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomasz.unger@yahoo.pl,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.pl:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[yahoo.pl];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yahoo.pl:mid,yahoo.pl:dkim,yahoo.pl:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FE6E1D043B
X-Rspamd-Action: no action

From: Tomasz Unger <tomasz.unger@yahoo.pl>

Replace strcpy() with strscpy() which limits the copy to the size of
the destination buffer. Since fw_dnld->name is an array, the
two-argument variant of strscpy() is used - the compiler deduces
the buffer size automatically.

This is a defensive cleanup replacing the deprecated strcpy()
with the preferred strscpy().

Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
---

Testing:
- checkpatch.pl: 0 errors, 0 warnings
- make M=drivers/nfc/nfcmrvl/: compiled successfully, 0 errors, 0 warnings
- Module loaded successfully in QEMU (x86_64) with buildroot:
  modprobe nfcmrvl - no errors, confirmed via lsmod

 drivers/nfc/nfcmrvl/fw_dnld.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/nfcmrvl/fw_dnld.c b/drivers/nfc/nfcmrvl/fw_dnld.c
index a9b03dcc4100..2b8f401d8fd7 100644
--- a/drivers/nfc/nfcmrvl/fw_dnld.c
+++ b/drivers/nfc/nfcmrvl/fw_dnld.c
@@ -492,7 +492,7 @@ int nfcmrvl_fw_dnld_start(struct nci_dev *ndev, const char *firmware_name)
 	if (!firmware_name || !firmware_name[0])
 		return -EINVAL;
 
-	strcpy(fw_dnld->name, firmware_name);
+	strscpy(fw_dnld->name, firmware_name);
 
 	/*
 	 * Retrieve FW binary file and parse it to initialize FW download
-- 
2.53.0



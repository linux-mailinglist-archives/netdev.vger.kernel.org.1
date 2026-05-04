Return-Path: <netdev+bounces-283750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFxQFVVa+GlStQIAu9opvQ
	(envelope-from <netdev+bounces-283750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 10:35:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CF04BA49B
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 10:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73E1A30038E2
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 08:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28145340280;
	Mon,  4 May 2026 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F89LkvQb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B599C33FE06
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883728; cv=none; b=Ksk8odySoXljFhcIh5W37eeIjL9AbNIuaPkLTWYWLm8jNIazgJGvR8/oB+XWPLXyPpAgqOkjvMCYw3Yk39097S90QLL+ajVK6FyVkrwAZh60KH663v4lV88eVWb0mFHsVBhUi/bUKcJQT2NoqtfTYvZRWBIv9ZVoVG/tCS9T8hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883728; c=relaxed/simple;
	bh=DHwUnrfrZgTlDIQiP+Zjn7uMlg6WsuGGbJPk/FSQf88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9GmwiEzXhYSTU+bRUstACCcqWEgmwsY663YDJXgiv6B2FuhKT5WObJffHbmz9LUawBQ+S8Ki383aCIjJ5evSOeSXOWRUctokQmP/kwpkpkZ19vZf97d6q4kTDnecztL1DQQRr86DYRE5QcPrqt7ZwMSKiqbgbsGp1/StI8Ltew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F89LkvQb; arc=none smtp.client-ip=209.85.217.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-60fee2fa3b8so1312462137.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 01:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777883726; x=1778488526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GkO+P4GbkGjzPIEoSVoRzokVI5q2WSF/G7Zn62CqGu8=;
        b=SFpueX1EBLVcAaGOUDVASL5nY1U3jGNqYLwCdw3Qsk5RxHg3hATwtj3JXjPt0yteC/
         F/vkUPiXdSZp9FKKvq8jUm0xfhsfhG84B78eUcWVaMyORU7Iule0shlObLEDR9vJ/Z/4
         5WVnZaAlQor06TnKVyCC3YbLYWnKkko4upIlaQdT42dKRnf1xQ50UA6ldixJAvocnroG
         xG1AH9kI2pFQf4F/c6iT1CGdJd1kXXJqc9SPIXCzmNoh9r8n7+zi2iXIN40VCxOxPPwG
         CPnNXp0R4Y4zUxGZWe47v8+lvyv/8+PnRTAG3X+DGMVr6c9f9zn4RM4VEmgAiyCg46EV
         WiRA==
X-Forwarded-Encrypted: i=1; AFNElJ+5K8SRMGtpZ/sxHiChwtQCCd8WkkiwXyxzMdQjnlkVZbrRoN/eejqhIWiCm8XqX+fWf4JaAtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXPNMMLgKOsLyibvQBgnzNppxhpq0eTTS680UOy2tZb9lPnsA7
	L4QrWZFfQCjRWIEvVWEVL48KFZCe25OK4KVnlo6ON7s3Nw2w8XP/QUu7yYZeTfyfp03J5MpStMU
	4qJd1v889r+k4mGdD3Sb91GonzaUavYFO66CCJv2Vauz1WjDCXX0MeXMAXqX6w8GEPEPCOElzqV
	shWnHb533GTnr5tRJjPytnN+FVKruVCRTCW6f34gl7T+J9jdF4WWduTG9EtXAANaOjhtyMhSshf
	hprebiCFRE=
X-Gm-Gg: AeBDieskybzzvSLRyyQpNXzgF/u7K7VeokUEeuThdPx+PjKMhndyS9cjnlfCuZb4PGW
	rh5UDpP4AeR4fQ8oOmTZtaHzbPSSqLhe6GT4AuTafpHsQ84z/5OIy8QDofDFzWeCUb8OqAv1IDc
	OUZqM0HiaI5K1Hldjxc/kPRT4ToAVgoLkNGLVJyIbtKBwb7ecXAqHdbDFpjoselsF+/86Y5D0nk
	eW9p8o9TqT98wKlD6L9gDorUYSpegOp4qdU+AnirhTTrvHTw6TUop511FPMdZ2ob7Leb2So9dru
	1UNA5Mn+O0Uz+IhOVBmk8gyCIjH0IDQbeutaoXL7tlaoPwUMyH6s2UV05/47NHatOqTY/LIalaf
	cSjIIqRpigHpkz1sxBT2T1gijrdIkr0kml66baPJKWK+Af58zRvxZJyDNSx8JlG3XHmGMvA1Ed0
	aLtWWB+hKcaasyDkA=
X-Received: by 2002:a05:6102:4a82:b0:62f:2d04:db5d with SMTP id ada2fe7eead31-62f2d04df7bmr1520163137.29.1777883725636;
        Mon, 04 May 2026 01:35:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-62bfe8c5e28sm738073137.20.2026.05.04.01.35.24
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2026 01:35:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f6a5b4f88so5365075b3a.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 01:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777883724; x=1778488524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkO+P4GbkGjzPIEoSVoRzokVI5q2WSF/G7Zn62CqGu8=;
        b=F89LkvQbHk5WSXWYkrxVau+QLEj3o/juJLKwbnlacOFx+p44ryGvP15Rha5g+IRtka
         /P0IIXPK22u6UB+Hcgx8igWysffv0QUjkmEnz/r8ljKgjSqtxS5A3XsiwqUH9cnbs46J
         Gqz/4oz7AjyG7EuldJGbcK0lPmD3b6ASc1E68=
X-Forwarded-Encrypted: i=1; AFNElJ9ynNO1mNMaCZmmoZ8xzrJd92eAtdKNXrZRaZeNnBHBB3IgnHSkX+/zl7hZqjuOcZiaEYM8vvo=@vger.kernel.org
X-Received: by 2002:a05:6a00:1916:b0:82f:9d21:d352 with SMTP id d2e1a72fcca58-8352d012d3amr8135519b3a.9.1777883723816;
        Mon, 04 May 2026 01:35:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:1916:b0:82f:9d21:d352 with SMTP id d2e1a72fcca58-8352d012d3amr8135497b3a.9.1777883723278;
        Mon, 04 May 2026 01:35:23 -0700 (PDT)
Received: from pc-hpe-top-git-sendmail-server.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515ad0183sm12539773b3a.31.2026.05.04.01.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 01:35:21 -0700 (PDT)
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	edumazet@google.com,
	michael.chan@broadcom.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net 1/4] bnxt_en: Delay for 5 seconds after AER DPC for all chips
Date: Mon,  4 May 2026 14:06:08 +0530
Message-ID: <20260504083611.1383776-2-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260504083611.1383776-1-pavan.chebbi@broadcom.com>
References: <20260504083611.1383776-1-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: A5CF04BA49B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283750-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid]

From: Michael Chan <michael.chan@broadcom.com>

The FW on all chips is requiring a 5-second delay after Downstream
Port Containment (DPC) AER.  The previously added 900 msec delay was
not long enough in all cases because the chip's CRS (Configuration
Request Retry Status) mechanism is not always reliable.

Fixes: d5ab32e9b02d ("bnxt_en: Add delay to handle Downstream Port Containment (DPC) AER")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8c55874f44ca..3db951d0c690 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -17360,9 +17360,14 @@ static pci_ers_result_t bnxt_io_slot_reset(struct pci_dev *pdev)
 
 	netdev_info(bp->dev, "PCI Slot Reset\n");
 
-	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS) &&
-	    test_bit(BNXT_STATE_PCI_CHANNEL_IO_FROZEN, &bp->state))
-		msleep(900);
+	if (test_bit(BNXT_STATE_PCI_CHANNEL_IO_FROZEN, &bp->state)) {
+		/* After DPC, the chip should return CRS when the vendor ID
+		 * config register is read until it is ready.  On all chips,
+		 * this is not happening reliably so add a 5-second delay as a
+		 * workaround.
+		 */
+		msleep(5000);
+	}
 
 	netdev_lock(netdev);
 
-- 
2.52.0



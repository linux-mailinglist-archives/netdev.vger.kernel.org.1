Return-Path: <netdev+bounces-268241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOeHNadFuGmLbAEAu9opvQ
	(envelope-from <netdev+bounces-268241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:02:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1E029EB8F
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE3DB301D063
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BC533509A;
	Mon, 16 Mar 2026 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SKXS+OYm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E02B14E2F2
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684132; cv=none; b=GwPDgTEcBXNpr4YbjRRMADgCW6KdeXAmDlqzpcd0z5ikcQzTYMcirvDfAB9HS9EydjHCxNueZR2DNBXSvOgoHrQ+W34oHMrGbgvxhI3LfDhL/WhLokoBQzPryM2ri5PUbr+wt0wcUIvKlmRjzieQHtzykNsI9kqWtyQaccUVAxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684132; c=relaxed/simple;
	bh=GH+pkqi70qiZ1IlEYk3hXcGc3zxJGM0uucnwwlL9KkI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XarUKRXXsgAMGF1lm6cKH63c83FUT4XYuJG2RWQEkeDb7IMDKCQTPnkQIk6wUWLIwbHnQhxNxKApBltoXrFQQVVFx/oFcss+hCGULOfk4oiX/07nryMmwPjHH/tOlm/pTwOE2PKzcip8yCGAGDCKHknR1auKpR8RfLM6EDDLZPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SKXS+OYm; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2b0603ee486so5318115ad.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 11:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773684131; x=1774288931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lXVhIqXFl+WWACJ5oislkt3DrtKNmxISZZlQPPLQV4=;
        b=WuPVoC9voMYyYj60KG0LppS0Wqq22whkl46QJd+uD2c2BROEJmExasJEetSJc/5DU/
         56m1pMnLy2BBldy6mMNtW/mLsQpRoVhIKEz/EWkskSTSFTd3CkTN4dTduU5MP9Qt+kKx
         nc3YA0SQI8jyghw5rFGU2sJcfNCq3fZ48E+Ao+/1N5JbUR+nxUZNcs4OHMtxxFV5LAIY
         CsKxtQBSUJtimN+6H8n8zSdY3oTCH0vN03kVzQ+NQFXxFBcGNHNCeVXWn3GehV1n+uMj
         C4YQykqS2DQ9VffXg1H7mMnssvJjkNjiXpyp16umUhSFtnSXAJQ3WrIGhWw4VZ4kQmFT
         u7SQ==
X-Gm-Message-State: AOJu0YwfqlTuo4ab3pRzlUaEWtlo/q706AR7dyA2IzNeNZBOnzykd0wG
	8nYp53SipZp2k7T0VX3zK2KNmuSgMrjaQDuD1WYko6X1B3OoTBIAa8vSpgC8bQIMbd+c9nnptza
	Y0duVDcxeaLeaqYX+2nyAW6cJ5dVyDRuPE+1D9HRG2APGPXYTXcuesQB88M0+QZkXl9bp1xJPBI
	kfU1bnSC696IYJJj4sKrc3wZ0zv30FmicDS0oNEX+md9lfsBs4BDrUfO6MbmOp3nszOpnEIXGre
	TvYUxuwvA==
X-Gm-Gg: ATEYQzxuki7tLNhicWy6zbt8bCovgyqQJLHJEHiFP3sOdBiOjUGlRHUuQSMohX8vIdB
	z7oEp4PTZU00Tz+s7Zc674F7r/4cbsu8VoP2z4a1gqExK1+BKyKzn9YCeGqz8aj2SJsvOeYfGMK
	3bGh46eTSmyLP54V+sMnx55vfyDHUNwBIp03thZxFRdLjzkbfR3PT800jskcxtbwYRr3aKwD84n
	lbCpAlR322X0Om6UHZHm5TqxPVmc6ttcGQsjEOaNcylX1bKzuR0kRbPf7LrtC7B+7fSLf/YgKRb
	ihnzW6LXp+s8qpsWhf9+Tr9A1L/oCt/8MHrlKUwnaURWi3yHL5P1OgL0OqfNxQvxmfaEP2sSCdy
	02O4ilezHpqCokJmoWReI+WYvTZnY9YZqKJ52g3dnP8ZGFc8llqR+z4sawbLv4NXNTu+XvxB8ZS
	z+T1zA0BWsN1sZkhO0tfaXC5xdqxeqM3Yby7pcWaqtKblBxJgH8hhFfL4=
X-Received: by 2002:a17:902:d482:b0:2b0:4eeb:f80a with SMTP id d9443c01a7336-2b04eebfabbmr64192955ad.29.1773684130425;
        Mon, 16 Mar 2026 11:02:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b04f8d6726sm7227015ad.28.2026.03.16.11.02.09
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2026 11:02:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd722c1a69so2909568385a.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 11:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773684128; x=1774288928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7lXVhIqXFl+WWACJ5oislkt3DrtKNmxISZZlQPPLQV4=;
        b=SKXS+OYmuvHkudTg7Hg3dGTuWtK/fydBGTHUrcfktwucLcOINezDqwaPsgOCUbTKiu
         5Jf1LU4pKNLPweYqKqML2Dj9bCrhkGPvnbsqZaYk4IOSIeyJVuMCOeFxOtTwS9/AKste
         LCEkphm6QAkbvLJkdM1RBjPwZpYinfircejrs=
X-Received: by 2002:a05:620a:31a0:b0:8cb:4066:7acc with SMTP id af79cd13be357-8cdb5b20c66mr1794433185a.50.1773684128453;
        Mon, 16 Mar 2026 11:02:08 -0700 (PDT)
X-Received: by 2002:a05:620a:31a0:b0:8cb:4066:7acc with SMTP id af79cd13be357-8cdb5b20c66mr1794426885a.50.1773684127818;
        Mon, 16 Mar 2026 11:02:07 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fc474dsm1412460685a.6.2026.03.16.11.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 11:02:06 -0700 (PDT)
From: justin.chen@broadcom.com
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net v2 0/2] net: bcmasp: Fix issues during driver unbind
Date: Mon, 16 Mar 2026 11:02:00 -0700
Message-Id: <20260316180202.3371477-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-268241-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1E1E029EB8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Justin Chen <justin.chen@broadcom.com>

Fix two issues when we unbind the driver. We hit a double free of the
WoL irq and a double disable of the clk.

Justin Chen (2):
  net: bcmasp: fix double free of WoL irq
  net: bcmasp: fix double disable of clk

 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 37 ++++++++++++---------
 1 file changed, 21 insertions(+), 16 deletions(-)

-- 
2.34.1



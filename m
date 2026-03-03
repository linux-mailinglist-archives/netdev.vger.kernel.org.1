Return-Path: <netdev+bounces-263435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHALNG5Yp2lsgwAAu9opvQ
	(envelope-from <netdev+bounces-263435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:53:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D261F7C87
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D62663025EEE
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 21:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15F1386C0F;
	Tue,  3 Mar 2026 21:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAIu6Cvb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAAC384225
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 21:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574823; cv=none; b=VGUX1cSvpy1Np6aW7YmIfJLkx9tMpVRVniA6ADIuZzqDo4h87u05vjj5szAESLnOmW03M0blBW3G1Iu2AEE2ekamlPijonUrg5bY3nEjpi3w4RCE0SZUk36UiCjvhcEJJNSOLazXQHTt5NI05SAuhvkGQmfuLaNH3IPJMQSLHLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574823; c=relaxed/simple;
	bh=OscDugvzWgw4hTLi0gNz86gG9VsX3iFOsAuiFl0ljWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=malcoUyQ1qYY5aaB43FtK2WJiGVlMy+AkQj9IfGFWW6pxTYhTz+ad2O/GFXkuA6LuzB1TitlFlMue8iR/V20unMAvBtDr02Za+1GwiK+R29E0ArCT1lUwaNr1pQuPrXnK8lN04DXqDIuZtV3MTc72PMRA+lkAHhyRYUZQjvLAqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAIu6Cvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D452C19425;
	Tue,  3 Mar 2026 21:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772574823;
	bh=OscDugvzWgw4hTLi0gNz86gG9VsX3iFOsAuiFl0ljWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DAIu6CvbcpiIHmrcWRaEKCziA1OlzhHnfGHRpcCa5NXR4dAZDTueyX9xLcDv7Kwdr
	 myYIye5y00yyAJ5VkG6Z+kAm4zEwqMu2wI2yI9JlnYzWisZwW6ZrJdjNG40ewytBg2
	 rIqd1hITuzJ1szq9+qXMtQ2IaYFBDlAs8ric0wYY+hqIytOfSL8BeqnM7mOtmKWUgj
	 awWuB2HuxaWsUAEga7Pc/+52o1gxYvoY5xGiqKAxy+NKtR9/+NcxYfFbErSCtzkMxv
	 zEYThup8SJ5bdp4j6ZggdyZAn5+YH3O0InrbPJXevJ1tMDB0Dc0sp+Rpbiey1QRc32
	 pN3QFKQqZr3Ww==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Subject: [PATCH net 01/11] MAINTAINERS: remove Johan Hedberg from Bluetooth subsystem
Date: Tue,  3 Mar 2026 13:53:01 -0800
Message-ID: <20260303215339.2333548-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303215339.2333548-1-kuba@kernel.org>
References: <20260303215339.2333548-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D1D261F7C87
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,holtmann.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263435-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Action: no action

We have not seen emails or tags from Johan in over 5 years,
and there is no recent mailing list activity.
Marcel Holtmann hasn't provided any tags in the Bluetooth
subsystem in over 5 years, but he is active on the Bluetooth
mailing list, providing informal review.
Luiz Augusto von Dentz is very active, handling essentially
all commits and reviews (12% coverage, but Luiz is the sole
active committer).

Subsystem BLUETOOTH SUBSYSTEM
  Changes 50 / 411 (12%)
  Last activity: 2026-02-23
  Marcel Holtmann <marcel@holtmann.org>:
  Johan Hedberg <johan.hedberg@gmail.com>:
  Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
    Author 138d7eca445e 2026-02-23 00:00:00 164
    Committer 138d7eca445e 2026-02-23 00:00:00 361
    Tags 138d7eca445e 2026-02-23 00:00:00 362
  Top reviewers:
    [15]: pmenzel@molgen.mpg.de
    [8]: keescook@chromium.org
    [5]: willemb@google.com
    [4]: horms@kernel.org
    [3]: kuniyu@amazon.com
    [3]: luiz.von.dentz@intel.com
  INACTIVE MAINTAINER Johan Hedberg <johan.hedberg@gmail.com>

Acked-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Cc: marcel@holtmann.org
Cc: johan.hedberg@gmail.com
Cc: luiz.dentz@gmail.com
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2265e2c9bfbe..0c9b69df9204 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4617,7 +4617,6 @@ F:	drivers/bluetooth/
 
 BLUETOOTH SUBSYSTEM
 M:	Marcel Holtmann <marcel@holtmann.org>
-M:	Johan Hedberg <johan.hedberg@gmail.com>
 M:	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
 L:	linux-bluetooth@vger.kernel.org
 S:	Supported
-- 
2.53.0



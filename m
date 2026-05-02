Return-Path: <netdev+bounces-283382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMsdJ7KU9Wm8MgIAu9opvQ
	(envelope-from <netdev+bounces-283382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 08:07:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F35514B11ED
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 08:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 208DF302801E
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 06:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2C52ECD32;
	Sat,  2 May 2026 06:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ftLPJdMl"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A442E889C;
	Sat,  2 May 2026 06:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777702044; cv=none; b=n9PWTtUmtenWF9+8lmCJOAIaQF3yfQC1jPmxdPIActTU67d/2165LH0RsCXQ03dcxacslL6flCgNgDOXWyJRdSVbgo8aKIV4nvhnY916kXwSldHJs0zr9NYCSMYOsZ2MHcb4T2KfIXOppz0+fEqZOsbufZ2Unv6sI97AM6kxrCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777702044; c=relaxed/simple;
	bh=VljIhxZfpabOtLIN/T9+3T2Myqx7uMzy99pXp3JFv/c=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=eo0aypoHaM5OEW7pV6UmGtyoBDIaC0vlv+ZZsOlEyplQNE/wkrGKhoGG3N943UtBmi9j7u54U50FV/9fZJIkG7cHolRK8Nl3g6eprRicUgt+OkyQ/fgAhahK4me0l4CprfUu8M6duDJ3YVmCGS8dZg7L0V5K/Fl31DBmLvNymBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ftLPJdMl; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777702034; bh=9ny8Y7WkulRs3ZlcZ8RD1O/OliGSzC47KpDVSR30OJo=;
	h=From:To:Cc:Subject:Date;
	b=ftLPJdMlILxJL0dYwYGkccndnRdGl6Elg+Gx4MtV+I/XglhWHqdJYof7LPRgm5KSK
	 If3wNOW6c78ft83BxPc5QYaEkKe9SOEQeT+whu4uPLsQ8hSM0l2CHu3+nz7hbbwSUt
	 1iiGuZEnh9G+dcxJjSY30OzJOrNx7UHVm7rwmoqo=
Received: from Lang.smartont.net ([223.88.152.211])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 1CB93887; Sat, 02 May 2026 14:07:11 +0800
X-QQ-mid: xmsmtpt1777702031tqu7y9idl
Message-ID: <tencent_93F8CA2FB714A80C571AC978F39E51D6E506@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnL7dp5IquUryQoysnzzocSHe5RheY1Gzlqktt0+6yyQjFaEkhJgZ
	 9PO7zxECOd4dV+WTL7iS+JYF4k6pGrrMkoA1A3Uionie4oYY/TV/zAHLDLo4DfA+ONPU1covIHuG
	 GyyBLIdsgp3UjJpHdua85+6wCZhd1U70lebfagOAPn+Bu1/Wra4+PgBU3O46w2R13ThLtiUJprMw
	 zWaAlguqN05D0mT5qjL4qP+JylKGguEHmS9rEcJxogesbLH9nQEH+umK0QZy5o1PJLRsC4LHmGhz
	 A+hbVbcTKPf9OFI8e3m9cUJVB+xgTxhfyhRsYdjMlz57+4Cdal1KFuH8riqrADkJzeeqhLSPe5Zv
	 GxjWaHbtOKGOY+hWzUPObq0CdoKtjvugO7xpr9XYrDBs8KX0664ZF5bLLUkY1bkC+ptLarCkr9Ro
	 crNM7DdnrsPh97DP49NRXrEBqZDSHdcupWuE1Vqna4+O2cP+//PuAwbHaccjLFBMNkchFZtPkKCY
	 X1aFh1OMj8tXKH7dlBHh6C2l9VxtMvpMxI+3DhBoXKjtpDoEruCEmo60DcBdm8UTpprFWeomsx5j
	 jghPB7826mGj6CKGl2SG/cMkF0Z1kgu3ptCmnAJDNzHyJc6z588krsPJmzAsUctLnltt0yBmCzpW
	 4vMSYWmTT+9DwvLDK9koZ3S+5txhVSlpH6pC1jhmqzwQIFnvKnYk+FZjwiz5D3DCFCo0Yh7w9ZMO
	 mFDWwHz0RHRj1A26u3ql48AKON3kskrtNcDQ4rF6TDWDxGT/6xtNWLo9zFSpyguNZhv+thQt6tIG
	 eAJjqA+CPGGRWYVydrky3Vr34zKCCXceWaGi/KfntuIR8RNmXZ8Snq7HUIoTGGnuxi/iwIKsd+3R
	 a8j4924Sxe22szQQAFKEpubpLDUnYIQTHKkeq9RwpJvFdAE5NuD/T6arIDD1ilxVn5MZRDQvOAKz
	 piDV29YQy6jlQJ1bMGCaIqLM12AmlH1Q6RO2cVlr7fatJD6dx0xW1JiJRgAzOicjeSsh9qP57cYM
	 QOW8DwJbHkc0CgorUj0MpW3pbloIgUkITrEdAA8SGL0w/3r4H93cWAPYKG/JmDN4KdyS7HUTreXB
	 H5BPuwcK7IamuIzaumJMCcgnb7WiXbdXhTbVgu
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Wang Zihan <jiyu03@qq.com>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Wang Zihan <jiyu03@qq.com>
Subject: [PATCH v2] net: switchdev: fix duplicate word in documentation
Date: Sat,  2 May 2026 14:07:01 +0800
X-OQ-MSGID: <20260502060701.141976-1-jiyu03@qq.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F35514B11ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283382-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,qq.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[qq.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiyu03@qq.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email,qq.com:dkim,qq.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Remove duplicate "in" word.

Signed-off-by: Wang Zihan <jiyu03@qq.com>
---
 Documentation/networking/switchdev.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
index 2966b7122..948bce44c 100644
--- a/Documentation/networking/switchdev.rst
+++ b/Documentation/networking/switchdev.rst
@@ -162,7 +162,7 @@ The switchdev driver can know a particular port's position in the topology by
 monitoring NETDEV_CHANGEUPPER notifications.  For example, a port moved into a
 bond will see its upper master change.  If that bond is moved into a bridge,
 the bond's upper master will change.  And so on.  The driver will track such
-movements to know what position a port is in in the overall topology by
+movements to know what position a port is in the overall topology by
 registering for netdevice events and acting on NETDEV_CHANGEUPPER.
 
 L2 Forwarding Offload
-- 
2.54.0



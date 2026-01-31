Return-Path: <netdev+bounces-255381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADJ4N4a7fWm4TQIAu9opvQ
	(envelope-from <netdev+bounces-255381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 09:21:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B9AC13C7
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 09:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA6D2300B9F7
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 08:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D9B2BDC27;
	Sat, 31 Jan 2026 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b="pEqFFeTi";
	dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b="ZLJz3c7k"
X-Original-To: netdev@vger.kernel.org
Received: from cvsmtppost104.wmail.worksmobile.com (cvsmtppost104.wmail.worksmobile.com [125.209.209.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06452EA169
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=125.209.209.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769847681; cv=none; b=s8xQUSMgA95mHShQGRCBT4H6YtuVGJTffmPv0zlFkrz5H06lXa0xZwcGeSf7B7nmkJO3yPomEaLVNijpqS+nzbg94xNHCGs/hO68v8uQS6YwzgggmWGL3iNMuQMgkf7Pu0qSbde8MhnD2ixdrGMZVWNn4QCytUWPHnADI/DW1YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769847681; c=relaxed/simple;
	bh=oOtYN2kA/KhRhXaBKoweJN/C8Bl5LOclilXIlHnmYsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cbe3uAjuMpsm+8tedAzatzclVp9d5KNsfGmNYkIIX+c/Gtqx3YSXO1rVaH90uzWJANjEJZXbY5vOIRXC7R1ZVYL8KS9LStzuTfbw28sdKZnNhF1jkv5CWN1Xb4U+h7qhuDal6dmubxhhKw7j8EJinmLQ6BASq5mJV4Pt/Z8AoGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr; spf=pass smtp.mailfrom=korea.ac.kr; dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b=pEqFFeTi; dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b=ZLJz3c7k; arc=none smtp.client-ip=125.209.209.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.ac.kr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=worksmobile.com;
	s=s20171120; t=1769847069;
	bh=oOtYN2kA/KhRhXaBKoweJN/C8Bl5LOclilXIlHnmYsA=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=pEqFFeTi/6qeAnbMOn/UJyl7ZmjRLXgdXRsYVtgDBElsNa7tZHlPm+GxOaPbjxxuj
	 fRQ5TdiO8unFTNaXFklv/R5GLVg+M3uE83QzurWdrOqT/M8fq0rJ3paXShCrAjgGjJ
	 BwGNvOhvbi2Hm7KyOGNFtaE47yM9P3hr/JJIBmEryBqB0EPiOv0rxmu74VZhERjmgG
	 Lzy9+nACBX4NBOs1eNbjhn1N3zMZnsVnac3Uh0k+v3dv3ukiUJ5AJEM/ITxNfQNDPY
	 z77UdJ/JmZrnpJO1wQnak9r2YxLzDf8v4LW7f2blOI+/jH3PH4ozC/kAuOkI+9FLRR
	 b3kaxBqieuayQ==
Received: from cvsendbo003.wmail ([10.113.20.165])
  by cvsmtppost104.wmail.worksmobile.com with ESMTP id mQQgLjzkSC6nnTN2jKKnFw
  for <netdev@vger.kernel.org>;
  Sat, 31 Jan 2026 08:11:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=korea.ac.kr;
	s=naverworks; t=1769847069;
	bh=oOtYN2kA/KhRhXaBKoweJN/C8Bl5LOclilXIlHnmYsA=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=ZLJz3c7kuhUh5pbLQquVcgzqtjenTmLF5bPcrhObxefrvIStka52Daofm8741+Yfv
	 MA+C6P3if7ziqkb/eSc6jj+ngvUyOR/NkBxUvveFTJIsk3snfHYXHObvdOmDf5jSUg
	 pfMePKejgVXAdxHvUmx14ZOA+tjq4W6TZ+sYlgfk=
X-Session-ID: 3Jt6y6jxTj+sdFgQ3eE80w
X-Works-Send-Opt: kendjAJYjHm/FqM9FqJYFxMqFNwYjAg=
X-Works-Smtp-Source: g9KwaAvrFqJZ+Hm/FoMd+6E=
Received: from s2lab05.. ([163.152.163.130])
  by jvnsmtp401.gwmail.worksmobile.com with ESMTP id 3Jt6y6jxTj+sdFgQ3eE80w
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Sat, 31 Jan 2026 08:11:08 -0000
From: Ingyu Jang <ingyujang25@korea.ac.kr>
To: lvs-devel@vger.kernel.org
Cc: horms@verge.net.au,
	ja@ssi.bg,
	netdev@vger.kernel.org,
	Ingyu Jang <ingyujang25@korea.ac.kr>
Subject: [Question] Dead code in __ip_vs_init() net init functions?
Date: Sat, 31 Jan 2026 17:11:07 +0900
Message-Id: <20260131081107.2919353-1-ingyujang25@korea.ac.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[korea.ac.kr,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[worksmobile.com:s=s20171120,korea.ac.kr:s=naverworks];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255381-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ingyujang25@korea.ac.kr,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[worksmobile.com:+,korea.ac.kr:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,korea.ac.kr:mid,korea.ac.kr:dkim]
X-Rspamd-Queue-Id: 94B9AC13C7
X-Rspamd-Action: no action

Hi,

I noticed that in net/netfilter/ipvs/ip_vs_core.c, the function
__ip_vs_init() checks the return values of two initialization functions:

  - ip_vs_estimator_net_init()
  - ip_vs_sync_net_init()

However, both functions always return 0:

  ip_vs_estimator_net_init() in ip_vs_est.c only initializes struct
  fields and calls __mutex_init(), then returns 0.

  ip_vs_sync_net_init() in ip_vs_sync.c only calls __mutex_init()
  and spin_lock_init(), then returns 0.

The error handling code (goto estimator_fail, goto sync_fail) can
never be reached.

Is this intentional defensive coding for potential future changes
(e.g., adding memory allocation), or could this be cleaned up?

Thanks,
Ingyu Jang


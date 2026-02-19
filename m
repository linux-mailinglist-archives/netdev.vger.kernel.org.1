Return-Path: <netdev+bounces-259394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJnmNVR2lmkIfwIAu9opvQ
	(envelope-from <netdev+bounces-259394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 03:32:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C03215BBEB
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 03:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B941303C628
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 02:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8EE26F2B9;
	Thu, 19 Feb 2026 02:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="oW89b9MV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA4C272816
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 02:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771468345; cv=none; b=VnhvOqktUJS7pIce2B2hVqIGI9PrWl7c8zuTzaAWPYf2Ld9AtbbW/9XmZXztMW4A+1mX4PMis3Ns0FdQ+fs6bHcJEpKDr/QIKcuSCNd0+bYMip0+hGzq2KekaiiRKzkZ9DCy9qrho6o/kTJouz+jQOY9jyN8iEDjuXxBON5j4qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771468345; c=relaxed/simple;
	bh=c7Ok8iXOfSYz4v4jJ7U6j6p+rRUgu075WEHNkvllUf8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DXvUh1Pouk9X2F86gDcQYqyo6irUBVVjWFcsfusllU0ky1k7fTxESzTHQTn78mp4yvlflSq1W465Dn0qy7NQvl8nD1RLH8ksbhePcQU7Z0Y2Z7ywIgV1Fj/TbeRIMfMkzbMQojSoRdrEtjVRTVnc73VNmqxQNGApGmkTKTPPgIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=oW89b9MV; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1771468327; x=1771727527;
	bh=1YjamJ6ylCdZhUudRHXFxvvo6UfDwTK/0lEPw8J6C+I=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=oW89b9MVIgvCV+UkzcJmU81WPKRNbuRda5aKQVOuw7DwMcOm2SwTBdNtZdKM0eH1t
	 oo9U2GRjUaFk0rB3XWdOozUkusjTRgKgX867Xlp2qsHATWS89c88baObKKETrv8Rus
	 83f5sweBktGuWRXvnNyDB2xk86pVjmC4Z/UzIDrhISijUdfuWDKxH1TH/0NVHbrzKm
	 Azw2jcq95tGHn0Sy7I8TkJNv8QnTDKxA/plRHejxNVCgJPXzFUNyFowrv7WbyNPi/E
	 hpdV1YkuO8Yr//11Pjk+jW6c6PVothpmWRkUuueNLDowEEljdL9IM9VhDk3XBTIUGa
	 G0B61ftW9DI8A==
Date: Thu, 19 Feb 2026 02:32:02 +0000
To: Victor Nogueira <victor@mojatatu.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
From: Paul Moses <p@1g4.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>
Subject: [PATCH net v7 0/1] net/sched: act_gate: snapshot parameters with RCU on replace
Message-ID: <20260219023151.171753-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 938bcd6b3be7383a87fc839d38cba17fe64b1b7f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[1g4.org,quarantine];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259394-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[mojatatu.com,gmail.com,resnulli.us];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[1g4.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1g4.org:mid,1g4.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C03215BBEB
X-Rspamd-Action: no action

This series fixes a schedule lifetime race in `act_gate` between the
control-plane replace path and the running hrtimer callback
(`gate_timer_func`).

Changes since v6:
- revert gate_start_timer()
- added explicit chain_put: label before release_idr:
- kzalloc failure path changed from goto release_idr to goto chain_put
- formatting only: blankline cleanup for readability, no behavior change

Paul Moses (1):
  net/sched: act_gate: snapshot parameters with RCU on replace

 include/net/tc_act/tc_gate.h |  33 ++++-
 net/sched/act_gate.c         | 265 +++++++++++++++++++++++++----------
 2 files changed, 215 insertions(+), 83 deletions(-)

--=20
2.53.0



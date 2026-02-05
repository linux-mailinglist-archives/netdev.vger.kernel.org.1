Return-Path: <netdev+bounces-257225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAs0GFa0hGk54wMAu9opvQ
	(envelope-from <netdev+bounces-257225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 16:16:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE174F4807
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 16:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9193B302E922
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC01741C317;
	Thu,  5 Feb 2026 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="e73av8Cl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9D03EF0B1;
	Thu,  5 Feb 2026 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770304240; cv=none; b=NcOJztmvbIwf+GKSJ6iaA2XU/t5/3qRXXv/3CxnR2gI1cj7NgjuAmtsWl5wWcPLeD55SMbCpZ7zD+DxstPaoNT16xIgt0UnqHb4Uaes01FsGmyaVQmse7GY7b46sNEqTppZKB4pFC+ce6Yp5a/6kTq5tS5LC8kMGs6to13ZYwN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770304240; c=relaxed/simple;
	bh=+/oooh7MkEq7+wpFfViAxh7pOdpoD2uyi0gMO2YAsJo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FS6l89eOVj0rZ/oirDDfXRc8CY0hw2+WsPbKjc/w95/bDv5hJCkXVfua8evtfk/4xBc0XmbVUrfOoC01IALI0tstLWuN6foCAt3FIyWS9UrCT+Ez1A8T2LX5gfL2WWgJizamzn0+RC14cZ/NnAfRPPg/b3u9TmXOhfiCHRLoNJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=e73av8Cl; arc=none smtp.client-ip=185.70.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1770304230; x=1770563430;
	bh=IUi/TmfOR7R158ie7wFHBTdZ1FO3LNQ2s6W4AfG5OYM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=e73av8ClCmO0qRd/gV+KttCiaMym4uCRynYrv4fE/RLOsQT22qH12+PEc80f+s4hq
	 q8q+5KEd7vABGdIKuFHM3gt+SXT3KTpnUAbvnipk2YjrohKyySKc2mtp6Yhgp00zk9
	 TqDD+b5CXDenmRbjoySpavn/WRETBMebCu8SzUXhhPr0EHCV/rZv7kj+86bRDvdFH/
	 d8epxRSpMm4NzgCEYU5ZhXWR5dFv5LfAF41ZeJizUhM44f6/frRGZ+Z4aVQoAuvUnE
	 VXyg3TYgZzPdfQdl99d4OlKef64YOW+HVA6Eq/UXAxEc3R1D+PHsV3epgdkjCc/QX8
	 rnD6oIDDMLapw==
Date: Thu, 05 Feb 2026 15:10:23 +0000
To: Victor Nogueira <victor@mojatatu.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
From: Paul Moses <p@1g4.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>
Subject: [PATCH net v5 0/1] net/sched: act_gate: snapshot parameters with RCU on replace
Message-ID: <20260205150958.412278-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 5f8e9bb3f7058715a9a8b10173b59934561778d3
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1g4.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257225-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[mojatatu.com,gmail.com,resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[1g4.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AE174F4807
X-Rspamd-Action: no action

This series fixes a schedule lifetime race in `act_gate` between the
control-plane replace path and the running hrtimer callback (gate_timer_fun=
c).

Changes since v4:
- Drop the gate_clockid_to_offset helper, validate clockid once, and set
  tk_offset in one place.
- Seed missing attrs from the old params when entries are replaced
- Reimplemented the timer cancel from RCU snapshot and cancel before taking=
 tcf_lock.
- Reuse a single protected deref under tcf_lock
- Compare old/new values directly in gate_timer_needs_cancel()
- Cleanup no longer assumes rtnl_lock

Paul Moses (1):
  net/sched: act_gate: snapshot parameters with RCU on replace

 include/net/tc_act/tc_gate.h |  33 ++++-
 net/sched/act_gate.c         | 266 ++++++++++++++++++++++++++---------
 2 files changed, 228 insertions(+), 71 deletions(-)

--=20
2.52.GIT



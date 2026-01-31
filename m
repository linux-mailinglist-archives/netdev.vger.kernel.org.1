Return-Path: <netdev+bounces-255448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGzdKewbfmn5VgIAu9opvQ
	(envelope-from <netdev+bounces-255448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 16:12:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB96C2A4A
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 16:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A50E300A8C4
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955512F0C45;
	Sat, 31 Jan 2026 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b="TrVi/VSi";
	dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b="AvTeZz/l"
X-Original-To: netdev@vger.kernel.org
Received: from cvsmtppost102.wmail.worksmobile.com (cvsmtppost102.wmail.worksmobile.com [125.209.209.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3D676026
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=125.209.209.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769872344; cv=none; b=VfrrOiUg0MiswaBLUYty+/bGLztZj0N76mBFsnLQJHs6fe+Bgos3jcInpvG16fGlmFSFEz2Gf+bw1/FwLSsOOWwbb63awb8VUvRzS3P7eDGVqn/hInhY54V4lJgzMhgOs7MBZFYLq2wgsVUcwUjce4RRb33GJi3cZ3yIxchPYZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769872344; c=relaxed/simple;
	bh=ciCf9zWxPZMOZBBnRub5O+kI9eVweIpwhRVBGgBcsCk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VCSsQm+O/CktfatAcBTWMCifA/31etqJ0ZyBH5StLy9a+AxWY8KZsNMpxqwSWr0SBOi103gaB6InaeDP4WhIbSxYCHilN7Oyl2c3pjV/oAyS7kQr9gFpt35OXoYmwrHV1gTyS7XlxuRDE8wQAYVTqonQzAfttHhmhoyhqZ91biE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr; spf=pass smtp.mailfrom=korea.ac.kr; dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b=TrVi/VSi; dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b=AvTeZz/l; arc=none smtp.client-ip=125.209.209.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.ac.kr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=worksmobile.com;
	s=s20171120; t=1769871732;
	bh=ciCf9zWxPZMOZBBnRub5O+kI9eVweIpwhRVBGgBcsCk=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=TrVi/VSie5OKj5eaRUSjA3B2ffIdnlPI3HtX+mjMyB/wgMBL83mJIeMGnYPVOcVdu
	 XcF0Vdk12OkAuqc0e3QgUX905b+aJPZncwXrAPOuiNocVWr3V7O3/Y4wQvSX7IAYmu
	 zSlbE9pUpT6wB6EYn+jUAG3jN90mgyvkpz1SrbCW8Pog2FGMq9CB4H7E3HD0hsej9d
	 1EE176fI73yAebPnm03Q2QhWvWYoIw4YgOKSeS5zBNAvHA9yTNh6OYZD0PcuoLTb4r
	 hRv5G3AMfqgyVCh/0uYlqJobp7U/MTq/HNpuxYUwG1IUfl5K4KWoy57L3vKFUTdyrJ
	 h2eqv2fAFBaHQ==
Received: from cvsendbo004.wmail ([10.113.20.173])
  by cvsmtppost102.wmail.worksmobile.com with ESMTP id tjmlbN4ISeqwiP7cNhoRKA
  for <netdev@vger.kernel.org>;
  Sat, 31 Jan 2026 15:02:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=korea.ac.kr;
	s=naverworks; t=1769871732;
	bh=ciCf9zWxPZMOZBBnRub5O+kI9eVweIpwhRVBGgBcsCk=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=AvTeZz/lMOKdVz7HHIdPDgDwESS0cbNVlC0x7ZY7eFz9VJmLiArJSaW7ueEr3VSEA
	 N33uLL8SCJrGCW7/2VYbG7XitiO52uqMHfr7ThNmtLtmGatDY+AxDaO1m358E2G+nS
	 +FcXDPaXkRWQgjVf4lWl1HFLYGNtGo9lmuReyuaE=
X-Session-ID: hJBwT7RFQOqptNZpQGn8yg
X-Works-Send-Opt: kendjAJYjHm/FqM9FqJYFxMqFNwYjAg=
X-Works-Smtp-Source: VqbqaAvrFqJZ+HmZKqKl+6E=
Received: from s2lab05.. ([163.152.163.130])
  by cvnsmtp103.wmail.worksmobile.com with ESMTP id hJBwT7RFQOqptNZpQGn8yg
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Sat, 31 Jan 2026 15:02:12 -0000
From: Ingyu Jang <ingyujang25@korea.ac.kr>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	Ingyu Jang <ingyujang25@korea.ac.kr>
Subject: [Question] Dead code in rawv6_mh_filter_register()?
Date: Sun,  1 Feb 2026 00:02:12 +0900
Message-Id: <20260131150212.3292929-1-ingyujang25@korea.ac.kr>
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
	TAGGED_FROM(0.00)[bounces-255448-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,worksmobile.com:dkim]
X-Rspamd-Queue-Id: 1DB96C2A4A
X-Rspamd-Action: no action

Hi,

I noticed that in net/ipv6/raw.c, the function
rawv6_mh_filter_register() always returns 0.

The function (at line 117) simply performs:
  - rcu_assign_pointer(mh_filter, filter)
  - return 0

However, in net/ipv6/mip6.c, the function mip6_init() checks the
return value and has error handling (at line 381):

  if (rawv6_mh_filter_register(mip6_mh_filter) < 0) {
      pr_info("%s: can't add rawv6 mh filter\n", __func__);
      goto mip6_rawv6_mh_fail;
  }

Since rawv6_mh_filter_register() never fails, this error path
appears to be dead code. The same applies to
rawv6_mh_filter_unregister() in mip6_fini().

Is this intentional defensive coding for potential future changes,
or could this be cleaned up by making these functions return void?

Thanks,
Ingyu Jang


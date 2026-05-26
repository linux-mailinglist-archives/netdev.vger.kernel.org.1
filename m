Return-Path: <netdev+bounces-291788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBfyJo/FFWqxawcAu9opvQ
	(envelope-from <netdev+bounces-291788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:08:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 424915D957B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 099753011783
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5960379973;
	Tue, 26 May 2026 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9gnwBMV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFC5379ED8;
	Tue, 26 May 2026 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811324; cv=none; b=Dr/8xCqu5dg++vE5PYBU/dQxG/oe+b81pjdOJQhrY41BqMgq+ziDE1ap+nNk+hEmUBpA5bUPY1zR6GXXCPd+ZoDWHWE+HvIMp99OYCnLcmL4F3QNPSCZe7qeisXjf8DL/ZCvk3PRTJc6q08G07XoxE/0QE2WAcv8ojxziibwpyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811324; c=relaxed/simple;
	bh=0Vb+bfle9daNKXh0r/ZjSzpXTi3DvD6dhAaNfFpR1X0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tS9jcNMp+ckAf8carxzIJ0D0scYsQMKCCoTBcO+vWZ1SAwaRVrZ4wfK7DRu39lGI3NVFYiNSvFFquog8v3UOAMCvY+wT+7tl1+RjqE+/bi7vRKyN1OqpUIdh72Vo8N1+vgQZuK7RiEdhw/6ba8Rp3IuPTsThdf5c/g34emCngXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9gnwBMV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5FE1F000E9;
	Tue, 26 May 2026 16:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811323;
	bh=8j/SyKyMypxsZ6cIR9H5pNObWxnYwfSeiYCHDRK/N34=;
	h=From:To:Cc:Subject:Date;
	b=A9gnwBMVKR+Dbo2spBPnURFVPwFNX9Ur19aUMbdUshNWtZoJDcCdTDY7AsdIrsnHF
	 7nzYtY23mPgFki9/YpO5gBITKHLutafqZ9yjR+TkvpL5BcwIc897jUuk90x/tQJREr
	 HnSH+oeJQ+Jz9H5PQJ+BknZUaH5sDAWv7kuQ2HbfrkOS+YdmMKN5D7MgpE9a0olKuK
	 C3w62rm2MRFLhJgn3ikzRhMkX18xPIQ4iL+QscXoGNDcxS6L3EM6V+O0kXgnuqPoIE
	 Szq/RCVZY4+k9mpLkwb4NKlwDWXA8fcwUJAYlJ4/3zpCMzQC3BbVNgSLKiqrR/p4nq
	 8+caNEx+3ZvHQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	corbet@lwn.net,
	vladimir.oltean@nxp.com,
	willemb@google.com,
	sdf.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	jesse.brandeburg@intel.com,
	linux-doc@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 00/10] docs: net: updates for old and cobwebbed docs
Date: Tue, 26 May 2026 09:01:41 -0700
Message-ID: <20260526160151.2793354-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,nxp.com,gmail.com,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-291788-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 424915D957B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm hoping to start feeding our docs into the AI review tools, instead
of maintaining a separate repo with review prompts. To experiment with
that we have to refresh the docs a little bit.

A read thru our current docs makes one slightly question the value
of including them in reviews. But directionally, I feel, it's probably
still right. I'm hoping the Rx Checksum section about not dropping packets
for example to be impactful. I don't think the current AI agents or
review docs include this guidance.

Jakub Kicinski (10):
  docs: net: netdevices: small fixes and clarifications
  docs: net: fix minor issues with driver guide
  docs: net: statistics: fix kernel-internal stats list
  docs: net: update devmem code examples
  docs: net: fix minor issues with the NAPI guide
  docs: net: refresh netdev feature guidance
  docs: net: fix minor issues with checksum offloads
  docs: net: add Rx notes to the checksum guide
  docs: net: render the checksum comment in checksum-offloads.rst
  docs: net: fix minor issues with segmentation offloads

 .../networking/checksum-offloads.rst          | 67 ++++++++++++-------
 Documentation/networking/devmem.rst           | 27 +++-----
 Documentation/networking/driver.rst           |  7 +-
 Documentation/networking/napi.rst             | 11 ++-
 Documentation/networking/netdev-features.rst  | 60 +++++++++++------
 Documentation/networking/netdevices.rst       | 31 +++++----
 .../networking/segmentation-offloads.rst      | 37 +++++++++-
 Documentation/networking/skbuff.rst           |  6 --
 Documentation/networking/statistics.rst       | 19 ++++--
 9 files changed, 172 insertions(+), 93 deletions(-)

-- 
2.54.0



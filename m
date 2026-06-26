Return-Path: <netdev+bounces-302136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QiTsBuhMPmrNCwkAu9opvQ
	(envelope-from <netdev+bounces-302136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 11:56:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7526CBDEB
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 11:56:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=YTvn0uMW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302136-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302136-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1BBE301275D
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 09:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F083E9C3C;
	Fri, 26 Jun 2026 09:56:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E533BB66C;
	Fri, 26 Jun 2026 09:56:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782467809; cv=none; b=LxeS7WnxAdK+zT8DgpyAXsdji+4KSUKUB5EYT2CrKCJVfn82JE3yB7r6qTGlKvzR8jZrBvBLOMixqrc8pIGtX1BGphkZWg8XjsY4gSfbRrNuAxuI87w8tFh04ftOnNob9eNuo1DQpZvhTfP5WiT5RYWjkp2e/13mkJgXdtdaGlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782467809; c=relaxed/simple;
	bh=RE0qhOfkQ7ruenyzlEj7Bxrp/hmm+5LmZjxXe8hCEhM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kpMRKAgAM/ylzHvkmQ3f+h7yztj2Me8J71HG3ZqWuFwG48F8Dp9QcpTKCUiFA3oFRXpb9VFk8CJ2yVM75shG9K150obigW/zjsA5V9ar4IlY0PoWCyUgvyFKeOqBS39Al7raReUuL1i+xgtDVuFbe+gnZ7wswo2j2st8pKiZMWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=YTvn0uMW; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=PRjTLPlPgo4RP++aNKoyqSFzF5p07vlm/FWH4+ncEtw=; b=YTvn0uMWt750zGg234gGUAVN7X
	LWkp3LeykRqkJumToA5aojtkKJSYnrjisD72fARWxKnZaPAJo6g3mnuO1DveLBo7hiNmf/KK7GYSb
	dj+3REQZHHnhx3RzLlznr8PdcGeYv3Bl0nET1BrUnoFNLUu3Xqz4rQLGfsZXNWrJIMZA4sYF03/AZ
	VuY2wx6XtWua6K/LoSD/iz4eG6xMLIVACguZDf0wU4ram5A739/cZKMcEN7axoOt/6oqgBDNATGwa
	D3pCB318HoLQwcmGabF4HWG4WvIKIxLmD9DuLX4Ujt2CLKI4T7W3C7wJs9yi8kXsRBshtRu/Jd0YP
	IPgzfzjg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wd3Ie-003t3h-3C;
	Fri, 26 Jun 2026 09:56:41 +0000
Date: Fri, 26 Jun 2026 02:56:34 -0700
From: Breno Leitao <leitao@debian.org>
To: linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel-team@meta.com, linux-mm@kvack.org
Cc: Breno Leitao <leitao@debian.org>, kerneljasonxing@gmail.com, 
	iipeace5@gmail.com, gavinguo@igalia.com, linux@jordanrome.com, amscanne@meta.com, 
	sj@kernel.org, gpiccoli@igalia.com, Daniel Gomez <da.gomez@kernel.org>, 
	mfo@igalia.com, platform-driver-x86@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Subject: [ANNOUNCEMENT] LPC 2026: System Monitoring and Observability
 Microconference
Message-ID: <aj5KJEIsTl6IK0nX@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302136-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-acpi@vger.kernel.org,m:linux-hwmon@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:kernel-team@meta.com,m:linux-mm@kvack.org,m:leitao@debian.org,m:kerneljasonxing@gmail.com,m:iipeace5@gmail.com,m:gavinguo@igalia.com,m:linux@jordanrome.com,m:amscanne@meta.com,m:sj@kernel.org,m:gpiccoli@igalia.com,m:da.gomez@kernel.org,m:mfo@igalia.com,m:platform-driver-x86@vger.kernel.org,m:acpica-devel@lists.linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[debian.org,gmail.com,igalia.com,jordanrome.com,meta.com,kernel.org,vger.kernel.org,lists.linux.dev];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[19];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D7526CBDEB

We are pleased to announce the Call for Proposals (CFP) for another
edition of  System Monitoring and Observability Microconference, this
time at the 2026 Linux Plumbers Conference (LPC), taking place in
Prague, Czechia, from Oct 5-7, 2026.

  https://lpc.events/event/20/sessions/262/

This microconference provides a valuable forum for key engineering areas
such as:

   - Kernel Health and Runtime Monitoring
   - Hardware Integration and Error Detection
   - Correlation of Issues (crashes, stalls, bugs)
   - Virtualization Stack Monitoring
   - Memory Management Monitoring and Observability
   - Anomaly Detection Algorithms for System Behavior
   - Automated Analysis, Remediation and post mortem analyzes

The purpose of each talk is to share challenges and discuss potential
improvements. Sessions will last 20 to 30 minutes and aim to encourage
brainstorming and open dialogue about ongoing issues rather than
delivering immediate solutions.

The conference acts as both a knowledge-sharing platform and a strategic
venue for guiding the future of kernel technologies to better meet the
demands of large-scale infrastructure.

We invite you to submit your proposals here:
	https://lpc.events/event/20/abstracts/

Please select track "Linux System Monitoring and Observability MC"


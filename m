Return-Path: <netdev+bounces-295233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id or3UD2h3IWrXGwEAu9opvQ
	(envelope-from <netdev+bounces-295233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:02:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA36F640258
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:02:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=riseup.net header.s=squak header.b=VoAQi4CK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295233-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295233-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=riseup.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6E2830416CB
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 12:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AED478E28;
	Thu,  4 Jun 2026 12:54:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82888402BB1
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 12:54:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577682; cv=none; b=IFpzUrB97hboGdt6bPoVmKgGJcfo83VIOODVFrOST+4SAyVgUPyhsdaS1447OcebQenAiGS6T9/COth5coW7IgAXkHFSgiU8gPiKIknG3Fm3gGVoWcKcgf0rAlXcGFCEvAjqFHmodgcGe24sT6KxE5LwjeVcK/SuSIfEKR2Gw1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577682; c=relaxed/simple;
	bh=8vbOIbpxtv5/SwgOcEPbDAd4aBFnRTK+DSf6GjRlfLA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=QU/yGjrFaL/Kb56s22l3tKURXFbsFC2sUhwD/Lq6vL6pHbCrWGUomkmmCOrg/Twe2VPLZXbug6V48sbKRs/MYJin4k5704bgleMmAVrXvM9uqmeUYayY1F8geCulh0Dd+wsm3RqmKkLfiSoMvMs65W2stTznFDesAn6guBl3H+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=VoAQi4CK; arc=none smtp.client-ip=198.252.153.129
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4gWPV34B2TzDsTR
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 12:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1780577243; bh=UZ3UnbOw9o0qfUbZ/k9TATPouz1S1OJahKNqU+lwhCY=;
	h=Date:From:Subject:To:From;
	b=VoAQi4CK05/pzC4j0rmtEZCN86F7jM5fmhnB1u+AyTmL3waFt0kCDBMFpyrQF5HvT
	 Ss3J3RfPaK09lUUyenQinYgCE5KdCnUaLo7DoQilXjj/myIohbIHY4D2qNErUf1NhY
	 CbhZnWl3kaH2eiP8kcus8h/Xib3g6mzMLycAs9NU=
Received: from fews04-sea.riseup.net (fews04-sea-pn.riseup.net [10.0.1.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4gWPTx4JyZz9s76
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 12:47:17 +0000 (UTC)
X-Riseup-User-ID: 370806BE397B9D5595A66A45481B322E0EE2CC8ED9E8D081A0CB890A7D3FD319
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews04-sea.riseup.net (Postfix) with ESMTPSA id 4gWPTx18fYz5vMb
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 12:47:16 +0000 (UTC)
Message-ID: <e69b2aeb-0fb0-44a3-89b2-e4ddee16dbf2@riseup.net>
Date: Thu, 4 Jun 2026 14:47:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: DrRac27 <drrac27@riseup.net>
Subject: [BUG] No cgroups in network namespace
Content-Language: en-US
To: netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[riseup.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[riseup.net:s=squak];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[riseup.net:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295233-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[drrac27@riseup.net,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[drrac27@riseup.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA36F640258

Hey,


I think I found a bug and wanted to let you know. If I create a network 
namespace and enter it using iproute2 I can't use cgroupfs2:

$ sudo ip netns add testnetns
$ sudo ip netns exec testnetns stat -f -c %T /sys/fs/cgroup
sysfs
$ stat -f -c %T /sys/fs/cgroup
cgroup2fs

Is this to be expected?

I can reproduce it on Debian 13/12 as well as Arch Linux.
If I enter a network namespace via systemd.service (5) using 
"NetworkNamespacePath=/run/netns/testnetns" I get my expected output: 
"cgroupfs2" instead of "sysfs" (tested on Debian 13).

First reported here: https://github.com/systemd/systemd/issues/42461


Regards,
DrRac27


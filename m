Return-Path: <netdev+bounces-303277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Zi6ECN3fQ2pokwoAu9opvQ
	(envelope-from <netdev+bounces-303277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:25:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF08F6E5E8A
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:25:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=W6u4nN9z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303277-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303277-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACB94301BCD5
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB57C372071;
	Tue, 30 Jun 2026 15:25:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4F3371CF4
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:25:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833110; cv=none; b=j2PNBOoTJq/rQg27J3w+MSBoFiP1K4MAM3wBaT7URffsNZy7FXu+Mu7E1/SwV/wWeV3E14LVuM6zZJJxqNZS3Z9ZPjyJuBLD2avaWsmaIMfunZdHMw69w/Iya6OWFGKWsFEITUY3eTS167TZKVBJbSFKrMS6ZJZAu4IC03iQZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833110; c=relaxed/simple;
	bh=/Xr3mJY2YX9Pv8+HY63KWc65qLJGHcEpnZbGJQu5Nws=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=uX5YuAyfjTzNDbaFJVQo97DWo1ZFGGq4kYD1MMlxsfYhuJT8QHHGXEQHU/+8Ekv+3rCk+89wzV71H0sElCza/NsifLxmCL4rOSZD4wgME6y50t/T8ZHAJThfrAJUcSVxlx0C6vBMIT1S9vIl15Z/J5Uj38eIr4HwOuge/2Lvva8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6u4nN9z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4AF1F000E9
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782833108;
	bh=VFqtrGwvT83GQsSUwVKl1j3l2jtS4zEWULwdCTKY038=;
	h=Date:From:To:Subject;
	b=W6u4nN9zPKhVBgfyINFsm3iWEhh/nu3HfEvhyfC2PUQT/yPywyWsqIK2/8f2lM4ID
	 8d0f2UbnIiAlsP7+ZmlYf44NhcAN5IXZp6qemSHsDQSMOeOSXu/TnPP8EMsujvmKB5
	 3e+xxTJ3iwBVMZuUnANmznHtqDJZpYAn+7sVWdsF3W7WJxbDwriMoK/GNLT0gbdAFi
	 DTh9iX3yl8G/5vs+8I29LFJxgkAySpDjtTaoSoJsjZD+Z4JTuzXP5fknCZ7IPqRE56
	 nB2WFp8FBym///PhDmazICKj2NWr4CFugcnlYrMbrnG0KJvQFbFQnjRzC5zaJoNKOq
	 scgkf8BlyVdgw==
Date: Tue, 30 Jun 2026 08:25:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] netdev foundation TSC meeting notes - Jun 30th
Message-ID: <20260630082507.6109b0ca@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303277-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF08F6E5E8A

Present: Eric, Jakub, Johannes, Kuniyuki, Simon, Willem, Paolo

Academic Research program
  - Revised with:
    - Limit of USD 50k/grant
    - Simon as email contact (happy for an alias to be created instead)
  - Contacted board for funding approval, expect them to meet in
    coming weeks to discuss 

Netconf: 
 - on the first day of Netdev 0x1A. 13th July
 - Have room for ~20 people
 - Finalizing invites today / tomorrow
 - Driver upstreaming challenges, some drivers reaching v50
   - May be more suitable for a broader discussion / driver BoF?
 - Foundation sponsorship for a meal
   - Double check what netdev.conf has planned

Logo
 - Some delay in paperwork due to the complexity of it
 - Now aiming for LPC rather than Netdev
 - Comments on the draft sheet
   - Mesh in the background would be good to represent networking
   - Yes on tux, otherwise the logs are generic, but need a distinct one
   - A voting sheeting to grade the suggestions to be circulated

Wireless CI running on netdev foundation infra


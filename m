Return-Path: <netdev+bounces-259861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id q4yGF8iwmmmvgAMAu9opvQ
	(envelope-from <netdev+bounces-259861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 08:31:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9858D16E987
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 08:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C00B93011F39
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 07:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FB84204E;
	Sun, 22 Feb 2026 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="HT6A3GUE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-106109.protonmail.ch (mail-106109.protonmail.ch [79.135.106.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5A7125A0
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771745477; cv=none; b=E/+v1/PL8wUIc4/XO5joaqy8l6ybUSCEE5cLWmhxtWgSuuTudQdovXpH2CLQzzppFHgLaVpAvRlGEX58XR0xjI9pVQPdY3gMrRQeZHM5sn0bS6oyNDXrgYLwzCSo5BQkAyTd3qgTTJFuHj2hoiE2tMtV4ReFMmZJKRYGTb8y/qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771745477; c=relaxed/simple;
	bh=GVeFrkGHd+zJB2J+eJLlpvF6zIS8Ee40GUUMdEit+MM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cZEFBqYAxBthbaxDy8Pz+U5ls+W0671bxmhyqbwFs1rrFVLaI1Vees3tMKvRGFcJDUbJ00JwRZZ0/Cn7MDmdcd6ZKFsDY8QoD8skobA4/SKz1ia1QtHzYQEA+tiLC52dh9AfpYiHHfzVaqmL9DPib6jw/aHgFmbmjGnOlswxjjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=HT6A3GUE; arc=none smtp.client-ip=79.135.106.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1771745083; x=1772004283;
	bh=GVeFrkGHd+zJB2J+eJLlpvF6zIS8Ee40GUUMdEit+MM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=HT6A3GUEdkgaLJGiffeeMLiag+fuXSaOpFWgVBxOrZNQiYi4DuWSUqiabW2MTf20/
	 BrvT9IqJFDeU8K3/x9kGLj4QZhrTJt/CdSdhPSdBkzoolHYgkIUQH97duHFfOZakwN
	 sEOSenjnEAIBSPBDgkNpSRynfq7X19kbsIvG9UG+fQgRXE0ouYB/KuEvpOaStap0Lu
	 TXpA70pWqUNhFGcbK++0kAQdpKYo1x1yETcM+q55rx4BWFFheaYuD68HOobDdEmCvm
	 jxOP1IaPsPUp0HPRAgIgWOnDMcx4kPDCOxDR7Sg1ljlxRIExrQRXhGkG/aTLKt2R6K
	 gb6ipnYbcV7Jw==
Date: Sun, 22 Feb 2026 07:24:39 +0000
To: Linux Networking <netdev@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Amazon: AI-assisted hacker breached 600 Fortinet Fortigate firewalls in 5 weeks
Message-ID: <-3q0eXE17223SaU-QV1MZw-y7iuKwRWlAEDY59A_b3dTEOt2tAUFIzm7fStrtegUi2ltMFj3wsEY7WbcilJwlX9K86JsWQLmmlRktcRaKRM=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: 156dc498a4f6fce3f4934976d951f66845ce1cf6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-259861-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[protonmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[teo.en.ming@protonmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[protonmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bleepingcomputer.com:url,protonmail.com:mid,protonmail.com:dkim]
X-Rspamd-Queue-Id: 9858D16E987
X-Rspamd-Action: no action

Subject: Amazon: AI-assisted hacker breached 600 Fortinet Fortigate firewal=
ls in 5 weeks

Good day from Singapore,

Here is a news article which I would like to share.

Article: Amazon: AI-assisted hacker breached 600 Fortinet Fortigate firewal=
ls in 5 weeks
Link: https://www.bleepingcomputer.com/news/security/amazon-ai-assisted-hac=
ker-breached-600-fortigate-firewalls-in-5-weeks/
Date of article: 21 Feb 2026

Thank you.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Extremely Democratic People's Republic of Singapore
22 Feb 2026 Sunday 3.24 pm Singapore Time







Return-Path: <netdev+bounces-263278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IENpFRn+pmkKcAAAu9opvQ
	(envelope-from <netdev+bounces-263278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:28:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2DF1F299C
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C33903169A86
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 15:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF1A481AA5;
	Tue,  3 Mar 2026 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="idvaSmB6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24427.protonmail.ch (mail-24427.protonmail.ch [109.224.244.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB0648A2BD
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772551314; cv=none; b=GUREZEAFT+yzLNHGJF7yVXyu3c2qfAn0gC9qxdvleO7kzHln8iV9wSvCBadMsmqxsGnxlqRgjlXmv3lgo1ovTU8BSeO0kQZLLCaheYxUDQREDfVXehYiuBHs8217qtoY/APQ9KdraZWIuR5DQLl/5rcq1+yPa5eUyEbvUkuSIW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772551314; c=relaxed/simple;
	bh=EZIT+VNL1KG9YbfUnPBc0LhQZfytmwUhJSnP1k3UJtQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=NX2R0guIsFRLXujfNoJZQppqxh0g6IygeWED0U9h4s938Kf8yYKeoDyF7pNRpUzgdwclYiUqVnRzTVS7SsvmQiQapaa37LcF6iH+IryCPuG3IYWMgyqWZLj88ZU9bV+3TWYgAF2NiU6IF3C3ORsXbpeSxLE2a2GmdJKcjaFKM20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=idvaSmB6; arc=none smtp.client-ip=109.224.244.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1772551305; x=1772810505;
	bh=EZIT+VNL1KG9YbfUnPBc0LhQZfytmwUhJSnP1k3UJtQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=idvaSmB6OmPUZU1yHnpao7Pg+Di9GBM6fxjC+oPU84A6oFkslCe+wWRZgyQC4RPmv
	 xY7ehrW79aIxzkmR2+207WieuhdEv+kxnsKeu4iQd+qgz/bGg92B7A6rKS7FiTHrJH
	 UKy5KiFbOYrhfd05OSRpV7atV3eRcr9NuXCZfoffBPGASAR8pkDJiacjb06e7dwud7
	 bGOLUNpy3XO580UIFyUfm7STG4GpLjd/H2XBQfhbABfNTObRcRKIPD5/WoBD27+Nex
	 GKbNOoN25T6Iv7OTT6OzBXwJcSQfjO52O8WM5M21hSIbDnbaa7y2uf61g0gsGZPEeb
	 XBWzuW1kYHt+Q==
Date: Tue, 03 Mar 2026 15:21:42 +0000
To: Linux Networking <netdev@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: nmap port scanning commands 3 Mar 2026 Tuesday
Message-ID: <s8BZ4ns00wPBZEbsgBWUK5eBpQbqy5HJzBIbW7-IwO-JFYnTRPfitESS-6M7MUXEFiZitAVL0RR0i6JmxmNl-Yj72CLpSib83bhwgQzk3wY=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: 77d9b70bc19e51ef49851f60bac054b6a6e52a78
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AF2DF1F299C
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
	TAGGED_FROM(0.00)[bounces-263278-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[protonmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[teo.en.ming@protonmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[protonmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,protonmail.com:dkim,protonmail.com:mid]
X-Rspamd-Action: no action

Subject: nmap port scanning commands 3 Mar 2026 Tuesday

Good day from Singapore,

[01] nmap command to scan all 65535 TCP ports

nmap -p- -sS -sV -O -T4 -vv public_ip

What Each Option Does

-p- =E2=86=92 Scan all 65,535 TCP ports

-sS =E2=86=92 TCP SYN scan (standard for firewall auditing)

-sV =E2=86=92 Service/version detection

-O =E2=86=92 OS detection (helps verify what=E2=80=99s exposed externally)

-T4 =E2=86=92 Faster timing, fine for Internet audit

[02] nmap command to scan all 65535 UDP ports

nmap -p- -sU -T4 -vv target_ip

What Each Option Does

-p- =E2=86=92 Scan all 65,535 UDP ports

-sU =E2=86=92 UDP scan

-sV =E2=86=92 Service/version detection on open UDP ports

-O =E2=86=92 OS detection

-T4 =E2=86=92 Faster timing

[03] nmap command to scan list and range of TCP ports

nmap -sS -sV -p 22,80,443,1000-2000 -vv target_ip

[04] nmap command to scan list and range of UDP ports

nmap -sU -sV -p 53,123,500,1000-2000 -vv target_ip

Please remember to use Verbose Mode -vv.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
nmap scan - Aggressive Mode
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

[05] nmap command to scan all 65535 TCP ports

nmap -p- -sS -A -T4 -vv target_ip

What This Does

-p- =E2=86=92 Scan ports 1=E2=80=9365535

-sS =E2=86=92 TCP SYN scan

-A =E2=86=92 Aggressive mode (service + OS + scripts + traceroute)

-T4 =E2=86=92 Faster timing

[06] nmap command to scan all 65535 UDP ports

nmap -p- -sU -A -T4 -vv target_ip

What -A Does in a UDP Scan

-A enables:

-sV =E2=86=92 Service detection =E2=9C=85 (useful for UDP)

-O =E2=86=92 OS detection =E2=9A=A0=EF=B8=8F (often unreliable with UDP-onl=
y scans)

-sC =E2=86=92 Default scripts

--traceroute

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
Explanation for Aggressive Mode
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

The -A (Aggressive) option in Nmap automatically enables:

-sV =E2=86=92 Service/version detection

-O =E2=86=92 OS detection

-sC =E2=86=92 Default NSE scripts

--traceroute

So you do not need to specify -sV and -O separately if you use -A.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Extremely Democratic People's Republic of Singapore
3 Mar 2026 Tuesday 11.18 pm Singapore Time





Return-Path: <netdev+bounces-260344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id twvXNMI7nWkGNwQAu9opvQ
	(envelope-from <netdev+bounces-260344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 06:48:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD26182325
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 06:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B297303B7CA
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 05:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3640D28850D;
	Tue, 24 Feb 2026 05:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="iuleetIs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129283B28D
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 05:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771912127; cv=none; b=KGrS/Dx16BYu/1di1QXLz19wXvFnDx5f2AhAepBDNBx718AILL+QGppnIGkh+yesshUtZnRoYMT0PQwRQenmqCp2zzR0ExwWmV5B3ikGZRjdmP6/fDkEFK0fKTdoNrupR+DbvewXCkY4CyxqxXfdBqIe+KZd8YgiZ4aV8UKzO7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771912127; c=relaxed/simple;
	bh=0Q471xwsnKyVoTUiMO69hpGua7m4f0Ja5TcM6Wb5mA8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Oljt9fPs6Goo6D72mI1munO1Jmn4fwM2p5XFcix/a/bqurs3ANEhDrkGTI56C4MgetLWpOq0Gmc+uaw15/HEZeukeusjIAuw5xOnAz/Kvko1MQ8ClIwJJwirCnElEOeABXPxliX6u+2PlIRbI0uSA/Xv+GXo7kWtDJ5YvXLEXI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=iuleetIs; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1771912123; x=1772171323;
	bh=0Q471xwsnKyVoTUiMO69hpGua7m4f0Ja5TcM6Wb5mA8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=iuleetIsQcOfPwcHueD72lEMEs4nf0k2SPJ16o1tZZxGt+P6FZgcNOGOcjcoW95Iy
	 aL8jv+w6hZTaTK4a4Ntz3tLmrsLQIR451x+vyYSInc1mwt1fMRnBMXMSixi3K7orXn
	 mJe2ZUu99qdlF+Z9bnTK3ngfNAHPVLPkhXYRuEipuuTp5yC3XxHY8mbwRKM6Dc8GHW
	 f6BnVKjbIxPyq9fQ7/PNOXededZU1CAndLFD/49wpyv1a2qaBB1CP4p5XWoeowXU7r
	 6ji9OqqcDxuvtUuLrDqRycpNgM8UZurHmt9kZOI5kiOGjhb9V6RS16bmJ/vOKIoTza
	 83Gm5S7UpIVhg==
Date: Tue, 24 Feb 2026 05:48:38 +0000
To: Linux Networking <netdev@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: nmap port scanning commands 24 Feb 2026
Message-ID: <VjZr3xTDnBNHKNkguI2aqodaIwdUBSrREdUYlDJv_tYkFkDytkaKQjpPQPrIf6PsE5QTJMFqug6uIfV5pBwsRD7-UvFybNopn2Q7HjFXoUg=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: 33990e3f68d351e01b48f3c25b86d8b9ae949e7c
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
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-260344-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[teo.en.ming@protonmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[protonmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[protonmail.com];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 1AD26182325
X-Rspamd-Action: no action

Subject: nmap port scanning commands 24 Feb 2026

Good day from Singapore,

[01] nmap command to scan all 65535 TCP ports

nmap -p- -sS -sV -O -T4 public_ip

What Each Option Does

-p- =E2=86=92 Scan all 65,535 TCP ports

-sS =E2=86=92 TCP SYN scan (standard for firewall auditing)

-sV =E2=86=92 Service/version detection

-O =E2=86=92 OS detection (helps verify what=E2=80=99s exposed externally)

-T4 =E2=86=92 Faster timing, fine for Internet audit

[02] nmap command to scan all 65535 UDP ports

nmap -p- -sU -T4 target_ip

What Each Option Does

-p- =E2=86=92 Scan all 65,535 UDP ports

-sU =E2=86=92 UDP scan

-sV =E2=86=92 Service/version detection on open UDP ports

-O =E2=86=92 OS detection

-T4 =E2=86=92 Faster timing

[03] nmap command to scan list and range of TCP ports

nmap -sS -sV -p 22,80,443,1000-2000 target_ip

[04] nmap command to scan list and range of UDP ports

nmap -sU -sV -p 53,123,500,1000-2000 target_ip

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Extremely Democratic People's Republic of Singapore
24 Feb 2026 Tuesday 1.48 pm Singapore Time







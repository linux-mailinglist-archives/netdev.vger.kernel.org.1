Return-Path: <netdev+bounces-260722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAdeFmxcnml3UwQAu9opvQ
	(envelope-from <netdev+bounces-260722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:20:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC5F190D5A
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E85B0318FF02
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DA426CE39;
	Wed, 25 Feb 2026 02:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="VrPOW2h4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-106101.protonmail.ch (mail-106101.protonmail.ch [79.135.106.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3677C1FE45A
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 02:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771985525; cv=none; b=SXq0kDXdL/SGDwoe5QWT+W/Lsx4ZhcW9UyHCPXWohU+GmgJh3jPoCr9+dvQf8UCuj7EabzO77XAMMA7NNo+xL4n8ypg7n1wg42RjcHOm2/2bNosZDqC7urhXXwCseyLoJ/LI/5k2OYp/Ascvh65HxiaHVMzTxKM8LidEnaJd9Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771985525; c=relaxed/simple;
	bh=igQlCcJjveTSd4HMVaRsubbsY6JwCSFyX08budxIONc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Vtou5lSUWQ60aUXFuqyn7rIkPixEE+lTdgnZnKJ9mHHa2c32CFGqVM7U9GlKp/CBi6TM8cxPCgrWjrNUX0xARAz4S0IqUlc4nTmX9rGwVQX0zMtTWquVmD6FYdj8lUx66Z+lYQNNSgzQY2kJiq17QZp6KVnFLMunwQEQ1bmbkxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=VrPOW2h4; arc=none smtp.client-ip=79.135.106.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1771985514; x=1772244714;
	bh=igQlCcJjveTSd4HMVaRsubbsY6JwCSFyX08budxIONc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=VrPOW2h4twjdjkpq7+qffkn4RJvFizm01KGa1yHQC0uwCuSSwRjs981Ap6bQlPqaB
	 ywvoly2H79udtIrYbfHdTDREmesTR15jL+vsI+7767HuG20tTQ3chK4+GxW2JR4Bvy
	 HQBepMR9brjtmsiRCDbk0KL6YHUuvysaLyHiB66J0eVWUUrenb+GE9c+Yww4E7XGas
	 bdx588tNksLXeQe9nnC27btIUazrfzsEnVTNIGyF6twQjR62FS8xMk8H+lx6GtSwie
	 K6N020PXLmJCw8WeSun7dO9JG8zJrIa76DSF6UQ2aBcMRJwbJnmynTp28QaVEd4cxP
	 /06Xggp32GBuw==
Date: Wed, 25 Feb 2026 02:11:52 +0000
To: Linux Networking <netdev@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: nmap port scanning commands 25 Feb 2026 Wednesday
Message-ID: <_VMay9nKqntMLSxUx4YBoVEOuZRcrNg-1RPvmeZFdlFdMbpLI-MZlwUSWEVzxLM_3-tbsN4xRUBWvNRQcoV1TDsv3y-hfnd835Va0u5ctwQ=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: bdcf39f085aac459521ec8ac06bf6bc86d92450e
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-260722-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[protonmail.com];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: CAC5F190D5A
X-Rspamd-Action: no action

Subject: nmap port scanning commands 25 Feb 2026 Wednesday

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

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Extremely Democratic People's Republic of Singapore
25 Feb 2026 Wednesday 10.11 am Singapore Time













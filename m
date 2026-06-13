Return-Path: <netdev+bounces-299081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O9PfB1fgLWr1lwQAu9opvQ
	(envelope-from <netdev+bounces-299081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:57:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 654BE67FFDD
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:57:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="grd/T65A";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299081-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299081-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 971833001FA3
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3303955ED;
	Sat, 13 Jun 2026 22:57:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D39219301
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 22:57:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781391441; cv=none; b=D8Mh/x8g/78vNnug2NOThbh6Omkiza6zJJhs1XVIyr3+UmGxuS+IHxj7uN92NM7II8swkjlbzdoU8ClLn2pi9oC0LkuLRjy3/1kSR5ImN0rKJ2Tu5KO6pQkkbejXqZdUvuGU2EAgRKk/QFofFTJQIF79HUzB4SEtubZZCBLpD70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781391441; c=relaxed/simple;
	bh=ZFrvxwQnZ6pSdcHqsFJGQ60DddBRaBnujElRx5LYB4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nbeu2MHPRAXzWWmKxTHu4x6Sp2kpBOxTSpJUNGJCBLCfhYSeDpUM6vW9X1k/xqRenkrBURC8FfdeDQQs+9AVOJN0u9uqm+OLnEflr25kQM28CPgqfijytQPzNDf17PWcWSUJTG3RYAv5+u/8VMQCFUidERze0Md8doBgtCNBPos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grd/T65A; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5671F000E9;
	Sat, 13 Jun 2026 22:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781391439;
	bh=k24wh30JTuty/CwE/HxdRXkLcDa5Rfp2ggyOA5fwtKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=grd/T65A6KZl28AaqchhcyOjS9J4+UOgi9XRqbbjPHSfkF9aKJBpGdJgyVbDu1fXh
	 4IMM4NlYZs+acgxBt3eFNnJye/BZF+XNDVdGRglKkyx4kdXwe3daZb7XW8RfBEMeMu
	 5dsHHr4f/BMlytmxli7sVgXUJAjsuG1iYpAYqZwr11vN0zszhcwAfNpQWyEDOHEiKZ
	 3fsamc1o2Q6xJLy1sQvPDJoEbUdXlMt3o5qKjNRLWXAwde48TxWm29ePMq0f7vgSdh
	 OB+b2tjVR5a5Dq9hIvTQ1WbhsM4jkp4g2E6vn3qDqXrbXKZLzEoe/M0sdz7Ge4lF10
	 Xsd7O+Otcoz8g==
Date: Sat, 13 Jun 2026 15:57:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: razor@blackwall.org, bobbyeshleman@meta.com, dw@davidwei.uk,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] Extend netkit io_uring ZC selftests
Message-ID: <20260613155718.16bf3964@kernel.org>
In-Reply-To: <20260611082527.741674-1-daniel@iogearbox.net>
References: <20260611082527.741674-1-daniel@iogearbox.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:razor@blackwall.org,m:bobbyeshleman@meta.com,m:dw@davidwei.uk,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-299081-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 654BE67FFDD

On Thu, 11 Jun 2026 10:25:23 +0200 Daniel Borkmann wrote:
> Small follow-up to the HW net selftests, in particular to add a
> selftest showing that also large rx_buf_len for io_uring ZC is
> supported with netkit queue leasing.

needs a rebase vs the PSP series that landed yesterday
-- 
pw-bot: cr


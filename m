Return-Path: <netdev+bounces-252615-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMWOGbTdcmmNqgAAu9opvQ
	(envelope-from <netdev+bounces-252615-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:32:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E70AB6FA74
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2C88300D46A
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E091F361676;
	Fri, 23 Jan 2026 02:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtKVzz7T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30758284674;
	Fri, 23 Jan 2026 02:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769135536; cv=none; b=BpsmjquPNCNrMW+IoQNdmC8TdCzE6gSirdt9SediBMjH7WotUAX9BzSTBwfwlBhgPOFKZD817OPVtMsEE402sIuMoVsX1Z283sMscTbwU+naxo/KMCbiYVFz9G7JLUCQUMUIJ77KYxiTCeNCxeHl3QZS2kGz8ciJD/Upj8VIRTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769135536; c=relaxed/simple;
	bh=E+u15N7KY4brSTe/c9YvYWvJ/YnAj+8Ur2OCUc7qw5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/SMTXxeI0zfOzWe5p+xLx+zPaRIXCrSGLkYc0cSb9EI5v9SYDsDl8PqyEi7ZXRXh/bgNSEMdGrjZQ6wHmFqWLTGCC7lNIcvIooYUwHINXVsc3TfKhe7f8a7QZpLuf49WIHhSruuPrpqFAj4qWUGGYaufoswADxNkfniOyl91yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtKVzz7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801CDC116C6;
	Fri, 23 Jan 2026 02:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769135535;
	bh=E+u15N7KY4brSTe/c9YvYWvJ/YnAj+8Ur2OCUc7qw5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NtKVzz7TtwFCeEtMnKxWladwZVAwRYKdMmmjF+aNlJhJD+qY3kzF/ATqcs/3j4jSl
	 JMAJKRR9i7wwJtzdFGedSd+xxqMTgRgwxQ2Et1Kc6qVHIwysWBWpd0dwcm36/dANsO
	 ooih0zQqqc/7WnMRyvgSlQmjTxnEynS5mRs9rx0r5nswZBtXzR90EstLuKHpTVD2+g
	 RZCh55C6pSdC/EIGjyZ1F6oU4iLlF4cB0fNYqMtTaHZgDS68yO/4E2ziS1jGbhC3Se
	 qJPzZxNo3Xo+gdagZzsN32w3kltx8yCQFAhaBUFDdEzZGB7O2YlVUjRc37GyP4PJVI
	 dB0OKCGxWhvcw==
Date: Thu, 22 Jan 2026 18:32:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Akiyoshi Kurita <weibu@redadmin.org>
Cc: krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 andrew@lunn.ch, olteanv@gmail.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: dsa: fix typos in bindings docs
Message-ID: <20260122183213.51998809@kernel.org>
In-Reply-To: <20260121130704.2236452-1-weibu@redadmin.org>
References: <20260121130704.2236452-1-weibu@redadmin.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-252615-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E70AB6FA74
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 22:07:04 +0900 Akiyoshi Kurita wrote:
> Fix "alway" -> "always" in lan9303.txt and marvell,mv88e6xxx.yaml.

Does not apply to net-next, AFAICT. Could you rebase on net-next/main
and repost?
-- 
pw-bot: cr


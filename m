Return-Path: <netdev+bounces-255288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEzREGNVfWn9RQIAu9opvQ
	(envelope-from <netdev+bounces-255288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:05:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B6DBFD6B
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A80C3013683
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2503164BB;
	Sat, 31 Jan 2026 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhtK2hGG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC002DECCC;
	Sat, 31 Jan 2026 01:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769821536; cv=none; b=RqowHFPjnUuCnb2u8Q1fwG3qweH8317tt5xa/L1dtvc+9RArE6HnUSJsdDGOPgD/XKFY7gMf/iU8QMRhIVs/lNEwskhhzgHlRzLC1sb34F+IVFyS+204j8GlxHMGTM4gh4XXiHko2r3ecD6498zbDh3pWYNp+AiZyrc7jQ4kiAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769821536; c=relaxed/simple;
	bh=0jI616kk35GV4rCmyrPDMjQwclX9zQXcyVZFyIWp20U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DMjQ27wryJgCRMxBHJMebBSaLDxK01ktYCZAOrdSPQXXL5FDWl98LhEd4w9OVexk5aL3U11f69wOLl4etJ7CdTBrVrDP4MLsPmi3NGWavpjLZj61iMOm3mctfOwmJmjWLb5zI3tN7Z4yxyIywkLr1Q/aKU89z9Vm6WXQqhSwoHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhtK2hGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1D4C4CEF7;
	Sat, 31 Jan 2026 01:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769821535;
	bh=0jI616kk35GV4rCmyrPDMjQwclX9zQXcyVZFyIWp20U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LhtK2hGGZHISVuVtnVdsIKijTl7Wwe8x7MkYfRcM7sQth7d0gD5G+bAF4305CDn+u
	 Ie3/xiFiw4VoJVjwm4lGz6HgsAFVbKOBu/kClFxhxEwOx8v81Y8AXKHNWVmCl7z9jE
	 LmC+a7C20jgQNqzyHfGIqlgAWnrS0Qu3iE9zu2IzcxLcKIeR72i73Z+izd6Ko8iLAQ
	 tTvgG8fQ32e73oXcvT+Gl8Zv597zW1BZN8MMnQUHHkLYjkkHasS8oBCdHTgzENnlS1
	 bVImwNMj7114gj6tpKgH6QoHapdIm2d/ZqJSZxLStqHvWoClgwNq5yOw76vgZlILj+
	 FMUhHZMl/mO+A==
Date: Fri, 30 Jan 2026 17:05:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Li Chen <me@linux.beauty>
Cc: Jonathan Corbet <corbet@lwn.net>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, Pratyush
 Yadav <pratyush@kernel.org>, Eric Dumazet <edumazet@google.com>, Neal
 Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Randy Dunlap <rdunlap@infradead.org>, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>, Petr Mladek <pmladek@suse.com>, Feng
 Tang <feng.tang@linux.alibaba.com>, Kees Cook <kees@kernel.org>, Li
 RongQing <lirongqing@baidu.com>, Arnd Bergmann <arnd@arndb.de>, Askar Safin
 <safinaskar@gmail.com>, Frank van der Linden <fvdl@google.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v1 3/3] liveupdate: suppress TCP RST during post-kexec
 restore window
Message-ID: <20260130170533.257db5fb@kernel.org>
In-Reply-To: <20260130145122.368748-4-me@linux.beauty>
References: <20260130145122.368748-1-me@linux.beauty>
	<20260130145122.368748-4-me@linux.beauty>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lwn.net,soleen.com,kernel.org,google.com,davemloft.net,redhat.com,linux-foundation.org,alien8.de,infradead.org,linux.intel.com,suse.com,linux.alibaba.com,baidu.com,arndb.de,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-255288-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89B6DBFD6B
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 22:51:19 +0800 Li Chen wrote:
> During a kexec-based live update, userspace may restore established TCP
> connections after the new kernel has booted (e.g. via CRIU). Any packet
> arriving for a not-yet-restored socket will hit the no-socket path and
> trigger a TCP RST, causing the peer to immediately drop the connection.

Can you not add a filter to simply drop those packets until workload is
running again? It'd actually be less racy than this hac^w patch ...


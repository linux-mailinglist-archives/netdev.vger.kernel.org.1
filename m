Return-Path: <netdev+bounces-255565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMdWJDewfmk0cwIAu9opvQ
	(envelope-from <netdev+bounces-255565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 02:45:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A79EC4985
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 02:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7169830160D3
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 01:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4977913D51C;
	Sun,  1 Feb 2026 01:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="dtTXRY3C"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB303597B;
	Sun,  1 Feb 2026 01:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769910323; cv=pass; b=Yw5er7UJOQXmeFkxoBNl6DLVLvn3ZywKd5MwaiX1ZejCPpGSPi2yto2tVF/NffcCbBGTQLSQmceAvXm7Ffnu40ewSi8JuaDM1H7HkaIqqEO+8c0Qr82FOJVD9k2CUB1bbHARZLcTSDEfeXqzOEMkAtrB8CIIlFioIQHpOV0Ggzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769910323; c=relaxed/simple;
	bh=+BE/aOCCJtfEvwl/rY/BaFAqJGwQ3CQ/5FKlrXU36Us=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QGXGgpsLsXx5sd6TbEfQCIA5L+bF1+3+92VRuqIiNGVP0eWdxRkzxhHWGPauMlF5rf7CvLaCNxmP/rF2UHR00WKlnrjiugPtTfetGd+KrgjHsZTHGna4GUXe0f5YGXSN0V93duIb+wQxjnwIrpTFu2UEWziwgnsWxPmLMsdO1g0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=dtTXRY3C; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1769910269; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=m0IOtmd5YqZsEJ/pwodTe27kB+pIBoW4WbFCt4/2HBk2Tyt9/b2eRTnA1uPRavHsUryo5b1JYTEe9SLAbB0crrmMEudEl4TsJkKO3IR5978gq57qSeuDs2L7H+cP1GYnCcww/2fzHY5/GKlZ44sjiVOe1BsH0rIylZ+vuyfbA4o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769910269; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IlG1n9BLDZ09VGbQUqKZBipsjvO2o1DnNBZKvwfyDwk=; 
	b=Ojpcf78xHG+VH9H+S4tL7P1V/m269NAUOSjTzoIIM8q3h4W7dlpZfjFcsLkPiaF/01V1fAHoYWQL9PXFBMa3XLP+/XVrMA0lmtDrMDwyHolxh7K7yAGgMPw4Ub64txwvuhmI8/tXMTRrdlgesIbrau1FQHNZpzUZC7wCS0x/Sag=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769910269;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=IlG1n9BLDZ09VGbQUqKZBipsjvO2o1DnNBZKvwfyDwk=;
	b=dtTXRY3C6JqHvcRiViY4SIotEiRzuDmvKpN0smf6mdUy9EbPUx+17cTp+tB7l6DW
	DNIEIc9ABwfrnYBUmYjbx81UkTHolhiu/FCJFUhI2zhKpFifEfGHkycX4AieV/g94sw
	hKoQa9hMSTG/7r3FxOhs0BZ49csvDBxX4Emz6H2Y=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1769910267415394.81945402914016; Sat, 31 Jan 2026 17:44:27 -0800 (PST)
Date: Sun, 01 Feb 2026 09:44:27 +0800
From: Li Chen <me@linux.beauty>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Jonathan Corbet" <corbet@lwn.net>,
	"Pasha Tatashin" <pasha.tatashin@soleen.com>,
	"Mike Rapoport" <rppt@kernel.org>,
	"Pratyush Yadav" <pratyush@kernel.org>,
	"Eric Dumazet" <edumazet@google.com>,
	"Neal Cardwell" <ncardwell@google.com>,
	"Kuniyuki Iwashima" <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	"David Ahern" <dsahern@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Borislav Petkov" <bp@alien8.de>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	"Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>,
	"Petr Mladek" <pmladek@suse.com>,
	"Feng Tang" <feng.tang@linux.alibaba.com>,
	"Kees Cook" <kees@kernel.org>, "Li RongQing" <lirongqing@baidu.com>,
	"Arnd Bergmann" <arnd@arndb.de>,
	"Askar Safin" <safinaskar@gmail.com>,
	"Frank van der Linden" <fvdl@google.com>,
	"linux-doc" <linux-doc@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"netdev" <netdev@vger.kernel.org>
Message-ID: <19c16df6e07.5d6555571430461.7492468111934043630@linux.beauty>
In-Reply-To: <20260130170533.257db5fb@kernel.org>
References: <20260130145122.368748-1-me@linux.beauty>
	<20260130145122.368748-4-me@linux.beauty> <20260130170533.257db5fb@kernel.org>
Subject: Re: [PATCH v1 3/3] liveupdate: suppress TCP RST during post-kexec
 restore window
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.65 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux.beauty];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255565-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.beauty:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lwn.net,soleen.com,kernel.org,google.com,davemloft.net,redhat.com,linux-foundation.org,alien8.de,infradead.org,linux.intel.com,suse.com,linux.alibaba.com,baidu.com,arndb.de,gmail.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[26];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.beauty:mid,linux.beauty:dkim]
X-Rspamd-Queue-Id: 3A79EC4985
X-Rspamd-Action: no action

Hi Jakub,

 > On Fri, 30 Jan 2026 22:51:19 +0800 Li Chen wrote:
 > > During a kexec-based live update, userspace may restore established TCP
 > > connections after the new kernel has booted (e.g. via CRIU). Any packet
 > > arriving for a not-yet-restored socket will hit the no-socket path and
 > > trigger a TCP RST, causing the peer to immediately drop the connection.
 > 
 > Can you not add a filter to simply drop those packets until workload is
 > running again? It'd actually be less racy than this hac^w patch ...
 > 

Thanks for the suggestion.

When you say "add a filter", do you mean installing a temporary drop rule
(nftables/iptables/tc) in the network domain which does not get rebooted by
kexec (e.g. LB/ToR/host firewall), so packets never reach the new kernel
until the workload is restored and ready?

If you meant a filter inside the kexec'ed kernel, I'm worried it won't cover
the critical window: kexec resets the ruleset, so we'd have to install the
drop rule extremely early (initramfs) before any packets hit the no-socket
path, which still seems inherently racy.

If the expectation is to drain/blackhole traffic externally and re-enable it
once the workload is running again, I can rework the series to keep only the
restore-window tracking plus a clear "restore done" control plane, and rely
on the external filter for the data plane.

Regards
Li


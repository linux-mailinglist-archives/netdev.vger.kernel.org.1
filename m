Return-Path: <netdev+bounces-262729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAhfM5O4pWkiFQAAu9opvQ
	(envelope-from <netdev+bounces-262729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 17:19:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 558111DCA0E
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 17:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C24FD3069660
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 16:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B5941163F;
	Mon,  2 Mar 2026 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="f8pn8U6F"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9A6387372;
	Mon,  2 Mar 2026 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468049; cv=none; b=A2CHjJgARZDxY9NdotAS0So5jaTy61OO6VNdWv3fViUufQFOsWi5qmJQ1kktONrhDKOE/YwhX/OLHz22mwEeDIwYKp8KivQZ1gpkKnAFshvX/ajRTb5KUEiXYMihu8YaC2cLG/iQyXHvJIMuAtYrMlEVA2MmT5kz87SnRM070AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468049; c=relaxed/simple;
	bh=GllBRQ+/5lw/YKIoqIlltaCvkXN3t0K2P1wecZTMdfo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j8/8FJXbtPcyYCvRx1OjvnFxC70LLBIx57cfUCBPzTr1LJeI7/WffZi0LJ7dyddFqaax3f/H76XkRoineRQCTvUntb6kbTe2FjIGOP/6Fyuj70KF0fFAoRbqTlttiXXG+KJsMrL7RASBrvXCSByBAgW9DLlGn6e2dPRcGUzp3jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=f8pn8U6F; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5854040C69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1772468041; bh=GllBRQ+/5lw/YKIoqIlltaCvkXN3t0K2P1wecZTMdfo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=f8pn8U6FA7kUP/r8iFJZ4rWUypHnzoaqHWxdAGjfHjokYaiGJKCr7IU0F2JeN/8Fw
	 azpeD8ldqGCxtqmHWLxHS49TZl0QI+PrcVa1ESn/HNUJLsJpACllhhxKlZ7WWhWA0G
	 4aJvqrqR8VuLoM4+Eg+rb1g/Si03GSmPlar/FE1+ppa4Qndh/WT11KisZJg8mqwbVh
	 /WzQmizJRbq2GmBEJHki9LsLvF6IsnP61jEwvwgciTs1BsM2J6ZOLVi4QFAAp0/ZhL
	 xDEN8yE0rRR0o2SHCha4a+omT/xNujvFQOxlgrR+kzRwwpwg0ORD4R3MLY+vZKFmpC
	 3fI6jawrtR2kg==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5854040C69;
	Mon,  2 Mar 2026 16:14:01 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Kees Cook
 <kees@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Randy Dunlap
 <rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [Intel-wired-lan] [PATCH 00/38] docs: several improvements to
 kernel-doc
In-Reply-To: <20260302165433.27f11148@localhost>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
 <87sear2kbm.fsf@trenco.lwn.net> <20260302165433.27f11148@localhost>
Date: Mon, 02 Mar 2026 09:14:00 -0700
Message-ID: <87y0kaw6nr.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 558111DCA0E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[lwn.net,none];
	R_DKIM_ALLOW(-0.20)[lwn.net:s=20201203];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262729-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lwn.net:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corbet@lwn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,huawei];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lwn.net:dkim,trenco.lwn.net:mid]
X-Rspamd-Action: no action

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> So, instead of merging this patchset, I'll be sending you
> a smaller series with the basic stuff, in a way that it would
> be easier to review. My plan is to send patches along this week
> on smaller chunks, and after checking the differences before/after,
> in terms of man/rst/error output.

OK... *whew* ... that sounds like a better way to proceed :)

Thanks,

jon


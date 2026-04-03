Return-Path: <netdev+bounces-275266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5nr1BOhH0Glu5gYAu9opvQ
	(envelope-from <netdev+bounces-275266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:06:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 840A5398E76
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55469301683E
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 23:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C74C361DA6;
	Fri,  3 Apr 2026 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYfpSeY8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A64285C8B;
	Fri,  3 Apr 2026 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257570; cv=none; b=URIeVusmeGQvNtQtOxgrFl5pSQvNUFcYaCIoQkIrC+w/6hjIFxaA8FEO+GemXXy6TXcBhZR+xfv4ObLjEeXikF1QIUHBD6Za+bIO/vKZHtJeL0PhuLHFNkqdcjr0x+SOWJCchPatQQsdZQRgqzWPWLbu55Sf8SM5yWRoK3XDRvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257570; c=relaxed/simple;
	bh=WN+LLQvMI1CsA7eX0vR0NLnnb3hkew4sf67EVQuhNY4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gjzgFma6fyHEgcUrlfnyqulZGCTtqJEoQdnZGH56ciV17x+Yy1Qwuoj4gTo4F2iiC+qjCAsqd25aq/ylHxDfwqtxiuxPuAaJJasPvrLibiuy+YW1RSJDHOIYfYG2RWPbFMnNPwI7H2pAzuaLwADGENhKJ/b+R8wIflo4TXAUIwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYfpSeY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6A5C4CEF7;
	Fri,  3 Apr 2026 23:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775257569;
	bh=WN+LLQvMI1CsA7eX0vR0NLnnb3hkew4sf67EVQuhNY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aYfpSeY8/ry3a22Sd8Ec+8eSe6JojjcENgPnxXgk8n9Cn2OYxEWTkHEhq0sUP1d3U
	 g7CchSKUR2HYf1FWh+4sd1eptEsDakil5nyigd7uzM+GL857IifjDWRSiD1siOcbdG
	 cs7CkLDIsO42BsVNRYROsarx01W8UDsjHeRgvG/YaD8sjev0WAXyYbeeg122mB6htU
	 Bk8ffJIOGWpm4shZ+Qh+itQx2/ff+NKniKVyW0Ymnc+SoubrTGuqL2wVVq8m200Pca
	 QnwNqkgn5argKynC1dQkqdX/w8rfjxa0IQFjqzXA6GunRsom+dQZVtKwXDQUS6VKHm
	 8vSTpyX9/eKIA==
Date: Fri, 3 Apr 2026 16:06:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>
Subject: Re: [PATCH net-next v6 0/2] r8152: Add support for the RTL8157
 5Gbit USB Ethernet chip
Message-ID: <20260403160608.04f2408b@kernel.org>
In-Reply-To: <20260402-rtl8157_next-v6-0-a9b77c0931ef@birger-koblitz.de>
References: <20260402-rtl8157_next-v6-0-a9b77c0931ef@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-275266-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 840A5398E76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 02 Apr 2026 10:28:12 +0200 Birger Koblitz wrote:
> Add support for the RTL8157, which is a 5GBit USB-Ethernet adapter
> chip in the RTL815x family of chips.

no longer applies, please rebase & repost
-- 
pw-bot: cr


Return-Path: <netdev+bounces-285737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uL5CMkeu/WmlhgAAu9opvQ
	(envelope-from <netdev+bounces-285737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 11:35:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B374F44DA
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 11:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD87D3003634
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 09:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AC83A9015;
	Fri,  8 May 2026 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="WwNWPKG7"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA8830148B
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232830; cv=none; b=Ci/H7lEC5sjCd3jFfhW08JiA5CWlWilUlCOetRHLfWRjmrskp0e6FZjMhDDy25I0sospo5iC0aUl0LQLaWqyNKuzH8ApOQ/Kf+syr77TsZui6PGYFaEbBr60yLK1Ww6M4b3b1f6FQjdF9KGTV7CcOrYhJAi2izTXNEz/iedpHGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232830; c=relaxed/simple;
	bh=imUYp0DDYfzNNtIwc1kO2VnsRc39OkGAN7c+JiqUPz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANP/otZ3gv3nkPev2bFmstuZ6HQkEF5m6IKVYrunKbkHOBMuVjB5E/VqivvNoSBUg3f8tMGX2P/FBgIvwjWXo7VGQjlAqtcZGmEr5F5IfG0F5QcXeUseHmX9S3VoPHnpNFkr7DB7mvX/MveFcGAPZrNYY2ycojh3zMp2PnV/yDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=WwNWPKG7; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BczyGx/Dp5xeBEupTcCEr3GAcqaJjjfH22Uew7ZW+0M=; b=WwNWPKG7oS1DRWE5Az2yk8b8Qr
	cMokwh4FzFlVAP6URUgrUlT/gz3eMyV+e5MoqTU+q5xrDoeqwDUtaKrS5xrO+SKepsA6EhBUFX+PU
	3X75tDqJjWFTkwP7lpG+225qFsUeVyGFB7wg7ii8AVKmIx4tsc9NKQZaeQhJEtmgmHRRd2coibQJa
	lHzkJqsrtJ4Gx6d4/6NnPpZUrdTSWPkmuKKooPcC86bEV4p0A7c7zuaKQhUUvoO5xxyj+9ThX3l8i
	nAPYLpMWmYL66ImPm0yQLWzRsxFH13pOvAEmvEAEUrcFQaZeX6EfdbgEnFIUitJ/1pBSvwwzPG6JG
	B353EitQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wLHaO-00536y-2a;
	Fri, 08 May 2026 09:33:33 +0000
Date: Fri, 8 May 2026 02:33:28 -0700
From: Breno Leitao <leitao@debian.org>
To: Tao Cui <cuitao@kylinos.cn>
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: ethtool: fix missing closing paren in
 rings_reply_size()
Message-ID: <af2tj9AkacSUfsp9@gmail.com>
References: <20260508071402.183909-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508071402.183909-1-cuitao@kylinos.cn>
X-Debian-User: leitao
X-Rspamd-Queue-Id: 53B374F44DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285737-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 03:14:02PM +0800, Tao Cui wrote:
> sizeof(u32) on the _RINGS_CQE_SIZE line is missing its closing
> parenthesis, causing nla_total_size() to absorb the subsequent
> _TX_PUSH and _RX_PUSH entries. The resulting size estimate
> happens to be numerically identical due to NLA alignment, but
> the nesting is wrong and misleading.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>

Reviewed-by: Breno Leitao <leitao@debian.org>

Even thought the resulting size is identical, I am wondering if you
should add the Fixes: here. (or target net-next instead).

I think this is a net material, which will require a Fixes: tag.


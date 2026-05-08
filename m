Return-Path: <netdev+bounces-285973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA89Bv5K/mllowAAu9opvQ
	(envelope-from <netdev+bounces-285973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 22:43:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B95E34FB94C
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 22:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F56F302F248
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 20:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C66E3FBED4;
	Fri,  8 May 2026 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2gPvYiC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445243ECBEE
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778272916; cv=none; b=GxfVx8g5nPLOML974by7zMWmyemjE/D2mLXM5lPAjN8U9jw2j1Cc65yxaDgPwJPe13V2eQWSRknV9yooT1XyWXVfWH87jZsZaR/YZ2tAHyiSv887V0NUdATqU9hAoJpz+1pOxNv1nzbnUHyXN3jDuiRXvEppLW72wDdx5NhBQDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778272916; c=relaxed/simple;
	bh=Vq3u7x3L9mJ3Y0PUDgXFvkpRHVdiRoUc+C+9Jyz/T90=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4NrWwQYcg8j2/NVSK7Aaq31vdU+BxyHHqJO9aiYtmWZ5dQXScSXeiItpwqb4n4wyp2FmjtECkn0KIo3WGwKSwiF9ry6ouEqfMAAT8uklu1DZcSdWsqN43O7lfOcDWDK8fjR6/ZJq3c7cGIg3F/ivNfa8klXadNABysfk1ABn38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2gPvYiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323F8C2BCB0;
	Fri,  8 May 2026 20:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778272915;
	bh=Vq3u7x3L9mJ3Y0PUDgXFvkpRHVdiRoUc+C+9Jyz/T90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R2gPvYiCY5ADY4t9gNe0elccPa3OLYVyIhKwGIdWpFjS40l802W8Z7zkHifrEsN6i
	 a58iTngGTW+/H/CUupc7R6Q5R/qXRss7/G3WYAobxdJfXeibz0ex60pgrVp4TBgXv+
	 1C8fm4NTBdIXB/XVFLYxr6YE8yXr65bLmVYNMcYezUfobDyR2SJr6mEhNgpzuoq4JF
	 pq5dxUUyFHM8yitTzMP05uecOMV9paeeGU+Mx9t4BReccDn81+6b2Li8XA0yDYJnh0
	 l4aAESRUohS4IGMCnr/lQHIsd03G/ZU2xbvTaoYGPxgu+gAZ20h7tD6fMIUTAtIx2c
	 Nqk8KlIrEBtnw==
Date: Fri, 8 May 2026 13:41:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Tao Cui <cuitao@kylinos.cn>, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH] net: ethtool: fix missing closing paren in
 rings_reply_size()
Message-ID: <20260508134154.170dc200@kernel.org>
In-Reply-To: <af2tj9AkacSUfsp9@gmail.com>
References: <20260508071402.183909-1-cuitao@kylinos.cn>
	<af2tj9AkacSUfsp9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B95E34FB94C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-285973-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, 8 May 2026 02:33:28 -0700 Breno Leitao wrote:
> Even thought the resulting size is identical, I am wondering if you
> should add the Fixes: here. (or target net-next instead).

For the record - no and no.
But don't repost this again, please, I'll clean up.


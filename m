Return-Path: <netdev+bounces-280038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NdHH0Mz52k65QEAu9opvQ
	(envelope-from <netdev+bounces-280038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:20:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D40904380A2
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 154AC301F1BA
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 08:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4C339A045;
	Tue, 21 Apr 2026 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ob3bagR5"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AA83859C2;
	Tue, 21 Apr 2026 08:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776759582; cv=none; b=bzkMgLHi46EGLtn1hlKJ4x8fiGPXcVb72p2wIT49MkdqjiIgc3lDxB2vjo6r4a0QlKapjIst/iBw+wd6rG6kTIGAQ1zbyhdNkTYU+0IVgx5AwjPw6MuSgGgTwt2YzU0Oi2HNQBKmeASSRbhLYiIPZIn7u3b7H+f5PIVP9eWGfPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776759582; c=relaxed/simple;
	bh=skS9sAxmUTtF+i1eMU/5DMsTUEtylqwxN2O3O2Wgaq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MO+D78mXgK0EbGH9QubvRJQfuOAnjjv/XM6hz0VxUrJjkiL5INCaEqn+0MFQrnfRp7n6yrnZ3qi0nRwOMS72AXFEzy20URJ/sx1C0MjbyEOahc4J1YTR6Xb0rmPWG8ycfIDm25anHfhEL54YtvjOswQI1mpynPUr99She6JLx2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ob3bagR5; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fGvmdupeMERdnRRGrdrk+FV4QqPGhplY/NanJt+t8j0=; b=ob3bagR5W2i8n767TmTtF29h3V
	YdnhVLJ+aCThjW0MbVCZKpgSNPBXvTW+8++c3drMzpOE8Gc7w8WD5U4ia+aoM2osyni4b3ppZhPJh
	v/tgbQekA38sxQG1mlP/lAkEP05NybQK6fCccxfObUyvUKStgyowLlTs60ZdeRaxLNhdo4ppCxh7m
	Vh3acOIUcYbMvcl2451Agwm1ju1cfv2/dA/JvTirRBT8i5Dek+apw4JeQGgkJhN77bC2WQ9NCUmHo
	iJh8Ry6sSepu17kGSrQR/NclrioByap3JrW8iEEAwlsrrD8n32RVWUzogc8bE0iZnbN6rFC06DTLs
	HhuCDRnA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wF6KQ-000ifx-0U;
	Tue, 21 Apr 2026 08:19:31 +0000
Date: Tue, 21 Apr 2026 01:19:25 -0700
From: Breno Leitao <leitao@debian.org>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] netdevsim: Initialize all fields of ip header when
 building dummy sk_buff
Message-ID: <aecyEArzjx8KRp8-@gmail.com>
References: <20260421073738.22110-1-zlatistiv@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421073738.22110-1-zlatistiv@gmail.com>
X-Debian-User: leitao
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280038-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[debian.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: D40904380A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 10:37:38AM +0300, Nikola Z. Ivanov wrote:
> Syzbot reports a KMSAN uninit-value originating from
> nsim_dev_trap_skb_build, with the allocation also
> being performed in the same function.
> 
> The cause of the KMSAN warning is a missing assignment of
> the tos and id fields of the ip header.
> 
> Fix this by calling skb_put_zero instead of skb_put to
> guarantee null initialization.

> Additionally remove the now redundant zero assignments
> and reorder the remaining ones so that they more closely
> match the order of the fields as they appear in the ip header.
> 
> Closes: https://syzkaller.appspot.com/bug?extid=23d7fcd204e3837866ff

How do you check in the report above that the missig un-initialized
fields are "tos" and "id"?

Thanks for the fix,
--breno


Return-Path: <netdev+bounces-281528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFoKNXLp72m+HgEAu9opvQ
	(envelope-from <netdev+bounces-281528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:55:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9A847BA57
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D367C3043D05
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BB03A6EE7;
	Mon, 27 Apr 2026 22:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3J/zqSU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02612116F4;
	Mon, 27 Apr 2026 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777330540; cv=none; b=KkzH3I0kBWEwDW8NTSOXacVmMSCVYH3R7A4r2MoUVw4TjCd1gpme4Via++D8PkJblHsgyg8WGnK5vyHph+7Bk3BUOPfeqO2U3dsSAv2h/pbfvPp2jEDQh+qvHgX1P6bhlR5ij4ojZztJk/QRN6jd28A9syRu5c8f6Q6o9EZyyL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777330540; c=relaxed/simple;
	bh=u4TmU67f5hhwJf1I4i/d/XWbjxi0EHQ0omutGz+1/+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VL8h2r9/HKLAw81IZZxKzI30+2pOLwklXc1GgYmLhmDDZ2yMwoT4CUnH8wzEwLCIsYFPvM0SufX1RHb73bmRUmNepcW0HaioCvJofGquInB+e40CjLQmfKgF0mtksVtwK9cSdEI+Pxo/RUi2Xl30JpC4Ct7A0fhFZON17rzbiVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3J/zqSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1CDC19425;
	Mon, 27 Apr 2026 22:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777330540;
	bh=u4TmU67f5hhwJf1I4i/d/XWbjxi0EHQ0omutGz+1/+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H3J/zqSUWdQG+2g7LezoYT1Gqql7aJLVtVhJE+MpKGOj8nEeazSr6wWT1/TfIZr8B
	 YyED+LEVseeNaCLB9x3bqnDlElbTjMCLoXh9XtNqIDPhI6bJYC9opsxPlEL8DgDpZQ
	 UdjAx3dS6pyfI2GgQRbbBrNtGelK0bwqDRE3pQBqLFw2EfaRCA3MB6HiCngBbq66+X
	 Nhn4Nzc4mDj2MOuKkc2uksSXoX35BmPtYCu/V6KcmuARBL8jQDD60HmqzB2uFT7JvI
	 ouGeJIXeSI4w79oz+2A87q1CnnUojv4WE0VdOWm4shBv5aSWiuEfSadDcO8q4/UKb3
	 p8y8PpIUSvnIw==
Date: Mon, 27 Apr 2026 15:55:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Jason A .
 Donenfeld" <Jason@zx2c4.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH net-next v2 0/5] Reimplement TCP-AO using crypto library
Message-ID: <20260427155538.2e1b8488@kernel.org>
In-Reply-To: <CAJwJo6Z9oJSMMBUL_pbYWN6ha3n4MRpKV_aVut8E+af3JUDFkw@mail.gmail.com>
References: <20260427172727.9310-1-ebiggers@kernel.org>
	<CAJwJo6Z9oJSMMBUL_pbYWN6ha3n4MRpKV_aVut8E+af3JUDFkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2F9A847BA57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281528-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]

On Mon, 27 Apr 2026 20:09:05 +0100 Dmitry Safonov wrote:
> I do like these numbers quite much! Yet, as I mentioned in version 1,
> removing a fallback for other algorithms' support does not sound good
> to me. There are two reasons:
> - Ronald P. Bonica (the original RFC5925 author), together with Tony
> Li do have an active RFC draft to support the additional algorithms
> [1], potentially in addition to TCP Extended Options [2]
> - There is at least one open-source BGP implementation (BIRD) that
> allows using the algorithms that you are removing [3]. Without a
> deprecation period and communication with at least known open source
> users, it implies intentionally breaking them, which I can't agree
> with.
> 
> I don't feel like Naking as we don't have any customers using anything
> other than the 3 algorithms above (and BGP implementation is
> [unfortunately] closed-source, so that would not feel appropriate even
> if we had such customers), yet I do feel like it's worth and
> appropriate to express my thoughts/concerns.

What do you want to happen? You are the maintainer of this code,
you don't get so say "i don't want to nack it but also no" :)
Like Eric says if there are no real users code can be deleted.

Adding deprecation warnings upstream is quite slow, IDK if injecting
deprecation warnings to stable has been discussed..


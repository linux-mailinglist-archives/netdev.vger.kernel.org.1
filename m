Return-Path: <netdev+bounces-287035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBY9FcX1AmrpywEAu9opvQ
	(envelope-from <netdev+bounces-287035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:41:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E2251DF05
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1515F304D5EC
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9873ACF0F;
	Tue, 12 May 2026 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3jLXEGW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991403A1696;
	Tue, 12 May 2026 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578617; cv=none; b=WO/abBL0j3EbRYCbcUKYMdnr5ygUMn+wtrpsHHx/lVS/0pj1mO4xEFW6SR2gGeJulwCE2ZJ/N3mKIwIf+L22VjNaTnTZXx7j/hWfBD/5Nt0czE0XfDpxVt0VnRSI3j3Nvcj13GNz+eq41bPwYeHOh6r/WTf3fPbzB63WLD/i8FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578617; c=relaxed/simple;
	bh=1ZVb6JAsWhhlMn5EyFbfVxMNq4KaFAxjA1rVB+g0uV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKozFcoDYE8YmQ8e00v5+iVuzjxWzbh4G/kkNVJjo+GtC7ZAnXHWFvt4V04IdQ2VdkWV1olVWc0DoK++DR9ZK6sZeqNavHHumo/Nd5MkDPgCfY2jydHyQ4deARFFMxm2DcwFeh+N5fciqTJM5MZkQY2e+bUxo+Wg48wpQVu1QGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3jLXEGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C289C2BCF5;
	Tue, 12 May 2026 09:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778578617;
	bh=1ZVb6JAsWhhlMn5EyFbfVxMNq4KaFAxjA1rVB+g0uV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h3jLXEGWO1pyPRqN1yjNTRsWT5Wm/znlIJJwkr6HMjYCZ5UCPEE7od5EW4/bmV4ep
	 lQv4ntBf0iLBS3wsd7LrSGMp0Cmpie0jvIyQ33Hma3nwHLCuUwmKZq4wGwyXI7nK1m
	 aSwB0kkb23aarLs809yyjK5haWp+g3ROTOxrBGhaA7phP5D1dAl61qsxYrp2CfLCpP
	 +88eP6SkrZMXBpApwswa3q7/2zVvSKNPC0NtYEb++I0wwQLIImRJrEoZdHE3DNaMwR
	 xJPxzJi2sfIEjGqak1EQnQTmNzP8NFhcpENbtEo9zQ1aslub8AEHOU2s6l+NFDx8Zx
	 rIKr/bskFQ47w==
Date: Tue, 12 May 2026 10:36:51 +0100
From: Simon Horman <horms@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Linus Walleij <linusw@kernel.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abdulkader Alrezej <abdulkader.alrezej@gmail.com>,
	Yury Norov <ynorov@nvidia.com>
Subject: Re: [net-next PATCH v2 0/8] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
Message-ID: <20260512093651.GH27589@horms.kernel.org>
References: <20260503-realtek_forward-v2-0-d064e220b391@gmail.com>
 <20260510085426.GS15617@horms.kernel.org>
 <CAJq09z7AUqUixR+jo=UFAbU9mTX0X50DuZJfRcmVwEWcHTZmQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z7AUqUixR+jo=UFAbU9mTX0X50DuZJfRcmVwEWcHTZmQQ@mail.gmail.com>
X-Rspamd-Queue-Id: C2E2251DF05
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287035-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid,sashiko.dev:url,linux.dev:url]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 01:53:14AM -0300, Luiz Angelo Daros de Luca wrote:
> Hi Simon,
> 
> > There is somewhat overlapping AI-generated review of this patchset
> > available at https://netdev-ai.bots.linux.dev/sashiko/ and
> > https://sashiko.dev/
> >
> > I would appreciate it if you could look over that and address any issues
> > which represent new bugs or regressions. While I think that, in general,
> > any pre-existing problems that are flagged can be left as possible
> > follow-up.
> 
> Thanks for the suggestion. However, it will take me some time to fix
> all the issues. Most of them are real.

Thanks, much appreciated.


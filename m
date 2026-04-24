Return-Path: <netdev+bounces-280998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EM9IPt+62lLNgAAu9opvQ
	(envelope-from <netdev+bounces-280998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 16:32:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D63E14603FA
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 16:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57D1D3007AC8
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 14:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9243DC4A1;
	Fri, 24 Apr 2026 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tm35pa+h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F2C3DA5C1;
	Fri, 24 Apr 2026 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777040919; cv=none; b=Sf0sE11txyAPpmYTI1K0Ns4psrpA9qYMN0QG+8PROjzXD5P4dR0PPm4rDy0siwXtlz5mR8No08qn+/oYeEesNLxzQ+eYFpyqGAHvwLkdObf9cEJTLpcJhcowqvuhZlz/hP8OzANOsztgKsg5SxIK9j7Fy9DPta3yjxv9owfHbmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777040919; c=relaxed/simple;
	bh=5cK6KrlDmS/euLYLqiKC/eqNlSFxvmx1H/+AC2Flb/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uNO5jIdDJzU/v8JoGYEuxsoHx31Uzf1rGXDw3kUbgP5/UEQcyYtEAOLfaFf0oC9XObhv5xDo1ZfYBAmqn2L83GHhP5rwBaxTjGKu0Lsx28R70YX/LwzOiqZcFCeK5ll99/Fc28YQSxm03LjOnV2lvfs/P3b65kfm+nvg4WkyHVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tm35pa+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B504EC19425;
	Fri, 24 Apr 2026 14:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777040919;
	bh=5cK6KrlDmS/euLYLqiKC/eqNlSFxvmx1H/+AC2Flb/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tm35pa+ham4eETf4/QLKs1RGbPM1SuCNESiibWSSJtnA2to6bx2bDySoAVFBE+e+P
	 OgYRk4zrnuqy7AUgieSZ0Jxjp+QDHM4ZJhB+WeyVerhYdtC0XtkWQPOZz2Sa6z8icP
	 PUS/9CZZ+HLMhQG6n9K0os5ExnNRySQ1I6t1E27+o2dBcgJKe9Ga6H9GnqygyLISzh
	 YYFPBSAt4K4OVPKQU5qtLmuNTGvZpaLyz8KpgzNUzh3wC7Zgudy39cP5ekRTlrOtFs
	 cTWIreWpKt/M3ZEF6vhHaCOe1UjHAQc1rjJ+Th3J/Dpt6vzxhgMbgx+pCVarQ1NIpd
	 WidMHTp+EUfcA==
Date: Fri, 24 Apr 2026 07:28:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Palmer <daniel@0x0f.com>
Cc: torvalds@linux-foundation.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: Re: [GIT PULL] Networking deletions for 7.1
Message-ID: <20260424072837.674f9066@kernel.org>
In-Reply-To: <CAFr9PXnNVL4mUEu19jMu2sPkOucGK7Q32iB-7FY8eUpKZY_XJA@mail.gmail.com>
References: <20260423235422.1541768-1-kuba@kernel.org>
	<CAFr9PXnNVL4mUEu19jMu2sPkOucGK7Q32iB-7FY8eUpKZY_XJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D63E14603FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280998-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Fri, 24 Apr 2026 20:14:51 +0900 Daniel Palmer wrote:
> > ----------------------------------------------------------------
> > Andrew Lunn (12):
> >       drivers: net: 3com: 3c509: Remove this driver
> >       drivers: net: 3com: 3c515: Remove this driver
> >       drivers: net: 3com: 3c574: Remove this driver
> >       drivers: net: 3com: 3c589: Remove this driver
> >       drivers: net: amd: lance: Remove this driver
> >       drivers: net: amd: nmclan: Remove this driver
> >       drivers: net: smsc: smc9194: Remove this driver
> >       drivers: net: smsc: smc91c92: Remove this driver
> >       drivers: net: fujitsu: fmvj18x: Remove this driver
> >       drivers: net: 8390: AX88190: Remove this driver
> >       drivers: net: 8390: ultra: Remove this driver
> >       drivers: net: 8390: wd80x3: Remove this driver  
> 
> For the drivers I really don't think enough time was given for people
> to come out of the woodwork and say they are using one of them and if
> they'd be willing to maintain it or not.

Real users show up a few releases later. Waiting for more responses on
the ML has little value.

> If this does get merged and someone wants to put one of them back will
> it be as simple as sending a revert?

For the users? Normally they just send an email and we handle 
the reverts. It happened multiple times in the past, we remove 
a few drivers in each release.


Return-Path: <netdev+bounces-272202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNt3HH5+xWnw+QQAu9opvQ
	(envelope-from <netdev+bounces-272202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:44:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB0933A50F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3B2230DDAE9
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7973A6B9E;
	Thu, 26 Mar 2026 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3sNCAO7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B203A6B8F;
	Thu, 26 Mar 2026 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549168; cv=none; b=dwWs/z3lhWpsxKk5xXBXSvrib78wvth3J4DPHHv5jN+R7jdfV6RRaudcOkspT3XTRCX/DNPSh8X6Urk+jakja0NBzowyfCSiT2FlZNLZqR2bA53HjAdsylCuwm85X7mQaSoXaUBpUxPRhLvnjtbq5obRYfe7mctkxHEE7swvaQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549168; c=relaxed/simple;
	bh=3DaolWCTH2undXGXbRYLLz2UkHktHJCLJY4I8mu9AAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iI5Jfo1H4vq2mG+1cowXflNwEGGtYW2VoofUuZ7C/hvXO7Dz5Z7DBm9xZFo0Q1csEkdeyI9aAeSHjL8NzPFmKr9wsraBFAgOBnB4TAIOeA8bcvmvSaKf8CJTbDcv3YnseGCG0xCiaDqG3J2WockbZhZDeiyxfLKwpZXo8mPycg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3sNCAO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E73C116C6;
	Thu, 26 Mar 2026 18:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774549168;
	bh=3DaolWCTH2undXGXbRYLLz2UkHktHJCLJY4I8mu9AAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r3sNCAO7z+7lQUP2nFrGHMGZAyH9J55GAM3ISIRDvierD+LlGehcNOgm+3rwmt0i4
	 uSZ6GqQW71GHzHS3XBHudkPq87jqKHe8qysxHs/O93c+jqFIwuRTSG3wnP3JJrRvpP
	 1VDzeQEyCYud5t7cIlf+1ey3hXPR2DVO4RamLep/CvrNGWFVumsozeXEST0K0dH/iw
	 h1sjjATwUtQX49lOj3sEdBsom2v5r8VuS8gXbvojAfoLitEOoPrsj76+iLp7csGnLk
	 ZQgMuV1IW3DeYygE5s33A+g+u0aLAvlFKZpFti+GOdTr1Kd5bwcDjpAc7to8fpGZ9t
	 IJVkP5pN+bswQ==
Date: Thu, 26 Mar 2026 18:19:24 +0000
From: Simon Horman <horms@kernel.org>
To: Yohei Kojima <yk@y-koj.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: Remove unnecessary backslashes
 in fq_band_pktlimit.sh
Message-ID: <20260326181924.GW111839@horms.kernel.org>
References: <dd0bbd48cdf468da56ec34fd61cecd4d2111d7ba.1774372510.git.yk@y-koj.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd0bbd48cdf468da56ec34fd61cecd4d2111d7ba.1774372510.git.yk@y-koj.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-272202-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,horms.kernel.org:mid,gnu.org:url,y-koj.net:email]
X-Rspamd-Queue-Id: 6EB0933A50F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 02:20:28AM +0900, Yohei Kojima wrote:
> Address "grep: warning: stray \ before white space" warning from GNU
> grep 3.12. This warns the misplaced backslashes before whitespaces
> (e.g. \\' ' or '\ ') which leads to unspecified behavior [1].
> 
> We can just remove the backslashes before whitespaces as POSIX says:
> 
>   Enclosing characters in single-quotes ('') shall preserve the literal
>   value of each character within the single-quotes.
> 
> and bourne-compatible shells behave so.
> 
> [1]: https://lists.gnu.org/r/bug-gnulib/2022-05/msg00057.html
> 
> Signed-off-by: Yohei Kojima <yk@y-koj.net>
> ---
> I tested the patch with bash 5.3.9. I couldn't test it with dash because
> the test depends on a bash extension with "if [[ $# -eq 0 ]]".

Reviewed-by: Simon Horman <horms@kernel.org>



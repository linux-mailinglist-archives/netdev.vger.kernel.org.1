Return-Path: <netdev+bounces-276758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGiiEKTz1mlpKAgAu9opvQ
	(envelope-from <netdev+bounces-276758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 02:32:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7AB3C5082
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 02:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8327302DB4A
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 00:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138B81F4C8C;
	Thu,  9 Apr 2026 00:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHbI5yQ/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CC72BB13;
	Thu,  9 Apr 2026 00:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775694706; cv=none; b=Cv/Q7yIy3EwPex3FpBxwrPrNoA6P1/YZ4T1Ex7CJ70+XX4k4WWPfZglS40KIPVSyMR8gZ+5HUs380vVvvD/rGVDesO2qoScI6X1239bZdQD+PfZ7ENIJiX0LcTO9b708dKBSOzxx7z9fc0m7B48mSM+f1vaXQo6d6VU+vqT0o6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775694706; c=relaxed/simple;
	bh=6uMxltVdw71yYGY6rza2XGO88fluxEIOQpWIc3xuAu0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RzS3XkQ11Owe2OfD2GxbQdiJaERe49uzOBG3S3xpYfugDcSRgSXnqsfXRuPo33TPCJmBGbx0C+NjWJTaIMZLRsu0bYgkLBCMl56y1X8FVEQopxK2hrqSNnf9dCk2qWZOa+KPeGsSi2lwYlbZqTeuWYJo9tsp7RSGqD9ael8+yMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHbI5yQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D82C19421;
	Thu,  9 Apr 2026 00:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775694705;
	bh=6uMxltVdw71yYGY6rza2XGO88fluxEIOQpWIc3xuAu0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RHbI5yQ/M/NVOl98+EDQLEJdXDcha77bdOt9H0EfnOMxafEvDiBsi3HVIOju+yES/
	 7McJ81YNhfLLdX9aJ8z8xCp3l262kSkZw0ZWPuyjgD+ayw0MQhEQmNXWmbRw25q4g+
	 2AY2JfLT1xpeOiD2PMInjaCJxOnnrusny02lp6ngxAgfwtUCbAFMiJc85qpHdaWfF+
	 m9eeQ/ZeLNOixyHk7olFb6IsxYxo7DBzSpPO1DPTXpxlMFPNxGT2ceOfCiaPnrwitI
	 8XLhL8U5NUoIdbAMcRSF0Hyqbtb7e4fUqWUi1vzDRdITxRxjNycVTK+DNz8CN9Qoxr
	 o5ySsMk3X2gkA==
Date: Wed, 8 Apr 2026 17:31:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Harvey <marcharvey@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v6 00/10] Decouple receive and transmit
 enablement in team driver
Message-ID: <20260408173139.6f041d15@kernel.org>
In-Reply-To: <CANkEMgk16j2xzQ85JGQ4OWqeiwiVO5Gy-UfkN3omKkKizpLxiQ@mail.gmail.com>
References: <20260408-teaming-driver-internal-v6-0-e5bcdcf72504@google.com>
	<20260408094015.3b8359c1@kernel.org>
	<CANkEMgk16j2xzQ85JGQ4OWqeiwiVO5Gy-UfkN3omKkKizpLxiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276758-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E7AB3C5082
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 8 Apr 2026 17:10:05 -0700 Marc Harvey wrote:
> On Wed, Apr 8, 2026 at 9:40=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> > It pains me to report on non-debug kernels: =20
>=20
> I'm sorry to have pained you.

To be clear it's a compassionate pain on your behalf, I don' care :)

> Despite my best efforts to run with the exact same environment and
> conditions as your CI, my teamd can be killed with "teamd -k" but
> yours hangs (both are version 1.32 on Fedora with the same kernel
> config). For v7, I=E2=80=99ll invoke "teamd -k" using the timeout utility=
, or
> just increase the test timeout.



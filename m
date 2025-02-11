Return-Path: <netdev+bounces-165074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC3BA304E3
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 08:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0C73A24B0
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 07:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A7A1EDA35;
	Tue, 11 Feb 2025 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ucOxjFb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nzTOMVSh"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E61F1E9B39
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 07:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260323; cv=none; b=LOanV8Fm1zXxjsOAphYGOS3bBg0X3X4pCN7v5KZeZoXimPkrDMReZZcPgP0STEg2wK/UFzcOLOFUK5ZW0feLtAOwkdzXvjSKuHjUu4FWbgRZi8l+k1rEL5PFU7CYbZdJOiTsMWOGA3IC1N9KxBjXtvGGJ9j4nRm+zUPWEZkukIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260323; c=relaxed/simple;
	bh=HtGaK6oDX0UG40KmmNZSuzPzVh7amRv0wg9jndXZgY8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=huFhMFfVgLs1Qg1I5gPR2tQbgx7I/Yw7yt0muNNhyviYX1i4cOktUZLW1Y2OayNcHu2GPYA/2Oh6ozjx+BmKH1A+pxUxaYMxENiE9d0zbkCaXVxBS0jjBg5/zkJTlUCfJRzOn/gO3HUYyhdjGPFMV2OkESW+4EAIimH/6xd2Fz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ucOxjFb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nzTOMVSh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739260320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HtGaK6oDX0UG40KmmNZSuzPzVh7amRv0wg9jndXZgY8=;
	b=1ucOxjFbt/LvXdvt3KBvM1c1DVWfuOQdlmexn5FdHa98NgqcWceV2GReD3SnKJRC+tDB/f
	tOVRag6GGi4/Zuh21eQoSi9PsmZLbhHXQ3tiEcVqkp8RzODODJUVfKK3Fh0Dp2MQXoSkSz
	aCjzl28CiS4wToV5Ysz8vB24YUS5EgS4Gi4zWJ6hqtN5ELbkHOwx5LrEwZkQ1ha+9Of8aq
	RCP+AarfuNHJgWXd0ta8XbNija8YPCS78JkUPnz3ICmVwxiXUe5+FouywzrCLFJF9b/zHB
	j1P4/1C5anuX6aCHsQFHUsy7bsEsNjqIYLcH9yaG9y8Yd0U1gyrXAuW9fikpfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739260320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HtGaK6oDX0UG40KmmNZSuzPzVh7amRv0wg9jndXZgY8=;
	b=nzTOMVShrhsUPaj9YUfVjWmKgI88INRVn6xKDWVEwROHUgOgd73ivfyHjUTAOOPIhvGQsB
	2oepvfeyV3S3wQAQ==
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Joe Damato <jdamato@fastly.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH 3/3] igb: Get rid of spurious interrupts
In-Reply-To: <b1b3e5e1-b1fe-4816-85eb-61ac7ea2d46d@engleder-embedded.com>
References: <20250210-igb_irq-v1-0-bde078cdb9df@linutronix.de>
 <20250210-igb_irq-v1-3-bde078cdb9df@linutronix.de>
 <b1b3e5e1-b1fe-4816-85eb-61ac7ea2d46d@engleder-embedded.com>
Date: Tue, 11 Feb 2025 08:51:58 +0100
Message-ID: <87y0ycor4x.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Mon Feb 10 2025, Gerhard Engleder wrote:
> On 10.02.25 10:19, Kurt Kanzenbach wrote:
>> When running the igc with XDP/ZC in busy polling mode with deferral of hard
>> interrupts, interrupts still happen from time to time. That is caused by
>> the igc task watchdog which triggers Rx interrupts periodically.
>
> igc or igb?

igb of course. Thanks.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmerAZ8THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzghbyEACnG4nKwnwLzG7XqGFj1yLSRInPQBav
XxoMAy9cLeh9Apn65tVBBvcycgGgX2SaDQeMhKFYw9DNrmNTvo3ZqPVemNksQC2D
YO9IlDKQzRPT5mWTLT/95vM0qUYl3MSt54RkiiY/d38zwUF/PtXJU4lKPap45zfu
KI4D7MCuDftc35PoFDU1h/JiLeO5QmRS4S0VKvZQx6vU0XyMhGMQR7DOIFT/DySI
kYX05LLnHR+N/zqyvC5z3dSCf+datdfKibpoOUzZx/+ZVU72cpGrh7gKMThLh4Ql
mOPiORXwFtW7cuIuTvuzwAotaCOOj6E0fGVKH3lvBGKyG60iQdMCu5sZLGAVx+FJ
9kaesl3JGIuCRvqulE6EZzEJn2xqVQCCl4lTaknBEcR7HElliQ0Lka/6CZrWtPMP
1EAkMU437NxuKzSNdbXVyEp0EMMFaA93/vbZUw8WEPahikqOxYdmb0EJ7sfsvC/n
IQNISTt0/FLZYj+FlgEuL0Kr4xnS22ld4fkZNnyQQ7kTIWSC7ClI40yNaUNq2rCG
4RFXLzoTBpuw7gXtR+mUg4ZYUklNC1UMJv5k5JLxCquwoRG/jB1VoUUq3Jsqs4Rs
3OWNUiJKbXw5uU50ZGFzR8F4mZJFo6BOatcfvCGZwUGtVGJ6nxaIcg3MZwWeclkT
UbrZ+5MKsyneEg==
=TTNU
-----END PGP SIGNATURE-----
--=-=-=--


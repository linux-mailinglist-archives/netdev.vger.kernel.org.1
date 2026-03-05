Return-Path: <netdev+bounces-264229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAmuBopFqWl53gAAu9opvQ
	(envelope-from <netdev+bounces-264229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 09:57:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9846220DD32
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 09:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 267BF302E7A9
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 08:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50E4372EC5;
	Thu,  5 Mar 2026 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g8zxm0UO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="57KdUgHm"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675232609EE;
	Thu,  5 Mar 2026 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772700957; cv=none; b=rQfYkgq0Py5WSo3eIQ+ZkIajujNr2kRBr4BhSmPD5U2xqBYbuIDxULkcX65EpaZSVIsa41ruXfysiVsxhQQsBsqteJsQYvrADo9Zbve7cLK0PpiLIxkYK8aTKcwdbNY62b4T1gJUWYkPa1x2wM77iB2jtkvNHHpHh84bajIF5MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772700957; c=relaxed/simple;
	bh=tdiSSpWSH2rXlDO+aTYlglUyAiN13r4ToBuz0sTUbGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g4axjh4pEkjHKU1nUbBoYPtpaBvN1q0AGQCixt3w/DZE8LaNs/aBw6oQZ+jVjhODhzgUYq8/n7uWYSHtAR0gqpkN/+uQSNxFoVhr7F8AHguHJUiP97yUlPiDyXBX7/3Mi4nKSIepCCZZFwX5HjBAvefA7Bf/JvUSD85Gpsg9ttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g8zxm0UO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=57KdUgHm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772700954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ecqro3YS78h33SUaUsJYIVaoB0LHuu2VIDT6L98U+ZU=;
	b=g8zxm0UO+kYJydvh1gWJZkCT+dKwS0pl90SUdHLmfQ4K5Lm0U3H+xs52y/+nZILqf+Vt2h
	00zGgW4a/bQM3PPFHLF8Q26jDBJvgnptZrTX8zlvbncO13NhMIzCkZIj1bb3MLA5YakQIr
	3yNg9jbqq2Av2G169EYRFyBy4PWiOkb5ZeXHvHDAqjCUamFegvw5gA6aTGPLf6Lalc4R2r
	Lluv6c/YXLRXkJap4FaxyL9Utv05JihGu6oAjCPc7fqFu9iDedvKeDn+HoFZL9af26+6mx
	GqLtl+RovxzqBh5l2T+PZQY6KHxgCMPcN07IP2Utl3j3VXkcAeu6TpRlsrensA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772700954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ecqro3YS78h33SUaUsJYIVaoB0LHuu2VIDT6L98U+ZU=;
	b=57KdUgHm8XZ5ZyAILCqJCRhioJDmsfvZQ4foBQSX4OSPxosP3hojz58idK/qgceU9NqX4y
	Gj1t5GqqfGthbbCQ==
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Vinicius
 Costa Gomes <vinicius.gomes@intel.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Jacob Keller <jacob.e.keller@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next v4] igb: Retrieve Tx timestamp from BH workqueue
In-Reply-To: <aaf8xVPWQ0-y1BnX@localhost>
References: <20260303-igb_irq_ts-v4-1-cbae7f127061@linutronix.de>
 <9805389e-9ea4-4e7a-a122-65f733ead33c@molgen.mpg.de>
 <87qzq1rq2k.fsf@jax.kurt.home> <aaf8xVPWQ0-y1BnX@localhost>
Date: Thu, 05 Mar 2026 09:55:52 +0100
Message-ID: <87seae4puv.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: 9846220DD32
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-264229-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[molgen.mpg.de,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,linux.dev,lists.osuosl.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kurt@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:dkim]
X-Rspamd-Action: no action

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed Mar 04 2026, Miroslav Lichvar wrote:
> On Tue, Mar 03, 2026 at 02:38:11PM +0100, Kurt Kanzenbach wrote:
>> > It would be great, if you shared the numbers. Did Miroslav already tes=
t=20
>> > this?
>>=20
>> Great question. I did test with ptp4l and synchronization looks fine <
>> below 10ns back to back as expected. I did not test with ntpperf,
>> because I was never able to reproduce the NTP regression to the same
>> extent as Miroslav reported. Therefore, Miroslav is on Cc in case he
>> wants to test it. Let's see.
>
> I ran the same test with I350 as before and there still seems to be a
> regression, but interestingly it's quite different to the previous versio=
ns of
> the patch. It's like there is a load-sensitive on/off switch.
>
> Without the patch:
>
>                |          responses            |        response time (ns)
> rate   clients |  lost invalid   basic  xleave |    min    mean     max s=
tddev
> 150000   15000   0.00%   0.00%   0.00% 100.00%    +4188  +36475 +193328  =
16179
> 157500   15750   0.02%   0.00%   0.02%  99.96%    +6373  +42969 +683894  =
22682
> 165375   16384   0.03%   0.00%   0.00%  99.97%    +7911  +43960 +692471  =
24454
> 173643   16384   0.06%   0.00%   0.00%  99.94%    +8323  +45627 +707240  =
28452
> 182325   16384   0.06%   0.00%   0.00%  99.94%    +8404  +47292 +722524  =
26936
> 191441   16384   0.00%   0.00%   0.00% 100.00%    +8930  +51738 +223727  =
14272
> 201013   16384   0.05%   0.00%   0.00%  99.95%    +9634  +53696 +776445  =
23783
> 211063   16384   0.00%   0.00%   0.00% 100.00%   +14393  +54558 +329546  =
20473
> 221616   16384   2.59%   0.00%   0.05%  97.36%   +23924 +321205 +518192  =
21838
> 232696   16384   7.00%   0.00%   0.10%  92.90%   +33396 +337709 +575661  =
21017
> 244330   16384  10.82%   0.00%   0.15%  89.03%   +34188 +340248 +556237  =
20880
>
> With the patch:
> 150000   15000   5.11%   0.00%   0.00%  94.88%    +4426 +460642 +640884  =
83746
> 157500   15750  11.54%   0.00%   0.26%  88.20%   +14434 +543656 +738355  =
30349
> 165375   16384  15.61%   0.00%   0.31%  84.08%   +35822 +515304 +833859  =
25596
> 173643   16384  19.58%   0.00%   0.37%  80.05%   +20762 +568962 +900100  =
28118
> 182325   16384  23.46%   0.00%   0.42%  76.13%   +41829 +547974 +804170  =
27890
> 191441   16384  27.23%   0.00%   0.46%  72.31%   +15182 +557920 +798212  =
28868
> 201013   16384  30.51%   0.00%   0.49%  69.00%   +15980 +560764 +805576  =
29979
> 211063   16384   0.06%   0.00%   0.00%  99.94%   +12668  +80487 +410555  =
62182
> 221616   16384   2.94%   0.00%   0.05%  97.00%   +21587 +342769 +517566  =
23359
> 232696   16384   6.94%   0.00%   0.10%  92.96%   +16581 +336068 +484574  =
18453
> 244330   16384  11.45%   0.00%   0.14%  88.41%   +23608 +345023 +564130  =
19177
>
> At 211063 requests per second and higher the performance looks the
> same. But at the lower rates there is a clear drop. The higher
> mean response time (difference between server TX and RX timestamps)
> indicates more of the provided TX timestamps are hardware timestamps
> and the chrony server timestamp statistics confirm that.
>
> So, my interpretation is that like with the earlier version of the
> patch it's trading performance for timestamp quality at lower rates,
> but unlike the earlier version it's not losing performance at the
> higher rates. That seems acceptable to me. Admins of busy servers
> might need to decide if they should keep HW timestamping enabled. In
> theory, chrony could have an option to do that automatically.

Great! Thanks a lot for testing and sharing your numbers.

I'll send v5 then with updated changelog as suggested by Aleksandr and
Paul.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmmpRRgTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgnfXD/9TOnDNTDngr0PXrCtQH9FliXc8zyXZ
fU5BOkrfttxRPocIgW3SSBLdNuyEhA/yBRjT1jnbPzc3qnZq4jvykXPpzS3CiVbg
eTM3f9zJWeFRBTEH1593e3CRNF6N4GMeDjWfnWYFwwgzcq87ifH5BZm36mdTVBPo
QhvO53dFSWdilG1AEc5RTc5Ltjc5cLWpK2LETxISJdA0+vYty3HKFSSZ3niEkxO7
AW6NhQKXowYuOa0yXmuhtGqDZGZ3TIyKAGJoS3rsAb0NyjW7mV3jTwlMMpY2OhHm
pVlOEs2qbMZQF4zElGubGiVNMGLSw/NYTnjgrFep02FykjPuXSh+3A3ZXL5ks2R1
WW8z98HNdUjeEyj7+DMfRPXTsHil4wKeBW+P8G5lLV9RdC9Mw6sUH+mfNhO4IB5m
O3avxJQZaYwYrnumpTWVIrYl+GN1qo8X6QvaM94+wX2agFA8nt9s5zxAclxYWPbc
cvUs/D8bO0+QQe1ZDGhmqLV97rVr3IttAcyDp1a+IHrYT4OtFBzW/wXIS4hsqjDc
SDzDh3q0CXkXGX2MGGzx8R5H9t+Di65UC71Mk49WSCx/d1WdHIdSuoPnrDp+cITa
QHyCdTzHhBZEBltEGUMl2COP+lQRgNhqIRciJddZWqNZKkMxSEuqIrZDvpgbV4M/
LG/gG9sVUNvAjw==
=8NQy
-----END PGP SIGNATURE-----
--=-=-=--


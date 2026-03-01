Return-Path: <netdev+bounces-262448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCg9MzaHpGlsjQUAu9opvQ
	(envelope-from <netdev+bounces-262448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 19:36:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E881D11D5
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 19:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DA053011BE1
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 18:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9213112BD;
	Sun,  1 Mar 2026 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="L+1g2+I8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5004D3043D6
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772390187; cv=none; b=N+AxJXsZGAyUMlLvQ2SDCEMzhJnWyGAHb3gCkEaGBndU1FZhQA4CwG4V4n0c51Ojr00B/PCJDcVHgVVKvKkhXNGBS8q4nfBTKpdP8tD2FDnDSDatbOjb7q2GhS6VRRvP+iLn+lljUWCBz0UtINCBqr5aCSh0NL8b9HE3XAlaz8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772390187; c=relaxed/simple;
	bh=1ObvqHsTsalxqDbL21MtuhPVcgQdYauVsk3uuRKAByM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twukguXAEjiunuWZA13YpvWZKjBOvyus4DmWvuevqgHoIFbZxFlOYzbZ9oFWyHxPmoSUrvo/AC4CgSKegFw6/CSE6YekKGhc2BKYnYO19NHy0sUa3A1BF0JBuRY1lrBnMYmCzDcZW2t3abTwYPE1gS6ayYCPfGfjwpemdrIisjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=L+1g2+I8; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12713e56abdso2155882c88.1
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 10:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772390185; x=1772994985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8iKVITopDTVtBsFNrs/1a92xZRkWVvA1ZIYWlvVsSA=;
        b=L+1g2+I83OcqfrG3Fv6xz1HGQ/nD92l9oM+H282ZgEMLoeqHGt+baWy0+0VTNuuPxy
         DcRWBm93T35TarlXzDvz5iQrsr9U1ctRv445nvIcJyUhKyG7qnxZkE0RUfD3YIUwrZXb
         YC4tPQqqjwGnF60F+xlcp0o5EqeasW2qYXc6j8OKUqOxxMuQ984vqYBBCyt07Z+x+y9M
         OPHArTLWi0DHOw1qzv/S+amAEnW4/1J79Myf+8hpJfb4PUTjVG9ED4vOctJGkt0be+cs
         fgzmpHHamBhfcR3Vxgk+LgZQjH2TGr/PtH5UX3iicOqqY92CecjAMYCba2gXx7GZWPfK
         uzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772390185; x=1772994985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L8iKVITopDTVtBsFNrs/1a92xZRkWVvA1ZIYWlvVsSA=;
        b=vhNzzIP9E885U5VC+UzA5U7uZKHuikI7mlE1rN5Vx/fNdV+BviMEUXN4POk+SMbiSa
         QX8jUx7wWEyRksSajVyHHKWqcMRxjW1M16zej+udNOlxDdHT6U3EqON6r2cZbOS0+YzG
         SH4crbGwfyloMEjm2cK0GP502AZGQy2YGHN4YwCxQNbWjKxp7oS16aLqcxkKW8P76Tbt
         cis2WaohwsHqJIgk7KKzI30aWL2KNS75O9uBTP5yC/i4Y4gP1A4gvoiMRdjGTbvPGUq+
         LIdgc3+cDztPmSU3OJ18Vx4DMvY9sNpl50OdG/T9Bi/nsLgsY7IzFYkbjrWpqVoPKqos
         sJVg==
X-Forwarded-Encrypted: i=1; AJvYcCVnrt0DD8zHWC0bUz6LNKbb59BPb5OUjhOi9WZihIP8UPPNZNGXJ92/igzh1ziaJ5jaarIRs+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2MP6+hcuUUmQvk2WwPpMiVsYb0KdUFhkes5cBoTV/RLOsbTBb
	vPht/KAjceXq6UuRwaFG/t2hchtjONwCsVBtVzhvK4Qks3ynbkIhUx3tyIJ9LYCM30M=
X-Gm-Gg: ATEYQzwYepW54WQnGhrRLU3XJGE/MALWS5mhEuFSbt/6Kl5uoD6BzxurFLfB2blx8pP
	WXwCJTWObYpv0zipoUSPDGUIk4x3OpsOSRIAvfsHG3ng/ObR04VeEp3+Y4IoeM2W6ukyb+KQHUe
	3hQz9qPTYow4kPMJ4NxDNR2G8cglBEXhh+6qfNADNwRaaIann7Kmx3WgfVfh3IbCqPL2poM7y9L
	iPCkiRokh704Ckh5Bm92pud6idEFPzj9XOp7cZ4xQxSWfAXGaa33Csw7iLWpLlx7n+03V3fhsh/
	fWoOx06gOlVis3QrSLI9EFJSJFI6HUOgApc7yi1S4ZDwsV7IqSv42N+IWtmGR0Mq5DYj2eUPeTa
	csoob6N4KVArsElVYoTtxQD9fIy1fwyAXR8rGjn407uiWEkOBl4+5+VCOQYb0VhlqtjdClJL8k1
	VA6vVz/uG7j4Tw3xfMuygbMzkreTomAxyOqR6blUbzPoRWVI+3HA6lMkzQiDuEUMHB
X-Received: by 2002:a05:7022:618e:b0:123:3a91:f563 with SMTP id a92af1059eb24-1278906bebbmr5013655c88.8.1772390185264;
        Sun, 01 Mar 2026 10:36:25 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899eab46sm11003870c88.8.2026.03.01.10.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 10:36:25 -0800 (PST)
Date: Sun, 1 Mar 2026 10:36:22 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yedaya Katsman <yedaya.ka@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Petr Machata <petrm@nvidia.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH] ip: Make 'ip stats help' exit with -1
Message-ID: <20260301103622.44ef19d7@phoenix.local>
In-Reply-To: <20260301-ip-stats-exit-code-v1-1-2b59f0704f2c@gmail.com>
References: <20260301-ip-stats-exit-code-v1-1-2b59f0704f2c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262448-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,phoenix.local:mid,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 20E881D11D5
X-Rspamd-Action: no action

On Sun, 01 Mar 2026 16:12:03 +0200
Yedaya Katsman <yedaya.ka@gmail.com> wrote:

> ip <subcommand> help exits with -1 for all commands except for stats, make
> it match.
> This removes a goto err, which is redundant since "enabled" gets
> allocated only if we find a level, but we enter do_help only if we didn't.
>=20
> Fixes: df0b2c6d0098 ("ipstats: Add a shell of "show" command")
> Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>

You raise a good point, but not sure that fixing just one corner is the
right answer here. Most of iproute2 gets this wrong already.

The (poorly documented) convention for help in Unix commands:
Output destination: stdout (not stderr).=20
Help text is expected, requested output =E2=80=94 not an error.
This matters for piping, e.g. command --help | grep something.

Exit code: 0 (success).
The user asked for help and got it =E2=80=94 that's a successful operation.

Contrast with error cases:
When a user provides an invalid flag or misuses the command,=20
the usage/error message should go to stderr with a non-zero exit code
(typically 1 or 2 =E2=80=94 2 is common convention from many GNU tools for =
usage errors).

In practice, this is codified in the GNU Coding Standards,=20
which explicitly state that --help should print to stdout and exit with sta=
tus 0.
POSIX doesn't mandate -h specifically, but the GNU convention is widely fol=
lowed and expected.
A surprising number of tools historically got this wrong (sending help to s=
tderr or returning non-zero).

But iproute2 does not follow this convention.
Fixing it might be a good idea, the kind of thing AI refactoring might help=
 at.

An example which should print nothing!
$ ip help >/dev/null || echo broken=20
Usage: ip [ OPTIONS ] OBJECT { COMMAND | help }
       ip [ -force ] -batch filename
where  OBJECT :=3D { address | addrlabel | fou | help | ila | ioam | l2tp |=
 link |
                   macsec | maddress | monitor | mptcp | mroute | mrule |
                   neighbor | neighbour | netconf | netns | nexthop | ntabl=
e |
                   ntbl | route | rule | sr | stats | tap | tcpmetrics |
                   token | tunnel | tuntap | vrf | xfrm }
       OPTIONS :=3D { -V[ersion] | -s[tatistics] | -d[etails] | -r[esolve] |
                    -h[uman-readable] | -iec | -j[son] | -p[retty] |
                    -f[amily] { inet | inet6 | mpls | bridge | link } |
                    -4 | -6 | -M | -B | -0 |
                    -l[oops] { maximum-addr-flush-attempts } | -echo | -br[=
ief] |
                    -o[neline] | -t[imestamp] | -ts[hort] | -b[atch] [filen=
ame] |
                    -rc[vbuf] [size] | -n[etns] name | -N[umeric] | -a[ll] |
                    -c[olor]}
broken




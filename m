Return-Path: <netdev+bounces-267260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF0YJqtos2klWAAAu9opvQ
	(envelope-from <netdev+bounces-267260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:30:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1641227C42C
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA3C0305CA02
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B26B2798EA;
	Fri, 13 Mar 2026 01:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMW8rj0B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584E8156677;
	Fri, 13 Mar 2026 01:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773365416; cv=none; b=JeD+m23xzb/l+LHoPbNck18NfXDH2V6enCQLd9NEQDubmagunJvMojdRWt78gELRnLTURj1WlyT3o4MF4UM48oS9ewJaEUmeMR2J9HoZmxD0sPWt1g3PAS6sY4dFom5Q/wqahEh+RuDIBJZ9ZlrKji7NGECTAVlXqwn0EGb4+RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773365416; c=relaxed/simple;
	bh=MbFGjkKbgw4ZDpQA4ICNacpqF+CouYS6lH+ZiFq2ofk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLVr3M3ZXfE+JZLuskyxOLduTIspLcD2UJZ2a49D/Uadih+D/C4DOBgFi3JEcqcE0zMPrru+hNEe080thaOTO02xw3KXesJlPqfZw4JKN17FhEL83kwUgQ4siDAcApc4z/ufLHPi02t4OOmT/RJkbilIS+JuYJciLQMSpkVDxb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMW8rj0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CE4C4CEF7;
	Fri, 13 Mar 2026 01:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773365415;
	bh=MbFGjkKbgw4ZDpQA4ICNacpqF+CouYS6lH+ZiFq2ofk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HMW8rj0BhL/TuRONoJ/qimsUnVigFKmOt2h/G8lJ3CxWYk6qOhsVVRong8KKVIOST
	 Cc3bZ9jUm2p3ZPmu3xszro1j2cLK2e3XbYBtw8e43ocZzLLVWPs8sA7uHTo7zVje9o
	 kLx9Ak0mzk7We8YpkMpfsL8tmOL9qbHE21N2XNp4bpG7E6uXapb4QpcHT6k/S+QvHV
	 FmkchlKMOvm42uUsSJ3MRnAmuFaXx4cFKPVijGKbQTgqwr+1iGkGgDWSPXd44q4/6d
	 U+mi4nlfynP/LqmERwNTtocrUc7Qimgb2AUjYv9sEecvRyTmsk9U3ai0YZSghF7Xuw
	 DYIBrhLhTTnrA==
Date: Thu, 12 Mar 2026 18:30:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?B?QmVub8OudA==?= Monin
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Paolo Valerio
 <pvalerio@redhat.com>
Subject: Re: [PATCH net-next v2 2/2] net: macb: distribute evenly Tx SRAM
 segments
Message-ID: <20260312183014.658ffa8b@kernel.org>
In-Reply-To: <20260311-macb-set-channels-v2-2-982693a1f5fc@bootlin.com>
References: <20260311-macb-set-channels-v2-0-982693a1f5fc@bootlin.com>
	<20260311-macb-set-channels-v2-2-982693a1f5fc@bootlin.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-267260-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1641227C42C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 17:41:54 +0100 Th=C3=A9o Lebrun wrote:
> GEM has registers to configure the Tx SRAM segments distribution across
> queues. The reset value is apprioriate (even spread) but we need to
> care if/when number of active queues is modified (or if we inherited
> unevenly initialised hardware from bootloader).
>=20
> To distribute segments, we take as input the number of queues
> (bp->num_queues) and the number of segments (found inside DCFG6).
> Its output is a number of segments for each queue, formatted as
> powers-of-two (eg 2 for queue 0 means it has 2^2=3D4 segments)

allmodconfig builds are not happy with whatever is going on here:

ld.lld: error: undefined symbol: gem_sram_distribute_segments
>>> referenced by macb_kunit.c:13 (drivers/net/ethernet/cadence/macb_kunit.=
c:13)
>>>               vmlinux.o:(macb_sram_segments_test)
>>> referenced by macb_kunit.c:51 (drivers/net/ethernet/cadence/macb_kunit.=
c:51)
>>>               vmlinux.o:(macb_sram_segments_gen_params)

ld.lld: error: undefined symbol: kunit_binary_assert_format
>>> referenced by macb_kunit.c:29 (drivers/net/ethernet/cadence/macb_kunit.=
c:29)
>>>               vmlinux.o:(macb_sram_segments_test)
>>> referenced by macb_kunit.c:34 (drivers/net/ethernet/cadence/macb_kunit.=
c:34)
>>>               vmlinux.o:(macb_sram_segments_test)

ld.lld: error: undefined symbol: __kunit_do_failed_assertion
>>> referenced by macb_kunit.c:29 (drivers/net/ethernet/cadence/macb_kunit.=
c:29)
>>>               vmlinux.o:(macb_sram_segments_test)
>>> referenced by macb_kunit.c:34 (drivers/net/ethernet/cadence/macb_kunit.=
c:34)
>>>               vmlinux.o:(macb_sram_segments_test)

ld.lld: error: undefined symbol: __kunit_abort
>>> referenced by macb_kunit.c:29 (drivers/net/ethernet/cadence/macb_kunit.=
c:29)
>>>               vmlinux.o:(macb_sram_segments_test)
>>> referenced by macb_kunit.c:34 (drivers/net/ethernet/cadence/macb_kunit.=
c:34)
>>>               vmlinux.o:(macb_sram_segments_test)


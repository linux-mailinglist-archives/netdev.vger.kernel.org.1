Return-Path: <netdev+bounces-254550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PNVyK8Dhemnh/AEAu9opvQ
	(envelope-from <netdev+bounces-254550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:27:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F65ABAC8
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0979930166EB
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 04:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A93F28B4FD;
	Thu, 29 Jan 2026 04:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgTdV3Bt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FDA2586FE
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 04:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769660861; cv=none; b=EI3Yi620YFG310vzv0BAPyj9MvbweFoQL80VZckLWQ8Vr6QMF4cNKUl1fautpfisvZkgR4lA9MiIN3qQX2zTzsze7onFa4tOKbVcXCrJM27t9pFfjJecbCh+7Y8W5S99m/8vPPNeQSLv6AgXpmQkW5HJyrA/NJgqZYZRtEAVRl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769660861; c=relaxed/simple;
	bh=4d1E1Kgqrk7jtfKN+WbGmnwelRQwKo3JX3U3ym0jIf8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RkedF0LXZskc9h7w0TeSe+NlXFaRoB6PbgFSNv+yJM3lF1yZsRNXoduQ3pGXyexMkzKEaijw68ai0GmmqcItzT7jNIqgpi3xID31U7mlsxS3PLK+IjwYrIfC964K1iPhSQscNK+bEudePsGB/KxlsmujGFQWG5+XZ3jd4c+vCPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgTdV3Bt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E80C116D0;
	Thu, 29 Jan 2026 04:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769660860;
	bh=4d1E1Kgqrk7jtfKN+WbGmnwelRQwKo3JX3U3ym0jIf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mgTdV3Btju8w2u/jExh3atbm7kGC58Z80502KhmUzU0BEk5XlZPH6wh2lf8FUV4jr
	 xm/9y1HsZs2Z/zSAMg44FzbmbLao06+WF3eqwNB3s3aAR3g9+2aRV1IHn11Y2DvyL+
	 YN6w9fXWAy+8v4MqPGKRtxnlJyASSd04mY9yMxsvGYjpR58nuTZcaZpG2d8fexHLUG
	 s+hN9FqNx+8Sdh4OSoqgCVRDhmnN5hKSgthN4VhGa/cvPy4pWsUovm8gaDT7atOvbC
	 zWkhBWXuELmzbx88Sh4brJ9IyuohDjk4+g0jWNl//wuUK1rtDAlJhyqCO9ul2JDCNy
	 2nQEWBfkfHILQ==
Date: Wed, 28 Jan 2026 20:27:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marc =?UTF-8?B?U3XDscOp?= <marcdevel@gmail.com>
Cc: willemdebruijn.kernel@gmail.com, pabeni@redhat.com,
 netdev@vger.kernel.org, dborkman@kernel.org, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net v2 2/4] selftests/net: add no ARP b/mcast,null
 poison test
Message-ID: <20260128202739.79af1bb8@kernel.org>
In-Reply-To: <713d6f1ca57b402be420ade1331acee4898675c4.1769464405.git.marcdevel@gmail.com>
References: <cover.1769464405.git.marcdevel@gmail.com>
	<713d6f1ca57b402be420ade1331acee4898675c4.1769464405.git.marcdevel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254550-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,kernel.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amt.sh:url]
X-Rspamd-Queue-Id: F3F65ABAC8
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 00:53:03 +0100 Marc Su=C3=B1=C3=A9 wrote:
> Add a selftest to test that ARP bcast/mcast/null poisioning checks
> are never bypassed.

> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftes=
ts/net/Makefile
> index 45c4ea381bc3..a765f1800752 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -9,6 +9,7 @@ CFLAGS +=3D -I../
>  TEST_PROGS :=3D \
>  	altnames.sh \
>  	amt.sh \
> +	arp_no_invalid_sha_poision.sh \

alphabetical sort pls

>  	arp_ndisc_evict_nocarrier.sh \
>  	arp_ndisc_untracked_subnets.sh \
>  	bareudp.sh \

> +readonly V4_ADDR0=3D"10.0.10.1"
> +readonly V4_ADDR1=3D"10.0.10.2"
> +readonly BCAST_MAC=3D"ff:ff:ff:ff:ff:ff"
> +readonly MCAST_MAC=3D"01:00:5e:00:00:00"
> +readonly NULL_MAC=3D"00:00:00:00:00:00"
> +readonly VALID_MAC=3D"02:01:02:03:04:05"
> +readonly ARP_REQ=3D1
> +readonly ARP_REPLY=3D2
> +nsid=3D100

unused? (please run shellcheck)

> +ret=3D0
> +veth0_ifindex=3D0
> +veth1_mac=3D

> diff --git a/tools/testing/selftests/net/arp_send.c b/tools/testing/selft=
ests/net/arp_send.c
> new file mode 100644

Could you check if mausezahn from netsniff-ng can send these
packets already? We already depend on mausezahn for other tests.

Similar comments on patch 4, I'm not gonna repeat.


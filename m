Return-Path: <netdev+bounces-258172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JNSJkDli2kVcgAAu9opvQ
	(envelope-from <netdev+bounces-258172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 03:11:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1249B120B52
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 03:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9C39301385A
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 02:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F702F3C3D;
	Wed, 11 Feb 2026 02:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGmPUVMA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BFD2D3225
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 02:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770775868; cv=none; b=Dsoyy01yrejt+A6IbQGrHKDPa1UE+f+QEc9Pt0NZ0UpzCfo3iX4hXrTAHzjUUjBHLWrngsSlYa7+OXeOZG6NhSYxQRJwf9OVe6uh9TMR6RNlAqDuPnwtC5Op9uR3mUEeHo3lkcAdMAQEOwGX+qMI4pK+DErIreM8xloJeeGuwNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770775868; c=relaxed/simple;
	bh=TLPtn6WOJKw0EpOKNmZoT7Lr0kSiJskkgtAG2jc/JZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oCxPtF4AmFIaImPLK3t6G/ivC+AEWTTyUJ4rsR/Sw/q8XppHy0tbfvRYyhr0AYLcmVfWJ10J/PQ8kQw/P8CCm/OvvatoUCP77ni9BJO28J6cwv0i0P8q0ugrky6+SgaGm32ALaVV6Gzew0Rp50DSxiePoiDPaQv8HJEAiddoYHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGmPUVMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9E6C116C6;
	Wed, 11 Feb 2026 02:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770775868;
	bh=TLPtn6WOJKw0EpOKNmZoT7Lr0kSiJskkgtAG2jc/JZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TGmPUVMAGJRAPYk/qP3GFfu64HHbYnTSSkoDaX2NBkNW6r9y08R6815Wd19KMgRs+
	 xeFCHHyzUEg3hIvwDhD/VIdtkm9J/YWlQVzuq9UgTYawYxlUF8KZL5eLfpimc5IKXA
	 8cXjQzkEPmtC/S7m3DilGjh5E0FCc6J+RIbJPDFBpUBKuUN6NZ6AOt719nnOsZyrZE
	 gnPA4KKxh43qCyFQre3N2nIgj62HRgQh6Wos+OiPETiTfC10lvFyUPpWGBoHRAsGFY
	 bwcvSwuqRtjXPofHL3JzWivE+c5ZPHIegbHkp4NgezXuUQF81lK/irTrlv32WDnPSp
	 /TeG6OxHzMNSg==
Date: Tue, 10 Feb 2026 18:11:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marc =?UTF-8?B?U3XDscOp?= <marcdevel@gmail.com>
Cc: willemdebruijn.kernel@gmail.com, pabeni@redhat.com,
 netdev@vger.kernel.org, dborkman@kernel.org, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v4 2/4] selftests/net: add no ARP b/mcast,null
 poison test
Message-ID: <20260210181106.0f4a305a@kernel.org>
In-Reply-To: <19761bd8088ea7bab2b8c37461aa77be08082fc4.1770399836.git.marcdevel@gmail.com>
References: <cover.1770399836.git.marcdevel@gmail.com>
	<19761bd8088ea7bab2b8c37461aa77be08082fc4.1770399836.git.marcdevel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258172-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,kernel.org,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arp_ndisc_evict_nocarrier.sh:url,arp_no_invalid_sha_poision.sh:url,bind_bhash.sh:url,bareudp.sh:url]
X-Rspamd-Queue-Id: 1249B120B52
X-Rspamd-Action: no action

On Sat,  7 Feb 2026 21:40:34 +0100 Marc Su=C3=B1=C3=A9 wrote:
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftes=
ts/net/Makefile
> index afdea6d95bde..c6d571bf72be 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -11,6 +11,7 @@ TEST_PROGS :=3D \
>  	amt.sh \
>  	arp_ndisc_evict_nocarrier.sh \
>  	arp_ndisc_untracked_subnets.sh \
> +	arp_no_invalid_sha_poision.sh \
>  	bareudp.sh \
>  	big_tcp.sh \
>  	bind_bhash.sh \

Not sure why but we get:

# selftests: net: arp_no_invalid_sha_poision.sh
# Warning: file arp_no_invalid_sha_poision.sh is missing!
not ok 1 selftests: net: arp_no_invalid_sha_poision.sh

When we run=20
	make TARGETS=3Dnet run_tests

The word "poison" is misspelled but both in the file name and makefile.
I guess there's another typo somewhere.


Return-Path: <netdev+bounces-305817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1mDfEIZRTmquKgIAu9opvQ
	(envelope-from <netdev+bounces-305817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:32:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DE6726D33
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:32:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cf9eQrzY;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305817-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305817-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F462303FAD6
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 13:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE0E33BBC6;
	Wed,  8 Jul 2026 13:28:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FEE33F591;
	Wed,  8 Jul 2026 13:28:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517310; cv=none; b=FBQBi4B7hjTsRsr6y07jRBkst4Lldpuu4HdnKosjpzz8N3V41aftmIpsEReTh/SuW/1r4DKFBCTHQqMlGkm9lp2xuE8Bxw+C/p5+exuUp1DcP+FVRhtSE0kKEXxCaKWFik5oeF4zeJpZNzifaZRxTaWgyf++NO3ms21Ei0sVFpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517310; c=relaxed/simple;
	bh=zDaESKBTYy4jlyC3dl7SAdhWIb6bcGpfhcnF1zMQ4QI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tCB6rKEG3FINLgS6vyciNKte4Y7PrsriBjsBh3I0I2uVolIxNoHG6LuPvxpaX6gkYJvHPq3sEnNaniqURCvKW8ef9uiMPI/95EaxmSygUbk9ISITRhWKDiiwK2Jn2YiN4sXn3v0fPneZzGfHT/XEIMCKuO9G2iseBYrhjdO7Jg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cf9eQrzY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F871F000E9;
	Wed,  8 Jul 2026 13:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783517307;
	bh=ErTICou7hVajnT0Tkw4wgoMeIyyZeH0Ei8wY6hC32YE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cf9eQrzY/qXpDWv94NIcSNOogqURsFqT5oeggOZh3wXmktJmDNexK6hxrimRyhBIk
	 TKe+WhQOTz9pBAypnCuf9szvS7c+/oWS/9jQzAhbqS/wCUnQQuD9fBihnWeoak8p7D
	 +JkHyR+pUreDy0N0cm76qLWkFf1C1UsKzix80go8ezNeszoKwkOVhBOv2cl8UWN+ph
	 o6sIhvSuCk4OjJIMfYv8REmbSlcQ3Qh9bscQ/0c6O7WCdGqc2SPJEAxDAHmkHvuhN3
	 aFAAV41C7oVu6gibY5VbQ5dg/uoei+RZ/GSUH4AYoXlx9qQ8uxcoyXPzevdojPQevq
	 EXVE+rbfLRmcA==
Content-Type: multipart/mixed; boundary="===============9166916302589270823=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0b7502b52100d29cb13a190835864be85e2d69967a8df8125b9762492ba4f368@mail.kernel.org>
In-Reply-To: <6c7a059057d309e999b706b5b547be9c620ce544.1783514455.git.deliran@verdict.gg>
References: <6c7a059057d309e999b706b5b547be9c620ce544.1783514455.git.deliran@verdict.gg>
Subject: Re: [PATCH bpf-next 1/1] selftests: drv-net: add XDP RX checksum metadata tests
From: bot+bpf-ci@kernel.org
To: deliran@verdict.gg,lorenzo@kernel.org
Cc: sdf@fomichev.me,kuba@kernel.org,andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com,martin.lau@linux.dev,sdf.kernel@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,deliran@verdict.gg,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  8 Jul 2026 13:28:26 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[fomichev.me,kernel.org,iogearbox.net,gmail.com,linux.dev,vger.kernel.org,verdict.gg,meta.com];
	TAGGED_FROM(0.00)[bounces-305817-lists,netdev=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:deliran@verdict.gg,m:lorenzo@kernel.org,m:sdf@fomichev.me,m:kuba@kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:martin.lau@linux.dev,m:sdf.kernel@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:martin.lau@kernel.org,m:eddyz87@gmail.com,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:johnfastabend@gmail.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1DE6726D33

--===============9166916302589270823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/drivers/net/hw/xdp_metadata.py b/tools/testing/selftests/drivers/net/hw/xdp_metadata.py
> index 33a1985356d9..687c43a1797a 100644
> --- a/tools/testing/selftests/drivers/net/hw/xdp_metadata.py
> +++ b/tools/testing/selftests/drivers/net/hw/xdp_metadata.py

[ ... ]

> @@ -81,8 +83,22 @@ _RSS_KEY_TYPE = 1
>  _RSS_KEY_PKT_CNT = 2
>  _RSS_KEY_ERR_CNT = 3
>
> +_CSUM_KEY_IP_SUMMED = 0
> +_CSUM_KEY_CKSUM = 1
> +_CSUM_KEY_LEVEL = 2
> +_CSUM_KEY_PKT_CNT = 3
> +_CSUM_KEY_ERR_CNT = 4
> +
>  XDP_RSS_L4 = 0x8  # BIT(3) from enum xdp_rss_hash_type
>
> +# Mirror of enum xdp_checksum from include/net/xdp.h
> +XDP_CHECKSUM_NONE = 0x1
> +XDP_CHECKSUM_UNNECESSARY = 0x2
> +XDP_CHECKSUM_COMPLETE = 0x4

This isn't a bug, but XDP_CHECKSUM_NONE does not seem to be used anywhere
in the test; was it intended to mirror the full enum for documentation, or
could it be dropped to match the nearby XDP_RSS_L4 which defines only the
bit it uses?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28945032378
--===============9166916302589270823==--


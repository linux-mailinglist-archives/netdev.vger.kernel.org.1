Return-Path: <netdev+bounces-299658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +XVxMz6NMGpdUQUAu9opvQ
	(envelope-from <netdev+bounces-299658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:39:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 683CA68A9AF
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:39:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KsUHbuUg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299658-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299658-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E55F930347F4
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF198359A99;
	Mon, 15 Jun 2026 23:38:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD97355F2A;
	Mon, 15 Jun 2026 23:38:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781566731; cv=none; b=NMePTg1NxrbAETAnKfL284b0sQjBZoO+SujXgPaUcye42qDlQGAgEwZxJs0jHH4ML/TRVBpIYgnq/3wtCkbLRfxjPOXnX7OMomtaErM04WZb2Zw27xgk8TpA34dADH9E7rFdeZq35++z9fHgZtbtk1AwG8c1AcRomkZt0Lj4okc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781566731; c=relaxed/simple;
	bh=lPdexIlo58D7Lq0NUMlhl3Bj8800Kbzz18NmytAljUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNgCN/DR3H8RUyAhVUtgj6rPwXtYK5zWDglNEOBsD8FRey50MK2IEW2afL1Mu7juO3Ulnj80ykMoBh+CLOmD+in40sTKmT6bFnk1zv0zwaxOUw0Cs05zafy6nRb0olweM/ATNa6I4LgZxchsNnx16CBuFWtQLmQRb5Suk0KYDHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsUHbuUg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD11C1F000E9;
	Mon, 15 Jun 2026 23:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781566730;
	bh=jKLPNhbMJUK/p7PD2Estkpj7uFBVbHPhaCT82Mgh5bE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KsUHbuUgh0Kico7Kh7y5uUGusBEckK7HauGoXM5Ld6Mco7t6ktGtVsUz/m+Il296p
	 C69u0TJf6frkVdV3q20JWhopLZ3tUbhvSmQWB6Z9r23wmwGGWpfmG3xQQYzOqQlITI
	 mv+UW6JrgwJgR3LqdboSeM3zz98mvRRANDDwzd0q8jYMlGMPRP8xLDxVFgznxowvTW
	 l1WRxv/fjuJZnnIo1VqoTe+Cgr7BPWLbNpgOZLWPyi2RgLsUpuF6oHoPckycEvev5p
	 /aYyP/GFvxS4QOvB9H+QEU2KlfaBmAwWl9MCb3eoUve95+QHaxqt4MUi5ZSrjMVBxY
	 V0bm8qbBvhO/Q==
From: Jakub Kicinski <kuba@kernel.org>
To: jensemil.schulzostergaard@microchip.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel.machon@microchip.com,
	Steen.Hegelund@microchip.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next 6/9] net: sparx5: vcap: add lpm vcap implementation
Date: Mon, 15 Jun 2026 16:38:49 -0700
Message-ID: <20260615233849.1042290-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612-sparx5_l3_routing-v1-6-fc3c10160f49@microchip.com>
References: <20260612-sparx5_l3_routing-v1-6-fc3c10160f49@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299658-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jensemil.schulzostergaard@microchip.com,m:kuba@kernel.org,m:horatiu.vultur@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:daniel.machon@microchip.com,m:Steen.Hegelund@microchip.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-hardening@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 683CA68A9AF

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: sparx5: vcap: add lpm vcap implementation

Add the implementation for the LPM VCAP for lan969x and sparx5. The LPM
VCAP has a static keyset configuration, and a single lookup dedicated to
LPM, so this is straight forward, and many functions can use existing
functionality.

> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
> index 95b93e46a41dc..e25e759c24f60 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
> @@ -1083,6 +1146,46 @@ static void sparx5_vcap_es2_cache_write(struct sparx5 *sparx5,
>  	}
>  }
>  
> +static void sparx5_vcap_lpm_cache_write(struct sparx5 *sparx5,
> +					struct vcap_admin *admin,
> +					enum vcap_selection sel,
> +					u32 start,
> +					u32 count)
> +{
> +	u32 *keystr, *mskstr, *actstr;
> +	int idx;
> +
> +	keystr = &admin->cache.keystream[start];
> +	mskstr = &admin->cache.maskstream[start];
> +	actstr = &admin->cache.actionstream[start];
> +
> +	switch (sel) {
> +	case VCAP_SEL_ENTRY:
> +		for (idx = 0; idx < count; ++idx) {
> +			/* Avoid 'match-off' by setting value & mask */
> +			spx5_wr(keystr[idx] & mskstr[idx], sparx5,
> +				VCAP_SUPER_VCAP_ENTRY_DAT(idx));

[Severity: High]
Are concurrent writes to the shared VCAP_SUPER_VCAP_ENTRY_DAT registers
safe here without a global hardware lock across the different VCAP types?

It looks like IS0 and IS2 rules are updated via vcap_add_rule() under the
rtnl_lock(). However, the LPM rules are updated under the
sparx5->router->lock inside a workqueue.

Since both execution paths share the Super VCAP hardware block, could
concurrent updates from TC (IS0/IS2) and routing (LPM) race on these shared
cache registers, and also on VCAP_SUPER_CTRL in sparx5_vcap_super_update(),
garbling the hardware command and corrupting the cache memory?

> +			spx5_wr(~mskstr[idx], sparx5,
> +				VCAP_SUPER_VCAP_MASK_DAT(idx));
> +		}
> +		break;

[ ... ]

> @@ -1379,6 +1523,7 @@ static void sparx5_vcap_update(struct net_device *ndev,
>  	struct sparx5 *sparx5 = port->sparx5;
>  
>  	switch (admin->vtype) {
> +	case VCAP_TYPE_LPM:
>  	case VCAP_TYPE_IS0:
>  	case VCAP_TYPE_IS2:
>  		sparx5_vcap_super_update(sparx5, cmd, sel, addr);


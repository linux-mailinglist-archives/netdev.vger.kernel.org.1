Return-Path: <netdev+bounces-297401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ugi3L7rDKGoCJQMAu9opvQ
	(envelope-from <netdev+bounces-297401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:54:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA5B66555E
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:54:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=i1LYyX0h;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297401-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297401-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2961E30D7E81
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEE831D730;
	Wed, 10 Jun 2026 01:51:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23583277C9E;
	Wed, 10 Jun 2026 01:50:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781056262; cv=none; b=t8/pVDVQ0UHroXiHmdw5cGp4ng1Dic6s5+DcFTfDALPeS4IgC/1x2Qag0BCnIFkXuP6enNSTgQhZ2Z/vP740+lvOY05PTDWmHc8CfxbfjUxdyMmT4pitKeHTP5TRBn17jvSAllKSUGTj9YBEAx4nIsYqmskx1FK6WT/o9nGPpQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781056262; c=relaxed/simple;
	bh=uftVRAAOqVcuNIfpF07qiFFvp0+DwLZcozUb/oOHfRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZ93ZPBVHWJE8AKxRkh8vceMqUwBnYC66dEYu/nrMbrcvAhmelo6GHvxVhZw52RFU3pBmQPdXRLpzMXdqkYXRymelosiX5eXNbPwCJeZgUIIWyIE7k/F9yuhoAFnANsRUj70AWJKJ/PP5B05RoJZ3ivvoKJ3SXRnKqAjFcZNb4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1LYyX0h; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E801F00893;
	Wed, 10 Jun 2026 01:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781056259;
	bh=TvIRhXnoht0u3XGvpgLnbKr6/cPJ22y4pil/MJeoQMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i1LYyX0h6Y1Yxt+nLjI53g1ZP+SDiJuw/eKQAVY0mjHvWG5sVFoyNQMFf59KxrIsX
	 8R5vIro0qglS+L+h9YbgH7tNjy/1e+6qh9xPLNVrTHZzXvQXaWdXM3fTIwqJLiw12J
	 wcE5SKDmuyrqSSP80PAUTIJVBElq5v6zeareYrEOVGshSOtmJ/Sog726XXZSdTc4Ur
	 YTsIUAiQ9Dsb1/6V6xHDMsmGYHJHS1/xI/kuy0oRCQb0MejgzQ3EJaVwjZnxJZSsrv
	 Z8Pe/V7qkbgkb9lErXvti80MC6wVCK2bWnRqoJjGsumTrs6Dj58/J9djmiRuraW1RM
	 SmYVa4FRnRQ2A==
From: Jakub Kicinski <kuba@kernel.org>
To: sam.moelius@trailofbits.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net/sched: act_nat: only rewrite IPv4 packets
Date: Tue,  9 Jun 2026 18:50:57 -0700
Message-ID: <20260610015057.1474491-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608181348.1146175.b644bbba93da.act-nat-non-ipv4@trailofbits.com>
References: <20260608181348.1146175.b644bbba93da.act-nat-non-ipv4@trailofbits.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:kuba@kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297401-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CA5B66555E

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/sched: act_nat: only rewrite IPv4 packets

This commit restricts act_nat to only process IPv4 packets to prevent
non-IPv4 payloads from being incorrectly parsed and modified as IPv4
headers. It adds a protocol check using skb_protocol() to skip inline
VLAN tags.

> diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
> index abb332dee836d..cb3e7a415da74 100644
> --- a/net/sched/act_nat.c
> +++ b/net/sched/act_nat.c
> @@ -142,6 +142,9 @@ TC_INDIRECT_SCOPE int tcf_nat_act(struct sk_buff *skb,
>  	egress = parms->flags & TCA_NAT_FLAG_EGRESS;
>  
>  	noff = skb_network_offset(skb);
> +	if (skb_protocol(skb, false) != htons(ETH_P_IP))
> +		goto out;
> +

[Severity: High]
Will this check skip valid IPv4 packets that have hardware-accelerated VLAN
tags?

When a packet has a hardware-accelerated VLAN tag, skb_vlan_tag_present(skb)
is true. In this case, skb_protocol(skb, false) evaluates to skb->vlan_proto
(such as ETH_P_8021Q), causing the check to evaluate to true and jump to the
out label.

Since hardware-accelerated VLAN tags are stripped by the MAC driver,
skb_network_offset(skb) correctly points to the inner IPv4 header and
skb->protocol already holds htons(ETH_P_IP). Should this code check
skb->protocol != htons(ETH_P_IP) directly instead to avoid skipping
hardware-VLAN-tagged IPv4 packets?

>  	if (!pskb_may_pull(skb, sizeof(*iph) + noff))
>  		goto drop;
>
-- 
pw-bot: cr


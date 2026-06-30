Return-Path: <netdev+bounces-303407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vciNLaxURGoKtAoAu9opvQ
	(envelope-from <netdev+bounces-303407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 01:43:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD176E8B23
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 01:43:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FfqoVT4v;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303407-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303407-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9573303B67C
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 23:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E201338910;
	Tue, 30 Jun 2026 23:43:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6725C330B07
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 23:43:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782863018; cv=none; b=ZJ1E98O88tBKcqWHcS7/MzeoJKohr4ByEYYnlQsWfEfPZ7m834DKgKyomAg0HOjQpBHTOCFXeQNiA7XgUoqzPnXHFJoYNMA43NJozdLAWDuxH6LU9JNRMXjW1hz5qy+hAQPItl+VRZ39bbR2kbpebdpTyR5KSNzuITgx6KbvvGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782863018; c=relaxed/simple;
	bh=uLkcBORwX/En4LH3Ln9K9b1Xmin/83LIRKrqFiSNz3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqEHKv4yvXGRbL358PiRhItnKWLiT2B75QzsJb88/HHPB67lAyRLAZLE5+bMaETVGiVldoedZDoyy21TzpuosvGx2MligoOc7FK3S1Qx2gxCNQulayuWeBFTOB68fiVwfn7o2qvvJTlhEwZqRCiLpMkYyaHLXCsfnZxjH4BLiMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfqoVT4v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BDB1F000E9;
	Tue, 30 Jun 2026 23:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782863017;
	bh=uLkcBORwX/En4LH3Ln9K9b1Xmin/83LIRKrqFiSNz3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FfqoVT4vU7+6hbTD4Vy7du7nemhTLuNKLmN1O/nUyvfMrXpdChflwgW4XXMmwNzgj
	 9t1ll/H8aNBjWnXaxuoUYL8gsYYK/pxtn4dLbSsOIqkFfFmeQ9xx5rK16RXpacclMF
	 NIr661tIJMW7LFayvAjnn071XdPD5NA1fhC/W127G3wkIVMphA89V4Guevdc6eUDxM
	 TS65/zJT4u7xqmIMEFWSAGJVrapclqHV+gE+cciNi5X3wVBVEdcWNDKWzHcV6nawM/
	 eNoHNfSxWDnhR6D4f66Gc77bSty3sxQ25y3WxEtjpxMfjCM3Mc2CYKxhbBrzb+QWcO
	 YJ763tPOqporQ==
Date: Tue, 30 Jun 2026 16:43:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next 6/6] net: document NETDEV_UNREGISTER unlocked
 rationale
Message-ID: <20260630164336.1350403f@kernel.org>
In-Reply-To: <20260630182129.1601784-7-sdf@fomichev.me>
References: <20260630182129.1601784-1-sdf@fomichev.me>
	<20260630182129.1601784-7-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-303407-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sdf.kernel@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4AD176E8B23

On Tue, 30 Jun 2026 11:21:29 -0700 Stanislav Fomichev wrote:
> +Many ``NETDEV_UNREGISTER`` handlers release their lowers with
> +``dev_close()``, which takes the instance lock itself. Holding
> +the lock across UNREGISTER would deadlock.
> +
> +Moving UNREGISTER under the lock is mechanical: switch those
> +callers to the ``netif_*()`` lock-held variants. Deferred to
> +limit churn.

Not following TBH. Let's say there's a UNREGISTER ntf for eth0.
Are you saying that eg. vlan which closes their own vlan0 devices
on top of eth0 needs to be switched to netif_ ? That wouldn't make
sense since the notification is holding netdev_lock(eth0) and
we're talking about netif_close(vlan0)?

Doing anything with the device that is sending the UNREGISTER
sounds odd, since it's going away..


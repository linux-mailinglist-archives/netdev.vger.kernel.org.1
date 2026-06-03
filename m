Return-Path: <netdev+bounces-294967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mNV8O4O6IGrt7AAAu9opvQ
	(envelope-from <netdev+bounces-294967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 01:36:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA3A63BE11
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 01:36:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JqiPswt3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294967-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294967-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A76423008775
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 23:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1563955E7;
	Wed,  3 Jun 2026 23:35:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5D619CCF5
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 23:35:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780529721; cv=none; b=gef3/aVXPPSEBbIOCtdYA75t+0tbfLXVYTDZRF5vbuQp3xtOCsnvpLn0PLIzG7IhBk6QVSeTrpHWg+Lxjn5taxEUnprq+6+V6GBrYHvb+kbv3KkOzRexvWEedG3VZ/8U1c2QzJa/zQf7iJhhyUgEJj56PNw689xZiWHdqHGWVYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780529721; c=relaxed/simple;
	bh=qAjp6pTB9JMU0MizM7vPZfhB/hfrUubCXrVZoqAzrFk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ey9GIULvuDvoV2YsX2zTHbwNc/DUK/gixvbjYkg0Z6E5NtmEVg4eOKsBG4lNNOFXMz2mb1XBsRLnovClowN97FANB+S4WFB5zUHcLOcE779rwlYbJbg0L+bMRD7ayILm1W1+zYRbAaUV5YNYPhkgVgbZyEMqKnmnPsLmjS704Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqiPswt3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79AF61F00893;
	Wed,  3 Jun 2026 23:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780529719;
	bh=IT0CNIFErzTX8MU0WrStSagYyw/rqJVEeX7GoldbCds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JqiPswt3trogXEtVQcOPHYG9VJJxsNK40trRlM7SOL3gtGIOZQZ8p2aOhvmISbKSX
	 /9m7Hljk1xZSF6IPzUH4szWjGl5zpqKoHNXZdMZeGWczsXMAsk6EDeSlDTDX+W24yj
	 Z3mEmc2RtoIjhaqfE11oU5irbZ6m8A57O7wwbjWtln6MIKwGE1Om5a6rcKGmxkHcjN
	 MGSHk4urW2y7/B3ipH46RNDoi5TZ0M5jkl5C/jO17u6jRAUEEFN4HIzE9T5c9wBnie
	 lWD7V4cmyKnOa2eVi5FGoHhD31qU/99ryLS4cwzqRkpjnLfY4MB1zArLwy3WyLfz3a
	 cAfXVomdJWCkA==
Date: Wed, 3 Jun 2026 16:35:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
 <donald.hunter@gmail.com>
Subject: Re: [PATCH net-next] tools: ynl: try to avoid the very slow YAML
 loader
Message-ID: <20260603163518.7bde747a@kernel.org>
In-Reply-To: <508a922f-c8e4-4b31-8670-43d44d45f467@intel.com>
References: <20260603210810.2636193-1-kuba@kernel.org>
	<508a922f-c8e4-4b31-8670-43d44d45f467@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294967-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jacob.e.keller@intel.com,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:donald.hunter@gmail.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BA3A63BE11

On Wed, 3 Jun 2026 15:08:46 -0700 Jacob Keller wrote:
> Hmm. I was a bit confused at first by the switch from safe_load to
> load.. but we're passing Loader as _yaml_loader which will either be
> CSafeLoader *or* the default SafeLoader, so we'll get the appropriate
> loader equivalent to what safe_load would have done, so there's no
> change. Ok

Maybe I should have mentioned this in the commit msg. I was also super
confused by these APIs but IDK how much is this me not knowing Python
and how much it's special. AFAIU basically:

somewhere in pyyaml...

	def safe_load(file):
		return load(file, Loader=SafeLoader)

so safe_load() is just a "shorthand" for using SafeLoader, which unlike
load()s default loader doesn't allow constructing real/binary Python
objects ?

Why it doesn't default to the C one is beyond my understanding.


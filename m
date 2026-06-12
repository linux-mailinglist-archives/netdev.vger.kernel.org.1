Return-Path: <netdev+bounces-298727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YooSFxc2LGoKNwQAu9opvQ
	(envelope-from <netdev+bounces-298727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:38:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFEE67B00E
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:38:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eMyYsFKV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298727-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298727-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D1B031F1F51
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAE63955EC;
	Fri, 12 Jun 2026 16:28:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F020E37F011;
	Fri, 12 Jun 2026 16:28:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281739; cv=none; b=AhfSkDc4jL4LnpX8BfRYamgF0BqZnK+1MVSwwTBoLqAvVTacYS7Q5KvaHzC+8XFyyJyB5MzaT2AMeOgeKaDJApK1nYz6wRezEiHqqqq1JJ4B/fOxwJg9DMldW3MQXibhmwP1oyC5dm83XuAt6Y9m0rR4tDPJmAsnHMVHhnMCbIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281739; c=relaxed/simple;
	bh=PZmMTZXzRt+C99kbXOxkubEIlf4jhXp0qRPcLgjlSqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmwXAfsdvakQs11w+LWMf5Jga5WhD1fcr8xhXVFAt30pn3KuA+0EittEXAIXoSMbxC9hYzuwVUQnqiUnFS1CcqC7+GW+DjCeitFv3TO5oNZLEcyfwrMvnB0oPRMuX3okcSJMK1grML1Lg3n2BAdrwZ9GM54y4xQ0QMiub78nPh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMyYsFKV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721D61F00A3A;
	Fri, 12 Jun 2026 16:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781281737;
	bh=+YkxKUKI+ttSACYhasK/qyZ52eMUZtHTMnbDNaJgTnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eMyYsFKVUI/AjLu4yjm2YPH2WCOHHt0vmajj/lYGVjak2UUxMEoPXOfcSQd6EBfR9
	 aOjYNII68yBM3a4I/TCiIw3bRZKAN+l6K6VvvUqD8aN53ypgvtHXwSyKJUGBj8P0S3
	 r5Z21FsWp3P5LFTPi5nbgn4RFu1fKWS8vAqAPIT8fwAmc4Oljdi8XoSaJqg32wn65u
	 pAfPPEonX3LBEnxBELdEb1nRhciHC6EM5SDFFzTqOLezeUD7OxvInbS7j/0U8jF45e
	 mCHqUhc167JQC28Br+UXJfsFJpOyjYK2/yr1BZX5jRJAx8qDNiG89SIj0ROK6QV0oh
	 2nIxjNmVpkwYA==
Date: Fri, 12 Jun 2026 11:28:56 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: lizhi2@eswincomputing.com
Cc: pritesh.patel@einfochips.com, linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org, edumazet@google.com,
	linux-arm-kernel@lists.infradead.org, pjw@kernel.org,
	pabeni@redhat.com, weishangjuan@eswincomputing.com,
	linux-riscv@lists.infradead.org, ningyu@eswincomputing.com,
	krzk+dt@kernel.org, pinkesh.vaghela@einfochips.com,
	linux-kernel@vger.kernel.org, alex@ghiti.fr, andrew+netdev@lunn.ch,
	alexandre.torgue@foss.st.com, kuba@kernel.org,
	aou@eecs.berkeley.edu, horms@kernel.org, mcoquelin.stm32@gmail.com,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	rmk+kernel@armlinux.org.uk, palmer@dabbelt.com, lee@kernel.org,
	maxime.chevallier@bootlin.com, linmin@eswincomputing.com,
	davem@davemloft.net
Subject: Re: [PATCH net-next v8 1/6] dt-bindings: ethernet: eswin: relax
 internal delay model to range-based constraints
Message-ID: <178128173639.1162200.4235173600332300329.robh@kernel.org>
References: <20260610012727.848-1-lizhi2@eswincomputing.com>
 <20260610012849.874-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610012849.874-1-lizhi2@eswincomputing.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[einfochips.com,st-md-mailman.stormreply.com,vger.kernel.org,google.com,lists.infradead.org,kernel.org,redhat.com,eswincomputing.com,ghiti.fr,lunn.ch,foss.st.com,eecs.berkeley.edu,gmail.com,armlinux.org.uk,dabbelt.com,bootlin.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-298727-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lizhi2@eswincomputing.com,m:pritesh.patel@einfochips.com,m:linux-stm32@st-md-mailman.stormreply.com,m:devicetree@vger.kernel.org,m:edumazet@google.com,m:linux-arm-kernel@lists.infradead.org,m:pjw@kernel.org,m:pabeni@redhat.com,m:weishangjuan@eswincomputing.com,m:linux-riscv@lists.infradead.org,m:ningyu@eswincomputing.com,m:krzk+dt@kernel.org,m:pinkesh.vaghela@einfochips.com,m:linux-kernel@vger.kernel.org,m:alex@ghiti.fr,m:andrew+netdev@lunn.ch,m:alexandre.torgue@foss.st.com,m:kuba@kernel.org,m:aou@eecs.berkeley.edu,m:horms@kernel.org,m:mcoquelin.stm32@gmail.com,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:rmk+kernel@armlinux.org.uk,m:palmer@dabbelt.com,m:lee@kernel.org,m:maxime.chevallier@bootlin.com,m:linmin@eswincomputing.com,m:davem@davemloft.net,m:krzk@kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:conor@kernel.org,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,eswincomputing.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDFEE67B00E


On Wed, 10 Jun 2026 09:28:49 +0800, lizhi2@eswincomputing.com wrote:
> From: Zhi Li <lizhi2@eswincomputing.com>
> 
> Relax internal delay constraints for EIC7700 Ethernet binding.
> 
> Replace fixed enumeration of rx-internal-delay-ps and tx-internal-delay-ps
> with a range-based definition (0-2540 ps, 20 ps steps) to reflect actual
> hardware capability.
> 
> Mark rx/tx internal delay properties as optional, as they are board-
> specific tuning parameters rather than mandatory configuration.
> 
> Update the device tree example to align with the relaxed constraint model
> and remove delay properties from the example to avoid implying they are
> required.
> 
> No functional change to existing DT users.
> 
> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
> ---
>  .../bindings/net/eswin,eic7700-eth.yaml       | 25 ++++++++++---------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



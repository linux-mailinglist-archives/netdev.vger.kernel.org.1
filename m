Return-Path: <netdev+bounces-290731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLosKNsgEGqjTwYAu9opvQ
	(envelope-from <netdev+bounces-290731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:24:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F145B11DB
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA0BC301C6F2
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAD63B3BF2;
	Fri, 22 May 2026 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYeDXDTz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5E938423B;
	Fri, 22 May 2026 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441610; cv=none; b=DwLR5FjU5B4j2HSwrizYbAEOde14NFmvJVCdgQ8ZJxPI8zEAUQy03TAM8MCELv3tWicdXAKrlszqjLw58N2AXt7j0fkoYcPwXH5Z5fLzHIcHOWs9VfN/PKZ9ekeJ2ZueKLaBifeIvFLFCk4oBBmODkQlqhdWv78ILgNIkZVIt0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441610; c=relaxed/simple;
	bh=DudcparEC6lmwfRPUBZqbqGD4e5cEl/llMsY/1ZWPxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVgwcPFob0X+mAinZAXm/KtDE0XYq7pnCYpcHW4ht9aB/72yFcanpSmcZsORK9FC2AbeV6Rpb8AK+30lVV96OyLkrmg+Y1kPrklHNee2sq4gtzkgi/OQrfZiQAg52mpFYdcrAhNZx63ZgWU9oaHL++0E7+L9wC6YWOrnhdJvC+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYeDXDTz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFB61F000E9;
	Fri, 22 May 2026 09:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779441608;
	bh=/osgLLHhiEx0dFQtDZv54uv6cA3cfEmbIrNeSkBi188=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UYeDXDTzW5bNlB0wFrzLvAaquK7OGRoxW98g2UqnLzbhfoYiYa3uhRjLskcElaJ4S
	 VXEEJ33juyaih7B3LEFX9MoBut97GzhkTciVvMzmE6ikW84Jw8INN7dK+fg87dPId3
	 QzEp4LsfpQ+hhNXp+S3kVYuikpB5/Bn4C4yCz3XyxjnlZGa5Erhd56z7Ju6ckTFpzD
	 qsfGV/UCqsUA29NGw7LhLkiwZZr2Mr7Cpf/yC/FnH4lA231Po+/BAVN2h/nUy7kLlj
	 TxzFUW7A0nJNmXfoPpfuOvLGRsnvaY2JWmwz0Ktq3zXVSSpCkfIxBJBZwGbaIJihAT
	 ESHtl5IDyi4Ug==
Date: Fri, 22 May 2026 10:20:04 +0100
From: Simon Horman <horms@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Patch net-next v5 0/7] r8169: add RSS support for RTL8127
Message-ID: <20260522092004.GJ1506108@horms.kernel.org>
References: <20260520031603.700-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520031603.700-1-javen_xu@realsil.com.cn>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-290731-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,realsil.com.cn:email]
X-Rspamd-Queue-Id: 15F145B11DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 11:15:56AM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch series adds RSS (Receive Side Scaling) support for the r8169
> ethernet driver, specifically for RTL8127 (RTL_GIGA_MAC_VER_80).
> 
> RSS enables packet distribution across multiple receive queues, which can
> significantly improve network throughput on multi-core systems by allowing
> parallel processing of incoming packets.

...

Hi Javen,

There are AI generated reviews of this patchset available on bogh
https://netdev-ai.bots.linux.dev/sashiko/ and https://sashiko.dev

I would appreciate it if you could look over them and address any
issues that effect the functionality of your patchset. I do not suggest
expanding the scope of this patchset, but rather treating other issues
in the context of possible follow-up.


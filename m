Return-Path: <netdev+bounces-253632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yjX/IJcGeGnFnQEAu9opvQ
	(envelope-from <netdev+bounces-253632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:28:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E129E8E7AF
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 953723022F68
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3318E1A9F9B;
	Tue, 27 Jan 2026 00:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kouNEQgC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1D918CC13;
	Tue, 27 Jan 2026 00:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769473682; cv=none; b=aoTwjrIMbrr9btzaLXmR3nvN+ORZf/c9zD0U04Cj9R1FJb9Soq1tZsdcPIbSnLBQx0/lYpqpvpQVQ/dzzRcuLzpmwMs0oeLjmxT9kw+um+0Xpgf9dH3mXZ1p/9UPM4pcwv8j0EjmQqOlfGPNi71mtZqfQZO59VV2Fgh82ea3qHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769473682; c=relaxed/simple;
	bh=FwWpJSMK+KrKXFsLv/93f1SUbLMFJ/zLW2o+OzeC85M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DU8BJSJglt10gSXSNLPn1NL1a4Ud/syBbfo3iLvJ8aE6FLa8zWGPmVKOPWeFpRQDZNCRCXuHRJv+SX5Ll+IV/+CdsdmS/tqIg8beMrizf/kqYls9bMusy7rq4zZa8NJRsLsJZkLsK8Gh9RG/x5yYY0stq/hj05rdlp9n2Q5XgqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kouNEQgC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CE4C116C6;
	Tue, 27 Jan 2026 00:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769473681;
	bh=FwWpJSMK+KrKXFsLv/93f1SUbLMFJ/zLW2o+OzeC85M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kouNEQgCUTsm7WECGlGSIoeT60wpZUWymYMFalYnQoxoPaS4lTekA90CKGIf2ThkJ
	 Qc1Lp6q95NfPPcoQuf04WYAIixfLYt2ILzmgCQ7DRj/t5V5zha7AdHmU/Z9gDNPxeE
	 5RTuI6m52gkDGZg8G7i+bIWTU6y5NjmeWkhJczeERQNcurrq5GvPeuQDryUDQO0794
	 q9mK+eCDdO0GMGE1/RWkM/ri7zqrhD2EgKQipbPb7JSJc+a7/OaYVqoWDS6ya/BRWX
	 p3N1kTUoXplxVL2v6iSnuJcHTk81DE3p+Q7qNTk5065YEwLC2GDDQiawrCLfdm9T0B
	 NhLvXQF5GDSLQ==
Date: Mon, 26 Jan 2026 16:28:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andre Carvalho <asantostc@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] netconsole: selftests: Move netconsole
 selftests to separate target
Message-ID: <20260126162800.10d5601d@kernel.org>
In-Reply-To: <aXdYwphLx2O-Hxis@gmail.com>
References: <20260124-netcons-selftest-target-v1-1-d3937f44c4c2@gmail.com>
	<aXdYwphLx2O-Hxis@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253632-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E129E8E7AF
X-Rspamd-Action: no action

On Mon, 26 Jan 2026 04:10:18 -0800 Breno Leitao wrote:
> On Sat, Jan 24, 2026 at 06:51:42PM +0000, Andre Carvalho wrote:
> > This patch moves netconsole selftests from drivers/net to its own target
> > in drivers/net/netconsole.
> > 
> > This change helps saving some resources from CI since tests in
> > drivers/net automatically run against real hardware which are not used
> > by netconsole tests as they rely solely on netdevsim.
> > 
> > lib_netcons.sh is kept under drivers/net/lib since it is also used by
> > bonding selftests. Finally, drivers/net config remains unchanged as
> > netpoll_basic.py requires netconsole (and does leverage real HW testing).
> > 
> > Signed-off-by: Andre Carvalho <asantostc@gmail.com>  
> 
> Thanks for the patch. Looking at NIPA, it seems none of the netconsole
> test run?
> 
> https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-2026-01-25--06-00

Do you mean after the patch? I'll have to manually add it to some VM
config (presumably the SW drv-net one). I'll do it after patch is
merged. (Remind me if I forget? ;))


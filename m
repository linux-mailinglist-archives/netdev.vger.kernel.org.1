Return-Path: <netdev+bounces-298335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DaavJAoaK2rK2gMAu9opvQ
	(envelope-from <netdev+bounces-298335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:26:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E5A675215
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:26:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BkQWoHD4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298335-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298335-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09E553247E5D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8DE3A963D;
	Thu, 11 Jun 2026 20:26:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE59C3E0C7A;
	Thu, 11 Jun 2026 20:26:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209564; cv=none; b=gQMwrwZvEWs4P+P21aKUEy4eovtOG4Z8mUMxTF1SSdcVWEhsvo2Pv7Us6M2RLKSCs8YiNalaIi5eL++xIs3ZhpCmqp3BmuoxQe5RQnGiYFbIftnvJFGPgQz9jva/VgSCwINp35cUOwzpwLgwca6GlWGM+Zq3Pxt/WuXF2kqn3Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209564; c=relaxed/simple;
	bh=Rbrycvwow+FxQc/jZ51SEb9/hMV7x015TjMv7s3KcXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOHca5KGLY6jpsLupb7jqS4HvwUHC19lBXv3eXXouq6FteMld9sLr74xaOUfmbtEDjVokJbY4SODUwxHIiWmh5o0AEQuVf9bJK3vaZHZOM9Q7z91pvfCnQ6DTstoFoF0Wcfmtx2Obm2eG9ux0UA/7XbXIMmUNjCGFyzd5IPI04U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkQWoHD4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB2B1F00A3E;
	Thu, 11 Jun 2026 20:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781209561;
	bh=Rbrycvwow+FxQc/jZ51SEb9/hMV7x015TjMv7s3KcXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BkQWoHD4HgOU8QPKUprfT7uO2nfwuq4/peXPwvVjn7AGIb/+9Co0ztuO4GUNBhKq1
	 mUN7hphfbbjwD9TqhKjsnRxhYPU1rZCFrCtnsjC8uBBMkLLfRYpNs6dWdJihTvrfGQ
	 +YsLaSDH9892NqkpUZfG/fZ/uJLBG9MgAHkKE7lzd6f5b5bDP0LCoaCoH8UMhwt4dT
	 +i7YN4xCz/MaVHn2avEPa1QhuouRfpS8zPEIbdXMJVUOaa67zm0CIvLIzHOh6aGAVq
	 K/V7WrRnfdafysWS5XPAcNZXpCLw2CkRUNHPB54y51KJfxMgMHj40MKxjs+3tJ2EQo
	 cdchLdcIw6Dsg==
Date: Thu, 11 Jun 2026 13:26:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Raf Dickson <rafdog35@gmail.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, pabeni@redhat.com, sgarzare@redhat.com,
 stefanha@redhat.com, bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next] vsock/vmci: use sk_acceptq_is_full() helper
Message-ID: <20260611132600.754ec1a3@kernel.org>
In-Reply-To: <aippcmlliXpO0BXM@leonardi-redhat>
References: <20260611023830.106259-1-rafdog35@gmail.com>
	<aippcmlliXpO0BXM@leonardi-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.linux.dev,redhat.com,broadcom.com];
	TAGGED_FROM(0.00)[bounces-298335-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leonardi@redhat.com,m:rafdog35@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:sgarzare@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57E5A675215

On Thu, 11 Jun 2026 09:58:22 +0200 Luigi Leonardi wrote:
> note: according to patchwork [1] you forgot to CC some maintainers,
> please be more careful next time :)

Please focus your reviews on the code not patchwork checks.


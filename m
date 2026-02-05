Return-Path: <netdev+bounces-256932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAxOJVYFhGn+wwMAu9opvQ
	(envelope-from <netdev+bounces-256932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:49:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 43252EE1C6
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D600300613E
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 02:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872112C11C9;
	Thu,  5 Feb 2026 02:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+oawdZF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EB42BEC44
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 02:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259795; cv=none; b=Tr3Oa0sxjYwQBk1CNq+A5aqA+LNSld5xe43kA3trKTAsyRpLUdFkvaUdg7kND/Y083Mto1b/K/GLARbyA3wjLuPqOC8l/U2RM4vuZ5lSaNm66Z//lfcCuTtkQtOXzm2F54eU497yUPo9aARGvvIOr0u97CtC/1jiTxg0nVB4n+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259795; c=relaxed/simple;
	bh=vYhVpynnw1EIDXCuwqKgqdsbw7zGCgC3zCF8SKtHxvM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjwtYrAVT2v9/JCFcJRbXsf8QsutRCGmJEl0gPC6VHsf7hk9+sVxV44x/Dk/vVFAofDMyOH7GEPxciekIROXt8kM8yKV/yks8z3bDKSnDt0XJx2aJBf1QCdO6mhnN4myLh3TxZxJfWxFvpex/ZSetsfB5gfYBh5IzjRvl+WwDN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+oawdZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D429C4CEF7;
	Thu,  5 Feb 2026 02:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770259795;
	bh=vYhVpynnw1EIDXCuwqKgqdsbw7zGCgC3zCF8SKtHxvM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T+oawdZFBzeS6PDXKLLq7mBF/dCqSnU8DDweJKDEidHeWf45TpLfceye4CSn8ypkK
	 ytqzkjPW5F3TMQ61jE0HR6xowpGRFpv1S9r4iA6L39w5qQXKaKxwK5QUFkluztxrt6
	 ylYokVqpXfl7kAS4ZH/EaDs1xxDvxw7NjOrpBM8AZ5dUqRfnHA4RRd0oJbhlaOZoc2
	 01fDYu1adb9qwng4zTe5jARxh0mVWtLfDea/W6D4RC/EzuZqqr8Tn1cxOwwwNughOD
	 or/pfcnVIL7E5Tuoc1aMaVqDGf1CjBK7xYg2lNS3GAC59QqKu2Li5jLk71oLcdkhu8
	 A6/0NWPaqsedg==
Date: Wed, 4 Feb 2026 18:49:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 leon@kernel.org, Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: Re: [PATCH v6 0/4] tls: Add TLS 1.3 hardware offload support
Message-ID: <20260204184953.28cc2318@kernel.org>
In-Reply-To: <aYPZcTAaRiLaCLQN@krikkit>
References: <20260203184835.3619101-1-rjethwani@purestorage.com>
	<aYPZcTAaRiLaCLQN@krikkit>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256932-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,google.com,vger.kernel.org,nvidia.com,gmail.com,kernel.org,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43252EE1C6
X-Rspamd-Action: no action

On Thu, 5 Feb 2026 00:42:41 +0100 Sabrina Dubroca wrote:
> 2026-02-03, 11:48:31 -0700, Rishikesh Jethwani wrote:
> > This patch series adds TLS 1.3 support to the kernel TLS hardware offload
> > infrastructure, enabling hardware acceleration for TLS 1.3 connections
> > including KeyUpdate (rekey) support. It also adds a selftest for
> > validating hardware offload functionality.  
> 
> @Maintainers Sorry, I haven't been able to look at this in detail yet,
> could I get some more time?

Thanks for flagging, sure thing!


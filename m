Return-Path: <netdev+bounces-295312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tCynHjShIWozKQEAu9opvQ
	(envelope-from <netdev+bounces-295312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:00:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0EC641A86
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:00:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Hl71muof;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295312-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295312-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A46AC300A12D
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 15:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EBF33B6F6;
	Thu,  4 Jun 2026 15:49:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74D11E766F;
	Thu,  4 Jun 2026 15:49:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588166; cv=none; b=LvdoV1xggZMwd1k5cxYfUDksVE95vVT4y5ys6uoRFsb5A3QMGTfrKVjluCWiFN9xxDPx5hQ6tEmavXcIN8aiz0xJv0F+ogDYzRXclpMIBnH039+qLkdN8OjAJKa/TXHCUztROFK1GjRdLU7NVbF2j5EAzA951QOlh3oHEwiUBIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588166; c=relaxed/simple;
	bh=Yheoo+y7D6MHDU8a4Nq3V/CSu6re5iqIAHmk9PMYOD0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMuYNaPy5cHKU1Sry/oXGe+JNwHWHS8asvPARiQiW7flE+ZaxkwwhaX7gldqdrHFR2FFc/opydxbePg9limTMoaa6uSTSHgMPSnIxrsmax/JA3z0N3YyqSLqKadfv+BHTL6Ljm8IzO5anEn/fWctkMOFTHVxHhF0+412bFGu/h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hl71muof; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77111F00893;
	Thu,  4 Jun 2026 15:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780588165;
	bh=jfdmmBjS2Sz9P2/iM/dUof4bklCIFpmA3vTieSl5ci8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Hl71muofP8AZ2jY2mq45xmt98n3htghNAyW8mjoEpjixHLV0p9kCUQFe5PpIRrMEh
	 Q3Yg0jHN1Tu1Sv30eAlgx+vXLHw0FryQs5sKP35K75PeDZjPnJMkI7rsQqLE9t8tm6
	 PfoNbOhj9dYI45ckPsfG759YqEjp4ABaSxAvBLEotOm7T8fCiPmfxOaE7uG4KRWdbu
	 AaVAqp/9FIHb/Rjuq9+J3Bw5oyBk7xhiYetPrqV1J7yjpaVD2KZysl8jkhNy/0QBJ3
	 VKPR/C8HfW6jkJGeJMidCjZh6IoYA1Pq4GVFyAa0Ft3tjv7+En+JZb9rcdGxaYnYT1
	 9NKpssU/COpCQ==
Date: Thu, 4 Jun 2026 08:49:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: aroulin@nvidia.com
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, roopa@nvidia.com, petrm@nvidia.com,
 idosch@nvidia.com, chirag@nvidia.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] selftests: net: add vxlan vnifilter
 notification test
Message-ID: <20260604084923.7577945e@kernel.org>
In-Reply-To: <20260604131922.3928241-4-horms@kernel.org>
References: <20260602185138.253265-4-aroulin@nvidia.com>
	<20260604131922.3928241-4-horms@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295312-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:aroulin@nvidia.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:roopa@nvidia.com,m:petrm@nvidia.com,m:idosch@nvidia.com,m:chirag@nvidia.com,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA0EC641A86

On Thu,  4 Jun 2026 14:19:25 +0100 Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> 
> Simon says:
> 
> There is also an AI-generated review of this patch on sashiko.dev.
> And AI-generated reviews of other patches of this series.
> But I believe what is forwarded here covers what should
> be considered in the context of this patch-set.

FWIW doesn't read like a blocker to me, please follow up if necessary.


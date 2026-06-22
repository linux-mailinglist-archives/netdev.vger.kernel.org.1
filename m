Return-Path: <netdev+bounces-301158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 01BbBSddOWqNrAcAu9opvQ
	(envelope-from <netdev+bounces-301158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:04:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A69716B0F73
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:04:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CUCYAo1L;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301158-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301158-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1640304EBA8
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 16:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484663CAE9B;
	Mon, 22 Jun 2026 16:01:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5667730FC39;
	Mon, 22 Jun 2026 16:01:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144062; cv=none; b=eGlePelin1vaAWVph256QVmWwxQSdiDBn8VS0BNcjPKkcyZQRW+TfOWEyEws6KGpZiRj8+ywe2w3E9uGnKzkZNJcEkmybTPPzP6FvJwnQECMMPLJmxamm7Fr+i23V7Nwuwiy3rQB/uXYBKEshlUVgaCxaSwRDOxHwgaJUuSRdis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144062; c=relaxed/simple;
	bh=uWrN9N8tLkl5jeJNrH98xFTV+fIzbe5ovyczRTpj/bs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EitOkI6tWMUYKAxf9t8RlJWSYkqxH0puuoxBQTNPoczzCJaZ4hUjJW+94IUI0+0x6QfbmpYAWUZEGUk4bvzrDk6CV92IB8jlG3WwbZ2sOHCbzzXSt41GWHHF+Lcw/wJKeliMcxqa/lLCwi0aI6EKVoaSh/vswebItF2U94bXhiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUCYAo1L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C561F000E9;
	Mon, 22 Jun 2026 16:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782144061;
	bh=uWrN9N8tLkl5jeJNrH98xFTV+fIzbe5ovyczRTpj/bs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CUCYAo1LFxfge7jZFLyQOPKo6REe5AjDLNc2cU3Y/grBFxpbLVX8lIRYlb64V/8PR
	 AjWv34uaq2AUiOh5QEIu88iNfSXuAq0j4wfzjTIxjwOvzADvFGx2c+uHkWEASeVJfi
	 pCQ/iEuk13mVt8JjjIowFNn2AYbaBWpHWUqFF3n1XsvkTRYPELJ7R2VIOI3Of6hMn+
	 1/GE1XNjpOf9UF785xD54kxObPgjPbwHuwcPYMlLYS9vgNEhbYJ146uBZIugukKkmF
	 hSSnSBoUd9pti4FDBySf7Ki0tQ6pzASJPAQ74UXmAPdqBGX3MHnLyd4nJnyTNEo1J2
	 6wmgdhGkgpEXg==
Date: Mon, 22 Jun 2026 09:00:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Hannes Reinecke <hare@suse.de>,
 Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, Gang Yan <yangang@kylinos.cn>, Zqiang
 <qiang.zhang@linux.dev>
Subject: Re: [RFC net-next 00/17] MPTCP KTLS support
Message-ID: <20260622090059.5d1813dd@kernel.org>
In-Reply-To: <cover.1782123118.git.tanggeliang@kylinos.cn>
References: <cover.1782123118.git.tanggeliang@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301158-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:geliang@kernel.org,m:matttbe@kernel.org,m:martineau@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:hare@suse.de,m:tanggeliang@kylinos.cn,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:yangang@kylinos.cn,m:qiang.zhang@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,queasysnail.net,suse.de,kylinos.cn,vger.kernel.org,lists.linux.dev,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A69716B0F73

On Mon, 22 Jun 2026 18:43:20 +0800 Geliang Tang wrote:
> Subject: [RFC net-next 00/17] MPTCP KTLS support

Please no. We have a ton of unfixed bugs and may have to revert some of
the features we dropped back in. I'd prefer to avoid large new bug
surfaces until we reach an LTS release.


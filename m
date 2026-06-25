Return-Path: <netdev+bounces-301841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EkBoBHyTPGpFpggAu9opvQ
	(envelope-from <netdev+bounces-301841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 04:33:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 835586C2672
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 04:33:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iYQocmNE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301841-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301841-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 993CE3022FAC
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 02:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE54282F09;
	Thu, 25 Jun 2026 02:33:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74D11C861D;
	Thu, 25 Jun 2026 02:33:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782354808; cv=none; b=ebv2HHnuVnFcE74Phas8ZNm+jFEuM+1AzC9K6JCWYu55BzdN3AeJd/4lAYwlZO1UBAg7QAEjBJO+u+axRH/yzkuEQS9O7BZ+PHGvwgniWK3CM/Mo1AsD9luv+yMbTnKaswySQxKyeBPVsH3pflFMQbOVt44abLpRvRcfHvYeXTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782354808; c=relaxed/simple;
	bh=WKlTbfrUNwUFyGpobav8CApD6v5B/qIAYIViXKGD7u8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMVsSB+1a2bJzzZjQHBSWGNxSakGO3JTD7xuwG/e/2zKR2qKluDKK7PWWGBXN8uOTd3b1b5JNOio0fbqGkatPePB92tWLJPPMMOTPw+EPwz2/OBzAoSB1Agkd+y1RIblXej7py63/ZcWUAEYpMYxvK0Vi/mIzayL31M7thuUYzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYQocmNE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303D71F000E9;
	Thu, 25 Jun 2026 02:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782354807;
	bh=gAp5DqBsrf+qqTJrCHBvd6moSshxYS3r3vVwtm7UlQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iYQocmNEMzyuFLh2RGCIPVlHqIqg1hTe+T8GaNwVV15IZwsj/PUgyaDpScjdfAwN9
	 SuX2DwknSxTky/q3WUUiu9hPz7r9cSEC603Dz4r/ZPi9SyEwz5NA86awUWno0Pm8+6
	 Jl5O/7nTg+qGtHq36kw8JUSNza+Neer8xIJQKZLpkb3aK0PA7tyW3tRyYcWolqcGiQ
	 27aqd75O4senmoIaBXjd39TkFvNf37NHZtmWFkruUOt18UD/vLJKnsvl8SsfTGJce8
	 1g/tTQs0tefhfnKwa+TOz/BIKI+CiNImeywAHhUEoOXmCgicsK5r/JS+gmjVQEwq6I
	 LpFZ27jiS/JRQ==
Date: Wed, 24 Jun 2026 19:33:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, pabeni@redhat.com, horms@kernel.org,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com
Subject: Re: [PATCH net-next] selftests/xsk: preserve UMEM view in bidi test
Message-ID: <20260624193326.295e3711@kernel.org>
In-Reply-To: <20260623091008.1046547-1-maciej.fijalkowski@intel.com>
References: <20260623091008.1046547-1-maciej.fijalkowski@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-301841-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:pabeni@redhat.com,m:horms@kernel.org,m:tushar.vyavahare@intel.com,m:kerneljasonxing@gmail.com,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 835586C2672

On Tue, 23 Jun 2026 11:10:08 +0200 Maciej Fijalkowski wrote:
> Subject: [PATCH net-next] selftests/xsk: preserve UMEM view in bidi test

Do you want it in net? Either way - we'll need a rebase

> Signed-off-by: Maciej Fijalkowski maciej.fijalkowski@intel.com

missing <> around the email 


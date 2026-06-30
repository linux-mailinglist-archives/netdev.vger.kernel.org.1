Return-Path: <netdev+bounces-302879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GePHEs8ZQ2p8QQoAu9opvQ
	(envelope-from <netdev+bounces-302879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:20:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 967FB6DF913
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:20:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=H2EPnaK9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302879-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302879-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C87A302C92F
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC0B368D40;
	Tue, 30 Jun 2026 01:20:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749C43672A8;
	Tue, 30 Jun 2026 01:19:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782782407; cv=none; b=n8CgFQuycNfzcbZXKUA9amVrwsuJJZkkVSA/PxFfkgp11BUwh9RyHh610gAjA4Z380naTa1kBKK5MfxyRDoe7EEStKsPX15FmF4byu2DrCTkAqXiDUTVWKpSmHt860qB2ZVDIuZ3WRV+37O0Kvl6TEojCX7YPj+c2EDGEiXBUjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782782407; c=relaxed/simple;
	bh=oH5ItFAvN/YMLQYllKayVXDZv3ry0Opqia1ypco3vAI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sICxAVN+ZXRyWdXw3j3DlhESTAjCLMQkq9SkOXFlKvrQMu7xNrmXQq6426501UnLml5WbC5WuYcEKxF/VtSgGDXHt2WMOURDWdiSQ/YESQjYdx+TA137VRIgH0IvZZOmc8w2Lk3jOcrAyztTlEn3Eh4Mrfafe1YS9xS5jfHTQUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2EPnaK9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B231F00A3A;
	Tue, 30 Jun 2026 01:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782782396;
	bh=Bq8NFMfE4HjHcqzwatm2Ix6EPEm2ZoNA8UKzYfMwQOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=H2EPnaK9FVhIiNcuAzpwN/oda82waz2IGKL0NWiTj3kZ7pKmgXAb6ZMJj3aQHa8PL
	 wOxU1aMvBS1GBfQpf7gT4k1Qw/TdTvg+uIewmsNvRZrVVa7t8nqsGrqqSNfEsVr3mk
	 jOGZ+LZtp8/XvX1y/q+3vspb6rvsq9a2ZO7gKwFSWq4TUhEUPfxg+m1zmS73oZA672
	 iYIM0O6XajuI5+gHgHG367ZM8iw1vcAujCpwRZ4WOIoSPXNYD+GN2rdJb7LN4DZj3x
	 y4HujHFpD3QjLYGYi+GrHeTra2pfHLTQxEJ9wX4mua02RqT3W30WclWdOhaRXXXE3K
	 5l1uywcjDbz2g==
Date: Mon, 29 Jun 2026 18:19:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shuhao Tan <tanshuhao@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan
 <shuah@kernel.org>, Mina Almasry <almasrymina@google.com>, Samiullah
 Khawaja <skhawaja@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v1 0/2] Reuse threaded NAPI kthread across
 napi_del()/napi_add().
Message-ID: <20260629181955.00e63b61@kernel.org>
In-Reply-To: <CAABY+HEcNnh+ATyA_JMg4LnVpP=egprTTi4UXxV9CfW2+71z+g@mail.gmail.com>
References: <20260629192029.4013794-1-tanshuhao@google.com>
	<20260629162619.55297244@kernel.org>
	<CAABY+HEcNnh+ATyA_JMg4LnVpP=egprTTi4UXxV9CfW2+71z+g@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302879-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tanshuhao@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:shuah@kernel.org,m:almasrymina@google.com,m:skhawaja@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
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
X-Rspamd-Queue-Id: 967FB6DF913

On Mon, 29 Jun 2026 17:47:03 -0700 Shuhao Tan wrote:
> > Send a netdev Netlink notification when NAPI is re-created and
> > let the userspace re-apply the settings?  
> 
> It feels surprising that the userspace needs to reconfigure thread
> properties when changing NIC configurations unrelated to threading.
> Another downside is that when userspace configures NIC configurations
> in quick succession, re-application becomes messy because a previous
> re-application might still be in progress when the thread is gone.

Can you explain more about your deployment and system configuration
flow? We may be adding micro optimizations when the problem is that
we recreate the NAPIs in the first place.


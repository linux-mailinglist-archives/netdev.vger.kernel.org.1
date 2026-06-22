Return-Path: <netdev+bounces-301156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gWCZGS1cOWpprAcAu9opvQ
	(envelope-from <netdev+bounces-301156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:00:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 591D86B0F13
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:00:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ezWYxNvI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301156-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301156-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51FB13012757
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213A03CAE9B;
	Mon, 22 Jun 2026 15:59:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CC33CAE75;
	Mon, 22 Jun 2026 15:59:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143951; cv=none; b=J7aLrkjx3q0hiBAVbMxOaLzoL6UphbS2Et8qUixLpZOT+l6NWIAsMkh/Vdr4Rc8B1bKvHHY/N3GYjKSwCHrhDlnPBS1FFalBErbopF26x5UfaLImP81h/1TOIuXTFoDyy+v52uKYDqADO00ot5quwWuQsGKGh6UTtnjLfxBMttA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143951; c=relaxed/simple;
	bh=HAUwhMKcvyznOOUxqrAAF14Sjv37HTQUD6EDZZ9Eyn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6r1ck366spxX6a0ad76UGki6tVkNmNWw1xNg8VeK60zIFzrbmjZoct+Eq+FYSueadbPTTerJH7+ELrFrIOOvF0e5fvrhtfZ7Xa9YQ5xsf1xEdwGOoN/sAxglDV1TZiC7fooPJZDE8uN3hEgis1EU60W6EsLVTDoH2iBc47B3PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezWYxNvI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429971F000E9;
	Mon, 22 Jun 2026 15:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782143949;
	bh=/c4Vt3lQ7zIHj8U81NDWo3t+icAmbCZVhtG649JkEO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ezWYxNvIWNPICRHZb3YDWfsljJr+6Iq38cQH8uqHpjYGMlYBigQrrCTISr4EI/GFw
	 mwqLGWYIc5gkf+OVVMrqH1stTJozliyswMb3KksMBTQ9L/8YeivJOPfeV17flC4z+J
	 OBeCrB7rXQXpWH3FIFrylO2cn+DxRM5CwErs9SMiPtCTz6GOc+K9OEAGN5PZL8ul62
	 BDsrpK6O+AUafR9iIBG+Ymy/rgUsBrInWGSsap4a20YdyGSeDbPTfr9LB5Z1ur0Dfr
	 y2RjPWfOVo4oKeH9JKSHeeEdaKbXknxdmo3+8yrU+pdBvdobVnJMVDMy4wKR/p4+bg
	 x2O7JcHvYe7dQ==
Date: Mon, 22 Jun 2026 08:59:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, horms@kernel.org,
 shuah@kernel.org, vladimir.oltean@nxp.com, vinicius.gomes@intel.com,
 fejes@inf.elte.hu
Subject: Re: [PATCH net-next 0/6] tc: introduce FRER action (IEEE 802.1CB)
Message-ID: <20260622085908.4ceeb156@kernel.org>
In-Reply-To: <20260622092118.6846-1-xiaoliang.yang_1@nxp.com>
References: <20260622092118.6846-1-xiaoliang.yang_1@nxp.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:xiaoliang.yang_1@nxp.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:horms@kernel.org,m:shuah@kernel.org,m:vladimir.oltean@nxp.com,m:vinicius.gomes@intel.com,m:fejes@inf.elte.hu,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-301156-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 591D86B0F13

On Mon, 22 Jun 2026 17:21:12 +0800 Xiaoliang Yang wrote:
> This series introduces a new TC action implementing
> Frame Replication and Elimination for Reliability (FRER)
> as defined in IEEE 802.1CB.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.2,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after June 29th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed


Return-Path: <netdev+bounces-301999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WQftOSdHPWrB0ggAu9opvQ
	(envelope-from <netdev+bounces-301999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:20:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D58C6C702A
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:20:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="QK/rCS4E";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301999-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301999-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B67C30E52C6
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90663E833E;
	Thu, 25 Jun 2026 15:18:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13813E7174
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 15:18:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400681; cv=none; b=ifWERI9rHqhrO/5/BnSRTFeYRauhFK7KyfOeOylzbGpskFuZKO7w+r76oNR13mXJTJtKaqRER+nR3DgB3XiOQ9CFw/s055+6/yAmppIvbXUmFEwtp+CRkPqfci5CkVyBdFUrFlTRS/QYBnQdfv+n4oRToSKf6GPdHOMAQ87jyE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400681; c=relaxed/simple;
	bh=ib2sAGwaIJ2oUyvwZbDZNmcPW9jcdvyizA8xO5OvAGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+IPmLqBXChzOpaVra6OvN+mvC/UAPgqtDdfVP8FWAx+TKONZlwqM6Z2LQhOerj8KklYXaWXDbQFqg1JG6D4hZRWc3GJBgWkgnrayoB4SKTSAK+s23YwQNbtQUWTh4yahlqbsaHVDXu1IXP27/XuSMfbVZ57F+Va4+yt5caMbaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QK/rCS4E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5581F00A3A;
	Thu, 25 Jun 2026 15:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782400680;
	bh=aZ0X4cgr9qLFZNQU5wx2hp/E8VvIilJvk7Gw2xJY+Lc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QK/rCS4E3jd3cpiNamBLRl9+ots8QcfDl32c6YcDzlnDFjqs7LVPxaaDIZ28PC9pJ
	 mVdjiFWV9Hka46cS1YTojk4o1sRIAfJtDQGoKZEFYdDGhxhfKu+Qn82Cnh6OgiwbSr
	 i9zwtm4YiTCcYXA+PozfIC5gmzFG2Cgk2oGPuP32Y44LbO3MI+To+7050hVsbp5QeY
	 hinmy84z19B19DLltYHIAiOxLUHDDYErw4G77jXstQJ00K2fJcus1/Jqgk3J/di9ua
	 CPoniPJRBpi3inMe+P+WqT7sUzqL5wHB6/28QxcbAAbDfCWIU79dmdaJlDOkaGrD+0
	 67S4bGmFeR0Tg==
Date: Thu, 25 Jun 2026 08:17:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jv@jvosburgh.net, sdf@fomichev.me, dongchenchen2@huawei.com,
 idosch@nvidia.com, n05ec@lzu.edu.cn, yuantan098@gmail.com, nb@tipi-net.de,
 aleksandr.loktionov@intel.com, dtatulea@nvidia.com
Subject: Re: [PATCH net 1/4] net: turn the rx_mode work into a generic
 netdev_work facility
Message-ID: <20260625081759.10330b7e@kernel.org>
In-Reply-To: <CAAVpQUCbT1Q9BPTLrVCjpt2vcJiWsYKa0onJ_vwnq86L73m8mw@mail.gmail.com>
References: <20260624182018.2445732-1-kuba@kernel.org>
	<20260624182018.2445732-2-kuba@kernel.org>
	<CAAVpQUCbT1Q9BPTLrVCjpt2vcJiWsYKa0onJ_vwnq86L73m8mw@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-301999-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:jv@jvosburgh.net,m:sdf@fomichev.me,m:dongchenchen2@huawei.com,m:idosch@nvidia.com,m:n05ec@lzu.edu.cn,m:yuantan098@gmail.com,m:nb@tipi-net.de,m:aleksandr.loktionov@intel.com,m:dtatulea@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,jvosburgh.net,fomichev.me,huawei.com,nvidia.com,lzu.edu.cn,gmail.com,tipi-net.de,intel.com];
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
X-Rspamd-Queue-Id: 6D58C6C702A

On Wed, 24 Jun 2026 22:55:06 -0700 Kuniyuki Iwashima wrote:
> Oh very nice !
> 
> I was drafting almost the same change for dev_set_rx_mode()
> in mcast path and some ipvlan changes.

Glad to hear! I wasn't 100% convinced by the added complexity
in the core :S


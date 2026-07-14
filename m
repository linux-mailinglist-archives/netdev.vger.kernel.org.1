Return-Path: <netdev+bounces-307422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y1RcIgUGVmqryAAAu9opvQ
	(envelope-from <netdev+bounces-307422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:48:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2408B7530E6
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:48:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307422-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307422-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B271C30071F1
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A84543FD1A;
	Tue, 14 Jul 2026 09:48:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C894D3F410E;
	Tue, 14 Jul 2026 09:48:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022530; cv=none; b=FQnWwHWqbNuDcFxBjYyV/Ovb1mphTMQl5rb6wJ6YZMqyJy0KBxw3Y1Y96yJ2Wq8IXX7+030jluVfEvOPbwunEXjQ2guSbXSYTyVLmx0quJF3Ic2molGMb3lEJV0DSPvRp1v9vKA3C77OZJOA69YoIcbJHCe8L9VPyV9z13A439k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022530; c=relaxed/simple;
	bh=+b6y8vPsh5H7XMMTd6eWY7WfDqrtswREAhLvm3JmIJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMk8qCS+Z7CEpc7JSrEypjQTvqAp44c5CBucLx23irdqSaKuFAnNvg3O+qBolfl0/UPn+Hw/29IwjnW6Cg6iGRTNU/2FLzLcOVfaSfr1IoNm6u/uBAFP8nUU8tYzZVncOVBx3w/Y+qWw7ogDLNLn3fpuOB6rB6ZwBx2281YGVpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Received: from equinox by eidolon.nox.tf with local (Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjZkp-000000022nW-3G5g;
	Tue, 14 Jul 2026 11:48:43 +0200
Date: Tue, 14 Jul 2026 11:48:43 +0200
From: David 'equinox' Lamparter <equinox@diac24.net>
To: Geliang Tang <geliang@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: Re: [PATCH net-next v2] mptcp: sockopt: implement IPV6_TCLASS
Message-ID: <alYF-78I4LUaePGo@eidolon.nox.tf>
References: <20260713135551.569365-1-equinox@diac24.net>
 <c3b017e1c96cdafce15012e737389108d7cbf8f6.camel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3b017e1c96cdafce15012e737389108d7cbf8f6.camel@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:geliang@kernel.org,m:matttbe@kernel.org,m:martineau@kernel.org,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[diac24.net];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[equinox@diac24.net,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307422-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[equinox@diac24.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[diac24.net:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2408B7530E6

On Tue, Jul 14, 2026 at 10:22:12AM +0800, Geliang Tang wrote:
> Thanks for your patch. However there is already a version under review
> on the MPTCP mailing list that adds IPV6_TCLASS [1] (as well as IP_TTL
> and IPV6_UNICAST_HOPS).
>
> https://patchwork.kernel.org/project/mptcp/patch/2617b8684039574734b8622936ef126d6a7cd519.1754986785.git.tanggeliang@kylinos.cn/

Darn, I looked for patches for this & didn't find any, but I've also
been carrying this locally for a bit.

Anything I can do to help get your patch moving?


-equi


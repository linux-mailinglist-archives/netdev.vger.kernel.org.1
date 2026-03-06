Return-Path: <netdev+bounces-264907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDY2BVMzq2n2agEAu9opvQ
	(envelope-from <netdev+bounces-264907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 21:04:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D215227618
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 21:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C6AAE302053D
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 20:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D65296BDB;
	Fri,  6 Mar 2026 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0ZVg2TX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1352725F798
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772827471; cv=none; b=mzPLXn4kLLjybfhCcsf0teuT8zloKGJ8Jqc7xtnequm0rPFWnjNXezXm4PC8YuhUtMNKx3z/iW1JYPaPD4EdZEpLqF3lOBGFkg9V0z7tDb7RR0tnE46hv6FM+tUm8xfCBya5QZtUnTTIrru0BIE/DkVlOtJwyDZwGJQblXWDdIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772827471; c=relaxed/simple;
	bh=xYIpXTn7F5KWj9jDumvN6M2TBa9lJOuYF602/pvJP5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nkbnU3qV5DqO1Ctqap9cvhc0mNuJ7HkATw5O8NCmwxMODS24TuTstbFns7VeWktchp/BlXyi8iUVSwhufv/xc4JgKEKlj5hrAV0nXYrjVB6BI8MfS94v4b72eUkI8L65eH+IDMpye/xTx1qzyv8sHvui3TO5yACqsVTMcfmqrCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0ZVg2TX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61449C4CEF7;
	Fri,  6 Mar 2026 20:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772827470;
	bh=xYIpXTn7F5KWj9jDumvN6M2TBa9lJOuYF602/pvJP5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z0ZVg2TX7n8tIXYHtzWOmyetekCCzXoQ73mqzqR5+WRPjcUOI2HJmhBwJQVwq5E1O
	 t4JqdVaX3Serw2WhfUU4lQN1+ocNMIZ2g3NAK8WI6J8o+e/AKxTwE/fey5BeSPiMai
	 XdCihNwvBHfvpzepXPmUigWms8sFHV/yZCaAczurjVw41gqx0WROIVgV+EB4o/XQr2
	 qwx6XlpJQSAl/516PjEBrhGx5niu2iL55iUfWtES1YDj+AlGtwHQlI41wrfKpFYMdM
	 FZspdVlbYSc1DoHtiH6WOtrURn2twsbsZHmQOg854uLsVuQIIzis5TcTCFu07rJZZ1
	 x5mRzLtHdQu9g==
Date: Fri, 6 Mar 2026 12:04:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "pabeni@redhat.com" <pabeni@redhat.com>, Dragos Tatulea
 <dtatulea@nvidia.com>, "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "sd@queasysnail.net" <sd@queasysnail.net>,
 "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net-next v2 2/3] selftests: Add macsec offload VLAN
 tests
Message-ID: <20260306120429.138f533e@kernel.org>
In-Reply-To: <305e5617d31872ed9734463a1e13bb714a5e2a22.camel@nvidia.com>
References: <20260227090227.1552512-1-cratiu@nvidia.com>
	<20260227090227.1552512-3-cratiu@nvidia.com>
	<20260227065833.36edcc6c@kernel.org>
	<305e5617d31872ed9734463a1e13bb714a5e2a22.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6D215227618
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264907-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.975];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, 6 Mar 2026 15:01:02 +0000 Cosmin Ratiu wrote:
> On Fri, 2026-02-27 at 06:58 -0800, Jakub Kicinski wrote:
> > On Fri, 27 Feb 2026 11:02:26 +0200 Cosmin Ratiu wrote:  
> > > Add macsec offload VLAN tests using the netsim VLAN support just
> > > added.
> > > In case that VLAN support is missing (e.g. when running these tests
> > > on
> > > older kernels), the VLAN tests are simply skipped.  
> > 
> > You have to enable macsec in the config file for netdevsim selftests  
> 
> macsec is already enabled, I assumed you meant VLAN. Will do.

Responding after a week and then immediately posting a v-next is really
bad. If someone responds to you here the conversation will be
splintered between v2 and v3.


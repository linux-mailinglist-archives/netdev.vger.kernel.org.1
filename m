Return-Path: <netdev+bounces-273392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMc2CekPy2lCDgYAu9opvQ
	(envelope-from <netdev+bounces-273392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:06:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECE73628BF
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8C533033AA7
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D40A61FCE;
	Tue, 31 Mar 2026 00:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKALKGVg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2973E40DFCE;
	Tue, 31 Mar 2026 00:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774915481; cv=none; b=sgTXQurQP219ZP0FEOHisUvKCzn4mBLYw7bPPNK/KHRHl/UB/kNt/fdDUXY7rH8QnxI/a6iIXP3NZ5hZqrOohkrDQR0vy6kcvljBxvihryvgksR0cwBx9IWolE3PtyewM2bZVjwLrE9Y5LZaER8mwC8YeQDzKsE8XIgilUYpWDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774915481; c=relaxed/simple;
	bh=ep9Eo/xNT3JPvWHxwOfM+K/RIfc0fvWxzAemEzUAq0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rsP+dwXUpSWGQHpQ4aRTpIpWJ0lsjgmhYDhr+eVXl0JPPkSyX+AI3t6Xq8gowvCM1Ss+w4wP1Y41y54oR7eUIJNuFKFRyPHit2OTT1UeFQ5ONSVAuHOjWAZ2+/kQ9zUipUlf/mIf149w/DisrRErk3OYMQ/K2Y+FeFFZT9ylb7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKALKGVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C1DC19423;
	Tue, 31 Mar 2026 00:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774915480;
	bh=ep9Eo/xNT3JPvWHxwOfM+K/RIfc0fvWxzAemEzUAq0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QKALKGVg9EOxjhIU06BEPpusqkLzlnE9OZ4m3CCxvoRNS+wgXHXhWWyyZe/8+EnKX
	 6TrUVLibZkInqt1Myo83fDXAwahguKT0yI/pk9juk3ehFsxv7LGQVQCReqRtyh3fZT
	 Zh0laWbqEvbOvDF/2ZTKXAO/sP1rmsj3PwJZdecDUigFWGU8Ta0ZHL9obCIN1VlE9q
	 UNF4HuQSBWf1ah+p6htmNoBNbhi05dE1Kp3LuwXUfnmrF6gPl2Yv73IawxCPhkm2HN
	 RjPpDJNIUe+jt5LHM22xImqxMeEinLLVTEdDkyTGLRg7Xsx5cn6bnCcdv5qeJz5M/q
	 BDWYKdGbh9KSw==
Date: Mon, 30 Mar 2026 17:04:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, <netdev@vger.kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, <linux-kernel@vger.kernel.org>,
 <willemb@google.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v4 02/10] selftests: net: add helpers for
 running a command on other targets
Message-ID: <20260330170439.35ef3cac@kernel.org>
In-Reply-To: <871ph15zip.fsf@nvidia.com>
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
	<20260326132828.805703-3-ioana.ciornei@nxp.com>
	<871ph15zip.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273392-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7ECE73628BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026 13:02:12 +0200 Petr Machata wrote:
> > +run_on()
> > +{
> > +	local iface=$1; shift
> > +	local target="local:"
> > +
> > +	if declare -p TARGETS &>/dev/null; then
> > +		target="${TARGETS[$iface]}"  
> 
> So I think Jakub's runs fail because there's a shell export somewhere
> that gets inherited through make to the launched test. I guess it would
> be enough for the test to validate that TARGETS is an array, because
> those don't get inherited.

Great catch, FWIW. Yes TARGETS is what ksft makefiles use to define
the group of tests. We do 

  make ... TARGETS=drivers/net ... run_tests


Return-Path: <netdev+bounces-293975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPPGI3BDHmraiAkAu9opvQ
	(envelope-from <netdev+bounces-293975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:44:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 326EE6275B4
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58CAD3048AD1
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECF433B6E3;
	Tue,  2 Jun 2026 02:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+eQakfI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EDA35F8D2;
	Tue,  2 Jun 2026 02:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367887; cv=none; b=MJz1MgZ2FGbExZ6sfjZLjDHOWB6XtjvxI+/SQryJBuSFjeJZthV8Iz0D5fw399UM0nWL2BfStaJfGnSPeeX5M1OvJmxNt12ieLP2jSyn8y6DdJv+J/HM+b/mxYSkZJBKI0qpNGJijAHHJulv8RYue9mPn9uq6kJ05W0ijeFUmLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367887; c=relaxed/simple;
	bh=9JCW+Gqy2ZpCrpUkMMjpDDTOkG8L0GCRzg9YRFwGf+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhQdAdK4RvPGgityKkZZpaRNTx2+qsIqaF4cGYBvPKGU2/Fy6slr8SW73Etpso6ppfcZt+RevlbnhAe3eT2Pqop0IPMEIfEoW7FWz8a7JAoC4uI/0vOmRD1X+RerBiZMliI8bIq2qVL8TCuTfK+86S3DurphUfXWWiZSj6h7GA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+eQakfI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9431F00893;
	Tue,  2 Jun 2026 02:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780367886;
	bh=idKsTKE7peTYnCPV2X1YQ2+JFoZ1gXg3LX1PrU80hUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C+eQakfImk7cHUD+weeOZZAP3pXcWEzZvpmIOFivGGrme6p9LS12i6zwZ73ct1R3n
	 jKLALeaDeu+LQzJdHFyARfm/0HzewUkd9s8k5NmOIMO2IC6J3cvnv4iObqyGP6w7wi
	 V2iLYudavhTlFaAznfuCl0CnU2Q9ZzSaku75NvMryF5HtMozGv+7dqVdMWGzflKWB9
	 YCwCYFmOyjCeL/WF4fdQPEPQDttRTp6DSUQukWjQOu1+Jl1A1QykyU6UwGFcAWIbTX
	 foGPXIdMVnlU2UDZFYxb/VXsUXM47jzn5/9cJPkPgqstctPDD2a1loQrGJx/Ntz6ew
	 XzoKhSq5DrOgg==
Date: Mon, 1 Jun 2026 19:38:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: Paul Moore <paul@paul-moore.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH net v2] netlabel: validate unlabeled mask attribute
 length
Message-ID: <20260601193805.011c7f15@kernel.org>
In-Reply-To: <20260528015913.190970-1-zhaochenguang@kylinos.cn>
References: <20260528015913.190970-1-zhaochenguang@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-293975-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 326EE6275B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 09:59:13 +0800 Chenguang Zhao wrote:
> netlbl_unlabel_addrinfo_get() checked the address length
> but allowed shorter mask attributes to pass through to
> fixed-size address reads.
> 
> netlbl_unlabel_addrinfo_get() only rejected a mask
> length mismatch when the address attribute length
> was also invalid.  A crafted Generic Netlink request
> could therefore provide a valid IPv4/IPv6 address
> attribute with a shorter mask attribute.
> 
> NLA_BINARY policy lengths are maximum lengths,
> not exact lengths, so the short mask can pass
> policy validation.  The mask is later read as
> a full struct in_addr or struct in6_addr.
> Require both address and mask attributes to
> have the exact expected size.

Sorry, didn't look at this until Paul responded.

NLA_BINARY does _default_ to maximum lengths.
But you can use NLA_POLICY_EXACT_LEN() to have the policy do the right
thing. Using the policy is preferred - less code, and policy
introspection informs user space about the expectations.
-- 
pw-bot: cr


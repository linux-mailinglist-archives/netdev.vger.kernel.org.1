Return-Path: <netdev+bounces-242569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCDEC921E8
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 14:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CE814E2B54
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 13:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDAF32B993;
	Fri, 28 Nov 2025 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b="FRQ9SjM6"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDDB32E13D;
	Fri, 28 Nov 2025 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764336190; cv=pass; b=Ql3OLa9mhpe2I1U+Kn0vgJFRVXtc4LKSxbFCZvq2nGevC80L+5+fm3s9EywM2FfRuMLC+laV4g8gXCDZ5jVO1o+qIB40mD7O5LXmQFqmpXJWi62RQzBXCFeNIeKEocbPHSEmhCU2907LFPp+fOS8q4BmM6flhhn2IS+hjW/eC30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764336190; c=relaxed/simple;
	bh=9z5VWv6vxgyOfdiDPbzV1Q2BK+8ZbCmdJtiIwcUv92A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=le/OT+k+iQl7eEALPw9+8OGWG9i6tzVVotNVGH4slKEWw8x8BpML6XL1n3jb+jTUbHsslrZ1T7AoYjnMziQT9acYaStVOJb9X0U5LHfq4ar2U0wtUMtkAionC3viMWCtaln7YJVpjzpc6mNRICKlQZuJBgzdN7ynbMvPEGj9+Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net; spf=pass smtp.mailfrom=azey.net; dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b=FRQ9SjM6; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azey.net
ARC-Seal: i=1; a=rsa-sha256; t=1764336155; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=bWoUS1EceOpqcddZI7m1bTBEOJ+UetcKYnOPL9H4wfzp6rmPODOfhyDX13r4QPyYjFGuBi1PBTpCHv0B7oCsQzGctByl43XSpqwO5cKSXOlkCXf1yG1iGmyUmjb+baxROrIhwB8n99KNeBqMpoG0bX5rurwwTeF/CbjpyOBEvHk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1764336155; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rRj1q49yWLxvqAD7wwEXyp2MhSCxCk5EDQuoaJqXbDE=; 
	b=Ae9ykwwVRTkpp/5NE48ufRnnazHcx6/qR0Y/pK4MkxD6Z5vZhqw0A8L3c/Q1hYM5S8jpPPWkeVG4RnGxmF42i/B4qTlf+WYs47V+acd5bIUHN5+somvQ3R5wBuZ3/HmJSlsGldgIWS5I9XfYDjUCQMAFDV1Gfg04hAuOLRTuAPo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=azey.net;
	spf=pass  smtp.mailfrom=me@azey.net;
	dmarc=pass header.from=<me@azey.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764336155;
	s=zmail; d=azey.net; i=me@azey.net;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=rRj1q49yWLxvqAD7wwEXyp2MhSCxCk5EDQuoaJqXbDE=;
	b=FRQ9SjM6NBUYi8RkxThgMByEBpJ28xDXv6MVb22Tse9zV6zntdTK2g8Muq/JvLrM
	aSodV2SehJxvzZ0lL17UW3RCXMTIYwcsdYxLc1SvJckMIAuZDGZkGFFkom4WWcABKMh
	JxKpQktfo3qooe7EF2/+5C9/n6n34mXbwhRDDyRc=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1764336152965415.9644893354091; Fri, 28 Nov 2025 14:22:32 +0100 (CET)
Date: Fri, 28 Nov 2025 14:22:32 +0100
From: azey <me@azey.net>
To: "nicolasdichtel" <nicolas.dichtel@6wind.com>
Cc: "Jakub Kicinski" <kuba@kernel.org>, "David Ahern" <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
	"netdev" <netdev@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19acaa1316a.105511e68180307.2775804843624326464@azey.net>
In-Reply-To: <19aca794ddd.105d1f97f173752.5540866508598154532@azey.net>
References: <3k3facg5fiajqlpntjqf76cfc6vlijytmhblau2f2rdstiez2o@um2qmvus4a6b>
 <20251124190044.22959874@kernel.org>
 <19ac14b0748.af1e2f2513010.3648864297965639099@azey.net>
 <85a27a0d-de08-413d-af07-0eb3a3732602@6wind.com>
 <19ac5a2ee05.c5da832c80393.3479213523717146821@azey.net> <1d44e105-77bd-42e7-81f5-6e235fd12554@6wind.com> <19aca794ddd.105d1f97f173752.5540866508598154532@azey.net>
Subject: Re: [PATCH v2] net/ipv6: allow device-only routes via the multipath
 API
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

On 2025-11-28 13:38:58 +0100  azey <me@azey.net> wrote:
> wg0 has fd00::1/64, wg1 has fd00::2/64; Exact command history:

Mistyped, my apologies. wg0 had fd00::1/64, wg1 had fd01::1/64.


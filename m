Return-Path: <netdev+bounces-292462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id k1eqHXdoF2qhEAgAu9opvQ
	(envelope-from <netdev+bounces-292462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 23:56:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D65905EA7CA
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 23:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0AB83045E02
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D15C38B15E;
	Wed, 27 May 2026 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS7t1OoQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5A9362130;
	Wed, 27 May 2026 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779918964; cv=none; b=lBek1iejFKXjhfcyPJAmmbEcloyP5r3TWu5rtg5xTgKFKOT7JBBpyn6Q/I8Rov6G9WpWgx2qpyAF+ZNxYlI6FDvFeaTj8RaceDOSYS9ZphPNtVHhLiFt8a82cbg3i9znfW1qbK5T5vfvH8+/v4skt5YY2q6CKX3V++6J/aocE4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779918964; c=relaxed/simple;
	bh=tS0bgiHDdfBbdT/VoMcFhty5LuCaxouVxK9rsi5R/d4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKCLODcgew6aJTqDyls2vXEJ4OM0SOi7/QyrXx+HdNt2TgB+fJbdtpXDqtg87rDpLVsDlJUs2ncBpk5VyrToEzLwVMzHwdZcr+MNzBz0sGDdyHQpDf6AWRHjv6BE8Fnfv5NZDidXWKlwbkQHuIw7JZXP66KrD74r3JibWHrWf+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NS7t1OoQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D64F1F000E9;
	Wed, 27 May 2026 21:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779918963;
	bh=k7jYSZKwCkb8YKqTHtdpZhV4jmxc57bTV07CM5xaP1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NS7t1OoQ/qosM3+/nmP1LQgHmVVJ3DEjjcmBCdtzhqvbODqqn+RIYY8EjGCW475DH
	 yGnJ/jcfgxmvqxwVp2q4yInwJLHlIcWHnFCHF+PyOvshti2UXCwVjVDKnNm108M9dc
	 XtA4fX5oKaKv4aWFEJHUqyF442TUpS5kDf3YIYNwR9Zwj11B056tn5JWQC5Z/c23sI
	 Le3K5Tzl+QhKLKzIP1uf+uF+x2L37eaU6FodZIKmsbVtbYH+qfXTKOpBrBJ/bQYzrX
	 Ius50BPbuxXtZApDUSLVnFY4xX4ley1IyymWbtG61HRpOJzC4/zmIG7CIBTfVNEakP
	 TzHTnsmiF3X3Q==
Date: Wed, 27 May 2026 14:56:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Thompson <davthompson@nvidia.com>
Cc: "bryan.whitehead@microchip.com" <bryan.whitehead@microchip.com>,
 "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: lan743x: avoid netdev-based logging before
 netdev registration
Message-ID: <20260527145601.512dbce9@kernel.org>
In-Reply-To: <SJ0PR12MB8113B58970F2E9B7A6EA5B75C7082@SJ0PR12MB8113.namprd12.prod.outlook.com>
References: <20260515215229.3881949-1-davthompson@nvidia.com>
	<20260519184115.3c70f2ac@kernel.org>
	<SJ0PR12MB8113A2493154C98E13D246F8C7012@SJ0PR12MB8113.namprd12.prod.outlook.com>
	<SJ0PR12MB8113B58970F2E9B7A6EA5B75C7082@SJ0PR12MB8113.namprd12.prod.outlook.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292462-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D65905EA7CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026 17:27:13 +0000 David Thompson wrote:
> While preparing v2, I realized it makes more sense to add a module
> parameter to control the initial value of msg_enable, instead of
> hardcoding it during probe. I'll update v2 to include this change,
> which means I'll also need to keep the checks that were previously
> always true.

Sigh, no. Please don't perpetuate this stupid log categorization.
The module param is not present, that means nobody needs it.

Also when you repost please target net-next and drop the Fixes tag.
I don't think it will make the cut as a fix given Linus's message 
from -rc5 announcement.


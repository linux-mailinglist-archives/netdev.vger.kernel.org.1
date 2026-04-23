Return-Path: <netdev+bounces-280820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKI+D+NX6mkhxgIAu9opvQ
	(envelope-from <netdev+bounces-280820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:33:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 747544558AB
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23A673006917
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 17:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED8338734D;
	Thu, 23 Apr 2026 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoMU6iVd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C992531A567;
	Thu, 23 Apr 2026 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965274; cv=none; b=ejLlEFP9kbgbrjpUL4b/I1l2zf8kK9I+YX3+4EhWEn4hR4i6HrDI8yC8LQj5a2BApPd2mrR9lEC+tk0+6wKvGjWNGPqxJuM7OY04Z5scgrrnJ1z8L0xWtKA3nm4sHTWeJhVKkL8i5Q2101XB6abbjIgping9BYt3FCtQo8UPFds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965274; c=relaxed/simple;
	bh=Aw9ZpvS4xYK1rpTdhS3g7GzKjovEFNtcbI8hZAwEiKc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNsKXiuTuJE7B8tw3NrKndLPX0xZ6wQe3FFzQabclwVmrEwQs/tsN5Ezq4Yqy7OihFdEIlyiP0VbyG3y6mhQPb76hgnA9bVfZDqhszCATEU3PS8YCIPEN8y9OtsH9sSUs4QD8ebHmkqS0GlhdOo4kXhFKfnHlXAJX2ckhl/KNeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoMU6iVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EFEC2BCAF;
	Thu, 23 Apr 2026 17:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776965274;
	bh=Aw9ZpvS4xYK1rpTdhS3g7GzKjovEFNtcbI8hZAwEiKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QoMU6iVditMXQS36nqrB44IZVxVqr4XatejeAYObvWPQqC6FpRCWQAO6MNP4IMxc0
	 OOVfAamGHlpFksIedgOiTIwxNauZOvng634VQ56aIIpBuLMH0gBS7cDaN9YaX2IVM7
	 5wtdzAnZchnxcfVzm87qhHbjivx4MYZWxxT6r2+kgk5+IRPMM77uDciuB6mKliiLDt
	 JacG8MEhKxFH7bl/pXk1jRoAkN4l8Y4I2Ks0sY2+DcCuiTGluRb4gtpvBiUdKhZWH2
	 FX38E/g59kGY7Zl14jfz45sE7Omiw2OJwU5KP9s2m/vprohUc8FB5UZIsj9TifdsOE
	 qx0Z5lwfj/x/Q==
Date: Thu, 23 Apr 2026 10:27:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, andrew+netdev@lunn.ch, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net/sun: Fix multiple typos in comments
Message-ID: <20260423102753.4161c261@kernel.org>
In-Reply-To: <20260421114512.2690443-1-j.raczynski@samsung.com>
References: <CGME20260421114526eucas1p29a73b6c60123beb164975e931347f1a4@eucas1p2.samsung.com>
	<20260421114512.2690443-1-j.raczynski@samsung.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280820-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 747544558AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 21 Apr 2026 13:45:12 +0200 Jakub Raczynski wrote:
> There are some typos in comments and while they are harmless and not visible,
> there is no reason not to fix them. Fix the ones that are not register related,
> which might have intentional naming convention.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.1,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Apr 27th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed



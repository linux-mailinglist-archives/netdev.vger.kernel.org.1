Return-Path: <netdev+bounces-266885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ENPHQ8vsmmzJQAAu9opvQ
	(envelope-from <netdev+bounces-266885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 04:12:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E6826CADB
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 04:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 739533078A06
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5453845DE;
	Thu, 12 Mar 2026 03:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DG79/evn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599D238425A;
	Thu, 12 Mar 2026 03:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773285063; cv=none; b=H0r+LQNWiqh43slK+2VVnRL2znXx+sr86aFx67CqwvuefOepZqaaMj+4wux2J+I5DlLKr6WOlnDjMVI4VDY4BKt6rCkqAn/p96falcARxPNaS77JqYcVhncgXdHkjuW2IQahPhh+6mGU0l3hi55Wfzxf0fGn+ACMxYQ4aI0f3zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773285063; c=relaxed/simple;
	bh=4AyF6qq2eKeMZ2o27Gj3pDh6oStLzbnfpjigh8+H/k4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzbRXtg8fgaV9h+qpf/q+A3k6sLSXWEx1ldQnDZIqf95mS1bc/Qzk2+l2E6F1OQfICROLIztIBLzC8P5Ecm1iupDn/l0IUaq4kg6VeAGBYdkZEhV26r4YKxhqkO2raLcxRC9ngtOsGAHoxhisamtsqmut8Vws+oEHcKByJemBPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DG79/evn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22ECCC19421;
	Thu, 12 Mar 2026 03:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773285058;
	bh=4AyF6qq2eKeMZ2o27Gj3pDh6oStLzbnfpjigh8+H/k4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DG79/evnfhFpCFF4QoFH2+PkKiWNDpUJc8u3f8FZDekZytrL0SyKzYhgK0w4wwNeG
	 TuKSImHO5zJXcyP2mjBltJYUDLTuQcyWhipdt4Se+VkTfPttZLyUtyTOvYdYys+Ro7
	 XrW7269d3TZPff6OVPhLbvaP5MasZcmpFg8+NKyVuKEtDk70VgeKmvkV5gqYWRQSLC
	 Jfx942T34IQcFHaSmaiKCrKS99iaSfkQy0fJan2epTcZcVJfyKzXglhEajpt90PR7J
	 HOnhq7sx+xMPqpuPkC165O0fFhQe0uOQBDVd3/EXI+j3rMmJc1G5DmVJLa2B4uR0kG
	 rXPbpJF6sk0SQ==
Date: Wed, 11 Mar 2026 20:10:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Aaron Conole
 <aconole@redhat.com>, Ilya Maximets <imaximet@redhat.com>, Eelco Chaudron
 <echaudro@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, dev@openvswitch.org
Subject: Re: [PATCH net v4 3/5] selftests: net: rename pmtu.sh to
 pmtu-test.sh
Message-ID: <20260311201057.049950d1@kernel.org>
In-Reply-To: <20260309152013.565216-4-aleksey.oladko@virtuozzo.com>
References: <20260309152013.565216-1-aleksey.oladko@virtuozzo.com>
	<20260309152013.565216-4-aleksey.oladko@virtuozzo.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266885-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pmtu-test.sh:url,pmtu.sh:url]
X-Rspamd-Queue-Id: 02E6826CADB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon,  9 Mar 2026 15:20:11 +0000 Aleksei Oladko wrote:
> Rename the pmtu.sh test script to pmtu-test.sh. No functional
> changes are made, only the file name is updated.

Please try to fix the test ?


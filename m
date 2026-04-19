Return-Path: <netdev+bounces-279600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHIhKhn25Gn3cQEAu9opvQ
	(envelope-from <netdev+bounces-279600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 17:34:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F4B4247F8
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 17:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0640300DF54
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 15:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46801A682B;
	Sun, 19 Apr 2026 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ce+yRL7+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF6D14A60F;
	Sun, 19 Apr 2026 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776612879; cv=none; b=ONlHipkiSERSpkuD5GOIkULOkL/CvbhLooHpiJ3h+xUtZ74V5Cvhl/s+2/wfzQdamkouv3C6DY2F665yfqgbsMxQo2xGhXGqBx93y4cbrEXQN88aqIjJfFd/Bi2FX2BLUIE6EKfziIWKWjPZsLkMIUHzfHRmYPgV/Ne1EuceFcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776612879; c=relaxed/simple;
	bh=H46xEImp2/v84M5n4lt1wVNxWaCced9vVT7gZZPrWtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muWsbgN7wr2IZ39B8RsUzm5u990HPc9e5iI98kS0D1ML7BGtVIhnB/kgM83N+g1LsWpc8kQjCzLP4Se9oGYSTfwKNHDVq/dvdeZi0g33CGz/uq1TjvkpNu9HAfpHKjzPQqiltzTPhzHG1d0k3wTyaRjQMmLGjszYOSoTeK0jNEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ce+yRL7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416D7C2BCAF;
	Sun, 19 Apr 2026 15:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776612879;
	bh=H46xEImp2/v84M5n4lt1wVNxWaCced9vVT7gZZPrWtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ce+yRL7+4d8WTyQfo3E73NQMAx1AL5s7RpefacGStpHgZQns5rfwSuCD7qJAOxTe4
	 wsD+BhhIhmVSDb2a2GSwLcPBU6PIXJKMsqqKSFrdMLef0hO0iGyywmbqdup7t6gxJQ
	 xhjp96aSKJUWtJMD8IGiN39PwWjZl7gv+Y7O5A8GNIRhprmz/hKmSY7PpCmKupCeqp
	 wMW6ekXdukex4hvNfo2mPh/Pewy1+gTGcRtnyNJDy+/Rr/2zi2Dm42yQx8d3bMO0nW
	 l+EyKXr6f3qjhyczRYhy3n6uJPNwo2mE6Iu8Jm2z0fHROn44n3HrXMhBkEZeMRQR3G
	 OUf0i4czA9Pew==
Date: Sun, 19 Apr 2026 05:34:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Thomas Graf <tgraf@suug.ch>, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-crypto@vger.kernel.org, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org, NeilBrown <neil@brown.name>
Subject: Re: [PATCH v2 sched_ext/for-7.1-fixes] sched_ext: Mark
 scx_sched_hash insecure_elasticity
Message-ID: <aeT2Dgam3gVqKiVx@slm.duckdns.org>
References: <aeGIsGi9fBqu9EZT@gondor.apana.org.au>
 <aeHjjGEhlikSsxCX@slm.duckdns.org>
 <aeHmeAz-Z-Rx2MqX@gondor.apana.org.au>
 <aeJe8oIyYUi-NtCQ@slm.duckdns.org>
 <aeLT8eB_xfzLxqbI@gondor.apana.org.au>
 <aeLV6aDhM0-S4oQ1@slm.duckdns.org>
 <aeLWH_HgSHF4buiJ@gondor.apana.org.au>
 <aeLgjAeJuidWNy3N@gondor.apana.org.au>
 <aeLhQRFPEY24ySIq@gondor.apana.org.au>
 <aeT11WIF6kzvifm7@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeT11WIF6kzvifm7@slm.duckdns.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-279600-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 12F4B4247F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Applying the rhashtable patch and sched_ext fix to sched_ext/for-7.1-fixes.
Herbert, if this wasn't what you meant and want the rhashtable patch routed
differently, please let me know.

Thanks.

-- 
tejun


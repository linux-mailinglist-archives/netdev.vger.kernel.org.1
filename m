Return-Path: <netdev+bounces-273028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +htzGianyWmu0gUAu9opvQ
	(envelope-from <netdev+bounces-273028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 00:26:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D733935449C
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 00:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B06A300DF49
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 22:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AAC2F1FF4;
	Sun, 29 Mar 2026 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WH0IzwMc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3E9463;
	Sun, 29 Mar 2026 22:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774823202; cv=none; b=Og5YqWzLEzXXeszM+keIwgkHkmvkH9R6f805I1K3eTJAc3jWkVvPgSniby8QrvrZ9i185gQvb8HEvm5Virn/87Gr9OaN91rSoMRfH13kmObzQ4iMA8QAXIDF7i+kr40EMqlMsspGlymD+3L89nNir2viUWvHS46vUgJNC4ZnEgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774823202; c=relaxed/simple;
	bh=KPxNYFLMKkQB1MP3F1iE6evx43X5GMGgRa4JNxbO3Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLP+zdBVwsWLurAiV8U5kuWvkXQ6xOgl4yCt5SgWAl8+tcY+recXssPyqqc7UbYIPS6LNHlsdThldh2eqEsdp+AVst0+xcwJrk17ZZeZVSKsyO8UyXWSo+fLlrpJ3O/m07t+Mk4NbT5wIDk9hFUq1gtTCtWBXTvc4SepQSW5R2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WH0IzwMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE24C116C6;
	Sun, 29 Mar 2026 22:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774823201;
	bh=KPxNYFLMKkQB1MP3F1iE6evx43X5GMGgRa4JNxbO3Lc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WH0IzwMcEYS4P/j1Y0Yp7jBzZdUsb+EPoH3exlMYdGj5P5cklaflYKwORqP4JlHTi
	 15h7KVtF80vCTITxxiuZycjU/7HOWuD57TndbXQ1xQUGv2ifi9urIVylvaH+7Stfs7
	 nCvhTHigzam3Eq18rt2Im1lekdfep82vcxj+8FIe3gy+kqjYs+Mq12Tm/5BDCtScYe
	 jisCFmG3MooeesSC4BvPRkyI6bbFmy/xzaroQJ4d8uPKevyYGgB5LBSkZU1de8UpuT
	 EGSnkwh2mPYX4vM1xN//vNdPGAP2GY9s2CZay9ej7d4AOweQSZcmAwhNm0glz2FciL
	 Pw2q8X7lWwJKQ==
Date: Sun, 29 Mar 2026 15:26:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org, leon@kernel.org
Subject: Re: [net-next v6 11/12] net: netdevsim: Add support for SW USO
Message-ID: <20260329152640.00d52107@kernel.org>
In-Reply-To: <20260326235238.2940471-12-joe@dama.to>
References: <20260326235238.2940471-1-joe@dama.to>
	<20260326235238.2940471-12-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273028-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D733935449C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 16:52:30 -0700 Joe Damato wrote:
> Add support for UDP Segmentation Offloading in software (SW USO). This
> is helpful for testing when real hardware is not available. A test which
> uses this codepath will be added in a following commit.

Not sure we need to carry this in the tree.
We have a bnxt device in NIPA, the code will be exercised.


Return-Path: <netdev+bounces-289698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LrGM4MTDWpUtAUAu9opvQ
	(envelope-from <netdev+bounces-289698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:50:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30975586A32
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E7523023DD6
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D182E29ACDD;
	Wed, 20 May 2026 01:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuyv7KDu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2C829CE1;
	Wed, 20 May 2026 01:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779241856; cv=none; b=d7QfZdMzY/RbSOccNWRvHkwEnIm1S/xZ3rbCpi1AlXQdM8pW5LKJYnXqLZYaVj+Ry2lqlG44JQn06TKFE6Nnqt8MniS5EXqgl9MLVk6+gzIXTBDBCd0yi0eiidcvb2iubJPZtfGRvfvD0/Ji/ef7VVeqs3t8I5pcpYa+dCv067I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779241856; c=relaxed/simple;
	bh=oEFF7oAJXNifLYzg4xO/zk3mwpOiZUNhWFuX0LM5zy8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DT354nsLQq6hyGqz5Aane9UFKTw5uUXIdmsraZQ+cEBug2Iq5GteJqdanwHj4nhTeGRckp9XXNVpLbOjLZt1LWw2TowIXqKYeSg9+hMGskCzk46yq6sgjI+bWBZCRnOn7oheuLeYKZejohxxS4jN0gAj/yH1krh/luiaLvtBgmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuyv7KDu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5011F000E9;
	Wed, 20 May 2026 01:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779241855;
	bh=1aJnMeJio2cos278iuIZCIWNeb0Zyn4tRzJL6f0ZCP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fuyv7KDuxqo3IQ26HXLikhtqD9FZzGFW+FP3mAWMPVWD42uc9iIg9qvNPAnivenrO
	 Z+mMjMUKW57voTRNmo8qfnNN1jV7jmQO8n5KBiAbgkmxlC4vR3wWzq3LUDeq7+H+AJ
	 yv2qANqz5J8vLf8k2HrgkxsYjx/CuElrw9mAB4L5lMBjkl1ajTPoyIKUdJb4b6olaf
	 lquaYTdHc8/oEgS7hVpEvypriiB2QoM55TjUPGrq/kFoUze7S3Bs3nIHg3ptQPfQ6d
	 yjdxs6FgytehSZ0RuHBcAT7EMRPSqeLf8sB9JqcjJjNzcOzw4Y5PQm9Wd+JOAvQPHx
	 Z1VbRl458R/6A==
Date: Tue, 19 May 2026 18:50:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
Cc: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <marek.behun@nic.cz>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Thomas Eckerman
 <thomas.eckerman.ext@ericsson.com>
Subject: Re: [PATCH net-next 2/4] mv88e6xxx: Cache scratch config3 of 6352
Message-ID: <20260519185054.4f8fe637@kernel.org>
In-Reply-To: <20260515223707.1026325-3-fidan.aliyeva.ext@ericsson.com>
References: <20260510213429.2044612-1-fidan.aliyeva.ext@ericsson.com>
	<20260515223707.1026325-1-fidan.aliyeva.ext@ericsson.com>
	<20260515223707.1026325-3-fidan.aliyeva.ext@ericsson.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,nic.cz,vger.kernel.org,ericsson.com];
	TAGGED_FROM(0.00)[bounces-289698-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 30975586A32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 16 May 2026 00:37:05 +0200 Fidan Aliyeva wrote:
> +/**
> + * mv88e6352_g2_cache_global_scratch_config3 - caches G2 CONFIG3 value
> + * @chip: chip private data
> + *
> + * Reads and stores config3 value of global2 scratch registers, which
> + * can be used to determine if the port is attached to a serdes. The
> + * value does not change once the switch is released from reset and
> + * represents the value of the pin strapping. Returns negative error
> + * number if the register read fails; otherwise, 0
> + */

The documentation of the return value has to follow the kdoc format.

 * Returns: ...
-- 
pw-bot: cr


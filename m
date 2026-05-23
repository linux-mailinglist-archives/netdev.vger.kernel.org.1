Return-Path: <netdev+bounces-291017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAzjEDAMEWpJgwYAu9opvQ
	(envelope-from <netdev+bounces-291017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 04:08:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 928885BC797
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 04:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43FCF30069BC
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F210E2848BE;
	Sat, 23 May 2026 02:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6UPwKyL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED162277CA5
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 02:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779502121; cv=none; b=omomJyylwmFFFqidVqZmit9mGmXwxZC75KRBdGHmLUeVOJ8MsPu5v9rP43DDdWQQlp1ZMySZw9ZFc4je7Wta84zSEdliGQR+H4PcB5uUzHXCX22wk/ERVDRuaP2wHcPC7iU8irmAhHh3IVAYFGAPIhbZggLwJXJXAuow0IRVyS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779502121; c=relaxed/simple;
	bh=AfqvAkJzTJddPgMLvLUEh5zyFT4JvDYaoHBJwWYcTfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aaxgopXuMLYv7A2sR8NVuMG/8k30N6pqaLcI44gNUr8PBR08runKSJVdaPaB743kV3rABUnJx3N5RSeK511AmqnccOJsN0HOS3hNu8camvdgiD+Rs4yNqci3OQbhsHuBHjhpIStZ+ER4jMD8z3vJoZ35rxrFwnPBjQlJcZIdxhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6UPwKyL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD491F000E9;
	Sat, 23 May 2026 02:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779502120;
	bh=vE6tkYfG7P22TMsoe3sNS1xtbORRktVQTlJJMJCoYuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=L6UPwKyL2FPqbNyI70kJv+gDOtDp3doq+ZXJ36q5CRuPmvRBx4RuvSL+iOmJW5APC
	 gqIS3bQOSa+TYd8FB4igjGrsjq06SaMnVeiQqWAY+7Weoxk0iivYOefytEOCg5GcaG
	 wn4FYz+HTF7kJ+hCoilYupuopFm3DtcMuuFdjRLzlMKvhM5B+vTLAkYwNLIBxjbmBx
	 JNkVA9C+/JKnLUSKo8IqlsylqHbRaZldVkxcf24oQgwdzV02mwZw0MJEFn2iJPAcm+
	 h6ZKXEIXYSaTUZBiGosW4vzmOP8gdo5gxfuxiBHPOgtHNtWcpl/ouI0azPd0IKM0rM
	 Rd4qALMYX0iVA==
Date: Fri, 22 May 2026 19:08:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Louis Scalbert <louis.scalbert@6wind.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, jv@jvosburgh.net,
 edumazet@google.com, pabeni@redhat.com, fbl@redhat.com, andy@greyhouse.net,
 shemminger@vyatta.com, maheshb@google.com, jonas.gorski@gmail.com
Subject: Re: [PATCH net v6 1/4] bonding: 3ad: add lacp_strict configuration
 knob
Message-ID: <20260522190839.3d43b528@kernel.org>
In-Reply-To: <20260520112539.798275-2-louis.scalbert@6wind.com>
References: <20260520112539.798275-1-louis.scalbert@6wind.com>
	<20260520112539.798275-2-louis.scalbert@6wind.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,jvosburgh.net,google.com,redhat.com,greyhouse.net,vyatta.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-291017-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 928885BC797
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 13:25:36 +0200 Louis Scalbert wrote:
>  	[IFLA_BOND_BROADCAST_NEIGH]	= { .type = NLA_U8 },
> +	[IFLA_BOND_LACP_STRICT]		= { .type = NLA_U8 },

As Sashiko flags this should also be added to
Documentation/netlink/specs/rt-link.yaml
Looks like we missed adding BROADCAST_NEIGH there so maybe another
patch in the series to fill that gap?


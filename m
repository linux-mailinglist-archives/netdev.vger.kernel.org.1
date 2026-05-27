Return-Path: <netdev+bounces-292014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPymOa09Fmr7jgcAu9opvQ
	(envelope-from <netdev+bounces-292014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:41:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD265DE001
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C8FE3010BA1
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680D52236E3;
	Wed, 27 May 2026 00:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kscmmn5T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516BD286A7;
	Wed, 27 May 2026 00:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779842473; cv=none; b=GbR9s3wbsGRi6Fov20E8py8a2ZqD+k/eVkbtIMPKNCLTJyqiG5aDS9DBw9k/gN63vFle1+jbpgBIs7tsJz23RD7lbBTu5+8bFgbBSAMSmeJA7tRDeMzYgiS/Y+LZKCV1OA+DdQDP5MVmgWn3B50aQZYifvynrpc39SKUvmKPeSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779842473; c=relaxed/simple;
	bh=ra7Oz073RjE+U2+8J8dgz2QFCuDUuu+cO2z3gbGFVrw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDfJohB/1fqsHeqEs6dk5oDoLpKFagiUHZLisUjSB0z4lRmasBNs/TYNcQBFbqIYjtye242Y9M2+rcxHlPAtT2fQuwsHWArGfqGZ1vD4RqLX0j5J7/kkk4KC3SGDUBkNzm1oYxxrXTS5m1BKndoOcvLmsJqzNRGCZSdnjz3POJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kscmmn5T; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949001F000E9;
	Wed, 27 May 2026 00:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779842472;
	bh=eWkorYtFhHkTvSvLXaoXTvQR814IbU+cPMEBwMjnO7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kscmmn5Tax+6xxlIPAR7dUestp5ATZIKrFeFkepUqFMhgdlJyHUgh48ubPNF2kdFV
	 o26eTUXEb5FOa7P6EcxuKyej6ssUtYtcMJkSV5qYxwZoNJtsnnxyCVEzY4HNweYmkP
	 D1dwEd7eIcK5qFQLLTI8gcQ/0yUIl9ZgGkSBSFaAidVKUi4lCpRpjsQLheAn2H4nse
	 MlKUhqJ5iA7Uv5+bvddKMDe1/VxULFhjKkZz79X+lzTbA8l52/wj3NmsafrHqltN/s
	 QyfzkIvdpUreX/UqrQY9NiGNtneqqYrlfrGXU8KY5FFGFVjEC04k128PG8t5nVPfu0
	 q1IF4BnD5AyZA==
Date: Tue, 26 May 2026 17:41:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <han.junyang@zte.com.cn>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <ran.ming@zte.com.cn>, <han.chengfei@zte.com.cn>,
 <zhang.yanze@zte.com.cn>
Subject: Re: [PATCH net-next v4 1/2] net/ethernet: add ZTE network driver
 support
Message-ID: <20260526174110.51876645@kernel.org>
In-Reply-To: <20260523174117467bbQo_yaI9XS_2nfd7pO6u@zte.com.cn>
References: <20260523174117467bbQo_yaI9XS_2nfd7pO6u@zte.com.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292014-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,zte.com.cn:email]
X-Rspamd-Queue-Id: 4DD265DE001
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 23 May 2026 17:41:17 +0800 (CST) han.junyang@zte.com.cn wrote:
> Add basic framework for ZTE DingHai ethernet PF driver, including
> Kconfig/Makefile build support and PCIe device probe/remove skeleton.


sparse (make C=1) says:

drivers/net/ethernet/zte/dinghai/en_pf.c:405:43: warning: incorrect type in argument 2 (different address spaces)
drivers/net/ethernet/zte/dinghai/en_pf.c:405:43:    expected void [noderef] __iomem *
drivers/net/ethernet/zte/dinghai/en_pf.c:405:43:    got void *priv

please fix, and when you repost make sure that the posting is threaded
correctly (patches are in-reply-to the cover letter). Please use 
git send-email or b4 if possible.
-- 
pw-bot: cr


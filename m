Return-Path: <netdev+bounces-275826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOEaJ0Bn1GnptgcAu9opvQ
	(envelope-from <netdev+bounces-275826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:09:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A35AB3A8E00
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ADFCC300602F
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 02:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897E626FA6F;
	Tue,  7 Apr 2026 02:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCwtf8bs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D41EED8;
	Tue,  7 Apr 2026 02:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775527737; cv=none; b=ouYvg5DC7ie4C4asegOWm6nFi+PlqpHrQEAOuSpLFA1BrtQluZm8tDTxXlG+UGPJQqF7EDcNzUNKHlmH5tqP9p1+ti2ewBoHzun1CiMnJFjqzS/xE+7ayV77D5cTA+zNOLK4rMtGwjOGE2+O30clAb8R/u0RDc4oRjknedf81hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775527737; c=relaxed/simple;
	bh=He/fqeGcwQSmgNiVZyJYEsyIDIMjQPKTbSWJEV+kcCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3lKmnncjBlf1V/krjrZEAnkPSenrw7cklK9IuWfIIVdxw4Cj12XicSlQik1b7dJ01exNSG0PZ7P2k0xR+v8kSizaukLI7G12xlz/+OJwJOVOqO5+PuOjyufjDl2clCNyc2zcxSKzgQs/xlMyMndzmMwzTunhUOXtJXj6z8+FeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCwtf8bs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73830C4CEF7;
	Tue,  7 Apr 2026 02:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775527737;
	bh=He/fqeGcwQSmgNiVZyJYEsyIDIMjQPKTbSWJEV+kcCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SCwtf8bsMl12ktsPj3oFIc41TE+oL3ZUtJTlC97i90HEZdaH8X31PgsavVyH3kh6k
	 CCCqFJ/2XHGourzmLkiJRmAfLRskkbx//u9zDnspLyUJJWy70eweGSOZkVwIYbqLGf
	 ygxoAxXlUTUgO93D+H9m/4LbLJkeShPK28qPppBGLoNDwCd2oK/GZDkb7X47QZaZHk
	 8Aq/Ph9PlCkVvCXuCAvJb4hbQNA2U701K8T7huPQWgxAkBNufohNjw58v29o2tFMGt
	 aeImjBNE+hCaCnqJ7xKFrunMecQIm/I3xxrR4QLVV0FPhPVsKGkNO+b+3jvojxvhFh
	 SWhw+PJl2n2UA==
Date: Mon, 6 Apr 2026 19:08:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Jitendra Vegiraju" <jitendra.vegiraju@broadcom.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com,
 richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, rmk+kernel@armlinux.org.uk,
 rohan.g.thomas@altera.com, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me, me@ziyao.cc,
 siyanteng@cqsoftware.com.cn, prabhakar.mahadev-lad.rj@bp.renesas.com,
 weishangjuan@eswincomputing.com, wens@kernel.org, vladimir.oltean@nxp.com,
 lizhi2@eswincomputing.com, boon.khai.ng@altera.com,
 maxime.chevallier@bootlin.com, chenchuangyu@xiaomi.com,
 yangtiezhu@loongson.cn, ovidiu.panait.rb@renesas.com,
 chenhuacai@kernel.org, florian.fainelli@broadcom.com,
 quic_abchauha@quicinc.com
Subject: Re: [PATCH net-next v9 4/4] net: stmmac: Add BCM8958x driver to
 build system
Message-ID: <20260406190854.13596789@kernel.org>
In-Reply-To: <20260402213629.1996133-5-jitendra.vegiraju@broadcom.com>
References: <20260402213629.1996133-1-jitendra.vegiraju@broadcom.com>
	<20260402213629.1996133-5-jitendra.vegiraju@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275826-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,foss.st.com,davemloft.net,google.com,redhat.com,gmail.com,broadcom.com,kernel.org,iogearbox.net,armlinux.org.uk,altera.com,st-md-mailman.stormreply.com,lists.infradead.org,lunn.ch,fomichev.me,ziyao.cc,cqsoftware.com.cn,bp.renesas.com,eswincomputing.com,nxp.com,bootlin.com,xiaomi.com,loongson.cn,renesas.com,quicinc.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A35AB3A8E00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu,  2 Apr 2026 14:36:29 -0700 Jitendra Vegiraju wrote:
> +BROADCOM BCM8958X ETHERNET DRIVER
> +M:	Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> +R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>

Should be:

L:	<bcm-kernel-feedback-list@broadcom.com>

It's not a parson.
Before you ask - FWIW what other subsystems allow in MAINTAINERS
is irrelevant.

> +L:	netdev@vger.kernel.org


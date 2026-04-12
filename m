Return-Path: <netdev+bounces-277845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EP1kGkrO22noGwkAu9opvQ
	(envelope-from <netdev+bounces-277845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:54:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6B33E4F10
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB97E301048F
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5012DC792;
	Sun, 12 Apr 2026 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+lT/ZRL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B1F150997;
	Sun, 12 Apr 2026 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776012784; cv=none; b=mYcol6bAaUUoOp1PmQ9vqeEw81o0bZasgi+4bnh2ZkfKm/Pakux588nymHSNB4r8KRclI/glNN01m9d3uJSxiHO7ESUh7i92YjMJEemeHgECKHmWvsEOlpgMOdnrXRwK0OUly77+NzOha6LkQwJl3YKjYYggVZNM1tPdNDgtlPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776012784; c=relaxed/simple;
	bh=g5poCvQcWA/xbkpNMF1O1j2MyXDRI+9MIN54+M9oWpc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QlNvzBvE2aYdj4wjso9yCAe1WaaOOyNWpK/rKoVJcs5eTqGmqpfGtcv1xk9tvJTvWaKYMV8vUcWC3vRIC5KQCVP0PhV32MlLyRNCbHAq2E6AJgfvWxyt3XeY/UnRia4i4+GlvMkNkBovLNaixnm4Zr+si9CqJ+23sz9CMLEoK0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+lT/ZRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32D1C19424;
	Sun, 12 Apr 2026 16:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776012784;
	bh=g5poCvQcWA/xbkpNMF1O1j2MyXDRI+9MIN54+M9oWpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P+lT/ZRL7FLKTG/gOLIjYcotU2QOfltOQ0inwPC9VbLQ/1zLQt+1IRB6wLHaMzZL4
	 48DpP2AIud3qlMgPu/8lcnKERUeEelj+pU1I2cA+NYEPiTphXEWxw77ote8JOLZisS
	 WF97g96fb6mkJUo2Ewd4hAaAicQbPP78mcvm9SiXcx2ARuj72WkqikDibRo/CeP/Df
	 gapbNyMvb/Z4WNPi/YvJJtHUj1QZtCEPjtskwTg5Bsfe0fIvCTefSOub+aHfYrlShq
	 oDlLcIovcgRF2adsTx/3jMxXGBYe2dqxjsXh4Hf50p/V8OUq8v22IlXsnQ+opptd0q
	 aUAh19GyuRfxg==
Date: Sun, 12 Apr 2026 09:53:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Wen Gu <guwen@linux.alibaba.com>, tglx@kernel.org,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, jstultz@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, daniel.lezcano@kernel.org, sboyd@kernel.org,
 vladimir.oltean@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
 jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev, yangbo.lu@nxp.com,
 svens@linux.ibm.com, nick.shi@broadcom.com, ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 linux-fpga@vger.kernel.org, imx@lists.linux.dev,
 linux-s390@vger.kernel.org, dust.li@linux.alibaba.com,
 xuanzhuo@linux.alibaba.com, mani@kernel.org, imran.shaik@oss.qualcomm.com,
 taniya.das@oss.qualcomm.com
Subject: Re: [PATCH v2 2/2] MAINTAINERS: update PTP maintainer entries after
 directory split
Message-ID: <20260412095301.4fe1fe65@kernel.org>
In-Reply-To: <4B889ED5-D1F6-401D-B753-89AE2037F316@infradead.org>
References: <20260407104802.34429-1-guwen@linux.alibaba.com>
	<20260407104802.34429-3-guwen@linux.alibaba.com>
	<20260412084704.743482ad@kernel.org>
	<4B889ED5-D1F6-401D-B753-89AE2037F316@infradead.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277845-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,linutronix.de,nxp.com,linux.dev,linux.ibm.com,broadcom.com,lists.linux.dev,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,infradead.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: DD6B33E4F10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 12 Apr 2026 17:32:22 +0100 David Woodhouse wrote:
> On 12 April 2026 16:47:04 BST, Jakub Kicinski <kuba@kernel.org> wrote:
> >On Tue,  7 Apr 2026 18:48:02 +0800 Wen Gu wrote:  
> >> +PTP EMULATED CLOCK SUPPORT
> >> +M:	David Woodhouse <dwmw2@infradead.org>
> >> +M:	Wen Gu <guwen@linux.alibaba.com>
> >> +M:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >> +L:	linux-kernel@vger.kernel.org
> >> +S:	Maintained
> >> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core  
> >
> >Hi David,
> >
> >Do you have a tree to route the patches thru? Or do you really have
> >access to the tip tree?  
> 
> I do not have access to the tip tree. I can make a shared tree on
> git.infradead.org if the other two maintainers would like to send me
> a SSH pubkey and preferred username...

Honestly I'd love for you to be the only M here, and the other two 
to be reviewers. Xuan Zhuo is currently at v40 trying to upstream 
an Ethernet driver. Some growth needed there to become a subsystem
maintainer IMO.


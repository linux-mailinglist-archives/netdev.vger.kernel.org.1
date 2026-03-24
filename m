Return-Path: <netdev+bounces-270850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PAqMnH1wWmmYQQAu9opvQ
	(envelope-from <netdev+bounces-270850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 03:22:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3243011D8
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 03:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9656303AF02
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 02:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D457138552C;
	Tue, 24 Mar 2026 02:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APvBhOZx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1D1386C14;
	Tue, 24 Mar 2026 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774318955; cv=none; b=N4PMpi8ayckPYtqRHWIV3vDTKDocnxQuPUldE2atNa4NbI4N/q73AX2zToK8Q78ETt7oOD18ILWzIgkQpVW0N9xu6qrD2m12fOSL1ZinlprF/7DKZ/G2KtR/r7qwlhPRy9prG8mJ6LmlpoPifYoASVddcJltDUg2oWBPjTwgcJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774318955; c=relaxed/simple;
	bh=dhcqtiZ1+Z6bHtcY+FeNQglwKzvJjFxeELs9lZgVjGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmct4wgYGgyXwWar+Lxji5E8AzHyDcMKBSJUkweZA0DBfeQ1K/fWjjltBfG7SPTWgz3SRDuBNGxntzhjT3bUvyN6CdXIDiKrabP56Fn734Af4PbBxZ1ARVBlHwGMkr804TI5PAWte9qJoo9F8CpmFTyzxUU39981YuCG8Wm+tV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APvBhOZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB29C4CEF7;
	Tue, 24 Mar 2026 02:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774318954;
	bh=dhcqtiZ1+Z6bHtcY+FeNQglwKzvJjFxeELs9lZgVjGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=APvBhOZxUUobsb7TolEGT+eOmL04buwmjJTsphGqTs5unlMLCcuwIOAXd5krZuHXm
	 ZO62XznK5PKfUVE45KEi5wz+fSvDzAxl3mVlqzDivqctOCmpwWoaiJF8TFNVkCJnxY
	 QFN5jaDM41njuipFNhcSIgGX5bSHvT4bNSLtir8ac0Ikfk/S/jc57seC3NGB24xjip
	 Uri0WFgavXckiig/FvWvrj6SqAOiD12F/Mvs/Pfl7XWQHjGshBRBCIpdzgWZo/Ox2L
	 KiY1INBId7N6erlT0pP3f6zyGQA37ntmmQf9wDbVvvuTwIKKJA0lQCI2VEaqsNSLjJ
	 ul2h3c0FRoW9g==
Date: Mon, 23 Mar 2026 19:22:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: tglx@kernel.org, tglx@linutronix.de, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 jstultz@google.com, anna-maria@linutronix.de, frederic@kernel.org,
 daniel.lezcano@kernel.org, sboyd@kernel.org, vladimir.oltean@nxp.com,
 wei.fang@nxp.com, xiaoning.wang@nxp.com, jonathan.lemon@gmail.com,
 vadim.fedorenko@linux.dev, yangbo.lu@nxp.com, svens@linux.ibm.com,
 dwmw2@infradead.org, nick.shi@broadcom.com, ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 linux-fpga@vger.kernel.org, imx@lists.linux.dev,
 linux-s390@vger.kernel.org, dust.li@linux.alibaba.com,
 xuanzhuo@linux.alibaba.com, mani@kernel.org, imran.shaik@oss.qualcomm.com,
 taniya.das@oss.qualcomm.com
Subject: Re: [PATCH 2/2] MAINTAINERS: update PTP maintainer entries after
 directory split
Message-ID: <20260323192232.3a5205dc@kernel.org>
In-Reply-To: <20260318073330.115808-3-guwen@linux.alibaba.com>
References: <20260318073330.115808-1-guwen@linux.alibaba.com>
	<20260318073330.115808-3-guwen@linux.alibaba.com>
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
	TAGGED_FROM(0.00)[bounces-270850-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linutronix.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,nxp.com,linux.dev,linux.ibm.com,infradead.org,broadcom.com,lists.linux.dev,linux.alibaba.com,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[35];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C3243011D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 18 Mar 2026 15:33:30 +0800 Wen Gu wrote:
> +PTP EMULATED CLOCK SUPPORT
> +M:	Wen Gu <guwen@linux.alibaba.com>
> +M:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained

I thought David W was supposed to be the main maintainer?
Two moderately known developers from a single vendor/company
is not enough to delegate this IMO.


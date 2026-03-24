Return-Path: <netdev+bounces-270849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHSvHgv1wWmmYQQAu9opvQ
	(envelope-from <netdev+bounces-270849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 03:20:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2611A301199
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 03:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 103F630A5825
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 02:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED23138643B;
	Tue, 24 Mar 2026 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOfueOYY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FA8385526;
	Tue, 24 Mar 2026 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774318607; cv=none; b=IPzenRylaWPUVaoy2xHZcyo8FIIkm+vWEJm6dtyaoKtXdGbKQxZnlmvHUWHOmybUDvfWB69Oj36Bv8zkyCK0pJC8XiMXuYlDjLKJAigWwvW6/s56W9yTxv8BfTiASHEF5T1SO4YPmm6seIRhIaqBpTByEN9f2hjVcQ+hwey5088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774318607; c=relaxed/simple;
	bh=yYsQflZATy05bGBsphe7H+1eD4A09u2Qeu0WqdFMi7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0zohD25y0lyKOro510W7JETJmfK+Uc3dE7D4Nn8a29Dv7ZHiGXjdOYidm2Ht4CO/ZgKYF49rLZhuc4TZ6YHIoSz2dBhymz04DLEU7BjzeMZTfILT9JojJ9fdW1AUXyZMz+FnpvhQa3EYbrM1hckaER7poI6z6Hg/I8sNNvaUqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOfueOYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDED4C4CEF7;
	Tue, 24 Mar 2026 02:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774318607;
	bh=yYsQflZATy05bGBsphe7H+1eD4A09u2Qeu0WqdFMi7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cOfueOYYK/9KslsmHqB7N5xHU7BYrHrZfBUcDdVJ4b9n2vdjCilU2icnACBJDz+Qk
	 AZAe5p9YjCJ29egUguPsPBzltBhQ4T7BW8Dhi0LolqPvFo8rd94zKWRzh70hpX33KF
	 MgmA1JKKjcq77zGZGtjncFl8Isov+CrCzFv/Em3cTT+bAoP/DMmhKQ8cXA/X5FGPzB
	 5orVMA0NKmbGDWK/gybckHwVL+0ct09FQ2O0H/wU0mPNK1OW6QQEWCA3Qe3uLB7Ghh
	 +My4Z4Zd3veJkjkSOyBY9SmyLI2Zt5H9miPc3tKENDecpwlZx4V7IWecggngmuykVp
	 2cUmsnLw9rGhw==
Date: Mon, 23 Mar 2026 19:16:45 -0700
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
Subject: Re: [PATCH 1/2] ptp: split clock drivers into two subdirectories
Message-ID: <20260323191645.46569808@kernel.org>
In-Reply-To: <20260318073330.115808-2-guwen@linux.alibaba.com>
References: <20260318073330.115808-1-guwen@linux.alibaba.com>
	<20260318073330.115808-2-guwen@linux.alibaba.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270849-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2611A301199
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 18 Mar 2026 15:33:29 +0800 Wen Gu wrote:
>  drivers/ptp/emulated/Kconfig                 |  61 +++++
>  drivers/ptp/emulated/Makefile                |  11 +
>  drivers/ptp/{ => emulated}/ptp_kvm_arm.c     |   0
>  drivers/ptp/{ => emulated}/ptp_kvm_common.c  |   0
>  drivers/ptp/{ => emulated}/ptp_kvm_x86.c     |   0
>  drivers/ptp/{ => emulated}/ptp_s390.c        |   0
>  drivers/ptp/{ => emulated}/ptp_vmclock.c     |   0
>  drivers/ptp/{ => emulated}/ptp_vmw.c         |   0
>  drivers/ptp/ieee1588/Kconfig                 | 179 +++++++++++++
>  drivers/ptp/ieee1588/Makefile                |  16 ++
>  drivers/ptp/{ => ieee1588}/ptp_clockmatrix.c |   0
>  drivers/ptp/{ => ieee1588}/ptp_clockmatrix.h |   0
>  drivers/ptp/{ => ieee1588}/ptp_dfl_tod.c     |   0
>  drivers/ptp/{ => ieee1588}/ptp_dte.c         |   0
>  drivers/ptp/{ => ieee1588}/ptp_fc3.c         |   0
>  drivers/ptp/{ => ieee1588}/ptp_fc3.h         |   0
>  drivers/ptp/{ => ieee1588}/ptp_idt82p33.c    |   0
>  drivers/ptp/{ => ieee1588}/ptp_idt82p33.h    |   0
>  drivers/ptp/{ => ieee1588}/ptp_ines.c        |   0
>  drivers/ptp/{ => ieee1588}/ptp_mock.c        |   0
>  drivers/ptp/{ => ieee1588}/ptp_netc.c        |   0
>  drivers/ptp/{ => ieee1588}/ptp_ocp.c         |   0
>  drivers/ptp/{ => ieee1588}/ptp_pch.c         |   0
>  drivers/ptp/{ => ieee1588}/ptp_qoriq.c       |   0
>  26 files changed, 296 insertions(+), 253 deletions(-)

emulated sounds good but the ieee1588 doesn't sit well with me.
IEEE1588 doesn't describe tickers and external signals.
Let's leave them in the main directory? Or call it hw even if 
it's not 100% accurate? In MAINTAINERS you can exclude subdir
with X:


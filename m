Return-Path: <netdev+bounces-285369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKHuOE+q/GkNSgAAu9opvQ
	(envelope-from <netdev+bounces-285369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:05:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 478DA4EAC66
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF2F0301BC21
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799DC43CEC1;
	Thu,  7 May 2026 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0n3VZCr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7328336074D;
	Thu,  7 May 2026 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778166129; cv=none; b=QmovFYPjmgGuL8NCKi4wRbKOJXh3G/EhjZ+b+e2aHin74qGswYmSydK486qRK9rhe35sLjvzJ4pokpYpIHPCVMz/+xVZhx7eiYzFZwqk4JKOhpuHgfqiQr2sDfdLKhMJcwT2W9emosjP+Rpn2ZtggLic3giT5XtYUJRtTuGcgIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778166129; c=relaxed/simple;
	bh=Tz3+n40bgUG+RR2d/vMtyETTE33zvfbgEfdQx8bGd2o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uxgW08S+rcPCQMEYuPTgzLYH+F5ryqQKZXpkAbUOmoL5YzxIfOi5om/8QyI+eRnFK72eiccRO9mi9ib8i63HTMhwZSYPCh9xjAREiOxO3UqfKmPHq/aZyjwX11+oxNewOCWqSb1+o5FFfnq0lGVesORfRe4sMqiZHfyz2dNJP6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0n3VZCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26920C2BCB2;
	Thu,  7 May 2026 15:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778166128;
	bh=Tz3+n40bgUG+RR2d/vMtyETTE33zvfbgEfdQx8bGd2o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=r0n3VZCr9h7LVE3CaM4E2eKku8mvjhkCIj9BLBf98qKaBjQbrdPyH1hTJKT3JnBDk
	 CGNOTnoCc0W4LrRvTtYcLzmzN1DZd4E4uIR/t4pt8k3jX8WwumDYe5Kmvnp2HFSWqq
	 EFHuIZ75KfQR5k805akEoQSV20Q3ey7i4j7TOUjpOcHSz59WD8+X4MywERGvyrdnai
	 /I869y+pM5nkMN9e5RZn0uzHscXFdS0JZXGiL7r2eqLCG4eznwTcJfZ2n13atqnAja
	 OmoUueahJdw+QNWsFjontQ8HZG32ZBiCwBG2GbTgFmdvJoEmXOA5ZjQjUM4/BCaH2C
	 qsN/VfWIkQk6g==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
 Min Li <min.li.xe@renesas.com>, Matthew Bystrin <dev.mbstr@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20260429072047.1111427-1-dev.mbstr@gmail.com>
References: <20260429072047.1111427-1-dev.mbstr@gmail.com>
Subject: Re: [PATCH v2 0/2] mfd: rsmu: fixes and new IC support
Message-Id: <177816612689.1928138.2810599453250571292.b4-ty@b4>
Date: Thu, 07 May 2026 16:02:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c
X-Rspamd-Queue-Id: 478DA4EAC66
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,renesas.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285369-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 29 Apr 2026 10:20:45 +0300, Matthew Bystrin wrote:
> First patch fixes Renesas 8A34002 SPI driver.
> 
> In my setup 8A34002 is connected to VisionFive2 (via SPI or I2C). I've
> discovered that upstream driver does not work:
> 
> [    4.728771] 8a3400x-phc 8a3400x-phc.0.auto: 4.8.7, Id: 0x4002  HW Rev: 5  OTP Config Select: 0
> [    4.737389] 8a3400x-phc 8a3400x-phc.0.auto: requesting firmware 'idtcm.bin'
> [    4.744462] 8a3400x-phc 8a3400x-phc.0.auto: Direct firmware load for idtcm.bin failed with error -2
> [    4.753547] 8a3400x-phc 8a3400x-phc.0.auto: Failed at line 1273 in idtcm_load_firmware!
> [    4.761576] 8a3400x-phc 8a3400x-phc.0.auto: loading firmware failed with -2
> [    4.769411] 8a3400x-phc 8a3400x-phc.0.auto: No wait state: DPLL_SYS_STATE 0
> [    4.776374] 8a3400x-phc 8a3400x-phc.0.auto: Continuing while SYS APLL/DPLL is not locked
> [    4.785206] 8a3400x-phc 8a3400x-phc.0.auto: Unsupported MANUAL_REFERENCE: 0x00
> [    4.796930] 8a3400x-phc 8a3400x-phc.0.auto: PLL2 registered as ptp0
> 
> [...]

Applied, thanks!

[1/2] mfd: rsmu: fix page register setup
      commit: d65ff90be2c1a09e9e477e6f7493fae21b31e59c
[2/2] mfd: rsmu: add 8a34002 support
      commit: c8e94555a15fbe0925a9cc424118ca10e3b5531a

--
Lee Jones [李琼斯]



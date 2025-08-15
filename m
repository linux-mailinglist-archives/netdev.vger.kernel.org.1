Return-Path: <netdev+bounces-213993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B22AB279FF
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 09:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089363A2FC5
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 07:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC7D1B960;
	Fri, 15 Aug 2025 07:21:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120A9219EB
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755242487; cv=none; b=TS6qDh7O58sOp3STbbIHr2STdbf96n8cnyN/fy+kVIxJktYnnneUzQ4Lfm7iXfCTBdLD4nvzqj/BuVZLioiUNhalZEQ69XXKqOmUyax285511UfOLPtlfLr2JTP2Ax6rGMkZMFo+WMGlMTCldzTnk+10uEDecIWTL8pqoYtm7iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755242487; c=relaxed/simple;
	bh=Zr9P2ndnhX3SK5UWWH9OdT0pfil/s2pLoN+1J1CRKnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdJ2sRjFrpNzLQnAbSut84x0I1myJDR/w2sxaYSqtXmt0BtqZZLrwGX7cID07tpBC4yGYM8GyNsQwYmRf6SGHD9WUplAT/saqQ7uDDSy2yGjbmh+/MEZrNGKhaEn9CNDyYVVt1++8pgwTmIvdyuyQgVRM5wU6FCgDiXDTGsDB6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz13t1755242466td134eb93
X-QQ-Originating-IP: P8B29TxqAIjtw9rcUWdGPOj/UlpMvPoKRSUDmw0C7LM=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Aug 2025 15:21:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5156444352730471506
Date: Fri, 15 Aug 2025 15:21:03 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] net: rnpgbe: Add n500/n210 chip support
Message-ID: <67844B7C9238FBFB+20250815072103.GC1148411@nic-Precision-5820-Tower>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-3-dong100@mucse.com>
 <a0553f1d-46dd-470c-aabf-163442449e19@lunn.ch>
 <F74E98A5E4BF5DA4+20250815023836.GB1137415@nic-Precision-5820-Tower>
 <63af9ff7-0008-4795-a78b-9bed84d75ae0@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63af9ff7-0008-4795-a78b-9bed84d75ae0@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MZz3ry4sOE6i+RyLH0s8dViJIFOg2SSDGEJlmPPuVgZPDjBNjSFXzU0j
	+amaPDvGg22Em+KYXXbljXRZUVpS6pv8PSqO3BhzX9XY6PIN1qx9xxfd4RIj7O0F6s8tGwP
	YGvU1/uOvAHIkL5JD2vbtr81H0aZe/BWf93jU8YXeVoSL2N4TcoUxWfpNJgN+5p2SIREI+I
	8EEYj/QSuyL9mPFOJAzJ4sNUbJbLIX5NewYMFkaGnlwNxkLWct0oTVGYxVvcZ4TQCeXVjQ2
	eFWf/0kHFRjkbAeN1xCh1FAWaTCMSAI7TMifuUUHZbPtJMPlaHeMC5dgGrg5MPFsWfCZLfi
	Kuaoj9QPBus3Dn+EMjxeTURvTjIIqK2moEBsA7mul2i4krJuALk3BvS2/I0Rgrfd5II+QxW
	SDzGwIylGT3Obebj0cFPC19XsKI3r6JL1NQhntYE5ButQHGiHWLSumbhFdzYOZ4WdcBaM7/
	WKdEc7PufwMEsUSJMTuZv/anM6QN7tD5tg7KKCweWYGdIE6usM8JPe8PCxYQKnl7GlwOGhC
	7WDt+QKMRhg5nKut/PvqYYJtyygPbdzZ73VMQbVqWagm4Ijd6XlhFYvSnYWF/6urxYwMQsC
	ZtBfGrfnqKz95ud+sShLLNv+w7tyUQCswM4VQcX77N9h2u80Qdesmdnzzh13G3AybIBKspZ
	EfMi5KIKqrS2I0z29d+Lhl8ZExUdoUQv3aYfOsgsyOv3da4vI+y5VUfXV0lcSNwT/QEUc/T
	a1redvdPSkjDxT1eYWqdGlwGsAfdA9GAaV0ML4swEueguXXtU/byP31K92ys4vRUNB69Lk7
	HqkMy34YfnL+PgmrjnMcwHcvFRfDEh0dShiCkPD4YOJaItiy+/dcxrx/mGj8TArk/D51l7T
	68rFwhE8mANCdZt15xnAm9rO6E9+wwc2SYkziB6NCqOdGvjj1cUghA3Yz08JecajxbLTL2J
	lb9CJIQQHA1Nj9bFrM5rZqZFk2DmHKGx0hvJStVBRg5ssHhRCsbsVEpNdzHaWGXB2uEmAqj
	wyqbHgbGnirXBp46e8t3Iyg5wzQ7aGKO4bsWO7aknhCWBNC2/04/ayP7NPS+FgZjzTorV8p
	Mi6aA9tDAsk+iGWNaDXuAY=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Fri, Aug 15, 2025 at 05:56:30AM +0200, Andrew Lunn wrote:
> > It means driver version 0.2.4.16.
> 
> And what does that mean?
> 
> > I used it in 'mucse_mbx_ifinsmod'(patch4, I will move this to that patch),
> > to echo 'driver version' to FW. FW reply different command for different driver.
> 
> There only is one driver. This driver.
> 
> This all sounds backwards around. Normally the driver asks the
> firmware what version it is. From that, it knows what operations the
> firmware supports, and hence what it can offer to user space.
> 
> So what is your long terms plan? How do you keep backwards
> compatibility between the driver and the firmware?
> 
> 	Andrew
> 

To the driver, it is the only driver. It get the fw version and do
interactive with fw, this is ok.
But to the fw, I think it is not interactive with only 'this driver'?
Chips has been provided to various customers with different driver
version......

More specific, our FW can report link state with 2 version:
a: without pause status (to driver < 0.2.1.0)
b: with pause status (driver >= 0.2.1.0)

Then the driver update the status to reg to confirm info to fw.
fw check reg status to decide whether report state again or not.

'Driver < 0.2.1.0' only support 'version a', it will not update
pause status to reg. Then, fw will report status again, again...

So, I add 'echo driver version to fw in driver 0.2.1.0' to solve
this condition. fw consider it an old driver if driver not 'echo
version to it'.

1. Old driver with old fw, it works fine.
2. Old driver with new fw, fw knows the driver is old, it works fine with
version a.
3. New driver with new fw, fw knows the driver is new, it works fine with
version b.
4. New driver with old fw, fw echo state without pause, and it never check
it in reg, it also works fine.

And I think it is a way to make compatibility more easy. Driver know fw
version, and fw also know driver version. Fw can easy edit existing cmd,
not only add new ones since it can support old cmd for old driver,
'edited cmd' to new driver.

Also, hw->driver_version is not useful to driver. I can use a macro in
mucse_mbx_ifinsmod.

Thanks for your feedback.



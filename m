Return-Path: <netdev+bounces-170449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7E5A48C71
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 00:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1336188D894
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 23:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B116A23E333;
	Thu, 27 Feb 2025 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beachtrans.com header.i=@beachtrans.com header.b="iZHG7aPm"
X-Original-To: netdev@vger.kernel.org
Received: from s.wfbtzhsb.outbound-mail.sendgrid.net (s.wfbtzhsb.outbound-mail.sendgrid.net [159.183.224.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E98622576A
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 23:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.183.224.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697861; cv=none; b=mpdhF5mSmuvipG9rTfdCG66TW3PN+QnIYTeDYJq8OxjX7x0FZjyOxuZxxfZJwDHkjNbvR1V/dTfDXY0AT+3pS3d7YZ3JvHIUi8SEPeHvSd8R2kSRo+rVK6kCEdh2PuxLGGrFbb26vZXM63VrooTHre4epJvrL30GOxdVk6b+zTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697861; c=relaxed/simple;
	bh=7cfikuYTKVCiqGcVYPtidbuhSLlsNkzHnX2+hkv1fwg=;
	h=Content-Type:From:Subject:Message-ID:Date:MIME-Version:To; b=FI29OybF80ecr5xtSswfZJ6cVXlP354QeFZnbRn58MA4jqFBGarxhD5wmLiCbf+IigmjVDNkVfYQ1BggkxE1W1g131CYXEO7F7j+1HwTPBygLkrJEVm1ky3HdBC98xfCFLLevjThy3n8QPe2oWjBUEQ4ggB4aRhYvG0jpONUXFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=beachtrans.com; spf=pass smtp.mailfrom=em3945.beachtrans.com; dkim=pass (2048-bit key) header.d=beachtrans.com header.i=@beachtrans.com header.b=iZHG7aPm; arc=none smtp.client-ip=159.183.224.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=beachtrans.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em3945.beachtrans.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beachtrans.com;
	h=content-type:from:subject:content-transfer-encoding:mime-version:
	reply-to:to:cc:content-type:from:subject:to;
	s=s1; bh=7cfikuYTKVCiqGcVYPtidbuhSLlsNkzHnX2+hkv1fwg=;
	b=iZHG7aPmMG3rezfLjx/0rLAw7DaNZS1dnIlVSIPLCiNcA2c0JoXhTL3C2gYbe0NSqeew
	MtqjRaPLUdAZ23plnif5XSR1HMlevCPfM7MzZhFQha4qGLR8goKCu+5/fA2Ovf3C0jsUAy
	D0Kd5mOz+PIpEV81RHSsFfeT0wAvXdI8RrAOsH0z3JeYf6vq79iJDBHlzC5MRCzevKLFGN
	CYgwjVbVaYfvgvaeyM+MijqlG5RRGBwQq5k9L8sY0FkNvKJ6X0uNYrpWB5hcrtqUtbdMyL
	hiS0SXYX48B2JXKLz4TlpjFLe2PPUatRt5v/Vgqc5WZTyAxPYc8mw59OtHaIPXNg==
Received: by recvd-5f5cf94c86-4vzs8 with SMTP id recvd-5f5cf94c86-4vzs8-1-67C0F100-1A
	2025-02-27 23:10:56.314646002 +0000 UTC m=+9078454.221566325
Received: from [127.0.0.1] (unknown)
	by geopod-ismtpd-10 (SG) with ESMTP
	id 0s0LpndqQoC1Jxy6ybtQCg
	for <netdev@vger.kernel.org>;
	Thu, 27 Feb 2025 23:10:56.097 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
From: Trina Norman <beachtrans@beachtrans.com>
Subject: -CPA for 2024 Tax Preparation
Message-ID: <67b6a87e-2925-0531-fd45-d63469c87e1d@beachtrans.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Feb 2025 23:10:56 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: trinanorman@quantumsynergysolutiongroupz.com
X-SG-EID: 
 =?us-ascii?Q?u001=2E8XscFR3rpduFdB27tRfUKavLwUZvMEoVMTYMOG1kmEWri5i8WUgQe5XT+?=
 =?us-ascii?Q?U5vVhE1+l1hKM6Om5j=2F6EGG24sDLPRVQHgmow1P?=
 =?us-ascii?Q?tiponuYEEUxptpdKBAoxuN=2F8rJHwEOd3+fovjA9?=
 =?us-ascii?Q?LP3J6IekjHhrg2U7ap5UAWlTEOH42D8ByEkr3oY?=
 =?us-ascii?Q?bgBro38NVVZ8revJsjfCrJKID9Kec+z2oQhTpWw?=
 =?us-ascii?Q?Rpwy76jSA=2FdhyZJTUpzS6zG69LUb8sDQRhEjUa6?= =?us-ascii?Q?l5wX?=
To: netdev@vger.kernel.org
X-Entity-ID: u001.R7thWtYRDgf6qc1FvLYI4g==

Hi,

I hope you=E2=80=99re doing well. My name is Trina Norman, and I work as an=
 Archaeologist with the U.S. Department of the Interior. Due to the nature =
of my job, which involves frequent travel, I=E2=80=99m seeking a CPA to ass=
ist with my 2024 tax preparation.

I=E2=80=99d appreciate the opportunity to schedule a call or Zoom meeting t=
o learn more about your services, discuss your fees, and go over any releva=
nt details. Please let me know your availability at your convenience.

Thank you for your time and consideration. I look forward to your response.

Best regards,
Trina Norman


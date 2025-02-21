Return-Path: <netdev+bounces-168593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8516DA3F708
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 15:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2CB424F45
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 14:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF161D5177;
	Fri, 21 Feb 2025 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seytrax.com header.i=@seytrax.com header.b="oVWEke8X"
X-Original-To: netdev@vger.kernel.org
Received: from s.wfbtzhsq.outbound-mail.sendgrid.net (s.wfbtzhsq.outbound-mail.sendgrid.net [159.183.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F4A2D05E
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.183.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740147547; cv=none; b=KP1Wz5BF3wj+3TvWTMTlaLoV6k6kRsvZ3q/QjXIi3ESVtf5mwhmJfZ/iIP9QCv5uAK+BY3AZeKcxyJ/3I2/j50O6u75MOAudWCRHxp/gOugKfYGJz00HHDPy4YgJwVQdZF4AaxuwfU+X6yh5tS1VYRTf5irZ8HOp/+Oh+7nHypQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740147547; c=relaxed/simple;
	bh=vo5OGOU/tQLy0Bo0Gst7hQMZLCB0zEw0P/i7va1o6AY=;
	h=Content-Type:From:Subject:Message-ID:Date:MIME-Version:To; b=GtFECA9zchSOHeP+0GPpiQilMosEH6pjIP2XYPGDd3/1cqUMf8FojPrE/wqbqFV0tIucHnN3s5SVioy2LDeSW91ft7Ff6KIODyXzHVEA28OpsSv6Avyo1B2Pu2J2Gsmg7rfS7ooMsLOg9G2qvIkm6Qwm0r7FL8PaEiXvRpwAwcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=seytrax.com; spf=pass smtp.mailfrom=em200.seytrax.com; dkim=pass (2048-bit key) header.d=seytrax.com header.i=@seytrax.com header.b=oVWEke8X; arc=none smtp.client-ip=159.183.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=seytrax.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em200.seytrax.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seytrax.com;
	h=content-type:from:subject:content-transfer-encoding:mime-version:
	reply-to:to:cc:content-type:from:subject:to;
	s=s1; bh=vo5OGOU/tQLy0Bo0Gst7hQMZLCB0zEw0P/i7va1o6AY=;
	b=oVWEke8XUf4fPGgjxhv+sVaIgWFTF+0hhJPlMOETu2sTgEY9tAG4iUngqDNv4o7W6nwN
	LHBwHxLxkrF49tHcC2zIkGXW8ad8c5/sIyrIchntyhxDSRdwmBmr/U7xRHnOJrvRQbtqFE
	iGDYCEWoKphKzltcN/FYdQId974JuA96VbVnkaOFAGBWJzHI1Oj1Jbo/ZHLJk/sLfKLxGi
	DX+NGmQEP15e/eTAjj/Q+6WjhmE3t38NFqhwpJ0h+ReRVwRgYBT5Dc9bpZ/dIHD4lwlJm4
	0PpazikVVxXl6f7ruY/Pl/jfjhKrkmz9lAovvVDnroF0sd0CK0eAN2Jy4nolTveA==
Received: by recvd-85768567ff-f4p9l with SMTP id recvd-85768567ff-f4p9l-1-67B88B57-5B
	2025-02-21 14:19:03.776285787 +0000 UTC m=+8528105.131012219
Received: from [127.0.0.1] (unknown)
	by geopod-ismtpd-4 (SG) with ESMTP
	id RtH-fhv1QTmLfiagBvwMEw
	for <netdev@vger.kernel.org>;
	Fri, 21 Feb 2025 14:19:03.684 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
From: Emily <sales@seytrax.com>
Subject: -Preparation Services for 2024 Tax Year
Message-ID: <29a4d9db-1523-55f9-4e90-f8625b26ceab@seytrax.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Feb 2025 14:19:03 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: emily@oceanicvessels774.onmicrosoft.com
X-SG-EID: 
 =?us-ascii?Q?u001=2EPudgTrHKvV+QMoT99zH9wLtzo0b5=2FJpxqrPcLrsRWDRDmu4jfWXa6wGoI?=
 =?us-ascii?Q?N=2FAJ0VSnmFvbeBX9UnHx+RHBVrHG86uYPSFQmzW?=
 =?us-ascii?Q?VfE2prdXKfD6g4plwiYfmEN+xyvJIW=2FMivwvbzD?=
 =?us-ascii?Q?ezT2zyTNK5smOCy0oHKVe6RpFG5KWtUlVqkSR4L?=
 =?us-ascii?Q?5beNvUThrAez5vw5GIgJynfAJQc1Ye+bao=2FLFzI?=
 =?us-ascii?Q?oXaks47MgGq6Xr+qOC3yfA=3D?=
To: netdev@vger.kernel.org
X-Entity-ID: u001.OHwfc4nOvBQp2DzmxLSeww==

Hello,

I hope this message finds you well.


My name is Emily, and I=E2=80=99m interested in working with you on the pre=
paration of my individual taxes for the 2024 tax year. As a new client, I w=
ould greatly appreciate the opportunity to discuss how your services can he=
lp me file my taxes accurately and efficiently.


Could you please let me know if you are currently accepting new clients for=
 the upcoming tax season? I would also appreciate guidance on the necessary=
 documents and next steps for getting started.


Additionally, I can provide a copy of my 2023 tax filing for your reference=
 to ensure a smooth process.


I look forward to hearing from you and the possibility of working together.


Best regards,
Emily


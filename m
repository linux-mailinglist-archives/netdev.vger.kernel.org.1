Return-Path: <netdev+bounces-162173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3CEA25F0A
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 16:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A933A2DEC
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F295209F2A;
	Mon,  3 Feb 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b="RC2Nwstw"
X-Original-To: netdev@vger.kernel.org
Received: from xtrwqkpv.outbound-mail.sendgrid.net (xtrwqkpv.outbound-mail.sendgrid.net [167.89.65.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE7C2080E7
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.65.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738597344; cv=none; b=flH+JUOfqY4ov2rPV8xYyDrqMQSJ3TYD04nsCulDuX1ATj4qOR8Hf3Q+VyawesRFBkKPP8x/PkcdthVMKTI/7p5Ta4SU+RgNq6dPFqsb9DhMhoW8FuxbimQIQJMrpXt/FWeeAABvBiGUP5n55iX6RLHTzvAhhqXm7uZ+BECAJds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738597344; c=relaxed/simple;
	bh=otDkNBvOqkRPd3VC+7NpUQnQkBxWpepfAIA7WoVlV6M=;
	h=From:Subject:Content-Type:Date:Message-Id:To; b=QlfI2WCsMhglwxoKpCCnbOIKNCLQ7hdzGFfOkuKFkcTo6/dl9JZjo+WVuOHNXiSrCq8Lp70EGIsiHua5VRKmFdmsEPzmGx5OZ661/BTw8FzRAc16MsVOvgprh2JYNgO4ZsABGm+7NLnEPQ/DRoavOjHMpwcm/qZ1+dTz1C3xv9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=novitera.com; spf=pass smtp.mailfrom=sendgrid.net; dkim=pass (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b=RC2Nwstw; arc=none smtp.client-ip=167.89.65.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=novitera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sendgrid.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
	h=from:subject:content-type:content-transfer-encoding:reply-to:to:cc:
	content-type:from:subject:to;
	s=smtpapi; bh=52IJgE/0WJKWA1gfIQQLbgP1HE0qCqFA/mov68VNZRU=;
	b=RC2NwstwpfbbGkCLJ0Jz7Fma8yx1zz08S034Qyvgi8M+9xUNsJsgdlv5IUOABnpQtzA6
	eFLPczmMIEjZxPa6Mx1PN2/oGfGWN40XagiVLgO/bLbF9eujZ3G/zmybC6m6FBeIkXP3/T
	eG+jZ3x7QeJurCyfQUJUPiNeEgnutydVY=
Received: by recvd-68b5db6845-5fj58 with SMTP id recvd-68b5db6845-5fj58-1-67A0E3DC-30
	2025-02-03 15:42:20.696336128 +0000 UTC m=+6977972.481107700
Received: from vultr-guest (unknown)
	by geopod-ismtpd-36 (SG) with ESMTP
	id YEU0JVakTrespkQ0ZDzrmw
	for <netdev@vger.kernel.org>;
	Mon, 03 Feb 2025 15:42:20.570 +0000 (UTC)
From: Sonia Anderson <info@novitera.com>
Subject: Inquiry Regarding CPA Services
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Date: Mon, 03 Feb 2025 15:42:20 +0000 (UTC)
Message-Id: <03202025024215537F5B101E-62B1A77D08@novitera.com>
Reply-To: ownernovitera@lycos.com
X-SG-EID: 
 =?us-ascii?Q?u001=2EnQyB9RseKhvfy648RbR7OJN72akifLCzElG4xAjb9k4hKRgLfS92jLSlr?=
 =?us-ascii?Q?q4YihGRNBGx8O1hbzWCzcth1bP7loIjiiE5fMIh?=
 =?us-ascii?Q?1CjnN0D+zKTJsUk3UxAIJ4diwU0wDkqCYiVY9cJ?=
 =?us-ascii?Q?bgjMWyl1wo6mUf=2F6al6K0CNo490NH9ZcnVfVbUP?=
 =?us-ascii?Q?t9cYbCu02+mTlCojohwSph5H+EfcikwSpjElXTK?=
 =?us-ascii?Q?x6xGwzGBVVtEHjgRUqSCp70F4xU9TLsPFXM+I2N?= =?us-ascii?Q?eQ2Z?=
To: netdev@vger.kernel.org
X-Entity-ID: u001.CSU14D88zsBssrA83kd+Gg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Morning,

   I hope this message finds you well. I recently moved to this area 
following my divorce and am in need of assistance with preparing my taxes. 
Since this is my first time filing in this area, I’d appreciate your 
guidance to ensure everything is handled correctly.

Please let me know what information or documents you need from me to get 
started. I’d also love to schedule a time to discuss any details necessary 
to make the process as smooth as possible.

Looking forward to your response.

Best regards,
Sonia Anderson
Director/Producer/Writer
331-7010



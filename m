Return-Path: <netdev+bounces-173189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C42A57C6F
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 18:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9838D3AFEFE
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 17:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B151A9B29;
	Sat,  8 Mar 2025 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buyticketbrasil.com header.i=@buyticketbrasil.com header.b="NEnD5mlR"
X-Original-To: netdev@vger.kernel.org
Received: from s.wfbtzhsc.outbound-mail.sendgrid.net (s.wfbtzhsc.outbound-mail.sendgrid.net [159.183.224.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1122A8C1
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.183.224.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741455576; cv=none; b=N4C519oITZ4sw40MBu1vtgq+xrQk1KEBNhzDC2KeT3kQxCsQVmS0UNPgC5boQ3KZ3NcbJrG+IE8CE3Wg+Ma6QNcUOmdsrMwbg/4EoBC8uXQCa4ZzQF8LLQk5FH0Myq739PUntxImaMRz255KB5WyK7n3fQCWN8gqkdzmj8YVViw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741455576; c=relaxed/simple;
	bh=WoYD4nL1WHLCYRPaDYJmP4aFMOqgo2tn7x8Z82UQxiE=;
	h=Content-Type:From:Subject:Message-ID:Date:MIME-Version:To; b=d0gMv1ahy1WtAATEW4pJ0Rm+2ldoIWU0uX4PB/7jBroGIomWhvmAEvlHtvjoHPzDRTLAPg1IaIc0QoKQV0SKGzzEHE6HKiPK0QcQS6nfZvYzX/xUZ9Ba/SRtdHn/I9vGVpCEvrVkHpzKs8aoCn5+26dIl6q8uWKuheSIF+Zdheo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=buyticketbrasil.com; spf=pass smtp.mailfrom=em731.buyticketbrasil.com; dkim=pass (2048-bit key) header.d=buyticketbrasil.com header.i=@buyticketbrasil.com header.b=NEnD5mlR; arc=none smtp.client-ip=159.183.224.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=buyticketbrasil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em731.buyticketbrasil.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=buyticketbrasil.com;
	h=content-type:from:subject:content-transfer-encoding:mime-version:
	reply-to:to:cc:content-type:from:subject:to;
	s=s1; bh=WoYD4nL1WHLCYRPaDYJmP4aFMOqgo2tn7x8Z82UQxiE=;
	b=NEnD5mlRwfb9IOE4eBf/te4pF2mawp1RhCFrS3rDXwJneJZcRQUrcMvhkewSJo1Gd3fq
	lFsAY/HJVCdCzqavs1ScoDrZXJhs39eGQ5UmAdf+7Ew7f6DS2+NP27qxigjw9UFDQqA2Q9
	NJ7tjX+8e26Jg2ScSYLVLfFTi2oXJ3q9VVLKGI3f8sbklI8Xeb5/VPvovuEUCjS+ze/Kn5
	Hv3oBht/9s9OKvEALzm6QHQuyahxNHnct4jM9v82HRpvCmXM1TpdsK5kkIdxcZALqSJE4e
	ARTujVRT6Rsfww7ksZRQxgxODmLXd12f7tRaITCBR+ixVYUwxiFB4LLmhscwso2g==
Received: by recvd-55dc9747f-cpmw8 with SMTP id recvd-55dc9747f-cpmw8-1-67CC80D4-B
	2025-03-08 17:39:32.040450466 +0000 UTC m=+3355054.370705071
Received: from [127.0.0.1] (unknown)
	by geopod-ismtpd-2 (SG) with ESMTP
	id d9_WoLL5R6GJucdhMo0ZKg
	for <netdev@vger.kernel.org>;
	Sat, 08 Mar 2025 17:39:31.894 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
From: Nicole Hunt <marketing@buyticketbrasil.com>
Subject: -Request for Tax Preparation Assistance - Zoom Meeting Invitation
Message-ID: <997580d1-7641-f70a-c8d5-852f910004fe@buyticketbrasil.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Mar 2025 17:39:32 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: nicole@bluehorizonventures238.onmicrosoft.com
X-SG-EID: 
 =?us-ascii?Q?u001=2E+jqN+gpXZTnS4UoUSa6bspJpUAeLnzx6b=2FtmwTmP3S3DRX+kXOrrrnIkw?=
 =?us-ascii?Q?vp404op=2FfZIGwW80l5zfvugPYy4XMiPAaKsiCrd?=
 =?us-ascii?Q?f5FInUhwkQen4OT+vRS5xdgAgSOTJOISHinmGEL?=
 =?us-ascii?Q?AM61sFO2pJGoGe5JLLj+yaQ8V5YKNW1VfdxHU4A?=
 =?us-ascii?Q?CEwvV8KK85X9z0yglfzEn0wKcwoVeVK2I4mt9lM?=
 =?us-ascii?Q?7g6y0W8F5dMmWmpvSfR60kkdvJuZVIiKSU7eMD7?= =?us-ascii?Q?LTz7?=
To: netdev@vger.kernel.org
X-Entity-ID: u001.U1IeBADCGloLwgZAiW8XDw==

Hi ,

I hope you're doing well. My name is Nicole Hunt, and I'm seeking a tax pre=
parer to assist with filing my 2024 taxes. I=E2=80=99d love to schedule a b=
rief 5-minute Zoom call on Monday to discuss my tax situation and your fees=
.

Please let me know if you're available, and I'll send over the invite accor=
dingly.

Thank you for your time, I look forward to your response!

Best regards,
Nicole Hunt


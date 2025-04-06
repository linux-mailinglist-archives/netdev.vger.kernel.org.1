Return-Path: <netdev+bounces-179469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC78A7CE8A
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 16:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45F5188D730
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 14:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7429817A2F9;
	Sun,  6 Apr 2025 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=focusinleadership.com header.i=@focusinleadership.com header.b="iN3rpe62"
X-Original-To: netdev@vger.kernel.org
Received: from xvfrsscn.outbound-mail.sendgrid.net (xvfrsscn.outbound-mail.sendgrid.net [168.245.102.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24918488
	for <netdev@vger.kernel.org>; Sun,  6 Apr 2025 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.245.102.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743951389; cv=none; b=mvCGa4hsw0YERqlVlI7uuG4ZBYE/jIlPADQ2/yCvbWQvQAAgA4X26JDEM7zUHJQqE25u0FAk08523p9Aoc1/yUYfnNVnBJcQi1Y/r+5l6pYmWZRbAxjQCc2P4doZqCULXMqjTkQi6lZsvhXfziKBuyOid8HIIrWr9yjYKf2BQHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743951389; c=relaxed/simple;
	bh=tcbixGOB0oTLfs5tv3mG2H2CtvdanJR1/48WjEburoo=;
	h=Content-Type:From:Subject:Message-ID:Date:MIME-Version:To; b=qKnfgrOovO3TeRLvSPZS1zykcsdbE9LjaO1OIusYZgKqhDGK+y50nWAWIct4bjC1uzTOst1vsgvJARCdtnWqjBP23trlnekDIfGV+RkiN4oHgd9TPqj35wnGfmnsPXZzHE1Zx0CavhcPSS327bDqLEIeW9kgayCVA7WZbSkDlmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=focusinleadership.com; spf=pass smtp.mailfrom=em981.focusinleadership.com; dkim=pass (2048-bit key) header.d=focusinleadership.com header.i=@focusinleadership.com header.b=iN3rpe62; arc=none smtp.client-ip=168.245.102.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=focusinleadership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em981.focusinleadership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=focusinleadership.com;
	h=content-type:from:subject:content-transfer-encoding:mime-version:
	reply-to:to:cc:content-type:from:subject:to;
	s=s1; bh=tcbixGOB0oTLfs5tv3mG2H2CtvdanJR1/48WjEburoo=;
	b=iN3rpe62/xnSh1w+a15JeaPlrUAdLU61d0tpDcIaP85y4CjDe5NRgvjzR0+b9XGAI+CP
	3U9XOKCoKetHpsGmOXGNny7kOKbxawNAgS39+owAQWnKt1idEhSzMokAGgnLQ0DIpAZKBz
	M8kjJpy0TfL/BBJswn0PRDUyd22pIQiNSrNEd7lBBxKxkOAD3pB7MTfQieMtCL7UzIjxPd
	O2cQ3JuUsb1ENSIJ9z1vPGkvAS/Iiwlcn15/cFCHer2L8sSU2AwRQD9DsN/3QBg1Kdjgju
	xFOcwgKaedGZfQTBS9EQYg/dEM8M+1P3GOme51gfxClq1uLJx+kSHK1M57txjtJg==
Received: by recvd-7f7675ddcc-9669s with SMTP id recvd-7f7675ddcc-9669s-1-67F2961A-54
	2025-04-06 14:56:26.842648694 +0000 UTC m=+6376890.188689782
Received: from [127.0.0.1] (unknown)
	by geopod-ismtpd-5 (SG) with ESMTP
	id GZa-Yb3PT5yVjz_bRuzpXQ
	for <netdev@vger.kernel.org>;
	Sun, 06 Apr 2025 14:56:26.711 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
From: Jerry <info@focusinleadership.com>
Subject: ~2024 Tax Ext_
Message-ID: <f2f36257-88f7-ba8f-7cea-162d02dfba11@focusinleadership.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Apr 2025 14:56:26 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: jerry@carelyticscollective.com
X-SG-EID: 
 =?us-ascii?Q?u001=2EIB1u3iPdC2UiSCBo8G38wr2xaOCaPCSQVtKNV8JQJraxsE828a8VKEwWy?=
 =?us-ascii?Q?ErNjArw9NW9ah2ZSIit93Lbw15kNVcvpGcMZ975?=
 =?us-ascii?Q?bh5hFxv9sWByNaSbDnK55P0ic+99EriX9g2=2F=2F=2Fh?=
 =?us-ascii?Q?W=2FS64Oc8At1TGycCA=2FvFj5N5iu5boGRJGF6g8xN?=
 =?us-ascii?Q?OUSJNqn4PQM5FENn=2FP4QefKNqp8exj1FlzPuFLh?=
 =?us-ascii?Q?Fh0=2F3PcuqsFMyU9LNAs3cJa7htu2LK42WVl6cDv?= =?us-ascii?Q?kUEw?=
To: netdev@vger.kernel.org
X-Entity-ID: u001.wzdlA3SpHhxzpCfljNAI7Q==

Hi,

I hope this email finds you well. My name is Jerry Williams, and I work in =
the Tech/IT department at Cisco. I was referred to you by Mary, our COO, as=
 I am in need of assistance with filing my taxes this year.

I understand that this is a busy period, and I am flexible with my timing t=
o accommodate your schedule. Please let me know if we can discuss further, =
as I am eager to proceed. I can prepare all necessary documentation and sen=
d it to your office address via FedEx or UPS at your convenience.

Feel free to reply to this email or give me a call to arrange next steps.

Thank you in advance for your time and assistance. I look forward to hearin=
g from you soon.

Best regards,
Jerry Williams
Tech/IT Department
Cisco
847-534-9077


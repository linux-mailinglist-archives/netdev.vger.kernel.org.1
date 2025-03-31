Return-Path: <netdev+bounces-178376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7514A76C92
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 19:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE86167A4E
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4891DF270;
	Mon, 31 Mar 2025 17:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b="hcHFbBhc"
X-Original-To: netdev@vger.kernel.org
Received: from s.wfbtzhsq.outbound-mail.sendgrid.net (s.wfbtzhsq.outbound-mail.sendgrid.net [159.183.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868CA126BFA
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.183.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743442330; cv=none; b=h1QePEFf1aWy7VFqAKfkzRP9OVPtpWbB+BUHq2wulSp761iNoiQKp03AdmgRUkuTsTii9cpVrWXROGM4gq9rgBe2pJPV4gFGaV/kfYTSvfXFO0vHRWlgb2svQlJW2JXhK+Ihq+Jars96/1mZ0QYP4DtVW3/7koFNh5PZA3497Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743442330; c=relaxed/simple;
	bh=iN5SWC/kvlHpA/5+sFeJh/APuEXkmCL3Cm09Qe9sFVM=;
	h=Content-Type:From:Subject:Message-ID:Date:MIME-Version:To; b=aeS4OfM/bu6A3pvBWgaSW3kUaNNjv2M0Y/vic/ODD0KfjsNcgMwcV0PLUkGf542ur1P772s/n3L2yp/jLXKld3DxNKx4aCyOYx/Rw++Hz3IsVr5F5nfNDZrJRXBz0IgTNdYj0U4+6EltoFPwmJdAPYH+rEy37hh5ZD27ipjkd4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philippines-etd.com; spf=pass smtp.mailfrom=sendgrid.net; dkim=pass (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b=hcHFbBhc; arc=none smtp.client-ip=159.183.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philippines-etd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sendgrid.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
	h=content-type:from:subject:content-transfer-encoding:mime-version:
	reply-to:to:cc:content-type:from:subject:to;
	s=smtpapi; bh=iN5SWC/kvlHpA/5+sFeJh/APuEXkmCL3Cm09Qe9sFVM=;
	b=hcHFbBhcpZpZ3h/UfTYcOPHn7P8xrUL6cpIMYb7tYzsP+gvPZznIJb1ok2jAVWQHiiIZ
	w7PzE38AhOzyOGMBCfezMPbvNABlQa6QzHsfm7Q2Y43SpykcUHhN3Sjf5ZwPnx2iWBUs6w
	820u5fdLcHBScZOOEYLc8AWo2z+hYAqco=
Received: by recvd-85c8d64d45-5w5h8 with SMTP id recvd-85c8d64d45-5w5h8-1-67EAD185-63
	2025-03-31 17:31:49.666537841 +0000 UTC m=+5275586.297483698
Received: from [127.0.0.1] (unknown)
	by geopod-ismtpd-5 (SG) with ESMTP
	id _ia-UH4qTkquG_p6ovClCA
	for <netdev@vger.kernel.org>;
	Mon, 31 Mar 2025 17:31:49.570 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
From: Colleen <inquiries@philippines-etd.com>
Subject: 2024 Ext_
Message-ID: <f8568f82-f499-f657-53d7-00d7866e56b7@philippines-etd.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Mar 2025 17:31:49 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: gaenser-stickler@fusionsphereinnovations.co.site
X-SG-EID: 
 =?us-ascii?Q?u001=2ELhzasuSPjOJK=2F2wNdeOjk6NPZZWv9VGZvZtXC1LXwocFgInGtJHwcIutT?=
 =?us-ascii?Q?=2FSGznZ9IY8xVBWdqCV8izOLgyHWkmNxAbmHsMMF?=
 =?us-ascii?Q?cvfSU0OO9MMM7FYZOCijsV7qLGXILrKKktAbgxX?=
 =?us-ascii?Q?UxLiyn+OpN8mD6bXDV3cEY+aYqsjLL7Hj31Zhfh?=
 =?us-ascii?Q?Kpy91PNFUDh9rSE2lGozkKaoJCITkHYUhY6XG3T?=
 =?us-ascii?Q?p1Hak3mAjRLyO7Bem6zqhQZ1E7S=2FUGbnwGwF7UU?= =?us-ascii?Q?5y0w?=
To: netdev@vger.kernel.org
X-Entity-ID: u001.ikJmbcOuTcXLbBBXuK30Zg==

Hi,
I hope you're doing well. Apologies for the delayed response. With the tax =
deadline approaching, I'm considering filing an extension but wanted to che=
ck if we can still meet to file my taxes this season.

I've uploaded my Driver=E2=80=99s License, Roth IRA, 1099-R, SSA, and Form =
1040 in the PDF link for your review.

Please let me know your preferred payment method for the retainer fee=E2=80=
=94Zelle, Venmo, CashApp, or Bank Transfer.

Looking forward to your response. Thanks for your time!

Best,
Colleen


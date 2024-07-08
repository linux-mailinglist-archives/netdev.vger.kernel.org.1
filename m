Return-Path: <netdev+bounces-109944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2AA92A5ED
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 17:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31A67B215B0
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 15:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FC31411E7;
	Mon,  8 Jul 2024 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="hdn5FLTf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B68713B7A3
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720453417; cv=none; b=MTE5JYqMr9NuEcbakeeZT76bjcK2ikbPVbZ1VgDDhYMYk4DS2s/M3Az4BIckiQG2q0RbHvjm2CRMwXXuk2w7Rllmu1RXa3XHnh8rP9j0bno6czjatZDwxKD9+P7IQLv5wsK5xzHShZhWrjqChdp9IF3NL9EHDvBL/er93JCXa/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720453417; c=relaxed/simple;
	bh=9EGfTZopiGgQAhODKHxelZlIc8fLUWSDWo1sv+RKg1U=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=t8IfTTp7Vs0n3iKcLBJGVyD2wPbgXjY0F9XiTPnbybSJ7VIvIpKaxdrBVkJIXDYzZOCNJACWQFHxHqyBty9U5tjQOXrJUIW7YWSDqykfBN95M8Q5mGEkrTT11ZvxbrYxFkKkvc8itfbnz/iXV2s642OBav0h/DPM3KDtpvKLJI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=hdn5FLTf; arc=none smtp.client-ip=185.70.40.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1720453414; x=1720712614;
	bh=9EGfTZopiGgQAhODKHxelZlIc8fLUWSDWo1sv+RKg1U=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=hdn5FLTfn0Kd0N+TO11UMpRxLRHcADOUzaSbPSLySwRCeYeR6QAdZLsD1hgNznf5N
	 OGUhuNNIvY/VmTZUs65CPO70bvFtn8tXrWpNguT7x4h6yo0n8sISmVZ6flQmER14a5
	 GJAEPZOWwCfjDf59WqnNQBv7o1VuxHdTEWW1YjaZTsrATOOhgwgreCTGATlhaFVsJf
	 9drfw1xmO0Qk5b5FSIBpPtU8rlm2EHSf5KKD1qEMobVqZC63cNRJM/oT/jDGe73TOk
	 Da0dCK8FpAmAGRdh7m/9oO3I7xDVqOV8qkYAYCjxqdsEsISac4vmBsbc8R6f/KPLtZ
	 wMWdxA/fnSuCw==
Date: Mon, 08 Jul 2024 15:43:31 +0000
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Bug <bugplowman@protonmail.com>
Subject: (No Subject)
Message-ID: <uEn5KZ2JC8Gg9UeR8TJb0fZ4jpihR1GPGh-hdbTYAQddUBpWnjikWLaiiVVjj3fWjtigLVlhV-mvBFmRbptFKP6tCaCbv8F4jqBuV9uT0NM=@protonmail.com>
Feedback-ID: 106709767:user:proton
X-Pm-Message-ID: c3465bbe319a0adddd20c31f33fdad45bf029142
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

subscribe linux-crypto


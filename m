Return-Path: <netdev+bounces-182078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EA1A87B1B
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 10:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A193B11A0
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 08:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCD1259CA4;
	Mon, 14 Apr 2025 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="GcDGrtSL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D2D201246
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 08:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744620894; cv=none; b=TXcYCr+ZiA9CyCbBRRl1h4/A1T+9rLwteBONCwChCxfFregmz37fm2EbNGsPh/xXUoBIbdRpFCsMlmwKw3r/JETTG4t/eYNU7EvNq4DhonvgAoKqRxmke3VgQNO+K3amq3DeJvQVqo57PNAclAgmm8Uoeun287KGSVXhuCDVgNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744620894; c=relaxed/simple;
	bh=FuFHyb8rrXQnUs0/RgvEOtukpnC/dv4iIU9qI1e4D2M=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oYqe/srr7xKeQU8R+fcUlsSMUASEy5hb764B4iHff47++c4itYoQQVLOSSaEmbRXD3ZwRLCsuEd9ehKzNczI0E0PjDClGP25izGszgO/JCiXy4ez8+VJeWAHQ6HlNduVAqi4eET8BdFebbZnWbwQUwiYNkCcgHNczAj9Uz28Nlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=GcDGrtSL; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1744620883; x=1744880083;
	bh=FuFHyb8rrXQnUs0/RgvEOtukpnC/dv4iIU9qI1e4D2M=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=GcDGrtSLNZeOpw9b2S4ix86ChMU/QrrhnpnB9A3bd9ceJ54J2U1fPQJorYJQfsUPO
	 04BezGpWRcBklDsRWWl+ZkD9f11ZWsRBqUUpjesKyCALwkB3Ok8lwx3VBIahHfncfn
	 cXE5yv2CRbauzss7k0XISPFoUYMr3NSDcabJWnk2IFNB7OA4wY6nlsbKDh5+GNvSV2
	 x7teZYAw1yg/OsW5nqZHN+q8B3a5RH8jyrzDUIRbE7U2pcDzgr3oUvIySBgt23wrN2
	 rDTibHxXmNlVY1prCiHRJ6p5ZWTsB0VbkdS4GfIaAMXKpwxFuS72Y+5p6xEtWeJ8aB
	 GL3ZqUy+89imQ==
Date: Mon, 14 Apr 2025 08:54:39 +0000
To: Linux Networking <netdev@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Check Point Firewall R81.20 will not need to be installed as a virtual machine inside Ubuntu Linux KVM host
Message-ID: <ZCfvU4Ek4T_Ns0Jl9SFCY7HjdzZDQQgubXXKHK8igDIYLEmy8Mgej5A3W800jsb-oY9tC3qBJ-hpCJfINTNELXjjsqXd4PRImlm6F14WFVg=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: 38953c1af214dbb0d62ada2d223cc572568c8f36
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Check Point Firewall R81.20 will not need to be installed as a vir=
tual machine inside Ubuntu Linux KVM host

Good day from Singapore,

Recently I had downloaded the ISO image for Check Point Firewall R81.20. Ch=
eck Point has provided it as a FREE download. Thankfully.

I have installed Check Point Firewall R81.20 directly on my bare metal phys=
ical machine.

This means that Check Point Firewall R81.20 will not need to be installed a=
s a virtual machine inside Ubuntu Linux KVM host.

It is unlike Palo Alto VM-Series Software Firewall 10.0.4, which is provide=
d as a QCOW2 image.

Palo Alto VM-Series Software Firewall 10.0.4 (QCOW2 image) needs to be inst=
alled as a virtual machine inside Ubuntu Linux KVM host.
It is compulsory and mandatory.

With Check Point Firewall R81.20, I just need to purchase a cheap physical =
machine with 4 network cards and simply install it from DVD, after having b=
urned the ISO image to DVD.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Singapore
14 Apr 2025 Monday 4.44 PM









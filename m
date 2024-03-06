Return-Path: <netdev+bounces-77973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFE1873AAD
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5046284491
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2EF134CEF;
	Wed,  6 Mar 2024 15:30:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DBC7FBBD
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739044; cv=none; b=V4Vk7tXKgqod9vB54hcJqe0i2GmuzNWRJwn6wCzPI6xbGiR6yTCZN2GO+HPmCP9FIzVjCdknM0ICCU+1FEbeRCNfi5AdwkKA09ufFw9nRBkqpYIkmWopf9yS3zFoheltpRqlaOJl9XctGEBSRaAFJX1hYLuCNPnOIBdPulBMs94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739044; c=relaxed/simple;
	bh=dk5LCLObmidhTWvoBxKS2Ia0odTDXjwd8zonkQUr4XQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Fw4tZKSmv8VBn7UqfMAVfN4V9Hd+vvi+eKZCE2WwoN5K5xxpgc1FMVGW5Lu1YqzUjQJhebh1t7gwn/UmdhH+1z1SzHAqUXe8D8tf982OJAfWksFsca+MBf0j2A3s5Gleedl9Ox8XcAtw9YfsevWKTCpo9iHwlCtCkrKmTwzXjP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from smtpclient.apple (172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 9875E7D0FC;
	Wed,  6 Mar 2024 15:30:42 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH ipsec-next v1 8/8] iptfs: impl: add new iptfs xfrm mode
 impl
From: Christian Hopps <chopps@chopps.org>
In-Reply-To: <Zeh2YFt4AWF7oNzE@hog>
Date: Wed, 6 Mar 2024 10:30:32 -0500
Cc: Christian Hopps <chopps@chopps.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 netdev@vger.kernel.org,
 devel@linux-ipsec.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BB1F8623-7FBE-4FD4-A561-40DAD91F70E1@chopps.org>
References: <20240219085735.1220113-1-chopps@chopps.org>
 <20240219085735.1220113-9-chopps@chopps.org> <Zeh2YFt4AWF7oNzE@hog>
To: Sabrina Dubroca <sd@queasysnail.net>
X-Mailer: Apple Mail (2.3774.400.31)

I'll go through the other comments this week; however...

> On Mar 6, 2024, at 08:57, Sabrina Dubroca <sd@queasysnail.net> wrote:
>=20
>> +/* ------------------------------- */
>> +/* Input (Egress) Re-ordering Code */
>> +/* ------------------------------- */
>=20
> nit: ingress? The whole patch seems to mix up ingress/egress and
> send/receive.


No, they are in fact correct in the whole patch. :)

"Tunnel ingress" is handled by xfrm output functions and "Tunnel Egress" =
are handled by xfrm input or receive functions.

The input routines take packets from inside the tunnel and move them out =
of the tunnel i.e., they are exiting (egressing) the tunnel.

If you replace "Ingress" and "Egress" with their English equivalents =
"Enter" and "Exit" maybe it's more obvious... As a routing and briefly =
an operations guy though I'll say that ingress and egress are used =
almost exclusively for tunnels rather than "enter" and "exit". :)

Thanks,
Chris.



Return-Path: <netdev+bounces-226917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25BBBA6264
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 20:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6628F3AF0F0
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 18:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37181225403;
	Sat, 27 Sep 2025 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="F8BaWg5P"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DD2125B2
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 18:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758996946; cv=none; b=lsYTVWGezVYswFalWQYtlF3CT3yuS/dFU2ImFo6lDz44oCwGP9O7h6huPTkwRRtW1d2OgIWh2pz7ZkUBk7D/ViONyRuLvgcJTvMonSVfzDn/haRgU4jHMZC2Xkws0KF8kG3UD/53wm/VW+HjZbCicW82xsUNxDAX+e7wHe6FhLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758996946; c=relaxed/simple;
	bh=MmjYhZwH3jeKDxeYpJ4MW71opApxJ8Fib/0AC3+P5yo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=E64a30Vc7WCuiIIikI/2MLzFO5XicwB0UPnNwoQavFVl4lLMhecqkyX1vlFzeP9YiTt0wk8tE4lf1IZqaDn9FgrIAvxEkVgJeckcWAY1J7cN6xiVBNhrAFqDCSnZKkIwJGKZBHQHShLOW2aJPrPqcEF9qyQgNMdzWjX6SSa71ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=F8BaWg5P; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 58RIF6NN012681
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 27 Sep 2025 19:15:22 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 58RIF6NN012681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1758996934; bh=tQ44l7sJ402Ia9t+pSHMAqMoWlu8ZmvFuR67B+XaCT8=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=F8BaWg5Pk4s+PVljYV9QgnrW9BmxfGzbYZnb4zzCsBsXrRC0mUrbYizhdmnNtkDBj
	 nm7O7YcB7r+wHKcZbNWemk3PnGNzt/ME5r+KZZOmi0WqmkkJOq3fels0XVL6IQpJr4
	 osEqC3D7dSgAraEtO5sd6OQeb2xeqCN1qDGmYR5umX+YmNXqZv08vokSihOPe4B+Y5
	 bygiLdpGpuoI2+yFSWSUHXiJEpT54OF/PiXnE/2uqvIJZXOYnXLr2ahI1D6/lrB3vv
	 08UsBRiCNbyev8XzZxyZucz/unfby4xHvtvC8UJfV0Vaain5KDWV63uRK7ctxSr8/w
	 nqaRisQ8oOZYg==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [RFC net-next 3/5] net: dsa: mv88e6xxx: MQPRIO support
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <d2d289ca-b40c-4e83-8fb6-ccf53d572642@lunn.ch>
Date: Sat, 27 Sep 2025 19:14:34 +0100
Cc: netdev@vger.kernel.org, vladimir.oltean@nxp.com, kieran@sienda.com,
        jcschroeder@gmail.com, Max Hunter <max@huntershome.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DE4F4AC6-2783-4374-A4F8-3032B32DB848@padl.com>
References: <20250927070724.734933-1-lukeh@padl.com>
 <20250927070724.734933-4-lukeh@padl.com>
 <79953e8f-a744-457b-b6b8-fa7147d1cbf5@lunn.ch>
 <B2B00AEE-521F-48D1-8290-18A771986AF4@padl.com>
 <d2d289ca-b40c-4e83-8fb6-ccf53d572642@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

> =
https://docs.kernel.org/doc-guide/kernel-doc.html#how-to-format-kernel-doc=
-comments

Oddly though very files in the kernel seem to follow this (unless I=E2=80=99=
m missing something obvious).

linux$ git grep @arg1|wc
     13      96    1009

Anyway, happy to change.

> Having an open user space side helps get such an extra attribute
> added.
>=20
> Would the kernel bridge have any use of this? It is normal to add a
> feature to the kernel, and then offload it to hardware.

Yes, it should probably be implemented for the kernel bridge.

I guess we need a new attribute or flag when adding a MDB or FDB entry, =
and also a way to indicate that a TC is SRP-managed. The kernel bridge =
could then be modified to reject or reclassify packets that are =
classified into a TC with the SRP flag set, unless a MDB/FDB entry =
exists for the DA that also has that flag set.=


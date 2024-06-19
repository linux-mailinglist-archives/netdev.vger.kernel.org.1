Return-Path: <netdev+bounces-104715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C098390E171
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 03:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7AAC1C220F8
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 01:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFD5208B8;
	Wed, 19 Jun 2024 01:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R1PIDjbL"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF0B1B812
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 01:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718762107; cv=none; b=LEaW7wukpsljUbxuGhVTQsSNS3oFM7xA+LBlleOQcLHkgELog9fn2GTUizALaiBD/Pxte9Gukr7Moncmpg9I0kULP3sRI6KUOqPn0rJQ6gcO/lexP3iIn1h6EnqdwQx7FKey4HYjPIB3bZVtQd0M9k1oe97R0LjMfrKJgucz+nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718762107; c=relaxed/simple;
	bh=Pkpd4+S3BY2qrvFQaZoy8qIgcC32R5QZew/HhAUrk/w=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Dpkg9qcCxCQD2z3fI6Q0su/QzJSfz+XWV5ROpGeqcsUU8UxYpqmDoDg57wRMQYW65VJwxaIKk18gMKvhD6EAPRoqslOhv5r5d1jlNZBx2UIpicTUJ9GfVYUzCm3LtM5cq4PDPYmv4dqARwai5qRXAL3efgdr5jZdVEF9GM60VoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R1PIDjbL; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: kuba@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718762102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pkpd4+S3BY2qrvFQaZoy8qIgcC32R5QZew/HhAUrk/w=;
	b=R1PIDjbL9kVMhK5WbV+BUDmGvq7ED8WgDnf7ouWxPplxO4vMMLZh1GY9URty+hsmva/IQQ
	6mKc6x2PtsgbIrJS9Ha0Z6BEPJDHkiBz9+uMgYWu3p9SdzRStww958jPsTYCD8YecfRusU
	SwykivlJw5rpiFbnWcOOLfAIMsCFc6s=
X-Envelope-To: davem@davemloft.net
X-Envelope-To: edumazet@google.com
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Jun 2024 01:55:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <077a532cb112d296b6cfb7692ed25bf9dd64f199@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next] net: core: Remove the dup_errno parameter in
 dev_prep_valid_name()
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240618074840.536600bb@kernel.org>
References: <20240618131743.2690-1-yajun.deng@linux.dev>
 <20240618074840.536600bb@kernel.org>
X-Migadu-Flow: FLOW_OUT

June 18, 2024 at 10:48 PM, "Jakub Kicinski" <kuba@kernel.org> wrote:



>=20
>=20On Tue, 18 Jun 2024 21:17:43 +0800 Yajun Deng wrote:
>=20
>=20>=20
>=20> netdev_name_in_use() return -EEXIST makes more sense if it's not NU=
LL.
> >=20
>=20
> netdev_name_in_use() returns bool.
>=20

I=20should say the netdev_name_in_use() in dev_prep_valid_name() return -=
EEXIST.=20

>=20>=20
>=20> But dev_alloc_name() should keep the -ENFILE errno.
> >=20
>=20
> And it does.
>=20
>=20I don't understand what problem you're trying to fix.
>=20
>=20The code is fine as is.
>

This is not a fix.=20

There=20are three callers to dev_prep_valid_name(), only dev_alloc_name()=
 needs
to replace -EEXIST with -ENFILE. We shouldn't add an extra parameter for =
this,
because it's not necessary for the other callers.

If we do it in dev_alloc_name(), the other callers can save a parameter.


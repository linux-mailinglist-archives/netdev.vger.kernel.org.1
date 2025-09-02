Return-Path: <netdev+bounces-218987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C28B3F328
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 05:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC75201737
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 03:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450982E091D;
	Tue,  2 Sep 2025 03:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="fqDR4GtX"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F304CB5B
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 03:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756785554; cv=none; b=YFOMS69h2urLhQjGG8c5bQN0NNtSfjr2mpo4EUMLNw/bFlVMngbKy/Hcz5D0L/zA5A3cqOkJV+0bUiWyIzdYbZTCK7He7fuC4XJ+PV3tqLZbdSpnZnXFL5+HqOGJUz5Cnxclr50BGf/r9imB8LB6qzg4uv3XODrhfijnbrxmD1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756785554; c=relaxed/simple;
	bh=RQpdpu30vhRRmDAPR1UqT0zZS4VZkT6iGJYxKl1mpcs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dbRu1fbP0/nMVdLs1/uyFWmJKI6XW5X6r4SNqs0Yc8X05y+TK/xZ2ChgKlyUfEKjqSBvoI5VkwrdLdUmuNeSeFGJh6UVsRcsgWd0zBmUuEGe50rOFUTOJOlhZ78K0Fo6suFvyoVL9H8zK5rNQe3i7RBGryLjBbJeIdyQyOH7nwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=fqDR4GtX; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756785544;
	bh=RQpdpu30vhRRmDAPR1UqT0zZS4VZkT6iGJYxKl1mpcs=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=fqDR4GtXIslTlyrzJdg3ZWmV+MCvmwRblul0zo253sisBussUn2s9wGlYZ00QmaPR
	 YORF9mw0AVufIn9Vthla8KuWPnz7BuuNHNxMchWj4+1mHNjFubjKNTozNuHWXfWnBb
	 uR9Cg8+V+UtSvHXuTCtV2FxZ57M4tKQrLNHtHjzLRbytidB1vxpjLjJey6MbSxzIJT
	 jF8DKbUeHtSNSzUOOcwc0Jb0wVkF9uraFxnlD0CfuXmH0ZPG/SZc4I6iAvfbWca301
	 aCfAlvj7vsU09IsaVFtfO75JD6Q8ue6q/2/vR6MspdWzk1TZsgguRb99TcSVh+e5Ol
	 T0LJ7IWExgPdQ==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 03C6E6E391;
	Tue,  2 Sep 2025 11:59:02 +0800 (AWST)
Message-ID: <a8c2dd5d8f72820941a3f4d660db3076ff9a8b52.camel@codeconstruct.com.au>
Subject: Re: [QUERY] mctp: getsockopt unknown option return code -EINVAL
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, matt@codeconstruct.com.au, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com,  horms@kernel.org, netdev@vger.kernel.org
Date: Tue, 02 Sep 2025 11:59:02 +0800
In-Reply-To: <f5978c86-5271-4699-bb7d-92e3f2e2b9be@oracle.com>
References: <20250901071156.1169519-1-alok.a.tiwari@oracle.com>
	 <048e6efc6e61901d0df3defaf6cc64c2afa5f937.camel@codeconstruct.com.au>
	 <f5978c86-5271-4699-bb7d-92e3f2e2b9be@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Alok,

> I was not looking at a specific path, I just noticed the
> inconsistency in the return codes between getsockopt and setsockopt.
>=20
> Extending this to the level !=3D SOL_MCTP case would also require
> changes in the mctp_setsockopt() API.

Yep. The changes to the level error path may have different semantics,
so if you'd prefer to look at that separately, that's fine.

> Also, would it be fine if I send this patch to [net-next] without a=20
> Fixes tag?

All fine by me.

We're fairly safe from any side-effects here, as we only have the one
sockopt, but we do want to ensure that remains the case in future,
particularly if any new sockopts are introduced.

Cheers,


Jeremy


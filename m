Return-Path: <netdev+bounces-175750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A073BA675FD
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3BAE19C040A
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3245520DD65;
	Tue, 18 Mar 2025 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="0mT47E2y"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B417126BFA
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306559; cv=none; b=Yr8SN0MlvYxV5DvHiKfDKSmQMF5kyOKHGvLrayGASGleURP5+eKWeV/5ncMxj77NXFL2o3MeAaNxpmMvffPTdQuAVtBSEdqyw7pxzQV0Vqv8IMhKpg/g/kSOWPiixJOy9glbiOZ7hYmFgYa4mB5NI5cxVwuJj7GTwjA8zUO0ZdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306559; c=relaxed/simple;
	bh=F2e40r40n6eqSC6k5MgBH3+wCup0YURGMSpP32SAcWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D62Oi4nnQapxavP9IIgKv+GIvLio0RPOKVKRQYHYqCyknROJYNRRyX1Tul0SR9fwA1LHkLOYS8WJKV1zIx3fZxIvXwt7+rJ54OjIDCsXhVKcXOxkas+4tIFjAQDBg36sBKTOFgHv8i3mYmxANUldvPF0FC54JzhXUXtbAWW73U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=0mT47E2y; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1742306170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zS6U9IbqxukiJ1clWx1A4PxWHL2mCHGPOXvVeRtKO/w=;
	b=0mT47E2yVSK9sQUtr2JzKuXdSBEYGzBRbtTqUi6/gq6OOpst2y3o9eErHmgUIOC2b45dNM
	Zooer++1C3wtMq0Ny7oqY3hp7V5Xv2cWZz3iH7s22ByHUs/BA1dX2yUU4YFq68mumjPtEd
	DRYMGzX0hI7yjd78mlCtcrGgOdQjYGo=
From: Sven Eckelmann <sven@narfation.org>
To: Simon Wunderlich <sw@simonwunderlich.de>, davem@davemloft.net,
 Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH 0/5] pull request for net: batman-adv 2025-03-13
Date: Tue, 18 Mar 2025 14:56:07 +0100
Message-ID: <3809149.MHq7AAxBmi@ripper>
In-Reply-To: <a0f1deec-2770-4b51-ad2b-b3d0e846be25@redhat.com>
References:
 <20250313161738.71299-1-sw@simonwunderlich.de>
 <a0f1deec-2770-4b51-ad2b-b3d0e846be25@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1964837.taCxCBeP46";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart1964837.taCxCBeP46
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 0/5] pull request for net: batman-adv 2025-03-13
Date: Tue, 18 Mar 2025 14:56:07 +0100
Message-ID: <3809149.MHq7AAxBmi@ripper>
In-Reply-To: <a0f1deec-2770-4b51-ad2b-b3d0e846be25@redhat.com>
MIME-Version: 1.0

On Tuesday, 18 March 2025 12:05:52 CET Paolo Abeni wrote:
> The series does not apply cleanly to the net tree, could you please
> rebase it?

$ git log -1 --oneline
9a81fc3480bf (HEAD, net/main) ipv6: Set errno after ip_fib_metrics_init() in ip6_route_info_create().

$ git pull --no-ff git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20250313
From git://git.open-mesh.org/linux-merge
 * tag                         batadv-net-pullrequest-20250313 -> FETCH_HEAD
Merge made by the 'ort' strategy.
 net/batman-adv/bat_iv_ogm.c | 3 +--
 net/batman-adv/bat_v_ogm.c  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

So, it works perfectly fine for me .

I understand that it is confusing that that Simon send a PR with 5 patches 
mentioned. It is actually only 1 patch - 4 were already submitted in the last 
PR. But still, the PR seems to apply cleanly for me.

Any hints how to reproduce your problem?
 
> While at it, could you please include the target tree in the subj prefix?

It currently mentions net in the subject. But I think you mean to change it 
from "[PATCH 0/5] pull request for net: batman-adv 2025-03-13" to 
"[PATCH net 0/5] pull request: batman-adv 2025-03-13". Or which exact format 
do you prefer?

Kind regards,
	Sven


--nextPart1964837.taCxCBeP46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ9l7dwAKCRBND3cr0xT1
y5/DAQD20CG4iCNDzl8RXkBPzxz4miX+U6QNUXpR+iB0JCSm8QEAzVj7p6ylNvFQ
Cqf6IBTk8Z+k1c9gZxXP1SkDzm6uAwk=
=+ADe
-----END PGP SIGNATURE-----

--nextPart1964837.taCxCBeP46--





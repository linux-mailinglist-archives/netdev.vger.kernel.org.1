Return-Path: <netdev+bounces-220509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D467CB46765
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 02:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734175C3C57
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 00:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB784C97;
	Sat,  6 Sep 2025 00:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXL9Y3Kq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025794A00;
	Sat,  6 Sep 2025 00:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757117398; cv=none; b=uoyx6HP24qtLBKg7UeQGS9KshSxG0Vn55Bi0/8Ly2MtsLkKD4ubAE5I8yRYXUichExYvX3QwUAKTNNv3HUt44s5AKHfoT53IM6YKF1CGWXxYblqA338ALu+DuhuZFiv0f7v4CcmyYNZMfGE7aYn+9+iiEfbXBPy2mOjQ5b9jc7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757117398; c=relaxed/simple;
	bh=VTf5wW96kBXEFtzvHYorlKxfpU60Bg+Sr9U40sLg0a0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RoGESAuWt84GzGGS8h0IMREkPlyshLHBYN4wjU4u8ZWMA87E0zwHIppjE93RQ4rre5JTyA5ZcTIXYwZP0FV86vMqTK1ggNtwRsVzMPgEvV+i8s5WhSd/qoHv9ELcaz8OrIUyyfxJBXy/OL9+SKP8g6wMEev3zvfta+O/tb053m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXL9Y3Kq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00552C4CEF1;
	Sat,  6 Sep 2025 00:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757117397;
	bh=VTf5wW96kBXEFtzvHYorlKxfpU60Bg+Sr9U40sLg0a0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oXL9Y3Kq3kyyU3GWml8d8JVQgV619xoRY9CJoY2WO/UV+pSvLFvTYzoCD9f9WXXP2
	 Dmturid+6Rihi7kP1R+xmGPW1zqDuHRCNgy9zC/JcLn+ifP0R5io1JFUHLqItNGtbn
	 3l0bTM/0Axur0n/CayjjVysDCt9nb1L/+TPm2Blwm66LsPUdFALHJHiQQ6zvr8okr6
	 S7qclZOhecukkU/nTgPv1p45fSF35do10J9LeJzoao3BKeDTNrK8WW4UJ8l9pLjg/Q
	 Msv8plDwESpTb5tCV12NCF09m+chCdIA/epVUgDmB8ttj+eLiC4ACsxWTxDok/qlMe
	 fLmjUoWpAeuCQ==
Date: Fri, 5 Sep 2025 17:09:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 02/11] tools: ynl-gen: generate nested array
 policies
Message-ID: <20250905170956.64fa623b@kernel.org>
In-Reply-To: <20250904220156.1006541-2-ast@fiberby.net>
References: <20250904-wg-ynl-prep@fiberby.net>
	<20250904220156.1006541-2-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  4 Sep 2025 22:01:25 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> This patch adds support for NLA_POLICY_NESTED_ARRAY() policies.
>=20
> Example spec (from future wireguard.yaml):
> -
>   name: wgpeer
>   attributes:
>     -
>       name: allowedips
>       type: indexed-array
>       sub-type: nest
>       nested-attributes: wgallowedip
>=20
> yields NLA_POLICY_NESTED_ARRAY(wireguard_wgallowedip_nl_policy).
>=20
> This doesn't change any currently generated code, as it isn't
> used in any specs currently used for generating code.


Reviewed-by: Jakub Kicinski <kuba@kernel.org>


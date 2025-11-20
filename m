Return-Path: <netdev+bounces-240245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CE9C71D8D
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 03:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 593B84E4929
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 02:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D051A224AF9;
	Thu, 20 Nov 2025 02:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fybc5y8l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982D62E40E;
	Thu, 20 Nov 2025 02:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763605649; cv=none; b=pwr5jrpnAnwuB/sJvdY8sv9PvMRnvjMN3UKEO8h7k8yvJsQXqS2//v0VyKVwDQGOGg5FKvsKB9I/mYYvBNWqKtv0Bl84oH5E2puuPiXMVydJEf/9b66m2sks9s1yiNO+ztSI1btufZ1HQTD0OF6EE2d/IvT82VIVBeX8Rp4ueDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763605649; c=relaxed/simple;
	bh=3Y9kcr0znSxvhLSXbAv9R4vrY6lksgh6vjh7lHpAmqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nseReQAqvoAvfJwE4iRaBTnrFixbbeb2OBQ4GEAo0JOJ5jTCAWdbhewH5NY8yE0WyYM0hpKI0dyygHw0rdvSemFBbVtWK6+O/oeBQckV+6+4jT1/tWRrW1l5WR5sPpauJSBg8bCNeCjMGd2CJzPhki0tBcixpuSsMalFFKaVytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fybc5y8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9759EC4CEF5;
	Thu, 20 Nov 2025 02:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763605649;
	bh=3Y9kcr0znSxvhLSXbAv9R4vrY6lksgh6vjh7lHpAmqQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fybc5y8l1gtATaBEOY7OJPh0GFTtycn9xzKEMr3NmAWOYviVz9j9wfZRgpLIkuqB7
	 mB2ni2I0KNZVR/ykS42Fo6ZcR881qwhp6AbuT82aW1BVT4faDiso3MbNqNkj/wvnt6
	 I2iJtRtoa/dk32MkHRi0xQ3dVtwFmC7CnQjN06GrVhAiy4x+eLejomZWnz0A/8ZuM1
	 ybqYNzeD2xuzTj0bUpvOO7ToIGoGqCgzqV4k8VwAaRG8VOgcKadsbAbasPtI6Qcm7f
	 UNqRHsQpsn7mACglxL0WoqdUz0bfMHaDWi+/Jy8Y9GuHAeSEsyuOCOqsF7dCAO8gcr
	 7nExsR/K1SLtg==
Date: Wed, 19 Nov 2025 18:27:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jordan Rife
 <jordan@jrife.io>
Subject: Re: [PATCH net-next v3 04/11] netlink: specs: add specification for
 wireguard
Message-ID: <20251119182727.612321f8@kernel.org>
In-Reply-To: <f4d147da-3299-4ae7-b11e-b4309625e2c9@fiberby.net>
References: <20251105183223.89913-1-ast@fiberby.net>
	<20251105183223.89913-5-ast@fiberby.net>
	<aRvWzC8qz3iXDAb3@zx2c4.com>
	<f21458b6-f169-4cd3-bd1b-16255c78d6cd@fiberby.net>
	<aRyLoy2iqbkUipZW@zx2c4.com>
	<9871bdc7-774d-4e35-be5f-02d45063d317@fiberby.net>
	<aRz4rs1IpohQpgWf@zx2c4.com>
	<20251118165028.4e43ee01@kernel.org>
	<f4d147da-3299-4ae7-b11e-b4309625e2c9@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Nov 2025 19:19:28 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> >> Also fine with me. I'd just like consistent function naming, one way or
> >> another. =20
> >=20
> > IIUC we're talking about the prefix for the kernel C codegen?
> > Feels a bit like a one-off feature to me, but if we care deeply about
> > it let's add it as a CLI param to the codegen. I don't think it's
> > necessary to include this in the YAML spec. =20
>=20
> IIUC then adding it as a CLI param is more work, and just moves family de=
tails
> to ynl-regen, might as well skip the CLI param then and hack it in the co=
degen.
>=20
> Before posting any new patches, I would like to get consensus on this.

The reason other C naming tunables exist (for legacy families!)
is because we need to give enough hints to C code gen to be able
to use existing kernel uAPI headers.

Random "naming preferences" do not belong in the spec. The spec=20
is primarily for user space, and it's used by 4 languages already.


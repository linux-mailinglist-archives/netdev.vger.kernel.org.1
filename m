Return-Path: <netdev+bounces-142596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D2A9BFB65
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3121F221A2
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 01:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF846747F;
	Thu,  7 Nov 2024 01:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYO5ZR4w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB92B28F4
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 01:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730942722; cv=none; b=KnKuy1fXKULgXozGbIo78lNxoCXpkrYVbjdmtpL/SSdWdgcNIOhCVnUyhxbUYxjPrEt8Lc7+d6wsbNu1Zimm793BVCaZQ0jytrcVNwPrCZAmiDiwNeAJhxK/T5ZM6n+M9pgmdkchGl/aYQAvVk3hFxE5nx0KoKLhA8yJWTPo19Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730942722; c=relaxed/simple;
	bh=vHTgvH6DIODuAzukB16x9SBWoJoOBYNT6YAx0GcQIYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCTL7XA6T3gBWGG65Jd6+534OuhVYI/YIi8miiV/TmNE5clZRYhnrC5a4NiS949PwAd/doL3uqfWJiv4ksam53wdaStLW3FAPY45V5UK1RaTrbmSuVU+zGtUKj4H8tOmW38CN1Sbd3W70IoOkKgI6589hhCSRhlLOeWj5Hh8/Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYO5ZR4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF54AC4CEC6;
	Thu,  7 Nov 2024 01:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730942722;
	bh=vHTgvH6DIODuAzukB16x9SBWoJoOBYNT6YAx0GcQIYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VYO5ZR4wm58b90M/yAQwNs+gjYv74y9A5k0JKD/JtxO9yWIt+x45Fy4LwYGhrXXhf
	 2SKKc6y/vPGpWU03MXutIJuo+e0hex0JBGn6PGrhEBAsW/H2EkDVij4/dcpJIzRn1I
	 k12Mg3yc//aMqbEujTOiD61nua1CxTev724E2l4TVOLqrn4keQrCHP9tM2p1pr4HgP
	 88hImS9S1RjnSa3YFm5iWMRQzBE+ivQKB0Cs5bjjsN7Z5JEXHJAL4vGrj3SEVHQD8K
	 1c6XugqXA8QF2nXLqmbxg8osjFDTA/3W+9nJAxtkXgJWcb1loCBCWGIgoHNFcchEWj
	 A82j5mk1u+Bbw==
Date: Wed, 6 Nov 2024 17:25:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, donald.hunter@redhat.com, Ido Schimmel
 <idosch@nvidia.com>, Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v3 0/2] netlink: specs: Add neigh and rule YNL
 specs
Message-ID: <20241106172520.7f36d5f0@kernel.org>
In-Reply-To: <20241106090718.64713-1-donald.hunter@gmail.com>
References: <20241106090718.64713-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Nov 2024 09:07:16 +0000 Donald Hunter wrote:
> Add YNL specs for the FDB neighbour tables and FIB rules from the
> rtnelink families.

In case Paolo wants to apply:

Acked-by: Jakub Kicinski <kuba@kernel.org>

I haven't checked that the definitions match but purely from the spec
perspective - LGMT.


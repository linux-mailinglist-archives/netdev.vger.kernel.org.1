Return-Path: <netdev+bounces-248735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDBCD0DD4C
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 21:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A5FC3012BD3
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 20:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C206283FDD;
	Sat, 10 Jan 2026 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfeA71UC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191882139C9;
	Sat, 10 Jan 2026 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768076031; cv=none; b=ZOq95pTRamu6BxtYptnbYcsdtXB6Nku+/IR4ZgHxH6wQXZpN9JvCptGwtBM9HJ24DloZ1dXRvBBiZsj+hdIBBj4y9buAFS5H5Cp4CjSVk5g8GLdxAkzm8T158Xw6wMem5SGoNaSny1ID2VY0pzaFs06w0HbRucDd1I09/H1Q4u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768076031; c=relaxed/simple;
	bh=7CFcTUhdtne9HIB2JWSObovUr87Zty1hnAetY9B3OZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCuk4nHVtM2uFoshzsDCvqqcz79jun9j2N75Tblznxon5bHe90CsgrNjuk4atFbCzsYrTU+Y1YCNNq0GnApkpxSM3hWxxBUm8wvLvVeDQU9agewASwWjBdwVhY0WltIpop0qPeNo9JCCLj8c1zcuMGKGOw3X9DSqNE1Co5GiK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfeA71UC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9C9C4CEF1;
	Sat, 10 Jan 2026 20:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768076030;
	bh=7CFcTUhdtne9HIB2JWSObovUr87Zty1hnAetY9B3OZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BfeA71UCHLwr3/fWCrvhsBrxEiyhRQ3P9UmwXmx35jr6KCGK/DOHpbsJwhrWltJel
	 68Wq863QGWHaohuaYUGKvx3ZKbka4ZTrQtyv8NkkpOu1Wd6OfxWcdch5NqAmITKpNQ
	 0udplL0i/Hf6k4PgrNxidO62sRYAXujqyf3jqslEkKCM0zPT/Y/5fRe3rwwghRYyTR
	 4Y5xoWAcuAW0wY4Gqmomp4MSrcRfkDSDQY+OsJS++D8xIGIpt72QGcY/KvEV4WqLIh
	 Cl3O8Ym2hZwKVP4v5w/6WJU1dMZsIkFPwyA11yeAtPcaS8C/NqHOjmc2JO8VeXfYJk
	 E6dH1YhZ0zpHg==
Date: Sat, 10 Jan 2026 12:13:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vimlesh Kumar <vimleshk@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sedara@marvell.com>, <srasheed@marvell.com>, <hgani@marvell.com>,
 Veerasenareddy Burru <vburru@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3] octeon_ep: reset firmware ready status
Message-ID: <20260110121349.25eb40ce@kernel.org>
In-Reply-To: <20260107134503.3437226-1-vimleshk@marvell.com>
References: <20260107134503.3437226-1-vimleshk@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 13:45:02 +0000 Vimlesh Kumar wrote:
> +#define CN9K_PEMX_PFX_CSX_PFCFGX(pem, pf, offset)\
> +				 ({ typeof(offset) _off = (offset);\
> +				 ((CN9K_PFX_CSX_PFCFGX_BASE_ADDR\
> +				 | (uint64_t)FIELD_PREP(CN9K_PEM_GENMASK, pem)\
> +				 | FIELD_PREP(CN9K_PF_GENMASK, pf)\
> +				 | (CN9K_PFX_CSX_PFCFGX_SHADOW_BIT & (_off))\
> +				 | (rounddown((_off), 8)))\
> +				 + (CN9K_4BYTE_ALIGNED_ADDRESS_OFFSET(_off)));\
> +				 })

This macro is completely unreadable. Maybe add a static inline to
perform the CN9K_PEMX_PFX_CSX_PFCFGX() writes.
-- 
pw-bot: cr


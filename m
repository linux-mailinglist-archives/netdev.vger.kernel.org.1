Return-Path: <netdev+bounces-221919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 135A2B525C0
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81CD56802A
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA6D1990A7;
	Thu, 11 Sep 2025 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoKl+ySN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026523595D;
	Thu, 11 Sep 2025 01:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757554197; cv=none; b=XPQLmG7elfYi4HGqRs/aoVqL0as3RQBW0Yk87SmKU1tvs+ivRHKZbVp7QOFSk0onpxYcfnMkCtO4ly6DD1t/cMrJexTjwrbATokWUK21dRXezCMBQ0IM15V9LotpD+w0SHkNzgCvxrhGFi3gfUeEi//QvGbg+kHu8n/+Sle5/h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757554197; c=relaxed/simple;
	bh=vqtwsbfCxiSwrtPhdMyCQgn1rx2fHdnoowDHVEMTgAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSzW/ABM1mVRndRsj69GBe9OAjjBNyE6aIm8caIWYBPo86f/qFQKj5ZlDIAyspvLOBiHzpvbhuSfGcSYOCX4s3DC+uqqt2NbKYbnJduqmJo/9cr7Wf1AxUXxhd/WJmb4w9B7tNWxjyePXnR94Vxcb2IH+/OzNNF0DnfSowuxTSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoKl+ySN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11C5C4CEEB;
	Thu, 11 Sep 2025 01:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757554196;
	bh=vqtwsbfCxiSwrtPhdMyCQgn1rx2fHdnoowDHVEMTgAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AoKl+ySNYgdiYkzJ7ned6aSDSsz/NnTFoYi33bb105CeUgoPp4SZaxBgqlFZhuO/B
	 YPsje5Gxw4QnH2gzDhfLhChe/WTuLUgIro+PlnAI19q8PBnRshacdNhy2gO+OLuXG6
	 K0eaFIeaieXgkm6nlEWFAkD5cAPc+nLEuVo3MWIoUetQF7Vzv9b9JORiaXVCTbSBHm
	 9WntbPisN8ih6TsW2NGLLfaZUXDN6IK3MCgw/l9vEaYoeNDrVNhaHGcpbS5jFFkQgx
	 aA+yZ8R3z5BTlYu7GSB48ilTPJAtQfSnYKFY0o5zu/PgxN9jaQPShwfMXwL98mrU6t
	 QRDy8ucF3pD6A==
Date: Wed, 10 Sep 2025 18:29:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Sabrina Dubroca <sd@queasysnail.net>,
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 00/12] tools: ynl: prepare for wireguard
Message-ID: <20250910182955.5d220149@kernel.org>
In-Reply-To: <20250910230841.384545-1-ast@fiberby.net>
References: <20250910230841.384545-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Sep 2025 23:08:22 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> This series contains the last batch of YNL changes to support
> the wireguard YNL conversion.

please rebase


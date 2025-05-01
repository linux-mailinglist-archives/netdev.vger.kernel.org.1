Return-Path: <netdev+bounces-187260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA550AA5FB6
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 16:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203304A0734
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 14:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EF71A0731;
	Thu,  1 May 2025 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/ssFVqd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38CA29CE6
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746108920; cv=none; b=KTFCI/VJ+pshOvBjFlUqz7cvSK+tnC13y0lpWYxHicxnPBO8DVoVnnyqcg83VeqpneGFAaSYQ4KsoOURxJZNZbcqpwKuhMx6joGQ9oRyWVBknTDW+Mo00DX9YolG8jSQLZ1zYZVI3VlwhIDbLEEg2ZfiPOGfKOdAUFOWUV0rhK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746108920; c=relaxed/simple;
	bh=9RB23hZVWmfW7dEWLdxiwSUVQ97nDs6C+WmIGSBZy4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UaCIbEblT2Ev5LlpNyRDkVT+viFPNq6sEylge+smzMeyFg+utS53lpDYKoMeU/PmGGiLKJ3LGPYIwB9QPVSsG8DvRIJz6uia/86Qs84sLYrcIOwdZDqI7U5d+jKvJV4isfS0JEqad5R4kkNFBhiBlpOpbOVOZ2gVYYcsZX1Bpb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/ssFVqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD36C4CEED;
	Thu,  1 May 2025 14:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746108919;
	bh=9RB23hZVWmfW7dEWLdxiwSUVQ97nDs6C+WmIGSBZy4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V/ssFVqdk49GRBYhcetFY4I6sWyAdoddxjRPmVg0ojYMJWkzsBnDeFDtcYmW5Ko/s
	 YTWWfno5dVEnnUY/dJFSWxmGDGbSDF92Ep1olgts5v4enUpN7O+Rts1OqjOERLSi/8
	 4U9KGguVNdbcxZI0iyrNndvAUoNo/DVkyK+vkA6oJNrVFOvWV54qu/l85KQ+IGx/In
	 B8IaDy/A+Fv+ZPB0gxfss9pOeufaG2ZW75g+YEIuLzp/d+hSeNZgAFawPmiQgL+LWV
	 TImnJD39L/speGNK6ZSq4Fzud02QQP1gJm/Zjk8vXEXOjFu9U9E2lkXbaNNYH/t8Uz
	 N7qKusmJETVbg==
Date: Thu, 1 May 2025 07:15:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net v4] net: airoha: Add missing filed to ppe_mbox_data
 struct
Message-ID: <20250501071518.50c92e8c@kernel.org>
In-Reply-To: <20250429-airoha-en7581-fix-ppe_mbox_data-v4-1-d2a8b901dad0@kernel.org>
References: <20250429-airoha-en7581-fix-ppe_mbox_data-v4-1-d2a8b901dad0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Apr 2025 16:17:41 +0200 Lorenzo Bianconi wrote:
> Moreover, add __packed attribute to ppe_mbox_data struct definition and
> make the fw layout padding explicit in init_info struct.

Why? everything looks naturally packed now :(
__packed also forces the compiler to assume the data is unaligned AFAIU.
The recommended way to ensure the compiler doesn't insert padding is
to do a compile time assert.


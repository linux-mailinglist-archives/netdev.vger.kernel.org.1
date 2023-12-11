Return-Path: <netdev+bounces-55995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B7880D2C5
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1BD12819B7
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B66948CD6;
	Mon, 11 Dec 2023 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvrINhKb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAC9FC07
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 16:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D840C433C8;
	Mon, 11 Dec 2023 16:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702313501;
	bh=jXrfnDnXSAdCkJtLjpJCKDrNg7DOIOOclITycj8SrBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XvrINhKbpjF5SAY9B9Ur5XIGWUrWK005J4+6zhivTUVERjJN0CYBnXNG6sktJZBEa
	 +TKtwkIzZVvPI/ygufXQWweLn+Mlqk6IeALZRk1vekCm+1e8XBBdoXTor6Yv7ivWhQ
	 eL54cJKPGd8ozXq1KoU/98JRmzw28WQfqH+5QfPPpHimLkTDrn2qc37M5hhAd/CYgR
	 LT1RJwRU6R4F1wu0CIRg9sztDfGXp0nQkO6lpE5eldTKmGpQmfO32z1+P/M7GeB6pF
	 aL8ZWXSw25SVWwVnRbrBW4SgnRh5pKeQrIlqCEeUczOF1wijqzJZHLuNJgDRQirWa0
	 gJHZU4dYAQ6pA==
Date: Mon, 11 Dec 2023 08:51:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Patrick Williams <patrick@stwcx.xyz>
Cc: Ivan Mikhaylov <fr0st61te@gmail.com>, davem@davemloft.net,
 edumazet@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, peter@pjd.dev, sam@mendozajonas.com
Subject: Re: [PATCH net-next v2 3/3] net/ncsi: Add NC-SI 1.2 Get MC MAC
 Address command
Message-ID: <20231211085139.011f650a@kernel.org>
In-Reply-To: <ZXZ5EOSJAekCiT44@heinlein.vulture-banana.ts.net>
References: <20231114160737.3209218-4-patrick@stwcx.xyz>
	<20231210215356.4154-1-fr0st61te@gmail.com>
	<ZXZ5EOSJAekCiT44@heinlein.vulture-banana.ts.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Dec 2023 20:50:56 -0600 Patrick Williams wrote:
> Either you or I can send a "Fixes: " on this commit to improve the
> handling as you're proposing.  While the change is likely trivial, I
> have not had any chance to test it yet, so I've not sent it up myself.
> If you want to refactor the code to reduce duplication, I think that should
> be an entirely separate proposal.

Yes, incremental change is better.


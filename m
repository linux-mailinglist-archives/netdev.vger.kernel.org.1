Return-Path: <netdev+bounces-26086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACAF776C27
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 00:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900C0281E5A
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8377D1DDF1;
	Wed,  9 Aug 2023 22:26:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EF51C9E1
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 22:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD1BC433C7;
	Wed,  9 Aug 2023 22:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691619998;
	bh=D86GAVma+0XKP4Z8hF6yc63R4h8X8o+QwNFVeaE3SjQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HTFySCuPBdNPIER5Y7kPQ3iaxpQ/VJW8QTf5UuEQceOeOeLQR15lf7coUzMkMYo6N
	 N/N9fouxUaNUIYoKJmTIWj4e/g88sqdU58pnJAit91LUaB3A2lJBiyrF2QR0+p6o0R
	 OZWT95ZdhBaAz0yvyx3Y5E0/mNAiPzulfVimj9Pox4CauzURq4+Dkd6shNlFwgOwo7
	 RTkgCkaJJvHGtUGxlSgNXSlhJKeZ9ZnOhuJmUbUpIUwSpJ6TlJspAgHb9vn9x3GL3P
	 rzfdEEpqA6agZXgA8+SH3pi6I8+jd2vVVaFMEi6NiAcFzxq0t0jTFUUyV9lX8KYyWe
	 PoRt0+yWYkFCQ==
Date: Wed, 9 Aug 2023 15:26:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <sgoutham@marvell.com>, <gakula@marvell.com>,
 <sbhatta@marvell.com>, <naveenm@marvell.com>, <edumazet@google.com>,
 <pabeni@redhat.com>
Subject: Re: [net Patch] octeontx2-pf: Allow both ntuple and TC features on
 the interface
Message-ID: <20230809152637.17888c9b@kernel.org>
In-Reply-To: <20230808063623.22595-1-hkelam@marvell.com>
References: <20230808063623.22595-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Aug 2023 12:06:23 +0530 Hariprasad Kelam wrote:
> The current implementation does not allow the user to enable both
> hw-tc-offload and ntuple features on the interface. These checks
> are added as TC flower offload and ntuple features internally configures
> the same hardware resource MCAM. But TC HTB offload configures the
> transmit scheduler which can be safely enabled on the interface with
> ntuple feature.
> 
> This patch fixes the issue by relaxing the checks and ensures
> only TC flower offload and ntuple features are mutually exclusive.

Not enabling a feature is not a bug. And it will cause conflicts 
with net-next. Resend for net-next without the Fixes tag, please.
-- 
pw-bot: cr


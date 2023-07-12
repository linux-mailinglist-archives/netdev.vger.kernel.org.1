Return-Path: <netdev+bounces-16996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABF074FC4C
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 02:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27761C20E86
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 00:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B4B365;
	Wed, 12 Jul 2023 00:43:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB75362
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 00:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71293C433C7;
	Wed, 12 Jul 2023 00:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689122591;
	bh=3axPrmw4y+Z5QNRDwLTeMrlIrd2WntruvKqrhdFFYmM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mwTt0ZwrbSwt6DgNqES8kDj+5RMcNhfrQrbiWg0dVFfvUkMt0HKJWl6p2R8Kie5mT
	 D6dnVGoSIFngz+BxVvaxkZNE2Rza1kdSPp6calPGoldzViiWnkS6L7J3KG7j7CMO5Z
	 lk+d1pzgL061te0QQLJqjnOm4w6UGxUH4TKTV7eKWdOtx17Rvx2j8PLmtUpz2nbyOd
	 /pDGiZ0F2YiZO6K0EaITAa4PfkVdkKr/G2M4XIE0vzZrMT7aUWSP5mmsaPEW/out3w
	 EVz6Sq1xySXp6gzoper8xpSruI/hqhbKaRfpUtfaoBJ+U5C8UsUZ2WfYWoMGXKSlL+
	 dp0sDmQyr3VcQ==
Date: Tue, 11 Jul 2023 17:43:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next][resend v1 1/1] netlink: Don't use int as bool
 in netlink_update_socket_mc()
Message-ID: <20230711174310.081a2574@kernel.org>
In-Reply-To: <20230710100624.87836-1-andriy.shevchenko@linux.intel.com>
References: <20230710100624.87836-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jul 2023 13:06:24 +0300 Andy Shevchenko wrote:
> The bit operations take boolean parameter and return also boolean
> (in test_bit()-like cases). Don't threat booleans as integers when
> it's not needed.

I don't have a strong opinion on the merit.
But I feel like the discussion is a waste of everyone's time,
so to discourage such ambivalent patches I'm going to drop this.
-- 
pw-bot: reject


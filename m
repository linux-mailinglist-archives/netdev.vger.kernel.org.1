Return-Path: <netdev+bounces-23687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1D576D1D4
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9959281A7D
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF398C12;
	Wed,  2 Aug 2023 15:23:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D81D6FD0
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA495C433C7;
	Wed,  2 Aug 2023 15:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690989816;
	bh=03Ss9QaH4LJUp+idfEBSD6LOlA3Q9HWXg0H9LoXdUeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JdW/FfP2uNxyWqABdFtAYnBz/ABJ/a3oxBZbSM3N8PWw+wT4wJc1z/8C5t2lqDIdL
	 IF2OHGj1eW+ion3J6Oq7RDPu+D6QH/N+fwLl75z7CQA5+GzjlAmLwNjCHtZsR9QlYq
	 e0UG/mN9CU5+ZTiT3kx1Ocr9Fz839FcN6lr/2yMLru8Cy7V3sr0Jw5m2Or5zLleJwq
	 DKNsmmH18x91M+m44Z5q7xqluiiLavHsPPh/nKVoCqZmLhLUD7yimWgzK2rC0FYOMQ
	 F9anU5Ak36lnR+MeX7MjnbnSNw2PfANgkcLoyG1dS/ViXw5eatZF8FZmk0a66jfHw1
	 Mw/Rjxcm3XxNw==
Date: Wed, 2 Aug 2023 17:23:31 +0200
From: Simon Horman <horms@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/4][next] i40e: Replace one-element array with
 flex-array member in struct i40e_profile_segment
Message-ID: <ZMp080Vxne1eKtdK@kernel.org>
References: <cover.1690938732.git.gustavoars@kernel.org>
 <52da391229a45fe3dbd5c43167cdb0701a17a361.1690938732.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52da391229a45fe3dbd5c43167cdb0701a17a361.1690938732.git.gustavoars@kernel.org>

On Tue, Aug 01, 2023 at 11:05:59PM -0600, Gustavo A. R. Silva wrote:
> One-element and zero-length arrays are deprecated. So, replace
> one-element array in struct i40e_profile_segment with flexible-array
> member.
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/335
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>



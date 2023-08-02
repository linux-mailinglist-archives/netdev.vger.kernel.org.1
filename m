Return-Path: <netdev+bounces-23714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD5176D40C
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 18:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCEEC281E43
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 16:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2C4D519;
	Wed,  2 Aug 2023 16:49:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52CB5230
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 16:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EBAC433C9;
	Wed,  2 Aug 2023 16:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690994958;
	bh=i3NjhRfDljUbrvQ9Gjo9ttGLESER8Q16GU4ZplSPidI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HDDBlMlJS/8uZokFwLDzwv3dXlf1kvMtWo9a/Oe1kkicO17efe68mOhCqyAIrOEdr
	 Qzkea7OTSBb1B9CxbM/PeUnVy4Jkq2FE+kNuOv+wjBytV4+CwjMc4qvzY80WqHgk+W
	 Vhvb6ANO1W2q13QgD4+Cjy8zJqrBPDu69sTDOH7zkyh1dW/KrwC6H1jYWJQU5fpl64
	 OAB4HdisYQKjsP+7CS4E+gY8vzl5Mc80yBYxnej5gg6b84ofwq8i78x9LaR+QLJQIB
	 jab4U+833gPTABK3Sn9PoNk4x/VhtUt6fIVE7hUiQo/FU+V5aPvySxDm5b90cokAK1
	 i1km7K/eip/DQ==
Date: Wed, 2 Aug 2023 18:49:13 +0200
From: Simon Horman <horms@kernel.org>
To: Yang Yingliang <yangyingliang@huawei.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] ice: use list_for_each_entry() helper
Message-ID: <ZMqJCQC+8vL+HA5a@kernel.org>
References: <20230802090739.3266122-1-yangyingliang@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802090739.3266122-1-yangyingliang@huawei.com>

On Wed, Aug 02, 2023 at 05:07:39PM +0800, Yang Yingliang wrote:
> Convert list_for_each() to list_for_each_entry() where applicable.
> No functional changed.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>



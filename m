Return-Path: <netdev+bounces-23637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C8476CD72
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 14:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07CD2281D6B
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 12:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CBB746C;
	Wed,  2 Aug 2023 12:48:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080CE63B1
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 12:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C016EC433C8;
	Wed,  2 Aug 2023 12:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690980501;
	bh=eyDNeWRFu0qRVi/gQpUpgU014RymA+Y3RYnh4/pOX4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PXd6CMSnFh0tCioTc/f6apixSdTMxpPiVF9K9VBBM/LhUfKxUrjlPlDubYU6STAJd
	 fKjfemGFmy7BAb7MY5tIKlA4mp9dvx94BdhGIvnFzrrVHKTpV0fL9haycbY9IuqsTj
	 5wPTkR0B2R45qaMSWNUuBY0XXjHy7A25n7rma7yltZM0x7OZycL5sRJnkowyEU4DGN
	 Hq6zn6hfy/c1+6Gj8lRzA7ymuaucKRtX4iRBgz+tWHcgRSzl+ONRU4UCJqFU/LIXXh
	 OWtzZ/54/KXcLqJp39/fQeRKbgX5bhY2skMXXQ5TNBi4YKNPIOTozhxXI8pH8Gcrhv
	 iuUcRqvbMd2oQ==
Date: Wed, 2 Aug 2023 14:48:17 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	petrm@nvidia.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: switchdev: Remove unused typedef
 switchdev_obj_dump_cb_t()
Message-ID: <ZMpQkXwF+hGvFbt7@kernel.org>
References: <20230801144209.27512-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801144209.27512-1-yuehaibing@huawei.com>

On Tue, Aug 01, 2023 at 10:42:09PM +0800, Yue Haibing wrote:
> Commit 29ab586c3d83 ("net: switchdev: Remove bridge bypass support from switchdev")
> leave this unused.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>



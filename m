Return-Path: <netdev+bounces-35405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8CB7A9567
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 16:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31BE2281BA0
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 14:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547CB199A3;
	Thu, 21 Sep 2023 14:58:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEAA199A2
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 14:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EC0C4E761;
	Thu, 21 Sep 2023 14:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695308309;
	bh=wJb8k51eTjK2EvfYi7fIsXq4U34YSY4caUOFqrjSykg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TnaNAjCrDXRgL/P0hWXqyrvuCpEOCMPwoa3b8rMNXbGf0r5Jf+2zRrOKc4nT49Qyt
	 72K+HhyeNd2uyTwRbdG2BocGvjwXsHjScqxfqBlfwxKUgJ6T8Fev8VVUHoE/IFxqQa
	 mMKyI7ylawl2bYM59qSFQoIuL9i355L+ZCzYoeEmvo8wC6I0pV1F6gmTnNaScjoiK0
	 SEe4q7O2wyvw8SNRc035D14BF+OhqRop3UWCTBgFZCgr/7fu1Ll/utDEJo88wcNbDs
	 ebJmLkJ+Euz4c/kFAAxFQSFXndHVr8rReMbi8thvwFRTbxYREcofkETRFPTrKcX7Zz
	 8t2/sAwc48ZTQ==
Date: Thu, 21 Sep 2023 15:58:25 +0100
From: Simon Horman <horms@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next] ethernet/intel: Use list_for_each_entry() helper
Message-ID: <20230921145825.GO224399@kernel.org>
References: <20230919170409.1581074-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919170409.1581074-1-anthony.l.nguyen@intel.com>

On Tue, Sep 19, 2023 at 10:04:09AM -0700, Tony Nguyen wrote:
> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Convert list_for_each() to list_for_each_entry() where applicable.
> 
> No functional changed.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>



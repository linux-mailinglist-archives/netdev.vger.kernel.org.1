Return-Path: <netdev+bounces-32321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494E97941A5
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 18:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9743F2813FE
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 16:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DA21094E;
	Wed,  6 Sep 2023 16:44:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A4C1079A
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 16:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EE7C433C8;
	Wed,  6 Sep 2023 16:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694018671;
	bh=EI+fvmvCWqkc2KvJRNNxL/0XTQiGCQyC+Wq7BVvHLbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GJphocDoYaCEC2q0FlyhwS2052waXIDzJHzIdPzpiWlS4y3p2SAOqx6BQ4eW0Gnb5
	 xTrcawY491TpXvsTGriQLa+fxiX7nyheq/JKMcgosSjwVcEXVIzxOCiuU83ckmdA+M
	 wZpcgQb+FJH78SF7AMyBQ3X15P6qV/3iCsMf8+dNc8JMjzeGzbXBEIhsLZzsjZMGJX
	 xmeoWKGPUKSMa5FjSA2+A3nTJ8TMicZRBt+PdowRHmvOHxLg5s5c4RytvrZnJ0+qQe
	 uw0o/K694wTBRD8YTenWL8xQ1PUfXTUYoWVdZvBZHZuEQHV6ZFWGNt9dWr3i7S1pRo
	 ouGcdjKJGgkAg==
Date: Wed, 6 Sep 2023 18:44:27 +0200
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org,
	ivecera@redhat.com, intel-wired-lan@lists.osuosl.org,
	jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org,
	edumazet@google.com, anthony.l.nguyen@intel.com, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net
Subject: Re: [Intel-wired-lan] [PATCH net 1/2] iavf: add
 iavf_schedule_aq_request() helper
Message-ID: <20230906164427.GC270386@kernel.org>
References: <20230906141411.121142-1-poros@redhat.com>
 <bbb51ddd-ceb1-63a8-a06a-f365da5ac4b7@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbb51ddd-ceb1-63a8-a06a-f365da5ac4b7@intel.com>

On Wed, Sep 06, 2023 at 09:32:59AM -0600, Ahmed Zaki wrote:
> 
> On 2023-09-06 08:14, Petr Oros wrote:
> > Add helper for set iavf aq request AVF_FLAG_AQ_* and imediately

nit: immediately


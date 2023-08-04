Return-Path: <netdev+bounces-24424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389A0770252
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 15:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694EF1C2187F
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 13:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8A9C158;
	Fri,  4 Aug 2023 13:52:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E9AC2DB
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 13:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6D4C433C7;
	Fri,  4 Aug 2023 13:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691157153;
	bh=sp0Gy9/iy/CSN4Ks/r5KI9WJQmANhwvtLTr+VmIddCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QDsSgnZR2YLQKCEZogU9QFyPmQYicXDppoD163D7ImF6hJL7bvaPX6YR2ij+gfvtH
	 aJ5TK0A3PbZkio5lflcUykEAvvY8hCYodfYXBhg4fGcyHrX7YO1LdKJP+FAAlQTNiT
	 oxA8A+dRwcS+btAX46rWT75GzcIY32tF2i63teB2lxtDxYHK34GOuFnP1+5Z6K/4NL
	 go/UZav4hLMzvX3ur0emWvf+StrutjElQij0QLtGTMh8pS6oSIsAD/gj8tu/d4oOqT
	 SGLCNm0rqTQkyJV4F7PMxHeZisPDdSlJwYMrv/yHkzjr0SwhjxILSdah74IV3kX56e
	 PfTTCl8D3q9Qw==
Date: Fri, 4 Aug 2023 15:52:28 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ixgbevf: Remove unused function declarations
Message-ID: <ZM0CnDts6dx7i4kD@kernel.org>
References: <20230803141904.15316-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803141904.15316-1-yuehaibing@huawei.com>

On Thu, Aug 03, 2023 at 10:19:04PM +0800, Yue Haibing wrote:
> ixgbe_napi_add_all()/ixgbe_napi_del_all() are declared but never implemented in
> commit 92915f71201b ("ixgbevf: Driver main and ethool interface module and main header")
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>



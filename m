Return-Path: <netdev+bounces-26525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB30778008
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC4341C20A94
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B6221D38;
	Thu, 10 Aug 2023 18:12:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835201E1DA
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 18:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C826C433C8;
	Thu, 10 Aug 2023 18:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691691170;
	bh=Oxr4KXfx95/65MtHcCBNNZFIsBML7khA1Do5fH2mkIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CSNQs9p0FR6bmSUGjT8jm72M0ZTW9JVkkZ6QNQG/UbmzHqoW6n0HsLPVSldq8I+XW
	 ylyNW424tAktR1SitA5MxuoLly3g+WMEtv7wRrHA0FQ5PAi0hkjAsYMVdLctKB+yjk
	 qQVJo1zNDydmYm/C//F0aWeUVcmDzwdnWijFIg2pD6xX7GriseAL5cOGIRPXfDUhoP
	 ri/3yxCoxkUpKwlp2KRWrg9sJt/6R6FQ0h+GW0NIY8j5hx7xnSkr9OUP11yV4beqMP
	 2CbWAHtpp2vr5j7LQenqmJhIAkvuaHJk+y2VQMP7vIq6UsW/tL4RPrSs6L6Y7sDEU/
	 YbSbWeGvm8GHw==
Date: Thu, 10 Aug 2023 20:12:46 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: santosh.shilimkar@oracle.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Subject: Re: [PATCH net-next] net/rds: Remove unused function declarations
Message-ID: <ZNUongYwq7C8K7wc@vergenet.net>
References: <20230809143627.34564-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809143627.34564-1-yuehaibing@huawei.com>

On Wed, Aug 09, 2023 at 10:36:27PM +0800, Yue Haibing wrote:
> Commit 39de8281791c ("RDS: Main header file") declared but never implemented
> rds_trans_init() and rds_trans_exit(), remove it.
> Commit d37c9359056f ("RDS: Move loop-only function to loop.c") removed the
> implementation rds_message_inc_free() but not the declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>



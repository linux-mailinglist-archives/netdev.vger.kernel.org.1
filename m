Return-Path: <netdev+bounces-26553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153EE7781CA
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 21:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0BC1C20BA5
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 19:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CBC22F1E;
	Thu, 10 Aug 2023 19:49:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2462420CA8
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 19:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70838C433C7;
	Thu, 10 Aug 2023 19:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691696952;
	bh=D3ftcslJ8YcyfvSLWosKRnrmeg4ITPNuHnd1GqSvXL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=emz27WWvZZ1hiv59S5Ojs39+m6bGWpOehRnXX9Roe61sfrxb4QYqIpXAh9s8hmX/B
	 V7gOkJtjnAviKdqb4XpPnL7hGxMbF5lIhafOzz9qzryy+cfBvBM3DAYrRtRec1n7qv
	 d5OAkkCCzudrrK8vF8VUkcDM/FJEUrdHfG8TPVshy2tqXPfBwl4mBkXnIpp50usJz6
	 gP/MVefeLRSp+d7AqYyN2S2H9nOPVgh1SNzF6hxWghcPwJyaYoT7c8hukOYl8C8Flv
	 q227yWRWhqDlXTVJUidbcBnCWZPjmjQbr4J1dUlIn2lYS9kFmNcsqAEbmoxSxRm5Qy
	 PHVOYeRndGadQ==
Date: Thu, 10 Aug 2023 21:49:07 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: santosh.shilimkar@oracle.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Subject: Re: [PATCH net-next] rds: tcp: Remove unused declaration
 rds_tcp_map_seq()
Message-ID: <ZNU/M1Iot28KUYtv@vergenet.net>
References: <20230809144148.13052-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809144148.13052-1-yuehaibing@huawei.com>

On Wed, Aug 09, 2023 at 10:41:48PM +0800, Yue Haibing wrote:
> rds_tcp_map_seq() is never implemented and used since
> commit 70041088e3b9 ("RDS: Add TCP transport to RDS").
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

BTW, I think these rds patches could have been rolled-up
into a patch-set, or perhaps better still squashed into a single patch.


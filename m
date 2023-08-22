Return-Path: <netdev+bounces-29536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF6B783AEF
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4191C20A60
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 07:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EC279C3;
	Tue, 22 Aug 2023 07:31:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD19748E
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 07:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D35C433C7;
	Tue, 22 Aug 2023 07:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692689494;
	bh=69ppbmhyjKqNsHDR6INC1NWAMN6c620Fp921v9/rBcI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zka6jsqtuk8eNQp7rbaUR1/g+2c1p2DVFG4Flg8jCmz65kSiCqBm9JVrsdZpoNQ5e
	 Ln8BMNES2Mgcm9j1szeHwdOZpY6zRvmWpmxgoHQ/7zbHPVYbvLtOv5iP2EHeIqAHfP
	 ORoTY2yPY5088gX3Vjp+uW4Ag70b41zine23eGJFt0S5JvGdzKF660lxGtMTgPnUfm
	 qBXo8SSgsg4NgNiRG0FsADIy65ytb+hL5+m1Cvn2NZKzq+Ke9zFLqjId69xs6/Skjz
	 V3f75ma+podibBnZqGf/SmSjIaYwbi8ILKAAq5jkYTijkR80l7CPr/B62+myMt2U0V
	 u7QMshFHWZeAQ==
Message-ID: <16b706ba-f755-d16d-3fea-bb0946a4c460@kernel.org>
Date: Tue, 22 Aug 2023 10:31:30 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next] net: ethernet: ti: Remove unused declarations
Content-Language: en-US
To: Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org
References: <20230821134029.40084-1-yuehaibing@huawei.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230821134029.40084-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/08/2023 16:40, Yue Haibing wrote:
> Commit e8609e69470f ("net: ethernet: ti: am65-cpsw: Convert to PHYLINK")
> removed am65_cpsw_nuss_adjust_link() but not its declaration.
> Commit 84640e27f230 ("net: netcp: Add Keystone NetCP core ethernet driver")
> declared but never implemented netcp_device_find_module().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Acked-by: Roger Quadros <rogerq@kernel.org>


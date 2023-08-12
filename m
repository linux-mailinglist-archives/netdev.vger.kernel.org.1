Return-Path: <netdev+bounces-27045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DB777A032
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 15:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73041C208D2
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 13:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD057485;
	Sat, 12 Aug 2023 13:46:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFCC7483
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 13:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B62DC433C8;
	Sat, 12 Aug 2023 13:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691848007;
	bh=FF19mRP9MCnqBmcE1/PThUv5SqaymEY1w30r5hJqrrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rD347akMUJagmLChtJkZ1WvfXiRN4Cm2AVyQXxOjWdl6G5ijCbuTtZtlZMEBfGmrY
	 TpcagMa2zMldidEu8xD9CcX3PiSgCPVrC5TLcEVEu0yDmA83Pwub7hPj97jm6+i0yJ
	 oV2lCD5FKtgzPLXDlO2DQqVA5ntasxPE0qYz/XPJSo9UE+TViLTbkGl2hB12PthUzU
	 lt9+Iz4LaaU+zPX2WneF130/eKBnF0V09iuq+NfbaWAfqlb6wptxVeyikC5GCrIug4
	 lJM6uVHJF2EevLD3Hcx/BstmtMvcJPQWnX6qjoIYrtav4rJJoNYHyIX4E2iZg7wgvt
	 QV6cFP63NLD2Q==
Date: Sat, 12 Aug 2023 15:46:43 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: e1000: Remove unused declarations
Message-ID: <ZNeNQ5tAefTj3JQl@vergenet.net>
References: <20230811105005.7692-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811105005.7692-1-yuehaibing@huawei.com>

On Fri, Aug 11, 2023 at 06:50:05PM +0800, Yue Haibing wrote:
> Commit 675ad47375c7 ("e1000: Use netdev_<level>, pr_<level> and dev_<level>")
> declared but never implemented e1000_get_hw_dev_name().
> Commit 1532ecea1deb ("e1000: drop dead pcie code from e1000")
> removed e1000_check_mng_mode()/e1000_blink_led_start() but not the declarations.
> Commit c46b59b241ec ("e1000: Remove unused function e1000_mta_set.")
> removed e1000_mta_set() but not its declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>



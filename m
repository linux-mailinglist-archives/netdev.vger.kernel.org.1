Return-Path: <netdev+bounces-134557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A714899A143
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 12:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6DDA1C2217B
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 10:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A2F212D1F;
	Fri, 11 Oct 2024 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tUOMCz8K"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34B6212D05;
	Fri, 11 Oct 2024 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642340; cv=none; b=MJMGMxrIqFS4afrgzf9rly0TJOuuDDL149ToDvUnqoWcD+UsxsxHvHucYYl2sgmjy9b/soZN2L/EEbDfwOeEiuXpMO6bnypmMN4xXElRrEeTrwvGsUcLYgMLNP6ttsn4v32jSmXQnIoi6Xn25kVzrNnnkaz2yYzNHG7lpZWUKw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642340; c=relaxed/simple;
	bh=84PyWdJ+V+0LklCBHXvfsuKuuW6qmdCDG15cFiw34fM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVrlUjoPuaC8wKysqmw3UmqcZb25oGbM2xJ/7qXp7ua+1QJGZIRbfLVhKiJTBE7o64OSYc9rVMNHg/j+EQzV/rbrxenbDyl8ZeWVFYNyfuOSCmd8sNpoaAyhH2q/CokXUurnVlKR2WrCGYVWtHLkz9JGhbx5JJBnAyAXgkWsVGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tUOMCz8K; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728642338; x=1760178338;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=84PyWdJ+V+0LklCBHXvfsuKuuW6qmdCDG15cFiw34fM=;
  b=tUOMCz8Kkh48phocy+cPegCpkXonJmcGapY1XRTMEmcNzrOeX97XiFeB
   g+QEg6QdyqX8F78X2DqraBzdpqtrk4yUrtnDL4LJt4AANCU1qin4+pIIg
   AU0zmSJPuapCfgb/cfZd2PyV3iE6Y/N+kzNrnVrOkogxMi/gEpKp6rn0I
   3huNzmW6h9mqVX8RE4yW3h+jNF7k8PFDhqZSSD7UtkUs0HIg8VxgqfkBv
   EVbhWy4I3qXySarZeM+F8uLwnn6NGIGWJDociRXZ9MN0pelObHxvLRpO8
   2Ki8swpfi3yAEvYvGY0Piu+SSxUzgBj1/myt2m1j4CSrqhKVH+6Ys/BFf
   w==;
X-CSE-ConnectionGUID: fmQRpgTGScuNRcBtlvkuqg==
X-CSE-MsgGUID: pf0RlI/uQMKmHRI6njKSjA==
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="200324178"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Oct 2024 03:25:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 11 Oct 2024 03:25:01 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 11 Oct 2024 03:24:59 -0700
Date: Fri, 11 Oct 2024 10:24:59 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
CC: <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jensemil.schulzostergaard@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: microchip: vcap api: Fix memory leaks in
 vcap_api_encode_rule_test()
Message-ID: <20241011102459.zxmegrcro2tv6b46@DEN-DL-M70577>
References: <20241010130231.3151896-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241010130231.3151896-1-ruanjinjie@huawei.com>

> Cc: stable@vger.kernel.org
> Fixes: a3c1e45156ad ("net: microchip: vcap: Fix use-after-free error in kunit test")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
> index f2a5a36fdacd..7251121ab196 100644
> --- a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
> +++ b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
> @@ -1444,6 +1444,8 @@ static void vcap_api_encode_rule_test(struct kunit *test)
> 
>         ret = vcap_del_rule(&test_vctrl, &test_netdev, id);
>         KUNIT_EXPECT_EQ(test, 0, ret);
> +
> +       vcap_free_rule(rule);
>  }

Wait, should vcap_del_rule not handle the freeing of the rule?
Maybe Emil can shed some light on this..

/Daniel

> 
>  static void vcap_api_set_rule_counter_test(struct kunit *test)
> --
> 2.34.1
> 


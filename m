Return-Path: <netdev+bounces-116714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2E194B6C7
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 08:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D3B285618
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 06:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392DD187858;
	Thu,  8 Aug 2024 06:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="tKFv5GZ9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE61D18785B;
	Thu,  8 Aug 2024 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723098758; cv=none; b=W5ANI5oYW4qRX1DCSkOPIKQ6wlau99zhG2YwcwCbr2m2JjnyhOLrkfIpzhVP92qeB0mjHRgDxp/iz3elxwVfnf7Un2TzdFGhBfTG/ilcPDmWS0rCEsjdeqynju56ty53hcvFYXNlyG8FGR8LFlUOyMkUpVgJgszxZQZYmyMTXtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723098758; c=relaxed/simple;
	bh=33jPo4vhPLqsyySaNcevP8gg0qfJrI7Z546GA/oleCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hivNTXgxC3d/kwaE/jQmoYen18w67SnykTR71YtdQRMv6ZtyCcH6l3JVhP/jcZcGkxBcvtRt5gxZsRJkQoghTzHkXi0BRi3lGq1YFdd5q43+km+WspseUHqRSozM9wGCg2J5ys4vxAC4KHVMqYKNpqZn9zc7PHE7uXoe+BQ3we4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=tKFv5GZ9; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id bwhJsmEy4IDadbwhJsi83k; Thu, 08 Aug 2024 08:32:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1723098752;
	bh=9n2P6IRzAGh+cFhbPIBM2pmgk2vAQEV42VzZZngjGKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=tKFv5GZ9se01NVzobXg1CwuAfRk9fH18mUG17VqbjiuKidda2BJLc6Y3ap6VAw4hI
	 zlltn8hguaRyrMEyThFHbFjqFulRaTXhG1lrEM3+/oimhD2tl24WwZ5rn+dnn0BIkW
	 yMuXJfsTNQjilOhdVkenTm4PEy77Jt6JCCf0EQYdTYFpGTPpG8uEOcYGdOR8+oT8EK
	 4apQoVvl3saELTcYAKs+Nl00vgcId9t+xuZ9sQ0OTJtip2AOThmmn4Ets0psM9nS0I
	 DpiL+9imtzqXyYP30X3AzBW83LByx0D0UnZjWyjOZbpKamCgPX6zoO67CamoIxIMbl
	 QgWv66utheizg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Thu, 08 Aug 2024 08:32:32 +0200
X-ME-IP: 90.11.132.44
Message-ID: <733a8111-5e7a-41fe-b01b-75d8190fa752@wanadoo.fr>
Date: Thu, 8 Aug 2024 08:32:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ibm/emac: Constify struct mii_phy_def
To: kernel test robot <lkp@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <dfc7876d660d700a840e64c35de0a6519e117539.1723031352.git.christophe.jaillet@wanadoo.fr>
 <202408080631.rKnoa41D-lkp@intel.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <202408080631.rKnoa41D-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/08/2024 à 01:00, kernel test robot a écrit :
> Hi Christophe,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-JAILLET/net-ibm-emac-Constify-struct-mii_phy_def/20240807-195146
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/dfc7876d660d700a840e64c35de0a6519e117539.1723031352.git.christophe.jaillet%40wanadoo.fr
> patch subject: [PATCH net-next] net: ibm/emac: Constify struct mii_phy_def
> config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20240808/202408080631.rKnoa41D-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240808/202408080631.rKnoa41D-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408080631.rKnoa41D-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     drivers/net/ethernet/ibm/emac/core.c: In function 'emac_dt_phy_connect':
>>> drivers/net/ethernet/ibm/emac/core.c:2648:30: error: assignment of member 'phy_id' in read-only object
>      2648 |         dev->phy.def->phy_id = dev->phy_dev->drv->phy_id;
>           |                              ^
>>> drivers/net/ethernet/ibm/emac/core.c:2649:35: error: assignment of member 'phy_id_mask' in read-only object
>      2649 |         dev->phy.def->phy_id_mask = dev->phy_dev->drv->phy_id_mask;
>           |                                   ^
>>> drivers/net/ethernet/ibm/emac/core.c:2650:28: error: assignment of member 'name' in read-only object
>      2650 |         dev->phy.def->name = dev->phy_dev->drv->name;
>           |                            ^
>>> drivers/net/ethernet/ibm/emac/core.c:2651:27: error: assignment of member 'ops' in read-only object
>      2651 |         dev->phy.def->ops = &emac_dt_mdio_phy_ops;
>           |                           ^
>     drivers/net/ethernet/ibm/emac/core.c: In function 'emac_init_phy':
>>> drivers/net/ethernet/ibm/emac/core.c:2818:32: error: assignment of member 'features' in read-only object
>      2818 |         dev->phy.def->features &= ~dev->phy_feat_exc;
>           |                                ^~
> 
> 

Ouch,

I missed the depends on PPC_DCR.

I did:
    - make -j8 drivers/net/ethernet/ibm/emac/phy.o
then
    - make -j8 drivers/net/ethernet/ibm/emac/

but the later does not build anything on x86, and I missed that.

CJ



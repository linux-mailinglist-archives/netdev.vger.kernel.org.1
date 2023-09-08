Return-Path: <netdev+bounces-32539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727EF798383
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 09:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5275A1C20BBE
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 07:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29CA1C03;
	Fri,  8 Sep 2023 07:48:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978471867
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 07:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9A3C433C9;
	Fri,  8 Sep 2023 07:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694159324;
	bh=Va9oW2IS2vwCCdtwShgla+tG9l24+uA44GRCVlSILF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M8Z/5JHrtwOUerhCcbTEW3SjhxuaF3Q337pc/PK4flGfuXERJeE/gadHGk/1mDJsm
	 P/xoRzFmBSIWoKIqJEPaEHoMKi2no/bxgAcm7frGSVNOiZvndGFHBcp5r5QBpglH5o
	 BUGvk/8B6h8nAeM7RpyTAFVzQ8GvQIVdzNp8vz6uQUxXk+HlMrM5LrQ+apjLAilKyk
	 SiNk3MngsLHjnJgnew36htD3cF2YnsAE238KehotFRJxWRyQbayNxBr1wMOBskkiet
	 vxaz8HBvltZMbxm9sPZnRyQbbZb3OFI2I8cUGPLXVH0gAAC2H5sNnHkQakxFNMvDmc
	 JmkOXKGaRABdA==
Date: Fri, 8 Sep 2023 09:48:39 +0200
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Lars Povlsen <lars.povlsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net: microchip: sparx5: clean up error checking
 in vcap_show_admin()
Message-ID: <20230908074839.GL434333@kernel.org>
References: <b88eba86-9488-4749-a896-7c7050132e7b@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b88eba86-9488-4749-a896-7c7050132e7b@moroto.mountain>

On Fri, Sep 08, 2023 at 10:03:37AM +0300, Dan Carpenter wrote:
> The vcap_decode_rule() never returns NULL.  There is no need to check
> for that.  This code assumes that if it did return NULL we should
> end abruptly and return success.  It is confusing.  Fix the check to
> just be if (IS_ERR()) instead of if (IS_ERR_OR_NULL()).
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202309070831.hTvj9ekP-lkp@intel.com/
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> This bug is old, but it doesn't affect runtime so it should go to
> net-next.

Reviewed-by: Simon Horman <horms@kernel.org>


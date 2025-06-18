Return-Path: <netdev+bounces-198990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C10ADE970
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 12:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F356217CBC0
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 10:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936612857C9;
	Wed, 18 Jun 2025 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFa+ZqoG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686D228507D;
	Wed, 18 Jun 2025 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750244144; cv=none; b=S5cJ0aJbWZ5FYUt/aPN/83YbxvnJos0khZXZABU0XDdVEukGfItdWWwTPcgy6GxeUQ+dwLhXeT8NGLx0PdkiT7jVUh2pJ75Pt1dAsT7oQIujeFae/wPb42j8hilbIPHTHzfZVuo5PB5KPej6hWjhlFAognIrATbgAtEEkvxFimQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750244144; c=relaxed/simple;
	bh=asXYdfFJiq+b7XQecocsnrjgeAEcAgVBqs/vSSh5q/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrcydMqqIWFmADr0sb3KM6Id0wSmV5KPa1+hVNg1JRQiyu0086Errd82gYL5tIwXHCKV39MAZj69YXHY40uQ66npesFhCMgvL++KgtBcOLs5gfxV1XKFdAm/Rc1ScDRX/VeLSr35bOpp9GdEOvD7VjoUk9IoPq2lSAcYfY0gwMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFa+ZqoG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29618C4CEE7;
	Wed, 18 Jun 2025 10:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750244144;
	bh=asXYdfFJiq+b7XQecocsnrjgeAEcAgVBqs/vSSh5q/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tFa+ZqoGu+qwaz7xKVtOXspuKBszKHFmBk7d/y9XM4nvOfB9q2bVvlabiU45xJc9C
	 yumgToewJX8cPrOveY1gcqhdsYzZAAWwuhvZhUVDfDWIolY4XVIook2Fz0tyV0+SHc
	 FdJSzS6OyMENBdalKl+vsZhRzjNfZQ62LS8Q3aNgMy2e1yZqHxf75tq5Y0kOVkss4S
	 93PS6IcWuKgyNMwYEuTt0w8A7rfor2vHf3wnWv/FeV3AxMSbBipSscdkVDEiyz1RMT
	 RD71nO/1PgZhpnnrk9VSCy276jwlPHqcqIveD2osEQcKbHHZHleRLYtk8HButmBj0V
	 j3Aqf2PN9EbVw==
Date: Wed, 18 Jun 2025 11:55:39 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.swiatkowski@linux.intel.com
Subject: Re: [PATCH V2 net-next 1/8] net: hns3: fix spelling mistake "reg_um"
 -> "reg_num"
Message-ID: <20250618105539.GG1699@horms.kernel.org>
References: <20250617010255.1183069-1-shaojijie@huawei.com>
 <20250617010255.1183069-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617010255.1183069-2-shaojijie@huawei.com>

On Tue, Jun 17, 2025 at 09:02:48AM +0800, Jijie Shao wrote:
> There are spelling mistakes in hclgevf_get_regs. Fix them.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>



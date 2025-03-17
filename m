Return-Path: <netdev+bounces-175394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD4FA65A15
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFFD21655CE
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D537206F04;
	Mon, 17 Mar 2025 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SY0IIE2j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659C12066F6
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231316; cv=none; b=k4t6JQhyH3/I4bKYhXEbeiJZ1nx4qvi6BwNG/r5y96o5pNik/pKBjR5CTH3EPqF+ANWSisf94V6VIr0G4v8dl8UScGMY1prAF0ukx1UmrHuP1e58H0ucNiznf7LLDzBTHUiq/pgiUS4tBdbC/jow6k1jca5ELC0SpP8CcFUek7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231316; c=relaxed/simple;
	bh=oKO4tuswfnZR47mN4xY+H18wafBuPz+lVK3hmfM9zRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqlSJ34ggI99lV4v6Y5sc3iPlVck6dz1teK0RJc0DBX+oIuQtrbcPx9XtleFQPnIXnxpZfJVAPxwS+2iCIwkO/V3duJr80cxUbSm+29UBkSU00KYec45NSsgjoXKGL1bkPXpuDlUYJxgGJNe0D1KT5q9rnUOhLcMHNBSPe/8eNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SY0IIE2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B142AC4CEE3;
	Mon, 17 Mar 2025 17:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742231315;
	bh=oKO4tuswfnZR47mN4xY+H18wafBuPz+lVK3hmfM9zRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SY0IIE2jTl3jt2h2dkEZu3ykGEcUg6NcThYZhDFObY6nY3rDrKvZyKkh9Wf614T/l
	 6zaxSHAsfTxU62IvsvbIZOvY+9AgRdwfZeK6/JZp5keRLVEbsz5nbfPl0fXbq7rbzZ
	 JiX7gM1FnRS1bMZThzrGEfR0gOADApcEO3gDpZOTNxL7R3UNmUxzw9ztSl1mWOClhL
	 qUrG83ubhdeaaDf/1hkjgqW7Kv3GyD9QebnAksJQYIGEe2PZBO3JcHWWuWD2GY/rrp
	 6YqyhJIE/rFGzXghG0zKi9vCmmcBVigstytXfTnHunId6YK4pWmuRiCVSDNm13Fh+d
	 s4BnrYBhj8Jog==
Date: Mon, 17 Mar 2025 17:08:32 +0000
From: Simon Horman <horms@kernel.org>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v8 2/6] net: libwx: Add sriov api for wangxun
 nics
Message-ID: <20250317170832.GG688833@kernel.org>
References: <20250309154252.79234-1-mengyuanlou@net-swift.com>
 <20250309154252.79234-3-mengyuanlou@net-swift.com>
 <20250316132204.GB4159220@kernel.org>
 <6B4E9B01-A3CF-4860-8A38-229AC8AA07B5@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6B4E9B01-A3CF-4860-8A38-229AC8AA07B5@net-swift.com>

On Mon, Mar 17, 2025 at 02:34:40PM +0800, mengyuanlou@net-swift.com wrote:
> 
> 
> > 2025年3月16日 21:22，Simon Horman <horms@kernel.org> 写道：
> > 
> > On Sun, Mar 09, 2025 at 11:42:48PM +0800, Mengyuan Lou wrote:
> >> Implement sriov_configure interface for wangxun nics in libwx.
> >> Enable VT mode and initialize vf control structure, when sriov
> >> is enabled. Do not be allowed to disable sriov when vfs are
> >> assigned.
> >> 
> >> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> > 
> > ...
> > 
> >> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> >> new file mode 100644
> >> index 000000000000..2392df341ad1
> >> --- /dev/null
> >> +++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> >> @@ -0,0 +1,201 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
> >> +
> >> +#include <linux/etherdevice.h>
> >> +#include <linux/pci.h>
> >> +
> >> +#include "wx_type.h"
> >> +#include "wx_mbx.h"
> >> +#include "wx_sriov.h"
> >> +
> >> +static void wx_vf_configuration(struct pci_dev *pdev, int event_mask)
> >> +{
> >> + unsigned int vfn = (event_mask & GENMASK(5, 0));
> >> + struct wx *wx = pci_get_drvdata(pdev);
> >> +
> >> + bool enable = ((event_mask & BIT(31)) != 0);
> > 
> > Sorry to nit-pick, and I'd be happy for this to be addressed as a
> > follow-up, but I think that it would be nice to:
> > 
> > 1. Both use some #defines and FIELD_GET() for the masking above.
> > 
> > 2. Use !! in place of != 0
> 
> #define VF_ENABLE_CHECK(_m) FIELD_GET(BIT(31), (_m))
> 
> bool enable = !!VF_ENABLE_CHECK(event_mask);
> 
> Is that the way to do it?

Thanks, I think that would work.

> 
> 
> > 
> > 3. Arrange local variable declarations in reverse xmas tree order.
> > 
> 
> 
> 
> >> +
> >> + if (enable)
> >> + eth_zero_addr(wx->vfinfo[vfn].vf_mac_addr);
> >> +}
> > 
> > ...
> > 
> > 
> 


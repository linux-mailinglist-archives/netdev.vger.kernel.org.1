Return-Path: <netdev+bounces-199465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DC3AE064B
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1ABB1887DEB
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522C52405EC;
	Thu, 19 Jun 2025 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bn3edj+6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2945923D2BC;
	Thu, 19 Jun 2025 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750337699; cv=none; b=iF1GrgUhHwPbSegpkAjS34pHWH3xiNfA1cyqUHotYqCbWfwbIbPbMo2df9l2+dhj70P7CvYjLawCmTcvZhVewljvOQO8Yrr7yzqBypBuSfvi9rfra+NmH6uL0wbdcE5SLX5y9XKbjSL/FD6sN1BfbSK4TYuKLSDzpPXepzTuCVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750337699; c=relaxed/simple;
	bh=Q2TfR27+HT+MuaAj4Qq6BTNKXQ10gAa+TydcGUZlr90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emHVn9Pd6bRnh2OPQiL1FDmP8hdgZTjGcS9y/UaEGgncww3nZu5hDRQ9DKkuh2mdm9ggfKLXO+N03nsSJvpwObaam+qVj6+P99fG83gq62Axqd/LNx+9FDpH86cLu8RnwCSolep73ZRfPILwguB+vEc5MN0i6mw3pN7kJGp3fbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bn3edj+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBAFC4CEEA;
	Thu, 19 Jun 2025 12:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750337698;
	bh=Q2TfR27+HT+MuaAj4Qq6BTNKXQ10gAa+TydcGUZlr90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bn3edj+664eT1HDnqAyxKcA2vyuPPYgiZaJ+om2m4n63KdGjwf9z3mqZFNpIPnqJB
	 LeBh81UxQ5beiCOF7wIxi/KApZuKe6NMcs4IUvfxmPlNJxF0rfXG3MSabImu1yR7V1
	 npPQMIdhdlBWHqH65bcj/VFRz5AvP9WaUkoBAdjKINBcaTga0JpJMhs7XaoV15SaJK
	 BNdE2ogdrpBpbM2jFPMhP27W58O2CXB6s/lX7e1GMj/hsvXRw+IJeDxqww3n+th3cy
	 mUwyodIyBQqC1s6Y2kiZI39s0QK+lUuJuD/lnf59QNJT206yZ9CWBHT4ZcGH0W6Xmg
	 S5feFKnG08/yQ==
Date: Thu, 19 Jun 2025 13:54:53 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.swiatkowski@linux.intel.com
Subject: Re: [PATCH V2 net-next 8/8] net: hns3: clear hns alarm: comparison
 of integer expressions of different signedness
Message-ID: <20250619125453.GO1699@horms.kernel.org>
References: <20250617010255.1183069-1-shaojijie@huawei.com>
 <20250617010255.1183069-9-shaojijie@huawei.com>
 <20250618112924.GL1699@horms.kernel.org>
 <5a23d321-307a-4f4a-a2cf-9c8dcf001dbb@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a23d321-307a-4f4a-a2cf-9c8dcf001dbb@huawei.com>

On Thu, Jun 19, 2025 at 07:59:07PM +0800, Jijie Shao wrote:
> 
> on 2025/6/18 19:29, Simon Horman wrote:
> > On Tue, Jun 17, 2025 at 09:02:55AM +0800, Jijie Shao wrote:
> > > From: Peiyang Wang <wangpeiyang1@huawei.com>
> > > 
> > > A static alarm exists in the hns and needs to be cleared.
> > I'm curious to know if you used a tool to flag this.
> 
> Sorry, the last reply was not cc to netdev...
> 
> Some internal tools, and then there are the compiler options, such as -Wsign-compare.
> 
> > 
> > > The alarm is comparison of integer expressions of different
> > > signedness including 's64' and 'long unsigned int',
> > > 'int' and 'long unsigned int', 'u32' and 'int',
> > > 'int' and 'unsigned int'.
> > > 
> > > Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
> > > Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> > > ---
> > >   .../hns3/hns3_common/hclge_comm_cmd.c         |  2 +-
> > >   .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 22 +++++++-------
> > >   .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  2 +-
> > >   .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  4 +--
> > >   .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 13 ++++----
> > >   .../hisilicon/hns3/hns3pf/hclge_main.c        | 30 +++++++++----------
> > >   .../hisilicon/hns3/hns3pf/hclge_mbx.c         |  7 +++--
> > >   .../hisilicon/hns3/hns3pf/hclge_mdio.c        |  2 +-
> > >   .../hisilicon/hns3/hns3pf/hclge_ptp.h         |  2 +-
> > >   .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  2 +-
> > >   .../hisilicon/hns3/hns3vf/hclgevf_mbx.c       |  2 +-
> > >   11 files changed, 44 insertions(+), 44 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
> > > index 4ad4e8ab2f1f..37396ca4ecfc 100644
> > > --- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
> > > +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
> > > @@ -348,7 +348,7 @@ static int hclge_comm_cmd_csq_clean(struct hclge_comm_hw *hw)
> > >   static int hclge_comm_cmd_csq_done(struct hclge_comm_hw *hw)
> > >   {
> > >   	u32 head = hclge_comm_read_dev(hw, HCLGE_COMM_NIC_CSQ_HEAD_REG);
> > > -	return head == hw->cmq.csq.next_to_use;
> > > +	return head == (u32)hw->cmq.csq.next_to_use;
> > Can the type of next_to_use be changed to an unsigned type?
> > It would be nice to avoid casts.
> 
> Today I plan to modify the next_to_use type,
> but I found that if next_to_use is changed to u32,
> it will cause many other places to need to synchronously change the variable type.
> At a glance, there are dozens of places.
> 
> Therefore, I am considering whether this part can remain unchanged.

Thanks for checking.

Based on the above I'd say it can remain unchanged.
It improves things. And leaves room for further improvements later.


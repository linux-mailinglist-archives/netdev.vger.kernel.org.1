Return-Path: <netdev+bounces-19002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F2D759483
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3BDE280DA8
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E430C13ADB;
	Wed, 19 Jul 2023 11:42:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907F2134A5;
	Wed, 19 Jul 2023 11:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3D1C433C7;
	Wed, 19 Jul 2023 11:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689766943;
	bh=wPRMqbpbLUGy3uCjIzFDHysaD/lX8t+s8gaE2CHN+uQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bXWkr6yyQPPbZ1rOXq5/QjUQz1j3giLABh26cCfhh5RRcADgmXpLqKdx6JXnVrscf
	 yTexG6yrL0z1t1ulOjO3C4ZUkqRJsjLO4wJZKDgopoxeqybJzNjsTqWOHqZRKeQVhG
	 RotmvRNeTvtPReViEohETLDXmXSDJChCj4jOmyo9YezWoaKD/l57/0z2mwn7zp+m4s
	 YP0EjW3m3YpKyNqd2l2yV0mlZzN0pjMvgf/sE89lpM0IlLv78rWAhz77VThRdQmWQI
	 yARd2dTevEcb+T6fuoahaUYIvSQ5RbKUoLu+UNDaCb/7BezmnJ9JS4SXlhGzw11ORB
	 ehqFuM01CIKbg==
Date: Wed, 19 Jul 2023 17:12:07 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Vivek Pernamitta <quic_vpernami@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	mhi@lists.linux.dev, mrana@quicinc.com, quic_qianyu@quicinc.com,
	quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
	quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] net: mhi : Add support to enable ethernet interface
Message-ID: <20230719114207.GC9312@thinkpad>
References: <1689660928-12092-1-git-send-email-quic_vpernami@quicinc.com>
 <20230718124334.GG4771@thinkpad>
 <350d577a-f0b3-1f20-9c35-356355a9aa8e@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <350d577a-f0b3-1f20-9c35-356355a9aa8e@quicinc.com>

On Wed, Jul 19, 2023 at 04:08:37PM +0530, Vivek Pernamitta wrote:
> 
> Currently MHI NET driver does not support Ethernet interface,
> 

Please do not top post. Read: https://people.kernel.org/tglx/notes-about-netiquette-qw89

> we are adding Ethernet interface support to MHI NET driver, so new client
> can be configured to be Ethernet type over MHI by setting
> "mhi_device_info.ethernet_if = true"
> 

Which is the new client you are referring to?

> currently we are not changing mhi_swip0/mhi_hwip0 to Ethernet. we are adding
> an provision to configure mhi client as  Ethernet type.
> 

If there are no users of the said provision, then it should not be added now.
You can only add interfaces to kernel if there is atleast one user.

- Mani

> 
> On 7/18/2023 6:13 PM, Manivannan Sadhasivam wrote:
> > On Tue, Jul 18, 2023 at 11:45:28AM +0530, Vivek Pernamitta wrote:
> > > Add support to enable ethernet interface for MHI SWIP channels.
> > > 
> > Please add more info in the commit message i.e., why this interface is added and
> > how it is going to benefit the users etc..
> > 
> > Since you are modifying the existing mhi_swip interface, this isn't an ABI
> > change?
> > 
> > > Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
> > > Reviewed-by: Daniele Palmas <dnlplm@gmail.com>
> > > Reviewed-by: Simon Horman <simon.horman@corigine.com>
> > > ---
> > > 
> > > changes since v1:
> > > 	- Moved to net-next from linux-next	
> > > 	- moved to eth_hw_addr_random() to assign Ethernet MAC address
> > > 	  from eth_random_addr()
> > > ---
> > >   drivers/net/mhi_net.c | 53 ++++++++++++++++++++++++++++++++++++++-------------
> > >   1 file changed, 40 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
> > > index 3d322ac..5bb8d99 100644
> > > --- a/drivers/net/mhi_net.c
> > > +++ b/drivers/net/mhi_net.c
> > [...]
> > 
> > > @@ -380,10 +405,12 @@ static void mhi_net_remove(struct mhi_device *mhi_dev)
> > >   static const struct mhi_device_info mhi_hwip0 = {
> > >   	.netname = "mhi_hwip%d",
> > > +	.ethernet_if = false,
> > >   };
> > >   static const struct mhi_device_info mhi_swip0 = {
> > >   	.netname = "mhi_swip%d",
> > > +	.ethernet_if = false,
> > false?
> yes ,it is false as by default mhi_swip/mhi_hwip interface will be normal
> net device.
> > 
> > - Mani
> > 
> > >   };
> > >   static const struct mhi_device_id mhi_net_id_table[] = {
> > > -- 
> > > 2.7.4
> > > 

-- 
மணிவண்ணன் சதாசிவம்


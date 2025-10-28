Return-Path: <netdev+bounces-233532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD37AC151D2
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4C5B33522EB
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 14:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C781D334694;
	Tue, 28 Oct 2025 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cPi08xVB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E871332ECA;
	Tue, 28 Oct 2025 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661117; cv=none; b=Hv928QZJd+HdxmbyTpvl5C33cbTeSdmELTsDdKv26JH/TeC3TAde2wDd6Kk0j2RBZTqTpEjLb1kYtIq62QYJgVRn0/i9V8/9wWDPjjIKfxyArALnD31uakPXHFXxp9ta7WNexn+pGaBcadG9lHRFHdhLK+7tjXiRMhk4NdLbLws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661117; c=relaxed/simple;
	bh=wwu4MvbyxId52W+97dHRQsXV89xBJOA8SKgpklBi0hg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6mhG/vcB8Lo5z9doTKI9/lUP8Pa+lS4y3PdrmxX6RZ2hiTyiusDin8//pGWIg6fXzHp/yvBQZGh4pb7xSumgcbWq+YH2EcY2/pSGzRxOqczb+Wg5kRW6ZYdaxIP7sP2loSkbL6WJIrY8c2o4FZrWGh2ktNbP81ZkXbaN6Kjc8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cPi08xVB; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SDrMBN1220595;
	Tue, 28 Oct 2025 07:17:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=rQfMy9WF/+BRJ3Qj7JkE+xbTQ
	gsR384RMCrGwcO45lE=; b=cPi08xVBOqYQDULvgsJKGdlEL3ZTlK2BNRTyInUT+
	xN768/smzsXTSLoc1uXoFti8l536Rvk2LsTTs6C145k5OV77Fx/OZT4oA5wExHdo
	8Kf4xhKy0ewB0kg+lq15NrEZFVdxnRhU6wS5BdhAq6OGU39ejHI0yeyGd07LNCZX
	Z8pnCOLqjhlhvYu8EQrqGr62Dhvl+1MEV4ljsoLxXD+Hqyhmj+xDUB9KTCPvtHFU
	X7dRkHRWkCucK5Xt4Ig1mq9pJ0hfoh316li4q37KCnQDGXi1WR5XmxuQRD8WWxrz
	e6DHzVgCFtGH+8kr5wpAKq6pZOuw+iWOXcawkEd9lbXSQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a2ttbh7c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 07:17:51 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 28 Oct 2025 07:17:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 28 Oct 2025 07:17:42 -0700
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id 81D883F7106;
	Tue, 28 Oct 2025 07:17:37 -0700 (PDT)
Date: Tue, 28 Oct 2025 19:47:36 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "Andrew Lunn" <andrew+netdev@lunn.ch>,
        Kory Maincent
	<kory.maincent@bootlin.com>,
        "Gal Pressman" <gal@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Breno Leitao
	<leitao@debian.org>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [RFC net-next] net: loopback: Extend netdev features with new
 loopback modes
Message-ID: <aQDQgBMp0R/RM0r4@test-OptiPlex-Tower-Plus-7010>
References: <20251024044849.1098222-1-hkelam@marvell.com>
 <e9aa0470-2bd2-4825-8333-ad9dbc7f40a0@bootlin.com>
 <aPtCrc6EPpn_hcYp@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aPtCrc6EPpn_hcYp@pengutronix.de>
X-Proofpoint-GUID: sGkdFMRTVOZvTo_B3N3qp0IQx2niEgT8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDExOSBTYWx0ZWRfX7HxRL27vY+jV
 MqgwHe2jrnWgsmhjMMv4eIphHaXfEsyS19YTjOhATjavULg/Zn/sXED+w2+/6Q454BYDSfE3Vqm
 Nal/NNK5AA7o1jxJjqFaoz6GpNCHBMZ9Q7HbpyU6ppc5eF3zg8KmmMaJJIpk65adxmJwPVgx19Y
 J3UUBRDZNN5/h5FqKqX74NgGd0oT++Sk0/wqhf4kI1i5C3uxDmkeB5femkRdIgt+r1iDvrxhacm
 jNHPfNHagSWc7/t2RvEuCz/FPy7PeNeXO6K0IpGRoI63W62GgG9euPVjdNiouhJJaIP/+6IQ10p
 zIBIoCwWVpI0LQDp8SKA6I1sC3+FN8Pwb0zw7xgVgIA/WuGRqT4d2sgxtdj2xTgVlAQPD8KQ0WC
 1T+mqhVf74VArQ4d5wZso3Zz3X0tLQ==
X-Authority-Analysis: v=2.4 cv=Ffk6BZ+6 c=1 sm=1 tr=0 ts=6900d08f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Y3b2rdwmGPljBhKwXEkA:9 a=CjuIK1q_8ugA:10 a=HhbK4dLum7pmb74im6QT:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-ORIG-GUID: sGkdFMRTVOZvTo_B3N3qp0IQx2niEgT8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_05,2025-10-22_01,2025-03-28_01

On 2025-10-24 at 14:41:09, Oleksij Rempel (o.rempel@pengutronix.de) wrote:
> On Fri, Oct 24, 2025 at 10:46:14AM +0200, Maxime Chevallier wrote:
> > Hi,
> > 
> > +Russell +Oleksij
> > 
> > On 24/10/2025 06:48, Hariprasad Kelam wrote:
> > > This patch enhances loopback support by exposing new loopback modes
> > > (e.g., MAC, SERDES) to userspace. These new modes are added extension
> > > to the existing netdev features.
> > > 
> > > This allows users to select the loopback at specific layer.
> > > 
> > > Below are new modes added:
> > > 
> > > MAC near end loopback
> > > 
> > > MAC far end loopback
> > > 
> > > SERDES loopback
> > > 
> > > Depending on the feedback will submit ethtool changes.
> > 
> > Good to see you're willing to tackle this work. However as Eric says,
> > I don't think the netdev_features is the right place for this :
> >  - These 3 loopback modes here may not be enough for some plaforms
> >  - This eludes all PHY-side and PCS-side loopback modes that we could
> >    also use.
> > 
> > If we want to expose these loopback modes to userspace, we may actually
> > need a dedicated ethtool netlink command for loopback configuration and
> > control. This could then hit netdev ethtool ops or phy_device ethtool
> > ops depending on the selected loopback point.
> > 
> > If you don't want to deal with the whole complexity of PHY loopback, you
> > can for now only hook into a newly introduced netdev ethtool ops dedicated
> > to loopback on the ethnl side, but keep the door open for PHY-side
> > loopback later on.

> Ack, I agree. I would be better to have information and configuration
> for all loopbacks in one place.
> Will it be possible to reflect the chain of components and level of
> related loopbacks? I guess, at least each driver would be able to know
> own loopback levels/order.
> 
> Please add me in CC if you decide to jump in to this rabbit hole :D
> 
    ACK, will define new ethtool ops for loopback as a first step.
 Will try to add generic loopback modes to the list.

Thanks,
Hariprasad k
 


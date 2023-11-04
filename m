Return-Path: <netdev+bounces-46037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5767E0FDE
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 15:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C429F281C20
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 14:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE3C1A591;
	Sat,  4 Nov 2023 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="niPX3JMy"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C0015486
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 14:19:30 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8614191;
	Sat,  4 Nov 2023 07:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nlg27fGYyBiOtVzMcSyTbiS710cqDrlOY1cgrkFy2xE=; b=niPX3JMy7btJ1/OZl0WZiZEkC5
	S45Q1L0Oiky5732ZZHBv4F0Gn0HQWeK/HRVBkS5Xb3asTQKmrTNPnU3BLV/sWLPl6sIjArXkBq274
	VVAvWm8IEevmRK3DZmXEnVHJImf60eIn79VuHf/yDVp/6uQcdJS7b6xWstxdcA93eKq8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qzHUV-000sHv-0V; Sat, 04 Nov 2023 15:19:11 +0100
Date: Sat, 4 Nov 2023 15:19:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: at803x: add QCA8084 ethernet phy support
Message-ID: <1aaf7a4b-fc7e-4203-af71-740bc187d046@lunn.ch>
References: <20231103123538.15735-1-quic_luoj@quicinc.com>
 <806fb6b6-d9b6-457b-b079-48f8b958cc5a@lunn.ch>
 <7f0df23b-f00e-fef8-fa03-314fcfe136eb@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f0df23b-f00e-fef8-fa03-314fcfe136eb@quicinc.com>

On Sat, Nov 04, 2023 at 02:25:25PM +0800, Jie Luo wrote:
> 
> 
> On 11/3/2023 9:01 PM, Andrew Lunn wrote:
> > >   #define QCA8081_PHY_ID				0x004dd101
> > > +#define QCA8081_PHY_MASK			0xffffff00
> > 
> > That is an unusual mask. Please check it is correct. All you should
> > need its PHY_ID_MATCH_EXACT, PHY_ID_MATCH_MODEL, PHY_ID_MATCH_VENDOR.
> 
> Thanks Andrew for the review.
> The PHY ID of qca8084 is correct, i will update to use PHY_ID_MATCH_EXACT in
> the new added entry for qca8084.

Note, i asked about the mask, not the ID. Is PHY_ID_MATCH_EXACT maybe
too exact? Is there the option for different revisions of the PHY? Can
one entry in the table be used for multiple revisions?


    Andrew

---
pw-bot: cr


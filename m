Return-Path: <netdev+bounces-15450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E45A6747A59
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 01:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B01F280F0C
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 23:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BDD6FD3;
	Tue,  4 Jul 2023 23:26:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D51210A
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 23:26:13 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA64EE7A;
	Tue,  4 Jul 2023 16:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5vSpFRL9vhuoN/m1SbVZ8d9E4zKR5/BsRm02N2N1dns=; b=DWutb2+/DC7I1nfVdvZFI+f/dc
	GSR0jtzVCCumyIy9hzNycP5L+NOEaOWq4Cfl+go2jc655bA7XX0eBTv/PcWeRniNy7aXwv3UrkFsO
	Va8wDl4L8QqMmWlpWsz2o4tS49gBoyNruu7G9AuR1e6zaHJGiSF5Guo9eXRPB+LmB0CY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qGpPH-000aij-Ok; Wed, 05 Jul 2023 01:26:03 +0200
Date: Wed, 5 Jul 2023 01:26:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] net: phy: at803x: add qca8081 fifo reset on the
 link changed
Message-ID: <cb4909bc-aebf-4691-bdfd-ebba3200f2a8@lunn.ch>
References: <20230704090016.7757-1-quic_luoj@quicinc.com>
 <20230704090016.7757-3-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704090016.7757-3-quic_luoj@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 04, 2023 at 05:00:16PM +0800, Luo Jie wrote:
> The qca8081 sgmii fifo needs to be reset on link down and
> released on the link up in case of any abnormal issue
> such as the packet blocked on the PHY.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


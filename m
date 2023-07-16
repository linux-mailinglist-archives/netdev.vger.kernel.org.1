Return-Path: <netdev+bounces-18116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E38754F16
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 16:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60492813E5
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 14:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F847483;
	Sun, 16 Jul 2023 14:48:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1FDEA1
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 14:48:58 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BFE1B4;
	Sun, 16 Jul 2023 07:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CbkBfBpRSVPwxZYI1N0yM4KwsV8EQ6xyHl2iM6/2ntI=; b=TMLieLbhW0t0Z1awveZlk+5D7I
	1RtPurTJ7fjdBrDbH6oHnWblypFpg/IffzJEPdlsqhcQhC7vFu5uCLO4eLaRrMu9xEPrRXSYPrPNV
	xQ9Bo1DRWz6r7u5l4hcBSBrvnzNVK2kPaC2VTDCzqW8D31w11xJQmCC9nR3mlhgR+BpU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qL33F-001U24-TI; Sun, 16 Jul 2023 16:48:45 +0200
Date: Sun, 16 Jul 2023 16:48:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] net: phy: at803x: remove qca8081 1G fast retrain
 and slave seed config
Message-ID: <8d2dd95b-13f7-41d8-997f-d5c2953dcb06@lunn.ch>
References: <20230716084924.9714-1-quic_luoj@quicinc.com>
 <20230716084924.9714-6-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716084924.9714-6-quic_luoj@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 16, 2023 at 04:49:23PM +0800, Luo Jie wrote:
> The fast retrain and slave seed configs are only applicable when the 2.5G
> ability is supported.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

FYI: You normally have Signed-off-by: last. No need to resend, but
please keep this in mind for the next patchset.

    Andrew


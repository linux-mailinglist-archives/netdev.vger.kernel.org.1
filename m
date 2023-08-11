Return-Path: <netdev+bounces-26911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C20779575
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 19:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756951C217F2
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 17:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4242B18AE1;
	Fri, 11 Aug 2023 17:00:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3819E11734
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 17:00:08 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6E230CF;
	Fri, 11 Aug 2023 10:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Liqdlmi/+TyK5HPaXer8k0QCEKn9MtG0+oTjYtyhoqQ=; b=WUwWI40p7riyJaYxaMT9EgWf58
	rYFv8EXBpv12SMnl5StMtAPwXarqsWHT0rejqUX8y2JboBlGUOlKOlmpaJVbZy4lhA4zM6BtpOX6m
	FPyyRgy6+tcVlDEsUFBqRIZnprGfS1vCGmOWWuiv9AerVlea4Boa2M0fZZZ1aHcesP8o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qUVUT-003pRN-9k; Fri, 11 Aug 2023 18:59:57 +0200
Date: Fri, 11 Aug 2023 18:59:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, sd@queasysnail.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v1 2/5] net: phy: remove MACSEC guard
Message-ID: <056a153c-19d7-41bb-ac26-04410a2d0dc4@lunn.ch>
References: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
 <20230811153249.283984-3-radu-nicolae.pirea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811153249.283984-3-radu-nicolae.pirea@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 06:32:46PM +0300, Radu Pirea (NXP OSS) wrote:
> Allow the phy driver to build the MACSEC support even if
> CONFIG_MACSEC=N.

What is missing from this commit message is an answer to the question
'Why?'

     Andrew


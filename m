Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930A57413FE
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 16:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjF1OoH (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 10:44:07 -0400
Received: from vps0.lunn.ch ([156.67.10.101]:40258 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229789AbjF1OoF (ORCPT <rfc822;netdev@vger.kernel.org>);
        Wed, 28 Jun 2023 10:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=CfJzgWWOQxipXmzttg2EGQA2mqNhb59x9OMQ0r6tDo8=; b=AH0/M6s1mqVYhjXgo62xpBmRUz
        W/cnkHOiO1eFkxxKCvheTFRTS5XAFppax6A4X3mEjYSHXrOCmmRuC0TBMKgVqSB340wq4qX7MiJ1g
        AUCwkAEZn9HmZ4vZpL9h1Jt9qIUrRtqStW67q85Aq6mzHwAuOKeLeqAxoCwypwciF+A8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qEWOn-0007u7-DT; Wed, 28 Jun 2023 16:44:01 +0200
Date:   Wed, 28 Jun 2023 16:44:01 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jiawen Wu <jiawenwu@trustnetic.com>
Cc:     netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net v2] net: txgbe: change LAN reset mode
Message-ID: <516f2276-e93b-4a90-a82f-8849d5bd3ccc@lunn.ch>
References: <20230628034204.213193-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628034204.213193-1-jiawenwu@trustnetic.com>
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

On Wed, Jun 28, 2023 at 11:42:04AM +0800, Jiawen Wu wrote:
> The old way to do LAN reset is sending reset command to firmware. Once
> firmware performs reset, it reconfigures what it needs.
> 
> In the new firmware versions, veto bit is introduced for NCSI/LLDP to
> block PHY domain in LAN reset. At this point, writing register of LAN
> reset directly makes the same effect as the old way. And it does not
> reset MNG domain, so that veto bit does not change.
> 
> And this change is compatible with old firmware versions, since veto
> bit was never used.

You are posting this for net, so i assume you want this back ported.
What is the real user observed problem here?

https://www.kernel.org/doc/Documentation/process/stable-kernel-rules.rst

	Andrew

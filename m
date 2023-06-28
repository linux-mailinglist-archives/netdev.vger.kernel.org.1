Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB8D7417D8
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 20:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjF1SQE (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 14:16:04 -0400
Received: from vps0.lunn.ch ([156.67.10.101]:40486 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbjF1SQC (ORCPT <rfc822;netdev@vger.kernel.org>);
        Wed, 28 Jun 2023 14:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=+l+HcNCx7j/WU4JvE93sXOflPbzjvQPHJ61VUu/0kdQ=; b=KR8zaTX4nsyXgFaGaxrFikLtCT
        MHqEDH2WIQrt8vT4K9HqV/enDd1XoCeEoKgjkeAnj26BXeB/agIwmlM0B/4m/hwFhhPOaEyMQQSev
        XQPtvFMHTy1zZHooW85zusaQoZbYG8KTn813dq9Mg5cCEZJcfy+t07E96RZkgR2reBQo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qEZhu-0009So-Jt; Wed, 28 Jun 2023 20:15:58 +0200
Date:   Wed, 28 Jun 2023 20:15:58 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc:     netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Saeed Mahameed <saeed@kernel.org>,
        Gal Pressman <gal@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>,
        Nathan Chancellor <nathan@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH net v1] ptp: Make max_phase_adjustment sysfs device
 attribute invisible when not supported
Message-ID: <27c450f4-0b72-4d32-b99c-1b29831ab468@lunn.ch>
References: <20230627232139.213130-1-rrameshbabu@nvidia.com>
 <7fa02bc1-64bd-483d-b3e9-f4ffe0bbb9fb@lunn.ch>
 <87ilb8ba1d.fsf@nvidia.com>
 <0e82eff0-16ba-49b0-933d-26f49515d434@lunn.ch>
 <87ilb7qxzu.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilb7qxzu.fsf@nvidia.com>
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

> It can be after -rc1. I understand your point now from this elaboration.
> Since the change is not heading towards a final release yet but a
> release candidate, it's not an "urgent" patch to be applied before -rc1.
> 
> >
> > We are in the grey area where it is less clear which tree it should be
> > against. So it is good to explain after the --- what your intention
> > is, so the Maintainers get a heads up and understand what you are
> > trying to achieve.
> 
> Agreed, I could have used git notes for that in my patch generation.
> Noted for the future. Just to be clear, my intention is for this fix to
> make its way before the final 6.5 release (before the changes make their
> way to an end user since the NULL pointer dereference when reading that
> sysfs node from a PHC not supporting phase adjustment is problematic).

A NULL pointer dereference is a valid reason for stable anyway. 

> I think the issue being present in a release candidate is a minor
> problem.  Would I still keep the Fixes tag however if targeting
> net-next?

It is useful, even for something in net-next. It is not needed for
back porting, except for making it clear back porting is not needed,
But there are some statistics gathered based on Fixes tags, etc.

     Andrew

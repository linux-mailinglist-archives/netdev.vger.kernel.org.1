Return-Path: <netdev+bounces-38651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D057BBED3
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 20:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B723C1C20B25
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 18:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C219137C95;
	Fri,  6 Oct 2023 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dLVaEBkR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E6138BB1
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 18:41:29 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0CBC2
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 11:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xgbfzXK3D1wpO6dPg0AG8cw3+dICLYeguheqKl1Oma4=; b=dLVaEBkRLtOvib+w+bJZGZUB3F
	d/YBXi1/XFHQ51QEuwUbmjwji8i5+Y9XTarLY7HpnChDv5duY4yB6TXPOArNdJsxPTKTFJp+vE7Pk
	vQCQcYinn7HJvo2Ncfv6e4PVP1IpmTMwqc46W/THno8cSQeXYjqvLBIsERLDvdnLiAK4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qoplH-0004zs-46; Fri, 06 Oct 2023 20:41:19 +0200
Date: Fri, 6 Oct 2023 20:41:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, jesse.brandeburg@intel.com, sd@queasysnail.net,
	horms@verge.net.au
Subject: Re: [RFC] docs: netdev: encourage reviewers
Message-ID: <8270f9b2-ec07-4f07-86cf-425d25829453@lunn.ch>
References: <20231006163007.3383971-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006163007.3383971-1-kuba@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 06, 2023 at 09:30:07AM -0700, Jakub Kicinski wrote:
> Add a section to our maintainer doc encouraging reviewers
> to chime in on the mailing list.
> 
> The questions about "when is it okay to share feedback"
> keep coming up (most recently at netconf) and the answer
> is "pretty much always".
> 
> The contents are partially based on a doc we wrote earlier
> and shared with the vendors (for the "driver review rotation").
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> --
> CC: andrew@lunn.ch
> CC: jesse.brandeburg@intel.com
> CC: sd@queasysnail.net
> CC: horms@verge.net.au
> 
> Sending as RFC for early round of reviews before I CC docs@
> and expose this to potentially less constructive feedback :)

We already have:

https://docs.kernel.org/process/7.AdvancedTopics.html#reviewing-patches

which has some of the same concepts. I don't think anything in the
proposed new text is specific to netdev, unlike most of the rest of
maintainer-netdev.rst which does reference netdev specific rules or
concepts.

So i wounder if this even belongs in netdev? Do we actually want to
extend the current text in "A guide to the Kernel Development
Process", and maintainer-netdev.rst say something like:

    Reviewing other people's patches on the list is highly encouraged,
    regardless of the level of expertise.

and cross reference to the text in section 7.2?

    Andrew


Return-Path: <netdev+bounces-12820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2739739058
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19C71C20FF2
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 19:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAFA1B911;
	Wed, 21 Jun 2023 19:45:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E791B908
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 19:44:59 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE92B1989
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 12:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oP/HPVe+zxTbH4Dtzbcu1shnX43lIh/y60JVhfdGIJc=; b=pvzbneRSObOyftZPt+A8kXfZKy
	p26RoxCLcW1/869VPW9SRY3wpSml1ZXbAN4oM8MwCX3y0D07meLLmEwirzqbWBrGDTzOHDjLoeeJ8
	6Va+5ciyjSDz42Jyh/rk9XmnzSw6AmDV7Hf89ni7/dyWWtD29WuUBUlmZVivPIz7SfOg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qC3l9-00HBSN-5P; Wed, 21 Jun 2023 21:44:55 +0200
Date: Wed, 21 Jun 2023 21:44:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org,
	emil.s.tantilov@intel.com, jesse.brandeburg@intel.com,
	sridhar.samudrala@intel.com, shiraz.saleem@intel.com,
	sindhu.devale@intel.com, willemb@google.com, decot@google.com,
	leon@kernel.org, mst@redhat.com, simon.horman@corigine.com,
	shannon.nelson@amd.com, stephen@networkplumber.org
Subject: Re: [PATCH net-next v3 00/15][pull request] Introduce Intel IDPF
 driver
Message-ID: <03819ef3-8008-43e9-8618-f37f5bc5160b@lunn.ch>
References: <20230616231341.2885622-1-anthony.l.nguyen@intel.com>
 <20230616235651.58b9519c@kernel.org>
 <1bbbf0ca-4f32-ee62-5d49-b53a07e62055@intel.com>
 <20230621122853.08d32b8e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621122853.08d32b8e@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 12:28:53PM -0700, Jakub Kicinski wrote:
> On Wed, 21 Jun 2023 12:13:06 -0700 Linga, Pavan Kumar wrote:
> > Thanks for the feedback. Given the timing and type of changes requested 
> > for the patches, would it be possible to accept this patch series (v3) 
> > in its current form, as we continue to develop and address all the 
> > feedback in followup patches?
> 
> I think you're asking to be accepted in a Linux-Staging kind of a way?

Or maybe real staging, driver/staging ? Add a TODO and GregKH might
accept it.

    2.5. Staging trees

    The kernel source tree contains the drivers/staging/ directory,
    where many sub-directories for drivers or filesystems that are on
    their way to being added to the kernel tree live. They remain in
    drivers/staging while they still need more work; once complete,
    they can be moved into the kernel proper. This is a way to keep
    track of drivers that aren't up to Linux kernel coding or quality
    standards, but people may want to use them and track development.

Andrew


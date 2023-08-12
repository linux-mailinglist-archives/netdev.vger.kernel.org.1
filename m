Return-Path: <netdev+bounces-27065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA24277A175
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 19:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7C4281042
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 17:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9066D8836;
	Sat, 12 Aug 2023 17:43:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7501823D3
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 17:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D66DC433C8;
	Sat, 12 Aug 2023 17:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691862184;
	bh=ebop/vhKG+d6ioZES9vEyyolUgCe+T6JMuW233egLIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JzPZCT2qbpEAkWJPc6drUu/evkBUoBXEM30b60pUouZMOb1kPzyU1jtrCIfBxtMf/
	 WLIPbX3NN5cCPFv0So8QLDa88E0mcxrXqehqAoJDpBCDaIbVT8Nys5lZLOMKgLhZbx
	 XcHEmXb+NBEXauVnmQVItxoH9F6uzlqOijb3bnbZN775yfB398Hbw7MkOghPJu8hrA
	 rvYUJXwsXzjlxpiBKVp+sl1VZB0BMBng7oTKAa98JBBYlOwG1JHWwe0nqPLixZ2L3y
	 GVcFaUAM/6PC0ZxoXNhhKABMi1O4pnexxqm7msHHLw1qNPn8KkD+7X2zOITJrRJx9p
	 G35go0u8CFCMg==
Date: Sat, 12 Aug 2023 19:43:00 +0200
From: Simon Horman <horms@kernel.org>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: netdev@vger.kernel.org, Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Abhijit Ayarekar <aayarekar@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Vimlesh Kumar <vimleshk@marvell.com>
Subject: Re: [PATCH net 2/4] octeon_ep: cancel tx_timeout_task later in
 remove sequence
Message-ID: <ZNfEpKt9SlLWAaH3@vergenet.net>
References: <20230810150114.107765-1-mschmidt@redhat.com>
 <20230810150114.107765-3-mschmidt@redhat.com>
 <ZNUGu74owyfsAbEW@vergenet.net>
 <CADEbmW2tmCd5K852-z7VQfMmp=ae06_gOE66uduhnV3zbA4RcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADEbmW2tmCd5K852-z7VQfMmp=ae06_gOE66uduhnV3zbA4RcA@mail.gmail.com>

On Fri, Aug 11, 2023 at 05:58:44PM +0200, Michal Schmidt wrote:
> On Thu, Aug 10, 2023 at 5:48 PM Simon Horman <horms@kernel.org> wrote:
> >
> > On Thu, Aug 10, 2023 at 05:01:12PM +0200, Michal Schmidt wrote:
> > > tx_timeout_task is canceled too early when removing the driver. Nothing
> >
> > nit: canceled -> cancelled
> >
> >      also elsewhere in this patchset
> >
> >      ./checkpatch.pl --codespell is your friend here
> >
> > ...
> 
> Hi Simon,
> thank you for the review.
> 
> I think both spellings are valid.
> https://www.grammarly.com/blog/canceled-vs-cancelled/

Thanks, I did not know that.

> Do you want me to resend the patchset for this?

No, not in light of your previous point.

-- 
pw-bot: under-review


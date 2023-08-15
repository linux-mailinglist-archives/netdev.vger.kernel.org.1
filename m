Return-Path: <netdev+bounces-27729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4194A77D084
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 19:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 447E11C20D40
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 17:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22489156DE;
	Tue, 15 Aug 2023 17:02:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0256913AFD
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 17:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA68C433C7;
	Tue, 15 Aug 2023 17:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692118924;
	bh=r9KZfoAmpLHh60UciV5nylVVLkX7ks9J5Cw/wgBs6bw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ow3YXSqMksDmaueAVNUM5WBG5xKeQfFxfA2pH0oD3F3PvzxmMy6ICbHq6ZzgWRWGK
	 aWiZcvJDavt+UHR9txOSRokZGJD9qnwxvM+4LGry273QbcF13RARMuqN/EpldDPYDz
	 i0ZsYWxjZmeSzflU80014K/dHCmsJDX9fy9KMyTwcG/Vjl3cE75GCUZbpKO87T62yC
	 3Bi7Za/j8N56fcVheaxGJPTdawjHf/fmoUf7FcSiHoSNE7yeJUf+tSLIC53h/zBXV4
	 9qetQIWqiAAyj3tjag/Z1MIK3/yq837XwlBfjKN5VylEFFKiQduQPdj5489SdaCf8g
	 k6H7+xF9YjAsQ==
Date: Tue, 15 Aug 2023 10:02:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Milena Olech
 <milena.olech@intel.com>, Michal Michalik <michal.michalik@intel.com>,
 linux-arm-kernel@lists.infradead.org, poros@redhat.com,
 mschmidt@redhat.com, netdev@vger.kernel.org, linux-clk@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v4 0/9] Create common DPLL configuration API
Message-ID: <20230815100203.4e45fc7e@kernel.org>
In-Reply-To: <ZNtm6v+UuDIex1+s@nanopsycho>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
	<20230814194528.00baec23@kernel.org>
	<43395307-9d11-7905-0eec-0a4c1b1fc62a@linux.dev>
	<ZNtm6v+UuDIex1+s@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 13:52:10 +0200 Jiri Pirko wrote:
> >> Feels like we're lacking tests here. Is there a common subset of
> >> stuff we can expect reasonable devices to support?
> >> Anything you used in development that can be turned into tests?  
> >
> >Well, we were playing with the tool ynl/cli.py and it's stated in
> >the cover letter. But needs proper hardware to run. I'm not sure
> >we can easily create emulation device to run tests.  
> 
> Well, something like "dpllsim", similar to netdevsim would be certainly
> possible, then you can use it to write selftests for the uapi testing.
> But why don't we do that as a follow-up patchset?

I was thinking about a test that can be run against real HW.
Something that a new vendor implementing DPLL can run and
validate that their implementation behaves as expected.
And something that distributors and stable kernels could
potentially use to validate the code still works.

We don't have any well established user space to make use of this 
new functionality, there's high risk that drivers will invent their
own ways of interpreting the API.

Perhaps something that Red Hat could help with? I'm guessing you'd 
be writing test to validate this for RHEL, anyway?


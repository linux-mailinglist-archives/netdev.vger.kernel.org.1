Return-Path: <netdev+bounces-41972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C1B7CC79D
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 17:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7771C20976
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 15:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EC8450DE;
	Tue, 17 Oct 2023 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUhN19a8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32DC450D5
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 15:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA571C433C8;
	Tue, 17 Oct 2023 15:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697557231;
	bh=k/4uIOPBHeaTpt7AKBQLDITfX6Aadkm7yb2mLqKeNWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rUhN19a8JFNf11jlSvHC/pjUaeM1BnwqHbcWiQ7N/JFb9Adqsz5S4vYjL3BjmSbjK
	 loa1jKQGeLqAt8RcHcp1mj1lOyj17+J21LT7xKWNDPNcLsI7FeK7r0RXMLAn/yIaGH
	 3DnJEzc9gsmWFiM6KUkgNLJWrGuiGG5jHdz5ta+eTC/I48AvkDpnqf6j8XhrVok5SK
	 TcOBUKkmFaIX8J25XYVN0CC7UiKJTBm5ogISECZp/b+cA4mTJ5I2/BQ+YPmTFKS94B
	 6hsUWwEmcKkzQDuWWXjRl6b5EEHHgZadholqceIgTCjgAbuKh1HXX6SGY3oiqvyVBH
	 A/QNaxIrKjarw==
Date: Tue, 17 Oct 2023 08:40:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, anjali.singhai@intel.com,
 namrata.limaye@intel.com, deb.chatterjee@intel.com,
 john.andy.fingerhut@intel.com, dan.daly@intel.com, Vipin.Jain@amd.com,
 tom@sipanda.io, mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
 tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com,
 mattyk@nvidia.com
Subject: Re: [PATCH v7 net-next 00/18] Introducing P4TC
Message-ID: <20231017084029.3920553d@kernel.org>
In-Reply-To: <CAM0EoMk6aRnm_EPevO7MuyOHq52KOVXoJpy2i=exCuQeg0X-zA@mail.gmail.com>
References: <20231016093549.181952-1-jhs@mojatatu.com>
	<20231016131506.71ad76f5@kernel.org>
	<CAM0EoM=nT2KQcVqPrWvKJXnW7h8uodhu0daNsLkuAUt5n=zuZw@mail.gmail.com>
	<CAM0EoM=ZGLifh4yWXWO5WtZzwe1-bFsi-fnef+-FRS81MqYDMA@mail.gmail.com>
	<CAM0EoMmA3_9XmTFk5H-0oR5qfEYtxq_1Vc2zRVKfA_vtVTmafg@mail.gmail.com>
	<20231016153548.1c050ea3@kernel.org>
	<CAM0EoMk6aRnm_EPevO7MuyOHq52KOVXoJpy2i=exCuQeg0X-zA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Oct 2023 11:27:36 -0400 Jamal Hadi Salim wrote:
> > patch-by-patch W=1 C=1 should be good enough to catch the problems.  
> 
> Thanks - this helps. We didnt pay good attention to
> https://www.kernel.org/doc/Documentation/process/maintainer-netdev.rst
> Only thing that is missing now is the mention of C=1 in the doc. Patch
> to the doc acceptable?
> Also a note about false positives in sparse output (there were a few
> in the warnings from the bot) would be apropos.

Um. Maybe.. Sparse generates more false positives than good warnings
lately :( We'd have to add some extra info like "Note that sparse
is known to generate false-positive warnings, if you think that the
warning generated with C=1 is bogus, ignore it and note that fact
in the commit message".

I don't like documenting things which aren't clear-cut :(

I'm pretty sure you have pure W=1 warnings here, too.


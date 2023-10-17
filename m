Return-Path: <netdev+bounces-41982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81437CC83B
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 17:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257FF1C20A0D
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 15:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D31C45F4A;
	Tue, 17 Oct 2023 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHciUR+d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38223D6D
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 15:58:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C61C433C8;
	Tue, 17 Oct 2023 15:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697558298;
	bh=YyaYrfN9LBjPGJ+H8HqeHZSQL0yfepouS3cwaPNwtJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JHciUR+dAZO8sknNyDOybDKB7PigcO/PzB2LARqw9QWMCnGOsnlyGfYov/Tvg+jha
	 qhhPmVTOlNUtlwnYsJWjRLSo1bg7OM7WaZLctvsq1CMMwL9wK7NjUi4sDxCYS/XqgK
	 5WY2MtzYA3I7eJ7HI0t9xQUWVKPkdPhE/4YP/WvXz2PfcY3BCt2BBkdcd6j1ZzryUa
	 +26BtOhIa82SV8EjYjERWNfBkBHnb/S6Nkz1sQYKgN0Mgu4vDUpaljO/4aPm72SGzh
	 G9DVDnbRo+DnCUafGD04R7wJl5S+5Q1bxFbr2ELDIm34OhCzlPGHgzqrmjeygFWXz9
	 y/hS3KOmNBdZg==
Date: Tue, 17 Oct 2023 08:58:17 -0700
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
Message-ID: <20231017085817.71d4f83b@kernel.org>
In-Reply-To: <CAM0EoM=f9qGmTR5jW1vayu0JHy0MQjrOeREX6acjnS7MFQP7Ww@mail.gmail.com>
References: <20231016093549.181952-1-jhs@mojatatu.com>
	<20231016131506.71ad76f5@kernel.org>
	<CAM0EoM=nT2KQcVqPrWvKJXnW7h8uodhu0daNsLkuAUt5n=zuZw@mail.gmail.com>
	<CAM0EoM=ZGLifh4yWXWO5WtZzwe1-bFsi-fnef+-FRS81MqYDMA@mail.gmail.com>
	<CAM0EoMmA3_9XmTFk5H-0oR5qfEYtxq_1Vc2zRVKfA_vtVTmafg@mail.gmail.com>
	<20231016153548.1c050ea3@kernel.org>
	<CAM0EoMk6aRnm_EPevO7MuyOHq52KOVXoJpy2i=exCuQeg0X-zA@mail.gmail.com>
	<20231017084029.3920553d@kernel.org>
	<CAM0EoM=f9qGmTR5jW1vayu0JHy0MQjrOeREX6acjnS7MFQP7Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Oct 2023 11:56:15 -0400 Jamal Hadi Salim wrote:
> > Um. Maybe.. Sparse generates more false positives than good warnings
> > lately :( We'd have to add some extra info like "Note that sparse
> > is known to generate false-positive warnings, if you think that the
> > warning generated with C=1 is bogus, ignore it and note that fact
> > in the commit message".
> >  
> 
> > I don't like documenting things which aren't clear-cut :(  
> 
> Upto you - couldnt sum up from above if you want a patch or not. I
> think it makes sense to document C=1 somewhere since it helps your
> overhead.
> But the comment Similar in spirit to the checkpatch comment if - "But
> do not be mindlessly robotic in doing so..."

Weak preference for keeping it as is.
The wins on my end don't justify the extra rule for the drive-by
developers.


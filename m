Return-Path: <netdev+bounces-104154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A93790B556
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE3C1C2192C
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AE313AA4D;
	Mon, 17 Jun 2024 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdKdioTC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691D913A3E9;
	Mon, 17 Jun 2024 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638796; cv=none; b=G3yp/nDMGTTfhcPINbb5RGip4gcPrFLjUaKWo09+Z2Nl0Y4Fvsu5IAinaTd91JeaDs2+wwubQu0H9cJD5WV2eaoQSuJPxJMDj2sYLX8kqwSLtWp6tR9tUxVcQk6JExsO0+iaQKghAdFNoVUprGAWG5oueXVyt8mSWPlXP8aZmcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638796; c=relaxed/simple;
	bh=X9cMooPcCeo+fl/9LtjYrlrwd04IfEY0Dhi+60nE4SY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HX1wYgxkt2EQwbhfDguuTDUgd+dlyjVm2mleyY6BecJZRDLSkYyLTgtdUf0Loda7n2FFuph4owY1cw6ogSB9KwQmaPCkbfJWTrQXV6OFk925HAi1hziFpnJGu7oaF6R0lmXlWfXoN9bUO5SD4GxyGvkGG+5BGZrpMs2yR2xyHPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdKdioTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E278CC2BD10;
	Mon, 17 Jun 2024 15:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718638796;
	bh=X9cMooPcCeo+fl/9LtjYrlrwd04IfEY0Dhi+60nE4SY=;
	h=Date:From:To:Cc:Subject:From;
	b=BdKdioTCz+mNe3L2+MiKBVkZHv/WLewrClyzQ265rsx/t2Knc3VDnW8sxQ23nLolm
	 Fj79GTJlY4VqnzWE6kB7+4/TIHg7GV14RyEX1dRpprvIuvT+ZrTxjAgjrXRvNkcJ1m
	 XHlNAmxWCF35XboXoyhZaYoiDjLxhKZtjyXRkkKzd9ykmLjL92mrNYK4C9/3Agaz/c
	 Lj3gRi92xMKfgy7yAl+v41B6abAi2KLd1gpSbsctMit2d3YxXblezxiHm+wnneUOc8
	 ibi9ALODsMGWuUtkOrxBZQtC0zhNjyZcnbm9XU0030OCfMnvX7k08eK2l9JMZmkPYA
	 yM8dzvxHzgsfg==
Date: Mon, 17 Jun 2024 08:39:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Cc: Shannon Nelson <shannon.nelson@amd.com>, Vladimir Oltean
 <olteanv@gmail.com>
Subject: [ANN] netdev call - Jun 18th
Message-ID: <20240617083955.1039b2e3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
5:30 pm (~EU), at https://bbb.lwn.net/b/jak-wkr-seg-hjn

I have one agenda item which has been on my mind for a while.
We have set a policy to reject any new drivers supporting the
legacy SR-IOV ndos a couple of years back. The hope was that
this will spur investment in implementing more full featured
offloads like bridge or flower. My very subjective feeling is
that the policy has not had that effect. I wonder whether we
should consider allowing the basics (MAC, VLAN, link state,
spoof check) again. Obviously absolutely no extensions to the
APIs allowed.

Please join the call or share here if you have on opinion in
either direction. Especially if you know of people actually
working on an upstream/open solutions to this problem because
of the current policy.

Please feel free to send other agenda items for the call.

In terms of review rotation - it's an nVidia week.


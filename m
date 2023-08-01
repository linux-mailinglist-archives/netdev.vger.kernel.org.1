Return-Path: <netdev+bounces-23437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84C176BF87
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 23:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08926281B76
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 21:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A7526B7E;
	Tue,  1 Aug 2023 21:51:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32713263D7
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 21:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7081DC433C7;
	Tue,  1 Aug 2023 21:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690926676;
	bh=4dYL6EavnS6V/WEwMnlud6nMt53cQOrRwJGdMdREcSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ea86IZrl/0H6euUS4i9ji2lVI4hqosY13fdKD8VJiQOs/xLhRtHS5ZeUhYFiS+Vg4
	 GrqrxzNevJoM9iBxCHbi+MYzYHdzRLcmrXkstsOihtbRkPiWZut6lS/JMxjUU1On7V
	 Ef848XgqHAqcJw9hKurZL05cGCuB5Yv+vQMNzxRCYilxSGZe9b7+VwuPQqkI0fAXqr
	 7CX7KP6d+Q1cM95rwTv/tzqZ41m8TtESjCOGaTrg6e8xTbmOkVeMI8HYCLbcwCRWDK
	 MKdumOKc6bzBo6VXUQGoWMpI/XRSFwJ9trRH34fnvw/NAkoErCLsfsAj1fzsVz7DZ1
	 NX8XKQgsThM3Q==
Date: Tue, 1 Aug 2023 14:51:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Atul Raut <rauji.raut@gmail.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>, <avem@davemloft.net>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>, <rafal@milecki.pl>,
 <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: Re: [PATCH] net/macmace: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <20230801145115.153f3629@kernel.org>
In-Reply-To: <ZMkSIfUEnvYvHyZx@lincoln>
References: <20230730231442.15003-1-rauji.raut@gmail.com>
	<20230731073801.GA87829@unreal>
	<ZMkSIfUEnvYvHyZx@lincoln>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Aug 2023 16:09:37 +0200 Larysa Zaremba wrote:
> > > -	u8	data[1];
> > > +	DECLARE_FLEX_ARRAY(u8, data);  
> > 
> > But data[1] is not zero-length array.
> 
> So, please, if you are certain that data should be a flexible array,
> send v2 without calling data a zero-length array. Also, with such change, I 
> think driver code could be improved in many places in the same patchset.

Atul, you should respond to reviewers promptly. These are legit
questions.
On closer inspection the patch looks fine so to avoid clogging up 
the review queue and wasting more time on it I'm just going to apply it.


Return-Path: <netdev+bounces-21022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 404EF762304
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 22:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74466281378
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4996426B22;
	Tue, 25 Jul 2023 20:09:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CFB25931
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 20:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50968C433C8;
	Tue, 25 Jul 2023 20:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690315758;
	bh=kIVefddpdQ6Ybi23L3k2l383hhK/2Se+OZt4aJy4KCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CQItttu3wJr1ujdmXT0HLFauOZrtfZmo4mM7VzlHgUqPiOMTuz5uQCvPAhbfmPqEm
	 4lvS7KVXp8qKQDU01uCFV/cOGwkUCK2L89U0Beub6y13n4RlUtnzL+Sz5wq17V045w
	 1kIKeNRhUeOimq/obsOar5y06FzkWU2HNjJxXKbRI3d2CXRfvvpiq4YH1ZJv95q4WB
	 oXvMDeIIgpTADkJ5/XgO2PrRpz17RrgVIlEPH7mSQAn48PNNw+Yfk3rHqEBCPO46Vd
	 C7HIsjIcbHhUTqG4ueKKOy1E5ZiU4TRZUow5nAIo5i61RujqNuRfIbiG3iPLUrWIsu
	 mLI4TzcEb3dnQ==
Date: Tue, 25 Jul 2023 13:09:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: valis <sec@valis.email>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, pctammela@mojatatu.com,
 victor@mojatatu.com, ramdhan@starlabs.sg, billy@starlabs.sg, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net 0/3] net/sched Bind logic fixes for cls_fw, cls_u32
 and cls_route
Message-ID: <20230725130917.36658b63@kernel.org>
In-Reply-To: <CAEBa_SB6KCa787D3y4ozBczbHfZrsscBMmD9PS1RjcC=375jog@mail.gmail.com>
References: <20230721174856.3045-1-sec@valis.email>
	<8a707435884e18ccb92e1e91e474f7662d4f9365.camel@redhat.com>
	<CAEBa_SB6KCa787D3y4ozBczbHfZrsscBMmD9PS1RjcC=375jog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 21:05:23 +0200 valis wrote:
> The document you quoted does not forbid pseudonyms.
> In fact, it was recently updated to clarify that very fact.

We don't know who you are. To my understanding the adjustment means
that you are not obligated to use the name on your birth certificate
but we need to know who you are.

Why is it always "security" people who try act like this is some make
believe metaverse. We're working on a real project with real licenses
and real legal implications.

Your S-o-b is pretty much meaningless. If a "real" person can vouch for
who you are or put their own S-o-b on your code that's fine.


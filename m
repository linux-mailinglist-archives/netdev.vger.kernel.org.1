Return-Path: <netdev+bounces-12315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1DB737150
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 18:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178E02812E5
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 16:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E00817754;
	Tue, 20 Jun 2023 16:18:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249891078E
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 16:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9E7C433C8;
	Tue, 20 Jun 2023 16:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687277881;
	bh=wBA0Y9Ha6H9ZxemUE1WcIWZcdsauUIHysTV95xMBlbk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=szyVySQzzS8HwDYR6rOQ7eMA98hrqGmEHdDyArc/vFhMv5MBwwTPO+dCIKe8dwVAx
	 /I3xmOA2A7pjhqaMUWqkYtMJccFXzhV6NdbHx4k8McuNZINpM8bQAXWlMFZS1zJEAW
	 Geuhcpk/Mj9/9LjyphIaKdqHrRPZnIBBjf9FPvTBjZHFT4qYhgd3gUyk3ok0ivsuna
	 YU0wj5N4tyVAkaOvhqWnuvbF7RwBeq1P2gK7usgYTAwifD8kLQ7FsyGqPlo5u4+yXB
	 1f32qZKJAcEmiCTy49yga2KxQYNZk05Ie6JXzo1zkEngDI9iERp4Y0z2wz7sjUOlpy
	 6jjPSFlBxvFdg==
Date: Tue, 20 Jun 2023 09:18:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Veerasenareddy Burru <vburru@marvell.com>
Cc: Sathesh B Edara <sedara@marvell.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Satananda Burla <sburla@marvell.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH] MAINTAINERS: update email addresses of
 octeon_ep driver maintainers
Message-ID: <20230620091800.736bf269@kernel.org>
In-Reply-To: <20230616101229.1e7339f0@kernel.org>
References: <20230615121057.135003-1-sedara@marvell.com>
	<20230615101311.34f5199e@kernel.org>
	<BYAPR18MB2423D248B84D85F3C1A48159CC58A@BYAPR18MB2423.namprd18.prod.outlook.com>
	<20230616101229.1e7339f0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Jun 2023 10:12:29 -0700 Jakub Kicinski wrote:
> > Sathesh will also be maintaining and submitting the changes for
> > octeon_ep drivers, going forward.
> >
> > Is the right way for this is, add Sathesh to MAINTAINERS list along
> > with his first patch/patchset submission ?  
> 
> The patch is perfectly fine. Please see my question as half survey half
> commitment device. I don't think we have a crisp enough understanding
> of responsibilities of "corporate" maintainers. It always worries me
> when I see someone who never (AFAICT) sent an email to the list before
> get nominated as a maintainer.
> 
> So I'd like to hear from Sathesh, clearly stated, what responsibilities
> and SLAs he's taking on. Once we gather input of this nature from a
> handful of maintainers maybe we can distill a guide in
> Documentation/process/...

Let me suggest one responsibility:

 - reply to maintainers' questions in a timely manner...

Please repost with the answer folded into the commit message
once you figure out what to say.
-- 
pw-bot: cr


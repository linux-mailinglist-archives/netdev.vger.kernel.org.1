Return-Path: <netdev+bounces-46866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C337E6D26
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 16:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91422280F0E
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 15:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEF6200B8;
	Thu,  9 Nov 2023 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL9tDuBl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E8C1E539
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 15:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F527C433C7;
	Thu,  9 Nov 2023 15:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699543132;
	bh=BWKi621+o3MV3TBu2cwBrnUMMH8i0nl+tpyM97wCE+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JL9tDuBlfXa3d6GNJWeLSRTRmYXL3VTA5jo07jPH64c0YhttJjPFABAJjmNak/jzm
	 wmEEGjSBUIU0LGvD68dKJBfflZWQUd2wCI4t7O0SGrCJ8hxEB3XVH1ez+zU89tOXMP
	 NbpZiSjpbyyfev+LVPX05maRXREpPE2kk5xQPpsqqVyaDA81PRmepDD/LiuSXJnmmk
	 wUEcwZ/BPSxIxWB6JCVi1xFRcu8go4EbkTR+z4vKZl/ootuiCwPylsmKjj1+DWFuuf
	 b2xPIPsV7BUEfPBDcwxVEBJ54VGA+Upg3Bk2jKCBSqrrBcLfUAo4ooiQnt0uSpmbCs
	 ycVfIMDnAUElg==
Date: Thu, 9 Nov 2023 07:18:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniele Palmas <dnlplm@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, syzbot+d55372214aff0faa1f1f@syzkaller.appspotmail.com,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Subject: Re: [RFC net-next] net: don't dump stack on queue timeout
Message-ID: <20231109071850.053f04a7@kernel.org>
In-Reply-To: <CAGRyCJHiPcKnBkkCDxbannmJYLwZevvz8cnx88PcvnCeYULDaA@mail.gmail.com>
References: <20231109000901.949152-1-kuba@kernel.org>
	<CAGRyCJHiPcKnBkkCDxbannmJYLwZevvz8cnx88PcvnCeYULDaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Nov 2023 08:40:00 +0100 Daniele Palmas wrote:
> For example, I can see the splat with MBIM modems when radio link
> failure happens, something for which the host can't really do
> anything. So, the main result of using WARN is to scare the users who
> are not aware of the reasons behind it and create unneeded support
> requests...

Is it not possible to clear the carrier on downstream devices?
Radio link failure sounds like carrier loss.


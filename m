Return-Path: <netdev+bounces-40553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BBA7C7A7D
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 01:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7589B207B2
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBA42B5E5;
	Thu, 12 Oct 2023 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Anl92KwL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAC52B5E2
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 23:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D26C433C7;
	Thu, 12 Oct 2023 23:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697153854;
	bh=c+3LuBsESfP3745tdLMWIFPLiLMUt1sjGKjdite7k/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Anl92KwLM6JcUnMUb0WDYDd2thk2/YcUx45EUECGk7flVzyDQX4clEK2HASyFNPDa
	 Ok/p7+YN7QbNEdkOcGMahVWLc/fGMw4wXzAgPkti74KfcsiJ8G57Jef5Sv9l83AL8P
	 pT5HVAdFf3uMS42LYoiEQ8IiuVztBvs6VcipmcHg/SG6W0b8NdxF3SyKV3MQ1IpvXo
	 uaOJM8kuNW+2UPrsbzrXuS3Gk0H+B75tCP7cV/EP6IbqUMwJbfmA9yE2Iwa9fwGejz
	 Q7pxnPTctYOefoGZhrDjSrPRhBKCAsFt06W+mjo/vnd2aTRmqh6XEoM860Ci7v9M/v
	 oWT8PFoDMYhyg==
Date: Thu, 12 Oct 2023 16:37:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xabier Marquiegui <reibax@gmail.com>
Cc: chrony-dev@chrony.tuxfamily.org, davem@davemloft.net, horms@kernel.org,
 jstultz@google.com, mlichvar@redhat.com, netdev@vger.kernel.org,
 ntp-lists@mattcorallo.com, richardcochran@gmail.com,
 rrameshbabu@nvidia.com, shuah@kernel.org, tglx@linutronix.de,
 vinicius.gomes@intel.com
Subject: Re: [PATCH net-next v5 5/6] ptp: add debugfs interface to see
 applied channel masks
Message-ID: <20231012163733.1f61a56d@kernel.org>
In-Reply-To: <20231011223604.4570-1-reibax@gmail.com>
References: <20231009175421.57552c62@kernel.org>
	<20231011223604.4570-1-reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Oct 2023 00:36:04 +0200 Xabier Marquiegui wrote:
> Jakub Kicinski said:
> > If it's a self-test it should probably be included in the Makefile 
> > so that bots run it.
> 
> Thank you for your input Jakub. It's actually designed as a debug tool for
> humans. I wasn't thinking about self-tests, and I can't really think of how
> that could be pulled of in this specific case. I hope that's ok. If not we
> can try to throw a few ideas around and see if we find a way.

Let's not throw random non-test scripts into selftests. It adds
confusion to our pitiful kernel testing story :(

The netdevsim driver which is supposed to be used for uAPI selftests
now supports PHCs. Maybe we can extend it and build a proper-er test?

Whether we'd then want to move the debugfs entries onto netdevsim
or leave them where you have then now is another question..


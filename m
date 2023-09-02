Return-Path: <netdev+bounces-31808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0CC790490
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 02:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28BF31C20926
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 00:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D7A15C3;
	Sat,  2 Sep 2023 00:57:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8959015A5
	for <netdev@vger.kernel.org>; Sat,  2 Sep 2023 00:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859CEC433C7;
	Sat,  2 Sep 2023 00:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693616235;
	bh=1xCsTHQgCtxwTmVpSfoTaVc70IJpszkoKVnt2d+dZgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QS/Kn2C2UGjoX0KyDnbGKRnuQZKuAta6+Jybnv1pYRaP6MMbESi6aIlUc/d6vyQws
	 DjTVTCCw0RwW30COkODW4OseV9BACnRX1M0rO1RXTPdWq9cN7WeHILL8zQPBl6qe85
	 eo3hLFJKAa39MfmyrPelFQr3getUQDPrVICCeXIUOoKmUaF4UV6cZ+vRWeMzWvSau9
	 2z+4X2pfyCMfV+tQawgTAcfi3FQlCs0Mon/cijWhWJ7QwwCUQHo8wUSm157zPQ4lPp
	 mkn5CpXstH7xkwt0p26jdbTcX44DmudNVheYJekOz1sPSquPM3deSgpdIyZmURD6st
	 uKgxcNVJjMLsg==
Date: Fri, 1 Sep 2023 17:57:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Li zeming <zeming@nfschina.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/socket: Remove unnecessary =?UTF-8?B?4oCYMOKAmQ==?=
 values from used
Message-ID: <20230901175714.1f2826bb@kernel.org>
In-Reply-To: <20230902182228.3124-1-zeming@nfschina.com>
References: <20230902182228.3124-1-zeming@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  3 Sep 2023 02:22:28 +0800 Li zeming wrote:
> used is assigned first, so it does not need to initialize the
> assignment.

It's a perfectly legitimate code pattern.
Please do not post any such patches to networking.

Please make sure you have read this:
https://docs.kernel.org/process/researcher-guidelines.html
-- 
pw-bot: reject


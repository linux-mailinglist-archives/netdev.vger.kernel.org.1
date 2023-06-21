Return-Path: <netdev+bounces-12835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A938D73911A
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 22:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D351C20B12
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 20:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9551B917;
	Wed, 21 Jun 2023 20:53:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3173818C14
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 20:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558B9C433C9;
	Wed, 21 Jun 2023 20:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687380803;
	bh=0L/v9EWZjXDD/XXVBVimZjkfkieGicfgH7+D9uEJ7U0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DHr/hNfV+QCFp+OYMbXcuXUiyX4tuPJ1rW38kw98FnmNF3RuTfTFl4QRDSECBOTY/
	 mkHnrrxAUCFUeFMesyPg0ZgVOMCNRqz/UactL/E8cjiWjeO0KwCWSSEPHtHUFVupvK
	 PNys7h5sWHlGV80oh70qNwJ6OoTPk5P2Pt/qqt+YaBs/9bJLCKQ3PUKN7o+1d1dMe3
	 A2PbREdtg+gqKI0jolLYH9yh5jlct+H5z/RjBaiM2k7xv8J/9eQk6ME0lwl2ZrKOTq
	 xSLw6tNMcQT+35Ecu11s0fsscddfTKzgfBS9GGKn3ZdhLvpXL9HwtNIYs3LjvN6qbM
	 MaY+hqnDvRKcg==
Date: Wed, 21 Jun 2023 13:53:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joel Granados <j.granados@samsung.com>
Cc: <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, Iurii Zaikin
 <yzaikin@google.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH 05/11] sysctl: Add a size arg to __register_sysctl_table
Message-ID: <20230621135322.06b0ba2c@kernel.org>
In-Reply-To: <20230621091000.424843-6-j.granados@samsung.com>
References: <20230621091000.424843-1-j.granados@samsung.com>
	<CGME20230621091014eucas1p1a30430568d0f7fec5ccbed31cab73aa0@eucas1p1.samsung.com>
	<20230621091000.424843-6-j.granados@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jun 2023 11:09:54 +0200 Joel Granados wrote:
> In order to remove the end element from the ctl_table struct arrays, we
> explicitly define the size when registering the targets.
> __register_sysctl_table is the first function to grow a size argument.
> For this commit to focus only on that function, we temporarily implement
> a size calculation in register_net_sysctl, which is an indirection call
> for all the network register calls.

You didn't CC the cover letter to netdev so replying here.

Is the motivation just the size change? Does it conflict with changes
queued to other trees?

It'd be much better if you could figure out a way to push prep into 
6.5 and then convert subsystems separately.


Return-Path: <netdev+bounces-30892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E8D789BB3
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 09:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0ED1C2085B
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 07:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1384A53;
	Sun, 27 Aug 2023 07:16:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812D1814
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 07:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61333C433C8;
	Sun, 27 Aug 2023 07:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1693120586;
	bh=HAJvTUoS9SuyCicHEbnAk7Ecn+ThZtFqVswyUPuqpro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=etxzV+Yr30qiLNLM5dWELx1azOncPMyE1zjdh9eBwNqTc4jaDqxhl4hGSyWi+asN7
	 yMIhzZ0cfxanUkUN3FrQ7ehPsHAF0+CgU/aVZoPnKE88F7TIoG058lcsRZNp3xAHrs
	 8HVskqym3z6P8gDnWWymkSJX5uOIXtVczyCm+cCI=
Date: Sun, 27 Aug 2023 09:16:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Garg <hargar@linux.microsoft.com>
Cc: stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, bjorn@kernel.org
Subject: Re: [PATCH 6.1] selftests/net: mv bpf/nat6to4.c to net folder
Message-ID: <2023082703-plenty-colonial-5540@gregkh>
References: <20230822220710.3992-1-hargar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822220710.3992-1-hargar@linux.microsoft.com>

On Tue, Aug 22, 2023 at 10:07:10PM +0000, Hardik Garg wrote:
> From: Hangbin Liu <liuhangbin@gmail.com>
> 
> commit 3c107f36db06 ("selftests/net: mv bpf/nat6to4.c to net folder")
> backport this v6.4 commit to v6.1 to fix this error:
> error: unable to open output file 'linux/kselftest/net/bpf/nat6to4.o':
> 'No such file or directory'

Note, this is a 6.3 commit, not 6.4 :)

Now queued up, thanks.

greg k-h


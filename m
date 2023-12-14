Return-Path: <netdev+bounces-57195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 246B0812551
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376C81C2117C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60302180;
	Thu, 14 Dec 2023 02:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kP8+AqMI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E1BEA3
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474C6C433C8;
	Thu, 14 Dec 2023 02:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702521261;
	bh=RXN5/rSyacpvWraHY2GbXeOvhIwFH3pgd7QurRxyHQI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kP8+AqMIPfRctFhHwHYSCGxsFErGeRZ3MuaH7Heyus3XnoefEyKn1kMHWt5Oo9Wsx
	 tw0MqMDAQ36d4b+FO0b2zpgIXEHhrkAaOtQs5rOknNmZdWATP1Zmk/C9NGdoB0oZDm
	 ybJNrMNvyMcVL9OBIdPom7IUlnjR/1yqlGOIz2jX842NKZS7QdEet9nnKM8s6jjfa+
	 nPvnroYdg0KsOxKvxdjEasyDNxeZJu0YZfD93vdV62A5eXesxP/q4FDvRFZNAz0Fda
	 BVoNsPzBWtDE3JFxHOd4tbemY7UqUmcRyWkW03WTndF4vb4+mRozjT10PwNwAmfWmj
	 vIqKywch0gmTA==
Date: Wed, 13 Dec 2023 18:34:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, hawk@kernel.org,
 linyunsheng@huawei.com, netdev@vger.kernel.org, linux-mm@kvack.org,
 jasowang@redhat.com, almasrymina@google.com
Subject: Re: [PATCH net-next v8 4/4] skbuff: Optimization of SKB coalescing
 for page pool
Message-ID: <20231213183420.78b3be68@kernel.org>
In-Reply-To: <CAKhg4tJDgaVeMp437q1BHuE3aZo2NU4JnOhaQEXepJuQhPnTZQ@mail.gmail.com>
References: <20231211035243.15774-1-liangchen.linux@gmail.com>
	<20231211035243.15774-5-liangchen.linux@gmail.com>
	<CAC_iWjJX3ixPevJAVpszx7nVMb99EtmEeeQcoqxd0GWocK0zkw@mail.gmail.com>
	<20231211121409.5cfaebd5@kernel.org>
	<CAC_iWjK=Frw_4kp-X+c4bN7e19ygqsg78aiiV2qJc59o7Gx8jA@mail.gmail.com>
	<CAKhg4tJDgaVeMp437q1BHuE3aZo2NU4JnOhaQEXepJuQhPnTZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 10:26:47 +0800 Liang Chen wrote:
> If there is no objection, it will be included in v10.

If I manage to reach you before you post - please hold off for another
30min with posting, I'm going to apply patch 1.


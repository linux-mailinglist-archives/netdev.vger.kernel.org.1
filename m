Return-Path: <netdev+bounces-17662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5BC7529C9
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 19:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111E91C213F7
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 17:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83AB1F16E;
	Thu, 13 Jul 2023 17:25:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDA02FB3
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 17:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65ADC433C7;
	Thu, 13 Jul 2023 17:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689269121;
	bh=n85NPxEBgg4xF23G3P9MuejKIyGgMiimuAe1yujxMKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dBj+45iMx4p9c/joV32Qd4r035VJpylzl0sGB8lHtIwF5Kcyr/BF6uHv5a/JEPsht
	 HW8gfk85AZchiQxtn9dS1mFz5/iBkoMRQ/3XzI2A7mxct2zPYclZy5HMCFoPsnqMmO
	 UD6XCTSAtrnz3l8m3bofwaUTIsg5QXsospkN68skuy0eG45Cur+9gq3dy4NoxoZ6JY
	 mkuw9AEh3uoKMR7zP5q+vAxuuemW+sSRXX5txqdb/ctCpB/D9TyfWf9BE9IyxDa0fi
	 F1v2lyyaAcVJf2FsD0i7J8wV18nzKDIKnULuO2UJX24SiX3UurqmE9b05fPAw32umd
	 VkIXsx455tzLg==
Date: Thu, 13 Jul 2023 10:25:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, pctammela@mojatatu.com, simon.horman@corigine.com,
 kernel@mojatatu.com
Subject: Re: [PATCH net-next v4 0/5] net: sched: Fixes for classifiers
Message-ID: <20230713102519.004653d5@kernel.org>
In-Reply-To: <20230712211313.545268-1-victor@mojatatu.com>
References: <20230712211313.545268-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jul 2023 18:13:08 -0300 Victor Nogueira wrote:
> Four different classifiers (bpf, u32, matchall, and flower) are
> calling tcf_bind_filter in their callbacks, but arent't undoing it by
> calling tcf_unbind_filter if their was an error after binding.
> 
> This patch set fixes all this by calling tcf_unbind_filter in such
> cases.
> 
> This set also undoes a refcount decrement in cls_u32 when an update
> fails under specific conditions which are described in patch #3.

I haven't looked the code, and probably won't have the time until 
the evening, so to save time - if these are fixes they will have to
be reposted against net, not net-next.


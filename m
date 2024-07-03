Return-Path: <netdev+bounces-108828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 244A7925CE8
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD891F25830
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 11:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A87A1822E4;
	Wed,  3 Jul 2024 11:13:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5A913247D
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005188; cv=none; b=QAXiv536e8FrAJfirmevQaV0cwK4rmpEpdqOQffXyy61xQvDaRr3KUkQZnX40EpVPcY0Sdl4zoB/+5pMqiyopEQzfRgzRCpyNh40ChgAyaWorLgJ7UVOoBSQN3s3ztWmO23xwmGn8spcbZN0IKPFdKaaEF62eQ0ZOhgRMvUGB9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005188; c=relaxed/simple;
	bh=2Kof6//Lo2TdA0RnUwq+5QCif1dpbv/730NzIi+Wxns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9miy34fek52yyY7AXiDv/0LghS61Rr1/KCrpFFAHgCp/R5Wh+uP2xpdve5+nDBIn7pMYvgWRg8A1bbfaSqY3nNsCapF5J5cKNsUOz2DpTjzw0gMA5kCk/4/QjBrl8eLDJUE2WfGKKmNRhoMKBKi6knl/T3RcwTRHJ5M91+kCuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sOxv4-0007cM-Dv; Wed, 03 Jul 2024 13:13:02 +0200
Date: Wed, 3 Jul 2024 13:13:02 +0200
From: Florian Westphal <fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, edumazet@google.com, davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] act_ct: prepare for stolen verdict coming from
 conntrack and nat engine
Message-ID: <20240703111302.GA29258@breakpoint.cc>
References: <20240703095846.16655-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703095846.16655-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Florian Westphal <fw@strlen.de> wrote:
> At this time, conntrack either returns NF_ACCEPT or NF_DROP.
> To improve debuging it would be nice to be able to replace NF_DROP verdict
> with NF_DROP_REASON() helper,

Sigh, this patch targets *net-next*, not net.


Return-Path: <netdev+bounces-103668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A504C908FCB
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 18:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB5D1F22C36
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2282F16C696;
	Fri, 14 Jun 2024 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHPu368e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8F16CDB3;
	Fri, 14 Jun 2024 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381650; cv=none; b=WhYIDgN4bZpHT8tLi4iFBN93+lhWOtB4rhm5eMtnVFDx892wG2E91IjjtMw2dJmHfSgaPxJAzMFN+jveGWq7NDAx66GM4JdIl3JYJkTe1E2Q3bDoWvMrQbiWKviY6Mph/jQCtLZJ5VOZXQbEu1iMGiK/0r929dh2eyBbISsjci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381650; c=relaxed/simple;
	bh=8hlqOeoJesdrM/kznHbtxymhcdzkztPlTxq5hmHvQlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNFle4RGdWJrTJAT5yTIJkSLMUQ/DGU8V7bsaHa4yj/gOfh7fzLpACMFGBQwc81SZszd5ShoxO8ieQL3nMfISwdoJA5OrqkapmMVx044kmQx49fuzusyBrrrzS9ceo4XZsK9pA3kb136F1mZi/gUoKxofFkabNzSwmhMZHkK6zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHPu368e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EC6C2BD10;
	Fri, 14 Jun 2024 16:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718381649;
	bh=8hlqOeoJesdrM/kznHbtxymhcdzkztPlTxq5hmHvQlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DHPu368eBj4oxKcJlzs7NZzauYfn+j/NAjlcGAlQa3jM6ELI1pqpWmQ8GeUhNuimn
	 mqRhjtdDP47FA6nds9JXRTbo9cank1WWDwcrNg58ugiiN8HkzAWEG8gdYxSVhU3hHI
	 OAOd+SI9x0dYK46AxDEDhMaooi4i7hKAwOJyWj6ZH/dQl9yWbhJKyO/9poIZvxUmgI
	 DZhIB/rL/sLCUlz187TLy3EWEFwOFE82luweUNbX55Qyu5d/FsWF95J/zukQM6jWXk
	 tHML+8mBY3vzud6Z6IwyPS58ofq27aoUvomQp+U9cJYv5OcWg3xnQwdjxGCcZKG8NZ
	 QC5JUeE0GZasQ==
Date: Fri, 14 Jun 2024 17:14:04 +0100
From: Simon Horman <horms@kernel.org>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
	i.maximets@ovn.org, dev@openvswitch.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/9] net: sched: act_sample: add action
 cookie to sample
Message-ID: <20240614161404.GS8447@kernel.org>
References: <20240603185647.2310748-1-amorenoz@redhat.com>
 <20240603185647.2310748-3-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603185647.2310748-3-amorenoz@redhat.com>

On Mon, Jun 03, 2024 at 08:56:36PM +0200, Adrian Moreno wrote:
> If the action has a user_cookie, pass it along to the sample so it can
> be easily identified.
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>



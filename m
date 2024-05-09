Return-Path: <netdev+bounces-94862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B74D8C0E12
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 12:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56DEF2818B9
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 10:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DE814AD2E;
	Thu,  9 May 2024 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyrQqLQW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3C0101E3
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715249968; cv=none; b=ZacilvVPmDL5OYwdFGgU9QQgEHQRRKIAClgLxxRBscbuUKrfNrAREg+xsaBfSxNKjsPA+VBAzXL4MkMNfZthImGGQCOGskiQzje4OdnrPIawr1PW+AhJbKZq+JcJ4mpUHm4oG/IkLh6Rdo6EsZd7A75IEFlN7f35TkPRIO7BGuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715249968; c=relaxed/simple;
	bh=4pX+rcsFqWriPz1NnLQYSoQIBsxXQauB8NgClVuVCSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0MRKLAsDKF6Y/rY49pMcUXaoKwKxfdO4io91exVFc+VZK57k4pDdokfvEP3lx0KRBi5uknB/wZbizpmnzzMHazvAlr3hWnD1EFOtxjbE8PDq3gMckpLuWnZ2NBeqIsC5gKzYHsaJD24AK4umqWWzFHVYPzVtZi6OL2jVGVoiKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyrQqLQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056F9C116B1;
	Thu,  9 May 2024 10:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715249967;
	bh=4pX+rcsFqWriPz1NnLQYSoQIBsxXQauB8NgClVuVCSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NyrQqLQWRScFhuQGicQeVJ1nshTdgtCZXsAAVbcaJWfMVECqYiFKFX16Jq2Jd6FL5
	 i77Pc5yu8haU6ZeImj2pH3xLDl1UjPJSY0Jxoey1K3tYQo12WXdImUWkZdOW2jUsMA
	 X/LOJ8TbUV28eDhU+GaGxAU4h9S8WByrIph8l8Fp5qZ1wYqGz/9lAUGL/q1FYOF/VS
	 kd7zT+fIV61k3RPIc8QSiQlj0zlIOMsFS8sWjZDyi4e191KDQcekA0F4MTrSIBj01S
	 SeeuoGZwC/I6PNL7wTjdsC8VrwGDUjncSTct5MkEOPIFg8l4aaVbPAXRqWmqW4xLMv
	 kI4z2VhDd7u3Q==
Date: Thu, 9 May 2024 11:19:21 +0100
From: Simon Horman <horms@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, laforge@osmocom.org,
	pespin@sysmocom.de, osmith@sysmocom.de
Subject: Re: [PATCH net-next,v3 01/12] gtp: remove useless initialization
Message-ID: <20240509101921.GK1736038@kernel.org>
References: <20240506235251.3968262-1-pablo@netfilter.org>
 <20240506235251.3968262-2-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506235251.3968262-2-pablo@netfilter.org>

On Tue, May 07, 2024 at 01:52:40AM +0200, Pablo Neira Ayuso wrote:
> Update b20dc3c68458 ("gtp: Allow to create GTP device without FDs") to
> remove useless initialization to NULL, sockets are initialized to
> non-NULL just a few lines of code after this.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Reviewed-by: Simon Horman <horms@kernel.org>



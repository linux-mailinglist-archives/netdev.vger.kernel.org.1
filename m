Return-Path: <netdev+bounces-25630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F021774F42
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F90B1C20F8A
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B2F1BB58;
	Tue,  8 Aug 2023 23:21:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C20171C4
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C497CC433C7;
	Tue,  8 Aug 2023 23:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691536894;
	bh=UO/CAV+9k+Ypr7UwjYw0KniEW5xF41GApZGqZ94X9WU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hdhFCGJHzKq7aGhbczZKRryOEhkOBRi15wLhXLf+Qi2He8gSxOARU8NWI5Zxoe6e5
	 fmLjD7yXcDG4ZVbmfzuAUqxw5P7ZWBg5L+JZjw7M5ob6PEk00+oHkbvNQSi1JP8upt
	 IryG56ocvsYxEaeIMs0QOXhQgKtsdnQaHzkTa/JdVMXz8qJiv0ScAf+Yaj7fgew860
	 //v+fDuY7uRDaQqSeiBwZZJx4c2sXHAuHWOls3H5IVhpp/clZVt9gUuEZMYG8OHvVZ
	 odgCSrwGzs/2HJXPepCQ+j3J0HF5GDpwoGQrp/lw/G2zjQvx6h6sToSzU9DdEZkMPG
	 7cA59QTlq604w==
Date: Tue, 8 Aug 2023 16:21:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com
Subject: Re: [patch net-next] ynl-gen-c.py: avoid rendering empty validate
 field
Message-ID: <20230808162132.08eb753f@kernel.org>
In-Reply-To: <20230808090344.1368874-1-jiri@resnulli.us>
References: <20230808090344.1368874-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Aug 2023 11:03:44 +0200 Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> When dont-validate flags are filtered out for do/dump op, the list may
> be empty. In that case, avoid rendering the validate field.
> 
> Fixes: fa8ba3502ade ("ynl-gen-c.py: render netlink policies static for split ops")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>


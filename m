Return-Path: <netdev+bounces-19702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A05F75BC4E
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 04:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA311C215C5
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 02:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D03837F;
	Fri, 21 Jul 2023 02:32:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8FD7F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 02:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDBAC433C7;
	Fri, 21 Jul 2023 02:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689906747;
	bh=/bGJ7Dpp8mZBQYXj/beUp5CjmPx9Nn2Hvv/bbhiBSt8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FZ65JHk9ZHIComW3L3ePEybNU2VZ88rwryJubXwj4KO6e1ZaLSIZvSG18+4nUK0yW
	 l5H/1TZcfQlPGhI7wHNlEM4sRG1zTz+XH8/H73bYfk3MW+thWmynwu8NBfqToSIgnn
	 LVpWGySHztglBuabxSRl63V8cvFNvFivC7IkDq0eNgYdxfERTOdxTNzNubB6+sNRgq
	 wnWjSNYqol/0RdCwSz5HDxuvXQtedp874CH4TDpeDl7sRUKkF9VIoBzUbduznsgDKw
	 VQoEpIIDYiDfDdzl2R7BkUEuiZYec9tkBiiR3DRIiCSKHd+JdQicG52acnLOMWHIWh
	 YwmQ7epziG33A==
Date: Thu, 20 Jul 2023 19:32:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com
Subject: Re: [patch net-next] genetlink: add explicit ordering break check
 for split ops
Message-ID: <20230720193226.57952cd6@kernel.org>
In-Reply-To: <20230720111354.562242-1-jiri@resnulli.us>
References: <20230720111354.562242-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jul 2023 13:13:54 +0200 Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Currently, if cmd in the split ops array is of lower value than the
> previous one, genl_validate_ops() continues to do the checks as if
> the values are equal. This may result in non-obvious WARN_ON() hit in
> these check.
> 
> Instead, check the incorrect ordering explicitly and put a WARN_ON()
> in case it is broken.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>


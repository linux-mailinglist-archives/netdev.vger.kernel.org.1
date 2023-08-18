Return-Path: <netdev+bounces-28977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C837814D6
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 23:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C062281F89
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 21:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BACB1BB5F;
	Fri, 18 Aug 2023 21:38:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEED1BB2F
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 21:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DD5C433C7;
	Fri, 18 Aug 2023 21:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692394694;
	bh=8vE7/TZq6jw1v2pCYKlTMOryuy0zccXxlrw+Wr7lVYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MC0FU6hgq+lVN5mcsi7Qf2CBjeayYn6pbj4NKIpDrL8+sAJRhfH3o0rk/aDakgLlH
	 juOCi00I4TqTdf+p/px5hubIbz/gir0KIHqB3llzciWrgTR1+bmV4oPMdLBoOasbzY
	 coSIJmgCXczcJN76H+QVxCo0P2oxmMbCVMoGU+DVP18FmjGpnoj6cI+yr0uFhMjjxH
	 5QP5RZ8SkWurAFjfdOaBZoGq0mh7orIP5PmmEgn9v/+UZfop25H52vd0PfJu87mKMj
	 PsKQ1K3Qa0N4/1FB1exTE7/C85e2Fm00rx+PTqpq1MhHakFdjd56m1/wBa2uOF5dmC
	 V5xbbMQ/mvTrQ==
Date: Fri, 18 Aug 2023 14:38:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com
Subject: Re: [patch net-next] tools: ynl-gen: use temporary file for
 rendering
Message-ID: <20230818143813.5480504e@kernel.org>
In-Reply-To: <20230818111927.2237134-1-jiri@resnulli.us>
References: <20230818111927.2237134-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Aug 2023 13:19:27 +0200 Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Currently any error during render leads to output an empty file.
> That is quite annoying when using tools/net/ynl/ynl-regen.sh
> which git greps files with content of "YNL-GEN.." and therefore ignores
> empty files. So once you fail to regen, you have to checkout the file.
> 
> Avoid that by rendering to a temporary file first, only at the end
> copy the content to the actual destination.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Neat! I thought this would be harder to implement.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>


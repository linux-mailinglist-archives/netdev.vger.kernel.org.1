Return-Path: <netdev+bounces-53572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC39803C7B
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 19:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0836B281130
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 18:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C1B2EAF3;
	Mon,  4 Dec 2023 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbsC2/PW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C6828694
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 18:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9A9C433C7;
	Mon,  4 Dec 2023 18:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701713493;
	bh=xFlWKLFEIfy+D8QnpSzssGTrOanNQIaSLnaL0/aJ9MY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KbsC2/PWcnyCY/z0zm4cAWfxJvxHYwkYQ83JXDzO8or1QgEKnsxEd9l/nFfRj+aAf
	 ljCTJUnmV2WYKLbv4aQz/ptZ/uMFkvZuegLbTZYSSQ/OXF7GGSWHxKyXd0s81KMv9w
	 kZFgL5vXQCS6IYPAxakVljP5umlUc14LIChM+5orjmGgS+QVsF/IhqCUlV1lfdyQw8
	 n/IvLVcxieGz/RrWKCKgW6A6Kqhvdm4hSMtyQgLMr6NQkomq3R9he1NSdA0z73ezBS
	 TOMg9ZMCGQEvriWPvUuwYqRH2XtYCYbpvD//883WoNvOSozGIQMcyP76Ge0zfdGwPK
	 6Xwc6c9yqHZJQ==
Date: Mon, 4 Dec 2023 10:11:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [ANN] netdev call - Dec 4th
Message-ID: <20231204101132.19ce29f6@kernel.org>
In-Reply-To: <20231204100735.18e622b2@kernel.org>
References: <20231204100735.18e622b2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Dec 2023 10:07:35 -0800 Jakub Kicinski wrote:
> Subject: [ANN] netdev call - Dec 4th

ENOCOFFEE.

I mean Dec 5th, obviously, i.e. tomorrow. 


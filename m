Return-Path: <netdev+bounces-19663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAD975B9A8
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 23:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC4B1C21542
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 21:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514331BE88;
	Thu, 20 Jul 2023 21:37:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C141BB56
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 21:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18DAC433C7;
	Thu, 20 Jul 2023 21:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689889067;
	bh=GZUiHqFRIa9kRqFdnfZG76QIb9kkoyd03I0c7rzEtyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FjhNfRFqD9OiPLhgTKdcW4hQ0kZIJhTHZ2NEg/quOHHTaoMtPNoe2XuiAdXjlbQJr
	 9UAEe1eip8ms1WhUOp6y9/cOoIIlfQm5lbMp90k0a14oSSvvPDe+YhLgLBZEvlk+Mz
	 UdZVfCsS/iDSTIRHRtnYltLW12WLvk3h59LAd8t7RcJ76cF1XbKDQLPHEs8LbuqS1l
	 ocekAft9WQjJ2F/Y3o15wfGmjfDcHuc2ypSLEz+A60jg1fCcN0hkDnE+2QNBuZ9Fy0
	 0ITe+vyojYkS11bfISx/Za/cuv4RwmNBY+lFESbUITd0OnKLYB0jurnSBxOGUT+Bs1
	 oHqjgiW89wo7Q==
Date: Thu, 20 Jul 2023 14:37:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: corbet@lwn.net, Andrew Lunn <andrew@lunn.ch>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mark
 Brown <broonie@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux@leemhuis.info,
 kvalo@kernel.org, benjamin.poirier@gmail.com
Subject: Re: [PATCH docs v3] docs: maintainer: document expectations of
 small time maintainers
Message-ID: <20230720143746.1adb159a@kernel.org>
In-Reply-To: <20230720-proxy-smile-f1b882906ded@spud>
References: <20230719183225.1827100-1-kuba@kernel.org>
	<20230720-proxy-smile-f1b882906ded@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jul 2023 16:15:26 +0100 Conor Dooley wrote:
> ..I noticed that none of these sections address actually testing the
> code they're responsible for on a (semi-)regular basis. Sure, that comes
> as part of reviewing the patches for their code, but changes to other
> subsystems that a driver/feature maintainer probably would not have been
> CCed on may cause problems for the code they maintain.
> If we are adding a doc about best-practice for maintainers, I think we
> should be encouraging people to test regularly.

I think our testing story is too shaky to make that a requirement.
Differently put - I was never able to get good upstream testing running
when I worked for a vendor myself so I wouldn't know how to draw 
the lines.


Return-Path: <netdev+bounces-20970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE2C762055
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AC3C1C20F21
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD2B25917;
	Tue, 25 Jul 2023 17:38:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E372925140
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 17:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A27BC433C8;
	Tue, 25 Jul 2023 17:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690306697;
	bh=oDZeaVx0NG6y/7Xay0XZUgP0AHrF1ly8+FT/sU8uqRE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q+yeeX/FgAlwchVBw2Pv1mNrvF1WSQqmxPkeqy+fyc7siAl8Ibyb3vWy72BTaIJed
	 F13IH+hbqjMdu/ieQLleF1KkDjvr6Gt4rfEAo3XOYbb7Q99p0JIGAwKODMQfBZi8GT
	 EkEAh+r8ew9gnjJCsFSTXjkv4A22N2Gwt1+rHKZj/PnGqtnRXkEyxOh1f7NmFF35v/
	 uL8feBR7o3xINXMiP8ckwi7LVE6ruvdFtN/BcGizhjAYqcNhWCelJ+9STjRa/tmBJd
	 9jl0AYsx2sW4aVjP5ZVC8ZXBlE2pLct2o5LqfxfIufRRJJOTsAFKNgkfUNLISX8E2f
	 /6MxojjShfGiw==
Date: Tue, 25 Jul 2023 10:38:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
 idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v2 08/11] devlink: introduce set of macros and
 use it for split ops definitions
Message-ID: <20230725103816.2be372b2@kernel.org>
In-Reply-To: <20230720121829.566974-9-jiri@resnulli.us>
References: <20230720121829.566974-1-jiri@resnulli.us>
	<20230720121829.566974-9-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jul 2023 14:18:26 +0200 Jiri Pirko wrote:
> The split ops structures for all commands look pretty much the same.
> The are all using the same/similar callbacks.
> 
> Introduce a set of macros to make the code shorter and also avoid
> possible future copy&paste mistakes and inconsistencies.
> 
> Use this macros for already converted commands.

If you want to use split ops extensively please use the nlspec
and generate the table automatically. Integrating closer with
the spec will have many benefits.


Return-Path: <netdev+bounces-29845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA18784EA5
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 04:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E3B28126F
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 02:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E297415AE;
	Wed, 23 Aug 2023 02:21:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE8210E9
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 02:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2924BC433C7;
	Wed, 23 Aug 2023 02:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692757283;
	bh=OmMA2cNYi5uqKLHPnfTToPfIm8rFnARJwjZuYF8l5O0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S8vOctK3xYd212kYXplu2O1YDGiuTVzX9xYC1oDbF2J/lEwXexfsXjw/SDEtO0pZo
	 LLu1T+tb+HC02BQjjW9V+B/hcC81C4+jE68+nBKHSnvFFnEtg/psgz44XtQsPpq+Fa
	 OaCYXa+XrK1DYXNVKdauB8oOAxEu9PZeyP8iK2iwi5sQZ6YMVokD+5jiHlQOTmayM/
	 Obthv8xeDzHKvchuYZMU6Tql0k6Ez4iPbBF+jhqA6SE5VYNdu0ULOHhg8j6r6jHQjQ
	 CFE16sC24RsTfxCl+nbemFt1koF53LF/4EW4wshk/haqajHu+BjXxcUb80VttDmSuo
	 JhZ+RuZVjjnZQ==
Date: Tue, 22 Aug 2023 19:21:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jiri Pirko <jiri@resnulli.us>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Milena Olech
 <milena.olech@intel.com>, Michal Michalik <michal.michalik@intel.com>,
 linux-arm-kernel@lists.infradead.org, poros@redhat.com,
 mschmidt@redhat.com, netdev@vger.kernel.org, linux-clk@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>, intel-wired-lan@lists.osuosl.org,
 Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next v5 2/9] dpll: spec: Add Netlink spec in YAML
Message-ID: <20230822192122.00f40f0b@kernel.org>
In-Reply-To: <20230822230037.809114-3-vadim.fedorenko@linux.dev>
References: <20230822230037.809114-1-vadim.fedorenko@linux.dev>
	<20230822230037.809114-3-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Aug 2023 00:00:30 +0100 Vadim Fedorenko wrote:
> +      -
> +        name: dpll-caps
> +        type: u32

Why is this one called dpll-caps (it's in the pin space)?
"doc:" could help clarify the rationale?

Also enum: pin-caps ?


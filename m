Return-Path: <netdev+bounces-27551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FE077C617
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 04:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B1C2812FE
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 02:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38B917F2;
	Tue, 15 Aug 2023 02:52:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0D4622
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 02:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6ACC433C7;
	Tue, 15 Aug 2023 02:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692067928;
	bh=fBlx8M6J3Snxii8KHE1eW/jzAOIKz2CzUVfAHu/9/ts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t9iFMyLeDP4MDfepY6USEo/x0FM5GK6yxCkWbKdBAvf4yGPHnUdXuty3oeoBY6nCO
	 gaqRJKCsFELr+kJXMxHSpTsiTtkn56mBUQRNJj9LlqTi+HxmZH/in0ov3TEKvLjhTw
	 GDst/Gkh6SjKTYywrDBpWmhGkV6tEzt81VLSp9oP6NrThOdE1Ridb6joIbqhh8DZIw
	 zrgO4k7Zf3V2H7dra8xvR5GHi9NTqdoAzMLvd95YDNxSfxMdgo8FKI3XiYQzR5tsPl
	 jGx72s2nHXW65snF5+WR0YruT4iHxzgHPRiCprjz/qOdi8ftKLqaBPm7D1FKEGN9LG
	 gPuLAJ8/QCCCA==
Date: Mon, 14 Aug 2023 19:52:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jiri Pirko <jiri@resnulli.us>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Milena Olech
 <milena.olech@intel.com>, Michal Michalik <michal.michalik@intel.com>,
 linux-arm-kernel@lists.infradead.org, poros@redhat.com,
 mschmidt@redhat.com, netdev@vger.kernel.org, linux-clk@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>, intel-wired-lan@lists.osuosl.org,
 Bagas Sanjaya <bagasdotme@gmail.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next v4 1/9] dpll: documentation on DPLL subsystem
 interface
Message-ID: <20230814195206.1d3ac1e0@kernel.org>
In-Reply-To: <20230811200340.577359-2-vadim.fedorenko@linux.dev>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
	<20230811200340.577359-2-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Aug 2023 21:03:32 +0100 Vadim Fedorenko wrote:
> +the callback operation. Neverthelessi, there are few required to be

Neverthelessi


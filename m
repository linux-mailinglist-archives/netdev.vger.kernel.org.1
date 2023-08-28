Return-Path: <netdev+bounces-31114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A462A78B88F
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 21:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58879280ED7
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 19:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E83214015;
	Mon, 28 Aug 2023 19:41:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7647D13AF8
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 19:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97074C433C7;
	Mon, 28 Aug 2023 19:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693251713;
	bh=FRkyoN28bA0TvlJ3RY9iFOdJIYYMOxmsjaIcU+xn6HA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z6ykNQHj5v1smymmy8iT87a87m3qn0RUsD5d6MSzm0nvQocIRjlQjx5T/gkjcCnq4
	 ebQrqlBLCwhtPUeyi835/CATC7qcAPDZJV4CIeVAQoP6bA8aG23275zbf0c4qB4/kg
	 GFm01kwEWoZRq7iP+n1THZK/kDlw1PmVogBxepsSxKtSpio50As0QTGelcex8AbnaA
	 /xjeHsLgLk0thp8nOVnIAlZ6sWfORKVj57Bofp7+D45XiRPWzUcNHoLddqgfbOIoMQ
	 uB/TO/FSzvVh+FgYSOGioLZjOsc3BfqALSUxdLcUR9leFRBHsB+ejUFC6go3IDgHCU
	 mkrkQsKrHXWPg==
Date: Mon, 28 Aug 2023 12:41:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jiri Pirko <jiri@resnulli.us>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Milena Olech
 <milena.olech@intel.com>, Michal Michalik <michal.michalik@intel.com>,
 linux-arm-kernel@lists.infradead.org, poros@redhat.com,
 mschmidt@redhat.com, netdev@vger.kernel.org, linux-clk@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v7 0/9] Create common DPLL configuration API
Message-ID: <20230828124151.37130b34@kernel.org>
In-Reply-To: <20230824213132.827338-1-vadim.fedorenko@linux.dev>
References: <20230824213132.827338-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Aug 2023 22:31:23 +0100 Vadim Fedorenko wrote:
>  41 files changed, 8050 insertions(+), 96 deletions(-)

After some deliberation we decided to play it safe and defer 
DPLL to v6.7, sorry.
-- 
pw-bot: defer


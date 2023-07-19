Return-Path: <netdev+bounces-18791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79307758A85
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 02:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340462818B4
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 00:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719AD15CC;
	Wed, 19 Jul 2023 00:52:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4334715A9
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:52:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7645BC433C7;
	Wed, 19 Jul 2023 00:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689727959;
	bh=HfJ9IwkZpA0DnsGaCCPzZGNvi3wNsmCaWhNsFEfRRfw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L8xrRIhgHZIA2vZzZcyfRAaoy16jSE6VTUL4iQ5afl+1gx7H9K6qRoWf4UT++eyM3
	 t9FupmSc1LxUt6LDKAFxRR7UWwIFTUNoIZkWBFL+g5yHcX9PqnoVn3XnQrLia8fO0E
	 cnWqfYUIBSrq2lUJaUKWXkV5bbVeqlJlzR3sXb7VF10519O1IitxMcxBg71TpdSnxX
	 hKpL4JHOQiwVh4tiA60p7eSVAHCaCYW9ODoWpOd0aQKunvp550gxXmSMjsl8AhtcR9
	 pfFKQXJ5TqMZneCmUvONnOAwHN1miSjYmBrLi9HzePPOhwNibdvZQZ59zw9dAbCL7O
	 hG17WwBrvfpaQ==
Date: Tue, 18 Jul 2023 17:52:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Minjie Du <duminjie@vivo.com>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com (maintainer:MICROCHIP LAN966X ETHERNET
 DRIVER), "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org (open list:MICROCHIP
 LAN966X ETHERNET DRIVER), linux-kernel@vger.kernel.org (open list),
 opensource.kernel@vivo.com, Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net v4] net: lan966x: fix parameter check in two
 functions
Message-ID: <20230718175238.226810e3@kernel.org>
In-Reply-To: <20230717022235.1767-1-duminjie@vivo.com>
References: <20230717022235.1767-1-duminjie@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jul 2023 10:22:35 +0800 Minjie Du wrote:
>  	vrule = vcap_get_rule(lan966x->vcap_ctrl, rule_id);
> -	if (vrule) {
> +	if (!IS_ERR_OR_NULL(vrule)) {

Please make vcap_get_rule() return an error pointer rather than NULL.
Mixing the two is a common source of errors.
-- 
pw-bot: cr


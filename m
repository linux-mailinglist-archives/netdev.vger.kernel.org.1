Return-Path: <netdev+bounces-38083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21827B8E5C
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 22:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id E73F11C20865
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 20:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5D123742;
	Wed,  4 Oct 2023 20:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPOSpeR3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944C122EED
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 20:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E46AC433C8;
	Wed,  4 Oct 2023 20:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696453115;
	bh=Kgxn5AIRhIWtyFuMGakZL10Svqz1LmHd7tgwEA8m0mQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bPOSpeR3Kg+uel4BpVB4iitLFWAWZNuCZ6+LM3nNieGz7u6iwhvavHV8mv4YQga0z
	 u37whBN/5hAI7VMB3JT/0OJW6pE7/g78JOFvDN7jgNLiDuwC/9SiXf5OieVX1AVGqS
	 t79tRLJ9JdW0JuR2+0sQ8bKLVr572azXKoPkIE0e3qk5PnTzHdNecOpoO8oty6aLFD
	 czWWgfPFRpDEGVymkAcJQb2cN3L2MbTpO5wkGTRm+3U4bw1Fa8X3kVV9Hbcp3EnWay
	 ct2XO5c/wRgQxa3UurRvBhtSqDQdbTALZ978+wzX88JcH5fAqKPOjc5mu68uSEq8e9
	 lXYitUvjiMQBA==
Date: Wed, 4 Oct 2023 13:58:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@kernel.org>, Vignesh
 Raghavendra <vigneshr@ti.com>, Richard Cochran <richardcochran@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David
 S. Miller" <davem@davemloft.net>, <vladimir.oltean@nxp.com>, Simon Horman
 <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, Roger
 Quadros <rogerq@ti.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH net-next v3] net: ti: icssg_prueth: add TAPRIO offload
 support
Message-ID: <20231004135833.6efdbced@kernel.org>
In-Reply-To: <20230928103000.186304-1-danishanwar@ti.com>
References: <20230928103000.186304-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Sep 2023 16:00:00 +0530 MD Danish Anwar wrote:
> +/**
> + * Config state machine variables. See IEEE Std 802.1Q-2018 8.6.8.4
> + */

Please use correct kdoc format with all members documented or not use
the /** marker.

> +struct tas_config_list {
> +	/* New list is copied at this time */
> +	u64 config_change_time;
> +	/* config change error counter, incremented if
> +	 * admin->BaseTime < current time and TAS_enabled is true
> +	 */
> +	u32 config_change_error_counter;
> +	/* True if list update is pending */
> +	u8 config_pending;
> +	/* Set to true when application trigger updating of admin list
> +	 * to active list, cleared when configChangeTime is updated
> +	 */
> +	u8 config_change;
> +};
-- 
pw-bot: cr


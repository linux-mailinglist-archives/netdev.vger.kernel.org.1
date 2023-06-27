Return-Path: <netdev+bounces-14295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0795673FFFD
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 17:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47433281000
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 15:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0AD1993A;
	Tue, 27 Jun 2023 15:46:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F1518C3B
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 15:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F171C433C8;
	Tue, 27 Jun 2023 15:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687880812;
	bh=citRCY1nXVM5YZjWqN+A8/dMciHAof7pxHR25ffEWQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=THP1uOpqKpG4iNLYRsx15JbN7wHnC/BFSxc51Tx28ToHIYQD+Ad49doHsw9tUHnwk
	 TdWUv+bKLJqn9cs7xRX+/Yx+yB5NPVsjwJNwcIXUwc1ir55zTeP8JNN7kOuVcrqfWy
	 lrZ89+2lIEc7lXcCrgNzobFDd8UFRm9SS5icb/M1Rnv0kgbz4tTq56PiaoFgW+S88+
	 wCmNmxDBCTYCQwWWRYo+Pg9B8MtPCTMEeBUMgM3BDOoqCIjeI+ZPGadV7fmgQtYE0Z
	 Ke+JYr/pQ9Jj3VbHYWkAmaHS1tx5mJXMo/kA6QkG0wLvSD0dDk7tMR41jbq16m2g5p
	 wk197WmcbQQdg==
Date: Tue, 27 Jun 2023 08:46:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, UNGLinuxDriver@microchip.com, Xiaoliang
 Yang <xiaoliang.yang_1@nxp.com>, Richard Cochran
 <richardcochran@gmail.com>, Antoine Tenart <atenart@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] net: dsa: felix: don't drop PTP frames with
 tag_8021q when RX timestamping is disabled
Message-ID: <20230627084651.055a228c@kernel.org>
In-Reply-To: <20230627151222.bn3vboqjutkqzxjs@skbuf>
References: <20230626154003.3153076-1-vladimir.oltean@nxp.com>
	<20230626154003.3153076-4-vladimir.oltean@nxp.com>
	<20230627151222.bn3vboqjutkqzxjs@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jun 2023 18:12:22 +0300 Vladimir Oltean wrote:
> This is still not as good as I had wanted it, because simply checking
> for HWTSTAMP_FILTER_NONE does not distinguish between L2 and L4
> timestamping filters, and a port configured just with L2 traps will
> still drop L4 PTP packets.

Out of curiosity - quick survey on why your reply does not contain:

pw-bot: changes-requested

 a) your email address is different and the bot doesn't understand
    aliases
 b) commands are hard to remember
 c) don't care about patchwork
 d) laziness
 e) other


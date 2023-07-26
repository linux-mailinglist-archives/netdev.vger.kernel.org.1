Return-Path: <netdev+bounces-21490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5FC763B43
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB181C21224
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62D5253D8;
	Wed, 26 Jul 2023 15:39:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5B01DA5F
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA2EC433C7;
	Wed, 26 Jul 2023 15:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690385957;
	bh=mIOGi0gBMHEqkGdNbDH6LW1lZ3Ao6lr4wjejxd0zmN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rKGZlp8LCfTHU4nOTm5q1zIvNpqloNGZQT5n5WzPRJ02MVLq4ePApKs/YcHVrX+er
	 KZ4/TCKkW1ETlfevpKlFrhg39pu0ZZ7roInTfdqAXsyrQE/yWMhiY8GVKqOoDWWiw0
	 VPKwLJmW++zUTqwR3/16foXuKSOpXnIamtITS0RvoRuqM+obd2mOuKwpUrSTmQ/77K
	 2wXRQkuq/RFwGkjunUqBUrXwfjnyZezX9sZ/tGD50YMPTJmyL71g62GrVMudd8mBY1
	 9S2EevaUtdF0zxMdl37QDa1Gg+xQvDPbBtfUc/Auv5ypPDvrsadTPIB8eF2sMiAoot
	 wEzY0euh6PYfw==
Date: Wed, 26 Jul 2023 08:39:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Md Danish Anwar <a0501179@ti.com>
Cc: MD Danish Anwar <danishanwar@ti.com>, Randy Dunlap
 <rdunlap@infradead.org>, Roger Quadros <rogerq@kernel.org>, Simon Horman
 <simon.horman@corigine.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew
 Lunn <andrew@lunn.ch>, Richard Cochran <richardcochran@gmail.com>, Conor
 Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David
 S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXTERNAL] Re: [PATCH v11 07/10] net: ti: icssg-prueth: Add
 ICSSG Stats
Message-ID: <20230726083915.1323c501@kernel.org>
In-Reply-To: <296b0e98-4012-09f6-84cd-6f87a85f095f@ti.com>
References: <20230724112934.2637802-1-danishanwar@ti.com>
	<20230724112934.2637802-8-danishanwar@ti.com>
	<20230725205014.04e4bba3@kernel.org>
	<296b0e98-4012-09f6-84cd-6f87a85f095f@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 16:06:06 +0530 Md Danish Anwar wrote:
> > Are the bucket sizes configurable? Can we set the bucket sizes
> > to standard RMON ones and use ethtool RMON stats?  
> 
> The bucket sizes are not configurable. Bucket size is read from hardware and is
> fixed. I don't think we can configure bucket size and use ethtool RMON stats.
> It's better to dump bucket sizes via ethtool -S.

The buckets in the ethtool API are up to the device to define.
Driver returns bucket ranges via struct ethtool_rmon_hist_range
from struct ethtool_ops::get_rmon_stats.


Return-Path: <netdev+bounces-30423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B140D7873F0
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 17:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2F5281582
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7739712B94;
	Thu, 24 Aug 2023 15:20:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD0A100DC
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 15:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA89C433C8;
	Thu, 24 Aug 2023 15:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692890440;
	bh=KN7cymyG/qwFVaSKXJdF2fwt9NoRwhRtC+EooIL1RaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LcxQxcMMxhYcBZXrvmOVBb/kLifU0H6t4KXgAdXxa43pjsns5lBzc/cjsBSGrn4sT
	 J1rTjc7UFZ+1IrIwMbc2DTq6wB74sCg6oJ9ULDDN6YQpxGCaLI+X7ooKpxwsp6YPuO
	 zIToOrWRxaNrk8nCD5v02yPR/LOBIfgz9RkyXEAZj3MymCKghl05C896vGeKz+4cGt
	 syMqZGzVwLsgEKu3S90Kipvy8AUK29iQJpfBq7GA96oIh9FVZYLqOXaZphROvBFgL/
	 iVCelHScLWQpnYwb8zxhYWhGZy/nMUAi2V8kpW3evsV5XPyQ8L19KWcJisO2enw4tt
	 W7GNoTAPPK/kg==
Date: Thu, 24 Aug 2023 08:20:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Junfeng Guo <junfeng.guo@intel.com>, anthony.l.nguyen@intel.com,
 jesse.brandeburg@intel.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 qi.z.zhang@intel.com, ivecera@redhat.com, sridhar.samudrala@intel.com,
 horms@kernel.org, edumazet@google.com, davem@davemloft.net,
 pabeni@redhat.com
Subject: Re: [PATCH iwl-next v8 00/15] Introduce the Parser Library
Message-ID: <20230824082039.22901063@kernel.org>
In-Reply-To: <20230824075500.1735790-1-junfeng.guo@intel.com>
References: <20230823093158.782802-1-junfeng.guo@intel.com>
	<20230824075500.1735790-1-junfeng.guo@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Aug 2023 15:54:45 +0800 Junfeng Guo wrote:
> Current software architecture for flow filtering offloading limited
> the capability of Intel Ethernet 800 Series Dynamic Device
> Personalization (DDP) Package. The flow filtering offloading in the
> driver is enabled based on the naming parsers, each flow pattern is
> represented by a protocol header stack. And there are multiple layers
> (e.g., virtchnl) to maintain their own enum/macro/structure
> to represent a protocol header (IP, TCP, UDP ...), thus the extra
> parsers to verify if a pattern is supported by hardware or not as
> well as the extra converters that to translate represents between
> different layers. Every time a new protocol/field is requested to be
> supported, the corresponding logic for the parsers and the converters
> needs to be modified accordingly. Thus, huge & redundant efforts are
> required to support the increasing flow filtering offloading features,
> especially for the tunnel types flow filtering.

You keep breaking the posting guidelines :(
I already complained to people at Intel about you.

The only way to push back that I can think of is to start handing out
posting suspensions for all @intel.com addresses on netdev. Please
don't make us stoop that low.


Return-Path: <netdev+bounces-27543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2991E77C5D1
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 04:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC231C20BF9
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 02:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3F017EF;
	Tue, 15 Aug 2023 02:24:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0FB17C4
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 02:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04F2C433C7;
	Tue, 15 Aug 2023 02:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692066286;
	bh=YzFumFPtqrwSK4VHj0Z/KqQf+hXultCGJnBS7Rx6tpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FmfapLA6WohmBPxTtaWnzFHppnHRokH4mx55T0Gv7pOqLN5JolNzAFv5gNsACOui+
	 9qhAoOdmtpC8nFTTR3x9YLp4cWvPhbVrb5tadWtlKLNv2/gKSqlEPTesO5WJM82+Yk
	 kQC8rdofe+ZokisXWXtPmpT5eczC9YGk4wRP5mm+70vU+jvebNlobA+bxvj3GX/0o3
	 o76kERfjY5jHwjOwxP8qyETNDD2298k8W3JiLi0le/xtSsXknSEusB9VgNqFwXk12n
	 XxolG/PJ4bQxm/u08apyaZ25FW7JpeVep1+3KdCTZzv77HJcC4lj5icE15BEg5pwwG
	 YQnGch5SX0vSw==
Date: Mon, 14 Aug 2023 19:24:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 pabeni@redhat.com, apetlund@simula.no, netdev@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>
Subject: Re: [PATCH v2 net] net: fix the RTO timer retransmitting skb every
 1ms if linear option is enabled
Message-ID: <20230814192444.24033764@kernel.org>
In-Reply-To: <CAL+tcoArZtbDKFMCC=i+v3fE1iG+UOBn4KhPxB-85rJCh882Xg@mail.gmail.com>
References: <20230811023747.12065-1-kerneljasonxing@gmail.com>
	<CAL+tcoArZtbDKFMCC=i+v3fE1iG+UOBn4KhPxB-85rJCh882Xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 10:08:13 +0800 Jason Xing wrote:
> I wonder why someone in the patchwork[1] changed this v2 patch into
> Superseded status without comments? Should I convert it to a new
> status or something else?

Ack, looks like a mistake, let me bring it back.
-- 
pw-bot: under-review


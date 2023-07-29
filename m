Return-Path: <netdev+bounces-22526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6FD767E77
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 13:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DA62824A7
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 11:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1C11427A;
	Sat, 29 Jul 2023 11:11:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299563D70
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 11:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9053AC433C8;
	Sat, 29 Jul 2023 11:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690629082;
	bh=nMJ+kE4TRdqTyV1GxAU9xGfFPVzM9pjTVlHLPwJSpiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b6hpMogIP8l/S6KNOtfuv1t6ZZDWoDxZf/74COXKq9lXRW1Lx2lZ4Nf5WbwPKwdCs
	 S4E7Ip/dSmt6cPBg9m8q7YNMSO15HXjzw8EVhaeNJz6ff/n8xbGf3pZk+SGpTTpGyu
	 s1orJEKpGzp7rJCJvjbzkEOGgOkmgXmxHcCvuyiY4KDUJxR9Jw7wuFmHJt+lcYcxW0
	 xsSx4++WfWPmoaYDQmk7aebjsYvwvKxZ843NGYx/cEuiG96mrpnMwdL4JRm08Ni9go
	 i6I9lo8JPknPOfbSm3j+nWGgnxeu6gK1RlspPnlSmXVpjNuTnASLa0E+znPUmkXZFb
	 gUIZw7LP2k0HQ==
Date: Sat, 29 Jul 2023 13:11:19 +0200
From: Simon Horman <horms@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	pmenzel@molgen.mpg.de
Subject: Re: [PATCH iwl-next v2] ice: Support untagged VLAN traffic in br
 offload
Message-ID: <ZMTz11K9nbOyr6/I@kernel.org>
References: <20230728083042.13326-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728083042.13326-1-wojciech.drewek@intel.com>

On Fri, Jul 28, 2023 at 10:30:42AM +0200, Wojciech Drewek wrote:
> When driver receives SWITCHDEV_FDB_ADD_TO_DEVICE notification
> with vid = 1, it means that we have to offload untagged traffic.
> This is achieved by adding vlan metadata lookup.
> 
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>



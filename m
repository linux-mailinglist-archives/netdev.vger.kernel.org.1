Return-Path: <netdev+bounces-32733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF68E799EB9
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 16:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB32828117E
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 14:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC8D79D2;
	Sun, 10 Sep 2023 14:57:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C3A257E
	for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 14:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E267C433C8;
	Sun, 10 Sep 2023 14:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694357840;
	bh=B6xci8mz2Oq6u/KskiGLXgJ/4fXTBxSYPFZDVhTcXB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ElP2EUjEnKxAlXIjojqpQ2WhzzDSDf73/8fawcCcSCdfM8TC3OjnAfHnagu/QL6f3
	 4lOntSn3d6hWC/e1PV251M0frRqYNRv2mRHJZwDjrWvVQZIHRrAxg/0kUJ2WuFrsiM
	 MIZeviYkQu4Y+bjIbrlc0Mr9BsavSRqgVAX60kp357CsJmgRbiNyiWdo48nQl62jER
	 w94SqidpA8KvLgqLejFz1aoKj7n+/r5P61pAjIQMegnWILy8XUkt1vVDwTpCFP211G
	 6/MNdVGxgUlCf75FseF1ydt4D0dZI2Yq39TVDXNF4z6BgjGw1dsGp2PYksUwAHaPc+
	 x2nnp2vFdKTAQ==
Date: Sun, 10 Sep 2023 16:57:16 +0200
From: Simon Horman <horms@kernel.org>
To: Andrii Staikov <andrii.staikov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net  v4] i40e: fix potential memory leaks in
 i40e_remove()
Message-ID: <20230910145716.GG775887@kernel.org>
References: <20230908124201.1836101-1-andrii.staikov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908124201.1836101-1-andrii.staikov@intel.com>

On Fri, Sep 08, 2023 at 02:42:01PM +0200, Andrii Staikov wrote:
> Instead of freeing memory of a single VSI, make sure
> the memory for all VSIs is cleared before releasing VSIs.
> Add releasing of their resources in a loop with the iteration
> number equal to the number of allocated VSIs.
> 
> Fixes: 41c445ff0f48 ("i40e: main driver core")
> Signed-off-by: Andrii Staikov <andrii.staikov@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>



Return-Path: <netdev+bounces-77124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D13D870476
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E73C1C232AA
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 14:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B414087C;
	Mon,  4 Mar 2024 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4p9LZdB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1C53FB1D
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709563440; cv=none; b=V0RXnfo44qZo0YHujtwse0safOnEnD3HuKRvtCzLvG79mV+QVV6XoxmBGxxHbL2O2OLsk1/B8PiVmapbh6p6/M2E26KdRdSvAmY4AqNyfbkNF1KXV7VyScuYeX26aFxxLgF4T5hhoU4Zbi/NijRUJFWiOtOa1GQTfEy615zTr7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709563440; c=relaxed/simple;
	bh=bEhj8MkH9zps2B9fx2sNVBMGwFdbii9vKt5z9Crpbo8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iwv6L4ighpDBerm9td+iEYcbr07bVQPaanM4iTgAkogvl9xJbRGeXLg3hH1iR0lQ2G3gVTvPB9rOyJl93vNRrXRnGxGAK+ui/lV8Re4/pBsmKvxVBX2JETpbUZQkEjeB0WXqhdzmcFnXY5SUNU8bzB3/2EmrGERlhmzQaDVSnbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4p9LZdB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFBAC433F1;
	Mon,  4 Mar 2024 14:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709563439;
	bh=bEhj8MkH9zps2B9fx2sNVBMGwFdbii9vKt5z9Crpbo8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L4p9LZdBkqP9F8k9N1gHb6G2bdPZnZpqh9yg5fuR8A886tXYy+zxQ4w6OYZwKD+Ul
	 PDjdRlb6F17WAug4cC8RvJykvQJsEadxSMuXTXh2r1LmGaH1V75bln7KF2W5RXni6F
	 gIdR7EQ6uwtlF3VghvImV0Uvaa7JvhkwVri8gzTfhC0Csot7lE6Vot7yxbTZlq9OOM
	 E04Ewznpih5JD5R6/5Qx6lkbfW/Cfi3JHo0OVewh45/mA4yAJB+HJTomaclvq+Dggg
	 uEA0Q67vlROg16G4RcPc9ufxkPwk7j5r27kaKb0mJ5BYmRZcc1RmDnE3Re9ibEUbW/
	 FgTMw57+cqeZw==
Date: Mon, 4 Mar 2024 06:43:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
 <edumazet@google.com>, <petrm@nvidia.com>, <bpoirier@nvidia.com>,
 <shuah@kernel.org>
Subject: Re: [PATCH net-next 0/6] selftests: forwarding: Various
 improvements
Message-ID: <20240304064358.62850781@kernel.org>
In-Reply-To: <20240304095612.462900-1-idosch@nvidia.com>
References: <20240304095612.462900-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 11:56:06 +0200 Ido Schimmel wrote:
> This patchset speeds up the multipath tests (patches #1-#2) and makes
> other tests more stable (patches #3-#6) so that they will not randomly
> fail in the netdev CI.
> 
> On my system, after applying the first two patches, the run time of
> gre_multipath_nh_res.sh is reduced by over 90%.

Great stuff! On the debug runner the total runtime for
gre-multipath-nh-res goes from 10016 sec (and timeout)
to 105sec! The overall runtime for the suite cut from 3h
to 1h31min. With 6 extra passes. I'll remove vxlan_bridge_1d.sh
from filtered once we merge.

Acked-by: Jakub Kicinski <kuba@kernel.org>

Thank you!


Return-Path: <netdev+bounces-137491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D79F79A6B31
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 980B5282036
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 13:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B161F4717;
	Mon, 21 Oct 2024 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h19xc56z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12252383A2
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519027; cv=none; b=MzsB0UJOPjPtApqcw0aemev/n1IpnrEE/75aNQuNuE7o8agaQEkc9OJZ12o3xDq8DMhgrJnnNn6WgDlzHJnxlwyOlhQ6oxiAwYInXAQ9JpOfi/LBLEzLZifPVbpfBNQ9t1BkSHP4KioF+dM5eV+53CdKQXbJWmVOjsRT5xDS8Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519027; c=relaxed/simple;
	bh=ocsaoy6SWeiXZExB3xTvWnrst7hsXXBiL9gmodujsXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcYlsoJ2/GKZO41E+LzD5CJRc+lHY2Rq0fSxZvPNHT0NzVZR0XBjARsajKmzOKrpPzZY5Gso4Z6oj5DyX0LJbYs2+/3/HrECooieEcLt0MRTpiShT/Q+Pq8n5h4AvaOWtM55Zkd/GsZ9OEFkJbW7nqFDx8saMkqtkBCoUiSIk9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h19xc56z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1B7C4CEE5;
	Mon, 21 Oct 2024 13:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729519026;
	bh=ocsaoy6SWeiXZExB3xTvWnrst7hsXXBiL9gmodujsXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h19xc56z7lB2IH9Ubgecft+IP4+Ljvljpnd5smQs7hvGjo7+OeGJR2+W70xnlyvua
	 J9jOcBrmTcpq8FOpBX3AK7bySWMDJKhZAAUOS1wzmkg3oytjO8ZE+cVLVcHXmTt643
	 xtikDqNVZUmB2mFPefaoPU8euU7qqlO4gx6VQCgrhsPz8yr3uO/JQy8ct6nKH3iCpk
	 Z4ynHU4ij9qQwgJiU9NMiyRJ4CAUhlBi6aehgsZj6sDiBpr0/VEY4JYya/IzYdC2We
	 P4AFm7PHwbrEy5T9k/pWB1cE6qFFyjr7V3mSN61aHTxdCpX6anznER/7aHmcEY8Q6P
	 8LojI1m8uyhBQ==
Date: Mon, 21 Oct 2024 14:57:03 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com, marcin.szycik@intel.com
Subject: Re: [iwl-next v1] ice: add recipe priority check in search
Message-ID: <20241021135703.GK402847@kernel.org>
References: <20241011070328.45874-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011070328.45874-1-michal.swiatkowski@linux.intel.com>

On Fri, Oct 11, 2024 at 09:03:28AM +0200, Michal Swiatkowski wrote:
> The new recipe should be added even if exactly the same recipe already
> exists with different priority.
> 
> Example use case is when the rule is being added from TC tool context.
> It should has the highest priority, but if the recipe already exists
> the rule will inherit it priority. It can lead to the situation when
> the rule added from TC tool has lower priority than expected.
> 
> The solution is to check the recipe priority when trying to find
> existing one.
> 
> Previous recipe is still useful. Example:
> RID 8 -> priority 4
> RID 10 -> priority 7
> 
> The difference is only in priority rest is let's say eth + mac +
> direction.
> 
> Adding ARP + MAC_A + RX on RID 8, forward to VF0_VSI
> After that IP + MAC_B + RX on RID 10 (from TC tool), forward to PF0
> 
> Both will work.
> 
> In case of adding ARP + MAC_A + RX on RID 8, forward to VF0_VSI
> ARP + MAC_A + RX on RID 10, forward to PF0.
> 
> Only second one will match, but this is expected.
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>



Return-Path: <netdev+bounces-101521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 222838FF2A4
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 18:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9278C2891DE
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 16:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB94197A88;
	Thu,  6 Jun 2024 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tM+kZ2YP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14A2195F0F;
	Thu,  6 Jun 2024 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717691823; cv=none; b=G0qHftEZ9sLJFmfA4ub/dDrdVbOvdzObOUJZG5wNFjVLieqRZNRR3OmAUoGXYvCyYxl2DJZkVrgA3RP+Uur81SSdIKNK19bUPfHjOZTHMsBSmEls8k6L4MtzxwO/DvUiFmmJ6b5IXq3T/O0TinIk76IyJ9KLcYGDg0gk2jm5zXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717691823; c=relaxed/simple;
	bh=x90P3hzoNNNwp8KKvp2Hc2+SCaeDe3DN744fkLDcrFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xxp0oqq0Y4jgFanW4yDH2lx0tW0EvST9J857UCq1VLBeJAbpPlfY1hOpM01YlGfkZS+I6j0XIIEZWWatXkSYGQOTswv6Odtm1JkKX4n8iRhKyNeNitB/QmeLTrl22hEKYHLGA9YHJM4potzCQvSylbINeNLGU8wZPynU/wevkfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tM+kZ2YP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F42C32782;
	Thu,  6 Jun 2024 16:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717691823;
	bh=x90P3hzoNNNwp8KKvp2Hc2+SCaeDe3DN744fkLDcrFA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tM+kZ2YPgyySJbzNTh5/B5daU4WCqiTxVq0IUU+Ve+LwNMHJx4mQYuK1/bMd7Ebo2
	 NRuDcWxETMyo47nMI127C0FiTHXgAdekK2bk9dkpYloFFnDOT997JIS2dzxwHVYqUW
	 lfVSPYB2nV2+IqGAOnrtRhF2dcXomxv8DX96ADUpN9XwnApdLZCXFINJxmO9Q6WkeX
	 L96SQiKhoflWDEnZaC06W0e5R8T/Twk7plkvEzipAfCIN2kXB0iuf2b7evteeC4CIc
	 V6pijITHJhZQiHOUdg/z3bExdGJeRsCO/3rbPH01kZ9t9WvxAYiDX4FfySq6GyxklG
	 3QzE6kxcOGY5g==
Date: Thu, 6 Jun 2024 09:37:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Alexander Duyck
 <alexander.duyck@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH net-next v6 14/15] mm: page_frag: update documentation
 for page_frag
Message-ID: <20240606093701.43e3a09c@kernel.org>
In-Reply-To: <20240605133306.11272-15-linyunsheng@huawei.com>
References: <20240605133306.11272-1-linyunsheng@huawei.com>
	<20240605133306.11272-15-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Jun 2024 21:33:04 +0800 Yunsheng Lin wrote:
> Update documentation about design, implementation and API usages
> for page_frag.

Documentation/mm/page_frags.rst:75: WARNING: Explicit markup ends without a blank line; unexpected unindent.
Documentation/mm/page_frags.rst:77: WARNING: Line block ends without a blank line.
Documentation/mm/page_frags.rst:79: WARNING: Block quote ends without a blank line; unexpected unindent.
Documentation/mm/page_frags.rst:82: ERROR: Unexpected indentation.
Documentation/mm/page_frags.rst:93: WARNING: Line block ends without a blank line.
Documentation/mm/page_frags.rst:95: WARNING: Block quote ends without a blank line; unexpected unindent.
-- 
pw-bot: cr


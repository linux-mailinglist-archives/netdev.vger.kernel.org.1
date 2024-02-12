Return-Path: <netdev+bounces-71025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FEC851AEA
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 18:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F710B24284
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 17:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4227E3D998;
	Mon, 12 Feb 2024 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi/0I1lW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B45E3F9EA
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757728; cv=none; b=G1O4GA8xJcitho6EofoH7nu8kYjRegAOyJ4c74pkRBdLx1i11oWFFVMwWXVzE9bGXh0l/OM9Dk9l9EOJrCYCzpWt0Efw8vqym0Ia0FADC7OCGPXeBU8dQo7spoT2wFxeW5rKaZglj3HBvxwsyaCNunjwQ4e/Awh7UYggmvdOsbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757728; c=relaxed/simple;
	bh=/RyB9ujrF+FTthrGIDD4FZmbHqey0FCs6eTNWRoLmOo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6yID5CRk9cUR8MVt7JxwNJlUGLbf9PBrDv6YNMCk0+bFR4dWVfkGtm3lx1YW0FJIDSaKNzJsv5IIdG+ulb4AD08ky0moRWjYIBFWbBpwaJEhEsdGBb3oduuk5agAw1eXtMRqr1j5vXFC+MO1DCptRfMz0Mm/XdI5W26xAokKNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi/0I1lW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A597C433C7;
	Mon, 12 Feb 2024 17:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707757727;
	bh=/RyB9ujrF+FTthrGIDD4FZmbHqey0FCs6eTNWRoLmOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pi/0I1lWN3smUk4ukW4FWNDDnX/RfL64UdYUgD6fPLLsYCX1hXAg9Ki+u1dMbW68o
	 nu49y8+clSgfWV+tXN+edZ+r7ktXvjXXO2nnJJASPxJQt8RGbqjArvzxjDSYxNfltf
	 AMbUxJGKOI9d2cyHqC2YVbs3K1GeRGVtBXaMuX5eiofMeg4hausY0M5hYno1dXvGph
	 iE0qjN6Lez7Mwa+B4Az+Rd7rtF7AaG39QLK9FL/93agLbc4uReMbc710AEPKTkiF8T
	 Usau7NgjGDJOinxqAU2uKOIgI10z6INv3KDiJHd/UoMj4Y+wnpEoItV5t/SJmf1Qlv
	 6UCDfbxARK6sA==
Date: Mon, 12 Feb 2024 09:08:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sasha Neftin <sasha.neftin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>, Paul
 Menzel <pmenzel@molgen.mpg.de>, Naama Meir <naamax.meir@linux.intel.com>,
 "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
Subject: Re: [PATCH net 2/2] igc: Remove temporary workaround
Message-ID: <20240212090846.18c517fc@kernel.org>
In-Reply-To: <ce4065d5-656d-4554-b288-94105a3631cc@intel.com>
References: <20240206212820.988687-1-anthony.l.nguyen@intel.com>
	<20240206212820.988687-3-anthony.l.nguyen@intel.com>
	<20240208183349.589d610d@kernel.org>
	<ce4065d5-656d-4554-b288-94105a3631cc@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Feb 2024 08:53:36 +0200 Sasha Neftin wrote:
> > Any more info on this one?
> > What's the user impact?
> > What changed (e.g. which FW version fixed it)?  
> 
> User impact: PHY could be powered down when the link is down (ip link 
> set down <device>)

to make it a tiny bit clearer:

s/could/can now/ ?
s/link is down/device is down/ ?
 
> Fix by PHY firmware and deployed via OEM updates (automatically, with 
> OEM SW/FW updates). We checked the IEEE behavior and removed w/a.
> 
> The PHY vendor no longer works with Intel, but I can say this was fixed 
> on a very early silicon step (years ago).

And the versions of the PHY components are not easily accessible so we
can't point to the version that was buggy or at least the oldest you
tested? If that's the case - it is what it is, please repost with the
improved commit msg.


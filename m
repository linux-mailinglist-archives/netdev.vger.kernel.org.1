Return-Path: <netdev+bounces-180787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF75FA82857
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494E3445095
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61498269811;
	Wed,  9 Apr 2025 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VppNnAd2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390D82690FF;
	Wed,  9 Apr 2025 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209517; cv=none; b=JXamGlmCipfNqiB3Utjdx87wBvHqlAyFPX5VlUwPKAbBJh8syD4J+/VvY9edWyGHjW0h/OWLvuarHbj2rxwssEB4dbB7MyhLTjV0jyXbUSb9BFlI35lzOHCJ3/I6X9SKsbx3nD7i+suglYtg1a5KzPVOQDZLv42Cwim701SyIpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209517; c=relaxed/simple;
	bh=bZ9LqXFL20jiPKhVHCikZHr3AT6FsxsF+d8oFILNqJk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCf4CFy9BS040dajknTNt79RYFfB9vc/IGZLObsjR+v+GID9uIKL/NTETGvnKOUOYC7p16KVDQLU9RlZmRCuqDqWtPFCHcBFftbj9UR5DTLf0q0GtjdwjNzv4EzBY9TEe43JrncjXnxA+ojMzIvllaRzTQQy1tk6XJaI9zlWan8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VppNnAd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FF3C4CEE7;
	Wed,  9 Apr 2025 14:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744209516;
	bh=bZ9LqXFL20jiPKhVHCikZHr3AT6FsxsF+d8oFILNqJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VppNnAd2YISS5KOAan+Dz+7uk/id2F66sciDMXE5//+ld5vvD0IH5Jhjhmmyph8yh
	 UFHMRrKBtnrhMwKSczQgKpiTvLPlRxeePIfiF8dKtZ5m1NvYewQtSkF6V6BMXJMbSO
	 Qt6Ht+kiFzebGT9sy+YOkK5QmwWRoWjRkkznuL03j/eFFw/6oVn97lyeNdlXZuPwON
	 cx6Khz11C11moVxdDI+euyuTEiBMFuMUl9eyWu5FpFWPVmqhNJ6+LkIiNeA1VudRwM
	 TvXpS5EmPUTsVloDj9DR2d8z4q6xQa/Wrb+9aMYNmbSxNKJxqI7m2iQnY8Ni2u31Yn
	 xttd+aPjUw+Vw==
Date: Wed, 9 Apr 2025 07:38:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>, "Dumazet,
 Eric" <edumazet@google.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "jiri@resnulli.us"
 <jiri@resnulli.us>, "horms@kernel.org" <horms@kernel.org>, "corbet@lwn.net"
 <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "Polchlopek, Mateusz" <mateusz.polchlopek@intel.com>, "R, Bharath"
 <bharath.r@intel.com>, "Mrozowicz, SlawomirX"
 <slawomirx.mrozowicz@intel.com>, "Kwapulinski, Piotr"
 <piotr.kwapulinski@intel.com>
Subject: Re: [PATCH net-next 10/15] ixgbe: extend .info_get with() stored
 versions
Message-ID: <20250409073835.5d0e4018@kernel.org>
In-Reply-To: <DS0PR11MB778531031053B86BC5301CBBF0B42@DS0PR11MB7785.namprd11.prod.outlook.com>
References: <20250407215122.609521-1-anthony.l.nguyen@intel.com>
	<20250407215122.609521-11-anthony.l.nguyen@intel.com>
	<20250408193124.37f37f7c@kernel.org>
	<DS0PR11MB778531031053B86BC5301CBBF0B42@DS0PR11MB7785.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Apr 2025 10:50:34 +0000 Jagielski, Jedrzej wrote:
> >Just to be crystal clear -- could you share the outputs for dev info:
> > - before update
> > - after update, before reboot/reload
> > - after update, after activation (/reboot/reload)
> >?  
> 
> OK so this looks this way:

Not terrible, but FWIW my expectation (and how we use it at Meta [1])
is that stored will always be present. If there is no update pending
it will simply be equal to running. Otherwise it's unclear whether
we're missing stored because it's not supported or because there is 
no pending update.

But I guess it's not a huge deal if for some reason you can't achieve
this behavior, just make sure to document it in the driver devlink doc.

1:
https://docs.kernel.org/networking/devlink/devlink-flash.html#firmware-version-management


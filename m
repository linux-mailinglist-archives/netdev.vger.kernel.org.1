Return-Path: <netdev+bounces-77961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F100873A04
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEAB028AF3C
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62BC1350CD;
	Wed,  6 Mar 2024 15:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sy5jJJiD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AC228EC
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 15:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737257; cv=none; b=AQr+b/nN+X2CdZp1RshhSldwPPI12B3hp9P5ukoqYoEGNqqZwOAHh59DXjmQCuA2yCTXx0jb0VQrDrTdLPtjgnfX1peY7TZo4sp4W3+s86oGTKcVGJ+vUDfgZOe4nEDCC5XMrpm465FSjYMWBN+2iQEKBckyCj1/1UQ72aQFXdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737257; c=relaxed/simple;
	bh=LfwQBbFcVFMQi9c2js7MIDHI5ddZcQW5s/fdcnnbuVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2HWGzMuDxspCZn3qnmxKmtrXN4etxIi919Se+F0UCEgZf4EgH0ukbvaRp1/x4n7lCqebzA6mjEeLZvytfd/g5yzsEZmhiPl/5+Q6cO4hHPY8vWx7v5PG1Pu+KTuANLspdzdSedlZ0zkYiVz2WlnRwrQk11mTwIgwic6NwDe6Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sy5jJJiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5763C433C7;
	Wed,  6 Mar 2024 15:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709737257;
	bh=LfwQBbFcVFMQi9c2js7MIDHI5ddZcQW5s/fdcnnbuVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sy5jJJiDao1wPzr8weSsNDm2A4fk5vorjgsz7VmYgP7e8quoQbNRT6F5vljJIf8+O
	 dfkcaBj78XTT1HyE8tDAvoNuiy1rWKtUksHZh++MpLlzzu2aBYoxvIVAGj97f4LIIl
	 9Vduvqxq0rr0k6uKda2TJOvMecxMbxoBjC8ddEm/3Wct5UMsXet9d0eoPqK7q0qdbp
	 sejR/Yv5LGGk/uq5XmkFqeDHZw34x4rUjWJdXVjS+Hw3Pi+ggXW+PhTKkbPc+R7kHv
	 vY32U8381Wh6Bty1gUAENdWx++3+Lq4kFdYSxcpJRt4E0LjK/hv9/ld9CrRhDhnZvz
	 Vp113RaK8nseg==
Date: Wed, 6 Mar 2024 07:00:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Zou, Steven" <steven.zou@intel.com>
Cc: "Sharma, Mayank" <mayank.sharma@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Staikov, Andrii"
 <andrii.staikov@intel.com>, "Lobakin, Aleksander"
 <aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "horms@kernel.org" <horms@kernel.org>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Buvaneswaran, Sujai"
 <sujai.buvaneswaran@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: Add switch recipe
 reusing feature
Message-ID: <20240306070054.094fe4a6@kernel.org>
In-Reply-To: <0056a010-4fd6-4300-9790-649d820a5a01@intel.com>
References: <20240208031837.11919-1-steven.zou@intel.com>
	<PH0PR11MB5013D1C2AD784512CA70173396212@PH0PR11MB5013.namprd11.prod.outlook.com>
	<IA1PR11MB79422EFDCA5CDD7EC60125C0F4212@IA1PR11MB7942.namprd11.prod.outlook.com>
	<0056a010-4fd6-4300-9790-649d820a5a01@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Mar 2024 22:55:48 +0800 Zou, Steven wrote:
> > We are seeing following kernel compilation error while compiling next kernel:
> >
> > "error: dereferencing pointer to incomplete type 'struct dpll_pin'"  
> 
> Thanks Mayank!
> The patch does not touch 'stuct dpll_pin', I do not think this is caused 
> by the patch changes.
> And the patch is based on the base-commit: 
> ce1833c065c8c9aec8b147dd682b0ddca8c30071 that I built and loaded the 
> ice.ko successfully before I submitted the patch.
> 
> Hi Tony,
> Do you have any suggestion about this compilation issue?

net-next tree currently has this problem. You can try merging in net
which has the fix (it will propagate to net-next on Thursday). 
Or try changing the compiler, newer Clang and GCC do not generate this
error.


Return-Path: <netdev+bounces-46871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A0A7E6D6A
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 16:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA331C2094B
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 15:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABED120318;
	Thu,  9 Nov 2023 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZrg+5XM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B800200D2
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 15:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A33FC433C8;
	Thu,  9 Nov 2023 15:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699543769;
	bh=Dvpc/hn3aIEBQWMzrsNL9Hlmh05ncAoe/xihc89NxGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kZrg+5XM1Czv03HdNl+1iAgvYyPpK6QWXn9Ao+PHwv2vXYIdZg6bxvyEn0BOZnxv9
	 kZyJQ54pJhcPKwqtAycmfW66gvQB64BSUu801eRuEe01A/hDGSaXgSCE3yhl/3LeuI
	 GfK0HoyKUIHR+M7w7hyVY8+I+VIJgV9V2hP/+MsqJFlJOY9q0Jhubht3VzuA2puQbk
	 KB5BEhmcHnD5/AEPg6EPSz8dmVbk298Fo1bmBXjbvQOEklFYuizIacV5jOOiW1coRe
	 4k0h4z6CqT7JFmE+488TEoPRpP+xs7rq0GrxI9IPgA6DxsFD2mC+Uh+tMnEuMHCNut
	 rVHO5m6OGQtRQ==
Date: Thu, 9 Nov 2023 07:29:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, MD Danish Anwar
 <danishanwar@ti.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>, Nishanth
 Menon <nm@ti.com>, "Su, Bao Cheng (RC-CN DF FA R&D)"
 <baocheng.su@siemens.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
 Roger Quadros <rogerq@kernel.org>, Grygorii Strashko
 <grygorii.strashko@ti.com>
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Add missing icss_iep_put
 to error path
Message-ID: <20231109072927.6695042a@kernel.org>
In-Reply-To: <502a27b6-e555-42d2-bb0f-964a58f81dbe@siemens.com>
References: <b2857e2c-cacf-4077-8e15-308dce8ccb0b@siemens.com>
	<20231107183256.2d19981b@kernel.org>
	<502a27b6-e555-42d2-bb0f-964a58f81dbe@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Nov 2023 12:08:21 +0100 Jan Kiszka wrote:
> > Is there a reason you're not CCing authors of these changes?
> > Please make sure you run get_maintainer on the patch, and CC
> > folks appropriately.  
> 
> I was only interacting (directly) with Danish in the past years on this
> driver, and he also upstreamed it. So I assumed "ownership" moved on.
> Adding both, Roger with updated email (where get_maintainer does not help).

You'll need to repost the patch, it's been dropped from patchwork.

Roger, if your old address doesn't work any more please add an entry
to .mailmap.


Return-Path: <netdev+bounces-28976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 814207814C7
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 23:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C421C20C45
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 21:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F651BB37;
	Fri, 18 Aug 2023 21:32:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC18E18B1F
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 21:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBC7C433D9;
	Fri, 18 Aug 2023 21:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692394361;
	bh=nn+nuO251dwWEoQpIKim8e/7fuF7cbVUVmYKEOTd2iM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nCSrnlIOylHNxMgmBRTjle9FFsaqh6kRx1T07ftpAHvLmFX/jDo5VL7KTmTygwhSF
	 14Hbm5OB215bm1QbgUz8HrNUyEx5n1K+fWI2AupaVzpoBH1uWmP36jfrL9UbEadMKv
	 45z2T7mc6SnZhxYngawWfYs7LJqSKsktGlQpbYzCdpLthlV2YD43Wf9K5WZUT5KJDI
	 NbFF/wJ//nZWaSGeNlWBfh0bYrLa5aC1xGwpCqeiTYiKzFIpYQ3f23Iw0k1YbM2oh6
	 U4nQDco6RMgr1FDa2bjW0Y9Gs4xGmYr7MYEhU5FonsKT9aumE/emduC6oe+4CYYBS6
	 jmM389Kg3zgYQ==
Date: Fri, 18 Aug 2023 14:32:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Dima Chumak
 <dchumak@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, netdev@vger.kernel.org, Saeed
 Mahameed <saeedm@nvidia.com>, Steffen Klassert
 <steffen.klassert@secunet.com>, Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v3 0/8] devlink: Add port function attributes
Message-ID: <20230818143240.3960be87@kernel.org>
In-Reply-To: <20230818183640.GA22185@unreal>
References: <cover.1692262560.git.leonro@nvidia.com>
	<20230817200725.20589529@kernel.org>
	<20230818041959.GX22185@unreal>
	<20230818093812.7ede8fbc@kernel.org>
	<20230818183640.GA22185@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Aug 2023 21:36:40 +0300 Leon Romanovsky wrote:
> > and you have to audacity to call the basic rules we had for a very long
> > time "very strange".  
> 
> This rule relies on basic contract of 1 series -> fast review/acceptance.
> Once fast review/acceptance doesn't happen, what else do you expect from me?

Since you don't understand what I'm asking please let Saeed post
your patches.


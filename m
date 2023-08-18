Return-Path: <netdev+bounces-28867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 296FB78107B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A99B1C20FB3
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83FEEDB;
	Fri, 18 Aug 2023 16:38:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0905862B
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 16:38:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194BFC433C8;
	Fri, 18 Aug 2023 16:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692376693;
	bh=Kq75jx3gNSVhhx+bk9h2GcY2ZSUOy3nY7gzQ9RKugUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lJUmSF5O4HXViUOp5rMTg673GEa3xI1of2NBwNS0VPD9Pu9xxTY1gF2AeSSHuRBWx
	 2YHHttWcoP3RLKbecmcjzfV2q7LsZ88cK/bnuL6Ahfbv0n+dLKiiphhgQuZrcEjT3y
	 8Jl/0Zlv4/sdTGqU/G3nC5kqGnygxVrMLWHoa1c5yEaowJwu1QVvEQb0JYR2z09vRr
	 tQRYXscFjCENShq1Nl1YevM+WDgzrZkB2mJAjwzi7fK5NHSup/gRD9g/fKwPSVxL5A
	 gKsrmXSU/MkKeHW0O6X6aqG86IJEyLE2VMIDU4Mm6CVtqbTBYa9DlHTqoHHzWrlsIi
	 UXq1gEFBfydww==
Date: Fri, 18 Aug 2023 09:38:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Dima Chumak
 <dchumak@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, netdev@vger.kernel.org, Saeed
 Mahameed <saeedm@nvidia.com>, Steffen Klassert
 <steffen.klassert@secunet.com>, Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v3 0/8] devlink: Add port function attributes
Message-ID: <20230818093812.7ede8fbc@kernel.org>
In-Reply-To: <20230818041959.GX22185@unreal>
References: <cover.1692262560.git.leonro@nvidia.com>
	<20230817200725.20589529@kernel.org>
	<20230818041959.GX22185@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Aug 2023 07:19:59 +0300 Leon Romanovsky wrote:
> It is very strange to expect 1 series per vendor/driver without taking
> into account the size of that driver and the amount of upstream work
> involvement from that vendor.

According to the "reviewer rotation" nVidia is supposed to be reviewing
this week. Sorry it fell on you in particular, but as a company y'all
definitely are not pulling your weight. Then Saeed pings me to pull
your RDMA stuff faster, and you have to audacity to call the basic
rules we had for a very long time "very strange".

SMH


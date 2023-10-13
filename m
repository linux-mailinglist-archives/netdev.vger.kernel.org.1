Return-Path: <netdev+bounces-40857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FCD7C8E24
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 22:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D481282F33
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 20:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF16F250F2;
	Fri, 13 Oct 2023 20:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JG9hFy1x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1457250EC
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 20:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BE2C433C7;
	Fri, 13 Oct 2023 20:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697227591;
	bh=J62YA1GAhd+QaRQ3z6JllZRyVbgvVGi3d7oKO5H2ymk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JG9hFy1xtPQdV/+Itj+3tkn+P89MDOPV2SCZlW8jYbsVHF12WRZy4rTL/6+6k7RPX
	 RLDnx1q4OqoIMga/KYpz9cLeu7duf44+AGdekioXdnKRWSUzTkqWnRumsTS08s4qSh
	 bzEjWRqZYtk1zaYPFtNVAMWhaE7kghIHCwUDtRXfT7oH2ufLPHE8MgEhlNMradWcoq
	 qFqeQsRJ628cfNQbo2MWM3Bt34/WncD8A0gQMuKjHQWT0K3pxdYfz+E569wQkEc1ic
	 1DtzuyXEV6qnic0jXTzt8gre0Lt+85SFL12Nmh+v9WbOj1PCHrO1HocvYZZuK7qkf3
	 gnpXWlkAu1M7Q==
Date: Fri, 13 Oct 2023 22:06:26 +0200
From: Simon Horman <horms@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Adrian Moreno <amorenoz@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>, shuah@kernel.org
Subject: Re: [PATCH net v2 0/4] selftests: openvswitch: Minor fixes for some
 systems
Message-ID: <20231013200626.GS29570@kernel.org>
References: <20231011194939.704565-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011194939.704565-1-aconole@redhat.com>

On Wed, Oct 11, 2023 at 03:49:35PM -0400, Aaron Conole wrote:
> A number of corner cases were caught when trying to run the selftests on
> older systems.  Missed skip conditions, some error cases, and outdated
> python setups would all report failures but the issue would actually be
> related to some other condition rather than the selftest suite.
> 
> Address these individual cases.
> 
> Aaron Conole (4):
>   selftests: openvswitch: Add version check for pyroute2
>   selftests: openvswitch: Catch cases where the tests are killed
>   selftests: openvswitch: Skip drop testing on older kernels
>   selftests: openvswitch: Fix the ct_tuple for v4
> 
>  .../selftests/net/openvswitch/openvswitch.sh  | 21 +++++++-
>  .../selftests/net/openvswitch/ovs-dpctl.py    | 48 ++++++++++++++++++-
>  2 files changed, 66 insertions(+), 3 deletions(-)

Thanks Aaron,

this looks like a good incremental improvement to me.

For series,

Reviewed-by: Simon Horman <horms@kernel.org>



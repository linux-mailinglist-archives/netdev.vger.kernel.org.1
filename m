Return-Path: <netdev+bounces-23946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F137376E3FD
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82744281F11
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 09:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EE41548D;
	Thu,  3 Aug 2023 09:10:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B297E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 09:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57743C433C7;
	Thu,  3 Aug 2023 09:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691053842;
	bh=QRI50CvVsw1NT2bo2BmJ3RMA6/s1sNXqJePF55C23xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y2NF9Mmy9HNWVSooHJy4u0VnvdRathY14zCjJwP4pxRH33eQ+Uvb1Rtjz/unrAWFn
	 Ffx8S6aEjyggLx0xl72k2Ygtcm2TjWR1MygYLC8ELBW3zS4YQJuIzfoTvDTSCb4sbL
	 Jhm1IQ7j+NL7iNbLVPtzpBQTtm8WONIEDMjTf1Y6o+Nz+CsSBespmUvZOoOX40faMr
	 Lr+4WiRCinAfICjKmIdJcZJZNeSF8jldtOKAbpHRnyYiauErOoyJagTcJbB3Gu9x1T
	 1eDLwh2VhfKV9opqF/H0tWY/pM435MN7978zyxRDvSiMpJlfs618UQ9SJd7R+nQnEd
	 fhCxkognvL9Ag==
Date: Thu, 3 Aug 2023 11:10:38 +0200
From: Simon Horman <horms@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
	linux-kernel@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>,
	Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH v3 net-next 0/5] selftests: openvswitch: add
 flow programming cases
Message-ID: <ZMtvDiiD9qv123ps@kernel.org>
References: <20230801212226.909249-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801212226.909249-1-aconole@redhat.com>

On Tue, Aug 01, 2023 at 05:22:21PM -0400, Aaron Conole wrote:
> The openvswitch selftests currently contain a few cases for managing the
> datapath, which includes creating datapath instances, adding interfaces,
> and doing some basic feature / upcall tests.  This is useful to validate
> the control path.
> 
> Add the ability to program some of the more common flows with actions. This
> can be improved overtime to include regression testing, etc.

Thanks Aaron.

For series,

Reviewed-by: Simon Horman <horms@kernel.org>



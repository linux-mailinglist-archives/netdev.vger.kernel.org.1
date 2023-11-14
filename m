Return-Path: <netdev+bounces-47860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7740D7EB962
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 23:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A78621C2090E
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 22:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096D010F7;
	Tue, 14 Nov 2023 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrSbzbqT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0473308B
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 22:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBB6C433C7;
	Tue, 14 Nov 2023 22:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700001157;
	bh=L/Td8SUxhKjIwgOy9zT63pN/TrB/RPCUA8hz09s7wbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OrSbzbqTQWNORXytNu0tKWaCCsFv1ky14Kx0QFS+cVXYBz3VsBX/IuxS7f5t7/hxK
	 BidFt4G3Kj+nylR3V2q8W0WkYlu5OlMaHIPWY92cK685bO4QHefBZtp2mxS6+s0p45
	 qGOivF7vlF02esNdwcGmWaipus5WbxH94UA0V0wcMzIQxKTMnsITZeeN7eTLYy78bd
	 DdIJf46FvIYv+3Ek1KZQQ5CajYuyx6nUeg0V9pSQlzYFSlOMXGFGQWfYV5JzURM2K3
	 /UdXQnPCqyfqLDW2fupIajXhK4La0cxOzNVDLB1ML+Z7xJmPzSb9/cIh/ItPPpkqWH
	 hfrXw4NFPeq1g==
Date: Tue, 14 Nov 2023 17:32:35 -0500
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, michal.swiatkowski@linux.intel.com,
 wojciech.drewek@intel.com, marcin.szycik@intel.com,
 piotr.raczynski@intel.com
Subject: Re: [PATCH net-next 00/15][pull request] ice: one by one port
 representors creation
Message-ID: <20231114173235.2c57c642@kernel.org>
In-Reply-To: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
References: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Nov 2023 10:14:20 -0800 Tony Nguyen wrote:
> Michal Swiatkowski says:
> 
> Currently ice supports creating port representors only for VFs. For that
> use case they can be created and removed in one step.
> 
> This patchset is refactoring current flow to support port representor
> creation also for subfunctions and SIOV. In this case port representors
> need to be created and removed one by one. Also, they can be added and
> removed while other port representors are running.
> 
> To achieve that we need to change the switchdev configuration flow.
> Three first patches are only cosmetic (renaming, removing not used code).
> Next few ones are preparation for new flow. The most important one
> is "add VF representor one by one". It fully implements new flow.
> 
> New type of port representor (for subfunction) will be introduced in
> follow up patchset.

There's way too much stuff from Intel in the review queue right
now and the fact that some of us are at LPC isn't helping.

Please slow down a bit.


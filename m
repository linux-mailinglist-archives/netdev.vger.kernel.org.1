Return-Path: <netdev+bounces-48708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E7D7EF532
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161F51C208BA
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD33315A1;
	Fri, 17 Nov 2023 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEKluOCu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB8530640
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C743C433C9;
	Fri, 17 Nov 2023 15:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700234654;
	bh=YM40P9jv7Cy3o5w8UVH/+WOpQeap23JT3M4hfdsDEoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DEKluOCu3r1zSO8AjR6IP5R+xGVYSC2vPP9qFv1bCLQepXusQCds3u0k2KIHH+hwy
	 p//7s7BeSZ/U8mIRDG0FH6s6N7/ljUVv4aNzkydwYAXRnLUF3a7mVDVqwIwl+GACG2
	 j7A1L9PCqkw9ojIPNu9Y2TvoHuvBRbPPMoa+g66Uz5Wu/Kb+ZOMBPC9JDjVbJqEiYB
	 3qSTkHi5t4nKh3kX++XqWjyuWGM/VMRqdtFRGxIM4tR3zuw/OL2LaCc52EDG823h91
	 gEvQWjfJ4Hnjutd6aMFilWgbSj82eW3ON3pwdEjflFYZqffRvHQgiqgvp6+kk3LDE5
	 M2S0W6t6PImiA==
Date: Fri, 17 Nov 2023 15:24:09 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 01/14] devlink: Move private netlink flags to C
 file
Message-ID: <20231117152409.GE164483@vergenet.net>
References: <cover.1700047319.git.petrm@nvidia.com>
 <d7728a0cd7e1643018306e8cfde0d4c0934ee2be.1700047319.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7728a0cd7e1643018306e8cfde0d4c0934ee2be.1700047319.git.petrm@nvidia.com>

On Wed, Nov 15, 2023 at 01:17:10PM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The flags are not used outside of the C file so move them there.
> 
> Suggested-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>



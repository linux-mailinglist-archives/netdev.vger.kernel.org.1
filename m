Return-Path: <netdev+bounces-49511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C647F23FC
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 03:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FAE52819F4
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 02:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA8F1549C;
	Tue, 21 Nov 2023 02:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJk5KymJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE6C1548F
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 02:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1F7C433C8;
	Tue, 21 Nov 2023 02:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700533745;
	bh=bbmaUxbSprdKz5WLODsxwn+3KK1v5jKjT6GJlDiInZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BJk5KymJnb7/weOdapwkb43BTjcT/M+j1ShX4G6hJriALbTQlksetBqvkdm4K2otK
	 Pd4Bjssgzb32iQlBZO6HBWbxoQoHCaS67Qagey0nIO0LfF/Ph2ZMIYSFIFkErh+wTB
	 3cfOyW7/LEBHQQIsmF+GDnQnvesLu1YQOK7M30owCvQGIpyow9QFv9pBT0BzsBY390
	 gdshYH8c2BNvA9xrLyE4n86Q9m+uY7x8m8NecG9s7KawCWgmLU/vWSKb9wxwC9+Z7o
	 cv85FZl4vUK+64JevEntzqdL784/xmhth/y3f6aHPvpoVqqoFpALUlq2Ko5YXkQHrV
	 0iIRD/C/dY1HA==
Date: Mon, 20 Nov 2023 18:29:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
 johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
 amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v3 0/9] devlink: introduce notifications
 filtering
Message-ID: <20231120182903.27a7b7de@kernel.org>
In-Reply-To: <20231120084657.458076-1-jiri@resnulli.us>
References: <20231120084657.458076-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Nov 2023 09:46:48 +0100 Jiri Pirko wrote:
> Currently the user listening on a socket for devlink notifications
> gets always all messages for all existing devlink instances and objects,
> even if he is interested only in one of those. That may cause
> unnecessary overhead on setups with thousands of instances present.

There's a conflict, probably with mlxsw's reset changes.
Please respin.
-- 
pw-bot: cr


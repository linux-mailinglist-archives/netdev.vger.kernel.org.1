Return-Path: <netdev+bounces-40569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 553E57C7AF2
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 02:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884FC1C20ED9
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 00:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57691371;
	Fri, 13 Oct 2023 00:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYzYbSf3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F3A36E
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 00:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E0DC433C7;
	Fri, 13 Oct 2023 00:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697157846;
	bh=auf5rIuba3pJHbNf1cYc+7InwnqYtQhxr2kPGpHWCDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QYzYbSf3qlhTbkZUZau7m8iF8+9+e3UktK3IE4WvrGYmats5XTLLqnfnpx7sXUv9K
	 AQJvGPeXvC7CTf6mfod0dU6CMzIhzOBYq6YFHDOlKQbIVtCvUkytXmXF1AlOzM4WiP
	 ixUbcItuMkJ6fReQRp5wyvgRnLZjEv3oena+hCKFAzj9tqXeiDRJpHDmkXF8uXVDBq
	 Jaj/sBnenFzPaO5mjKgR7xTkUB+CRAkwZ1oWClsJs7KeaRI9nj8ttm2yvFXykahIPH
	 0W6e5Cr9KYQgvzD2ur3KUwNP/fP5uTo1mRrt3vJ9T9NncibtxrzE8LItUgvAVMBK3C
	 rJVH90UV7TqmQ==
Date: Thu, 12 Oct 2023 17:44:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: <netdev@vger.kernel.org>, <sridhar.samudrala@intel.com>
Subject: Re: [net-next PATCH v4 04/10] netdev-genl: Add netlink framework
 functions for queue
Message-ID: <20231012174405.21ad5d01@kernel.org>
In-Reply-To: <20231012173636.68e6eeee@kernel.org>
References: <169658340079.3683.13049063254569592908.stgit@anambiarhost.jf.intel.com>
	<169658369951.3683.3529038539593903265.stgit@anambiarhost.jf.intel.com>
	<20231010192555.3126ca42@kernel.org>
	<fe26f9b6-ff3d-441d-887d-9f65d44f06d0@intel.com>
	<20231012164853.7882fa86@kernel.org>
	<8c9704c0-532e-4d35-a073-bee771cd78c5@intel.com>
	<20231012173636.68e6eeee@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Oct 2023 17:36:36 -0700 Jakub Kicinski wrote:
> we can't hold the lock in pre :(

To be clear - I meant to say that for dumps we can't hold the lock
across all the callbacks, for do it would technically be fine.
But I don't think that it's better.


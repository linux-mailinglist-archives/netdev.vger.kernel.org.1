Return-Path: <netdev+bounces-84439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAA3896EFF
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14EA128D02A
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6289146A92;
	Wed,  3 Apr 2024 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6tLyHxa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23424F602
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147980; cv=none; b=pjKizwR+Id8JW+M1RTlCoLREGdDVoGqfqHm+jvs+Wcgr+8a0e9uUGVpEAD1oTB+B+wQ7Pfw8WAA++xtJ2HY+l7SwAzEWO6+MLwGszvqel5umz/EtG8Pcoy1sG7k4oVNXUrw7v9JZYEeFPC8Lbl/fVYUy3N+3CMC1hJsfi6WHrv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147980; c=relaxed/simple;
	bh=0RWD+jv+FCjmQJXCnZg50MyhDklqvY4SiduIn+uIc24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLT6AFvHEWsOUFjLqhhmtjHSXEDiICTp6DZfpTreVLUgfy4zVxFhFZ0005nsQFRLs9BNp7XbBVm0hjKMnSpaCepckE5mjVWPtG0diK42LiCQQFhNz32nybQPZaBtvCHOizN1NAfb6BYZNDkq0IGPBKG4FwIlvgA2CyUqouuJxD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6tLyHxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5641C43394;
	Wed,  3 Apr 2024 12:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712147980;
	bh=0RWD+jv+FCjmQJXCnZg50MyhDklqvY4SiduIn+uIc24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D6tLyHxaYjdxerXi/suG9lGap3X+24ucohFnvJIqF0hLjOTlPGZpz3CCkmJbD6L5W
	 epvba7eq0YbwcoWNfcGzLEjtLKstjJtNDuYHNJXpjG3YXoMi7fjqqRo1OuXJsJEb1N
	 2Tkq6KdDimorE3VDN56ik7/qywGwKFtlEg9xPTgsDfkYYN68o5+RX7hnoc330OMYcO
	 i+ynNCBwhpF8oUC9Z2fiwlWGmtT2w0z6I/B/U48s7AvoiYfONZo9A1zuF3LkR+2q+O
	 dC6TlFeCSgU7agat64XbT9NWZRxM01Y7pK5fGf8QJpd1j5SRpoVR4sJfGBDoOVsGaL
	 6vnTb4RkOK7Cw==
Date: Wed, 3 Apr 2024 13:39:36 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 10/15] mlxsw: pci: Remove unused wait queue
Message-ID: <20240403123936.GF26556@kernel.org>
References: <cover.1712062203.git.petrm@nvidia.com>
 <f3af6a5a9dabd97d2920cefe475c6aa57767f504.1712062203.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3af6a5a9dabd97d2920cefe475c6aa57767f504.1712062203.git.petrm@nvidia.com>

On Tue, Apr 02, 2024 at 03:54:23PM +0200, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> The previous patch changed the code to do not handle command interface
> from event queue. With this change the wait queue is not used anymore.
> Remove it and 'wait_done' variable.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>



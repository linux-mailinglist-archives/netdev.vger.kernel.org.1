Return-Path: <netdev+bounces-125707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B33196E4EC
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 23:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D839DB20CBD
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E9E194C69;
	Thu,  5 Sep 2024 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LDfujtfR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84421917C9;
	Thu,  5 Sep 2024 21:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571184; cv=none; b=VZjNfHZqihmC1eDuOK8R4/qinA+3Xx9cO9oV4KRsqJhZ06uM3T2l0PK993ctTapi5D0Bx5iD6Tio81FXoZQR+itvSBw71fdZCR3sK3TeC3GNN2xzSVMuQ+QaEt+9eTv5+p9Fh2U3C98gSgk/fYDQi6iMvuHeQDEHVRztPENVmjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571184; c=relaxed/simple;
	bh=9Nc3Rm3BZFCmHkTVXOXQbq3azkqWIeZ28izYO663NZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFHyvcS6Mt9aB6xoHdboG8tULS0M6lD84eJG3sXqQZuBXW8kOT1zbQP7M+zmQ1ljHxNE2yuAtp7lREtYzyRaJs45Rsgh07N0pi1t6VU2cH1C++uW/uIcd2MZ88DYKnecW3zI7C4f1eQ7jg7m0ahtOdexTq9+59q/xh8yZb+jV5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LDfujtfR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9FiilU+Xa92ZvGz/lkVkPvChdSSNw0EcopOdJARN7kM=; b=LDfujtfRPOD2Tl6oYYfP6lbZNl
	UEJceS+pqzyYt0+RlW91QS+EfVr+FhC3TsW3bZl3IDGXzDmyeus0dMf5XyRONqsduXlkxCi4icP7u
	7IrL5cA2nnXEgIHFHO4HSHQSGJwYMQxacQnY+mdwLIWcjCo9atZKWZwrrA8brpiOjUp0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smJtA-006isa-Id; Thu, 05 Sep 2024 23:19:36 +0200
Date: Thu, 5 Sep 2024 23:19:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
	chunkeey@gmail.com
Subject: Re: [PATCHv3 net-next 4/9] net: ibm: emac: remove mii_bus with devm
Message-ID: <e23b4a46-d395-411b-885d-6a9796dfbcae@lunn.ch>
References: <20240905201506.12679-1-rosenp@gmail.com>
 <20240905201506.12679-5-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905201506.12679-5-rosenp@gmail.com>

On Thu, Sep 05, 2024 at 01:15:01PM -0700, Rosen Penev wrote:
> Switching to devm management of mii_bus allows to remove
> mdiobus_unregister calls and thus avoids needing a mii_bus global struct
> member.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


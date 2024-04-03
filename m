Return-Path: <netdev+bounces-84440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D521896F02
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3494E1F22FF0
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED6D146A63;
	Wed,  3 Apr 2024 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5MEad/l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0FF56B64
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147997; cv=none; b=EjE/t2PzwsO4D+h8XWJlUhwVqKHWUDdRj7l1Fm6H+o55bM7T2g3Oz4b5LSE7Ohuu0yXNijl+PwfOvKglmBR+Qlt6pkY+keXZ1h5nwucTxgJKZv3IT3WCt28lfq4JlwofFcBIKhNbkpHXRTT65h8Uqg0GY8iZ54JE4TlxDCDyJFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147997; c=relaxed/simple;
	bh=0sHBV5UIaJeGj8sDInwJ6PMHn2zWQHCzahO190d8Oac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPElByD7Y5kII+2lOzUctV+R6GzEfph3DA0YCIKbG0mlSodpqx9AhK7L+cbTy/XsGiIOaeKtnop1wWP6CiHEJZo0zJTzD+LZ+JRd19eTbePRjDJxMhy6rwsq7Gx0kT1l6lQHHa17V4CUl601At1NclvdXFUTN3RDaqBO7nsPzZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5MEad/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C01C43390;
	Wed,  3 Apr 2024 12:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712147997;
	bh=0sHBV5UIaJeGj8sDInwJ6PMHn2zWQHCzahO190d8Oac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b5MEad/l6web9h3g7uuT+faG2Tpo8R+k+1slUv9oAAjY8DA0h+IhAT8L7HSKmjZ6z
	 VPP3zb7MhgB4j1nCC8Tgd7W9UAs+9t9vqsyPba8BNYL9hn3pVkihkZZ/J8NjKezIyD
	 5Dm+EOqgasng4lzJo4HzJ3XEFDxDAJEJuB81pAWb20f9CFpns2SOjrINyLVQLFseEt
	 JPWpWjbnPt0o+PMT5Z5NDbMFAHYb0s66QeosTrolZH9pQLcencLFJfrLOyJ1YBjJjx
	 Urrtx4sXHiSOaCaCq3nDbXqph5p0G0m3+gd+XImcawF54MpNDZmbSah0F9eoX0H7oq
	 o4u6cT8yDm8Cw==
Date: Wed, 3 Apr 2024 13:39:53 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 11/15] mlxsw: pci: Make style change in
 mlxsw_pci_cq_tasklet()
Message-ID: <20240403123953.GG26556@kernel.org>
References: <cover.1712062203.git.petrm@nvidia.com>
 <7170a8f4429ecb5a539b0374c621697778ff8363.1712062203.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7170a8f4429ecb5a539b0374c621697778ff8363.1712062203.git.petrm@nvidia.com>

On Tue, Apr 02, 2024 at 03:54:24PM +0200, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> This function will be broken into several functions later. As preparation,
> reorder variables to reverse xmas tree.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>



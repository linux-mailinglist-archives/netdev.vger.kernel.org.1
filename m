Return-Path: <netdev+bounces-164240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9ECA2D1E1
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 01:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9C53ACEDA
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 00:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9994DEBE;
	Sat,  8 Feb 2025 00:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzgPARx0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65817A23;
	Sat,  8 Feb 2025 00:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738973293; cv=none; b=tM2K18DZXrsGuSdNT4z/++EDzcEkUzzh6+osUFLQWNApsu1QDqqrc9pyYXxKj+hJVcr83oq8RH7WeyDnanjqqJhAFXizGRIbpa+CW3Z+sff85shWi72Som/V0v/g+ZwCvjkngfovQQSBCIrXFhYDTlHXNXl27WQlSMf6mClU+0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738973293; c=relaxed/simple;
	bh=Jt27YOBauOT25eLYn1f+2wiLCkv2ekdcXnADQhe9MjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6CbU4bIKwfU4DfYotO1BgxciAFIRPDmEeiCx/b7cBnHkdA3ZhAGARB75nf5XBhQ7Xl+GNhFNCA5ZEffzl4Z1nVgRP9Ln85Vx66AqFqg8PMs+k9FoDSQv0vq9m2oec9k69vUX63z5EM8fQ7xBJ4jzNJBN399FMRCYv3M0jrXTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzgPARx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30891C4CED1;
	Sat,  8 Feb 2025 00:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738973292;
	bh=Jt27YOBauOT25eLYn1f+2wiLCkv2ekdcXnADQhe9MjQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KzgPARx0Up+NWJrOPE8IifvAD+G6oYYHUfeqoB7q92eA1q7LbteEJEQY/D/EKY0X+
	 USsNIP0nfw3bdDG7SUB+JmGXfNjI6d6bKfdmpKsJIWLrCT3s7eJliu+QeBQq8bmVQ7
	 4BnUpCUsGIf37xr5UqCSMKEMqOYmLYIo1Y62nw6ZeMm41qQeBl5u7x2pIza7OYcGyh
	 TaaABNUho8zL0m4v9rq5lrpvvItz7F5/LhR/rjHqXOTjLjHlaz9wEiRkkSdHjxS72G
	 zo8IQE3aYQpW5yYGMbmG6DtCe13n5N/xfJr24bsmrCtu2wNsNQIaHA3YlHr8hu/yhH
	 jXdGOPUJnrieA==
Date: Fri, 7 Feb 2025 16:08:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Aron Silverton
 <aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>,
 David Ahern <dsahern@kernel.org>, Andy Gospodarek <gospo@broadcom.com>,
 Christoph Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>, Leon
 Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, Saeed Mahameed
 <saeedm@nvidia.com>, "Nelson, Shannon" <shannon.nelson@amd.com>, Michael
 Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for
 fwctl_bnxt
Message-ID: <20250207160811.35898a4d@kernel.org>
In-Reply-To: <CACDg6nWU7XXn4X3LGy=jxREYDDVaqy1Pq19kt93wQPn_US9iiQ@mail.gmail.com>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
	<10-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
	<20250206164449.52b2dfef@kernel.org>
	<CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
	<20250207073648.1f0bad47@kernel.org>
	<CACDg6nWU7XXn4X3LGy=jxREYDDVaqy1Pq19kt93wQPn_US9iiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Feb 2025 18:29:15 -0500 Andy Gospodarek wrote:
> The primary use-case that I find valuable is the ability to perform
> debug of different parts of a hardware pipeline when devices are
> already in the field.

I think we covered the "debug by people who have access to the RTL"
in previous iterations. For networking that's not a sufficient use
case for a backdoor this powerful, sorry.


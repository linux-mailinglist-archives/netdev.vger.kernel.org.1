Return-Path: <netdev+bounces-204680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D140BAFBB40
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18CBF3BD08E
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 19:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014582620D2;
	Mon,  7 Jul 2025 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgLmOZd2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AAA4D8CE
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 19:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751915009; cv=none; b=K5FNpUnCH95A2JP8qxmoJyEM4ujFceGHJqMk9g7nIoYWscFIzb450PhjY8FQcb7AgzEEttm2KdUCiT8zE7UiVmAm/MwqFpH5LJSgt+2SOTxBWbhc++00EAtcewIa0/HOVqW7hn+mQPXhpv2WRz0d6aNF+N52xuTu7A/ugJu09PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751915009; c=relaxed/simple;
	bh=+U9DkfW89jLuqNRYXlI2LUJqXJisgDddl3By7VtSPqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sbw3c8apXrhmAtxmmRued9Mcc3GGDYHvexbMhdgrtjEL+i2z1D5FdPkvCPr+gqiy5rbYXJEyin5Z8qSPWEZFMYnV+rJYamEYoyK+V/5eRbjkkhXueb6ac70+rff1tnT2IEbkro2Had2BB0U7KlNxoSB1nQqBHiekDackjUJv6Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgLmOZd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD04AC4CEE3;
	Mon,  7 Jul 2025 19:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751915009;
	bh=+U9DkfW89jLuqNRYXlI2LUJqXJisgDddl3By7VtSPqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jgLmOZd2z+5OTojFoCTbb0W0DvYq/XgxSV43onLS0FbTY6pi/Sl3gZDp2ez3B89cE
	 ofWUcYAWQbyjox7OCwn5kuZwCnqWy0vPoBVQL32iNSaXvDOk7HXiElGqQmmu0mpIoR
	 TU7QsL+0qT0DKwlpKWSwuiKZ0JPKB4oIq6E8vHY6VKmVkfGVFrQyRMRc+P9wC57Za4
	 Mw7aLpno7jenOPSlrRP1uRdy50i34SJoNp7Q9M50dnLS0bq1jzXyjPS6fp85HOnJnD
	 F2MRM0VEU7gSlTzbFYR0CU4i43zJIqQ8OQKp1dz8AvP/B5spX2D+VNviNPYEQNiQ7y
	 KL9XBTL1vaM/w==
Date: Mon, 7 Jul 2025 20:03:25 +0100
From: Simon Horman <horms@kernel.org>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] selftests: net: add netdev-l2addr.sh for
 testing L2 address functionality
Message-ID: <20250707190325.GA452973@horms.kernel.org>
References: <20250706-netdevsim-perm_addr-v3-0-88123e2b2027@redhat.com>
 <20250706-netdevsim-perm_addr-v3-2-88123e2b2027@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250706-netdevsim-perm_addr-v3-2-88123e2b2027@redhat.com>

On Sun, Jul 06, 2025 at 04:45:32PM +0200, Toke Høiland-Jørgensen wrote:
> Add a new test script to the network selftests which tests getting and
> setting of layer 2 addresses through netlink, including the newly added
> support for setting a permaddr on netdevsim devices.
> 
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>



Return-Path: <netdev+bounces-110987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE8292F326
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077751F22458
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EE210F9;
	Fri, 12 Jul 2024 00:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBlpiQKM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A781FAA;
	Fri, 12 Jul 2024 00:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720744999; cv=none; b=c0W8JyZCjlxqe7vJwN8pcJJj4thfGQRTHEzLB38NcLF7tv23zZQDIV3TTi1qvyeb+6CIdMK4nSSuTI4p52/XxMEJGPDFI780+JdUmq9EtzuptcigJspAYfuAYXRcIFqI+7xHQkoZnJQnK0tpf3X4wk4Mf9VwAQGYrb9kHmrCxX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720744999; c=relaxed/simple;
	bh=1p0IrgdYSR9kqCtTEYwRzq0bPZoCbaHGNJuxytCUFTw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bsh8LtXfBw7y3q7pe8WPs83zcJL+BW3sSewrcB+8I3RF2SR77hEofsVHb8rUE7+Vvpp3rF+ig512o4YZ06RpreUdnoIPyexUZKOmLZkckj4u8LmQm3i3yJrTBXH+eXyYT4F5ACSV2rdRsD0ju5Y0eljoTJgawgQsXdkzShRCg5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBlpiQKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECE5C32782;
	Fri, 12 Jul 2024 00:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720744999;
	bh=1p0IrgdYSR9kqCtTEYwRzq0bPZoCbaHGNJuxytCUFTw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KBlpiQKMu3qPBB4lff8uaHGZVd09DY38RYecU2W3XYzCaKae/w91oW0rGlh7xe7/A
	 ObvCyu8jhdzAvIyjra6Q63NXE9xsFmDQhxvX8xnPyrEBGORbFgVnLNNm0WVvGpIepu
	 JzG7VCX8qzOFQtTeDDmap5RsoVxU0Ye6cOPFCa5iRD+JTWTKlv3nx3UkpHuqaH6G/g
	 nuAlp0h7e7rPUccqhseziI7xNgVZebWJVEOSzQegVTxDID89GB/+gfGTyX4b2Wlqzb
	 7SX8Krz5Qv3XMZGJnki48ftjHjovQCrZasaYV7kSf7Qwst/TTdHUlMbx8FDxGhiZZh
	 ywHSd3JZWv0XQ==
Date: Thu, 11 Jul 2024 17:43:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <idosch@nvidia.com>, <petrm@nvidia.com>,
 <ecree.xilinx@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: ethtool: Monotonically increase the
 message sequence number
Message-ID: <20240711174317.58a7b023@kernel.org>
In-Reply-To: <20240711080934.2071869-1-danieller@nvidia.com>
References: <20240711080934.2071869-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 11:09:34 +0300 Danielle Ratson wrote:
> Currently, during the module firmware flashing process, unicast
> notifications are sent from the kernel using the same sequence number,
> making it impossible for user space to track missed notifications.
> 
> Monotonically increase the message sequence number, so the order of
> notifications could be tracked effectively.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>


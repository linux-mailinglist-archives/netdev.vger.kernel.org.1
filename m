Return-Path: <netdev+bounces-67380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D793484327A
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 02:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934482859C5
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 01:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44537376;
	Wed, 31 Jan 2024 01:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwWsPG8G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DB636E
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 01:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706663227; cv=none; b=YShZegAPe1gdSB6JgcLYlIP/6AJL80vTA9GYtd2c14Z72kHk1klulMdwCd3fV+RDF0MAD0DzdELWeV4LSgwUggYg75NFkB9Tqt6fJZZKzzjwKKRZmkNXHQhV5qkvTry1oNmF7ST9Sk+1gQaNBH8YwXXhM2YqHeobmQFs4xGJ5es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706663227; c=relaxed/simple;
	bh=lzTwGueTYIb1jToBziHXzSWjEOTNjYl0a5BAlrJq8jU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fNigcNBfQqUUGw0dreYOwV7PRlAq1JEOHjgrfNYW1vD3sNS7phIUtgQLFkCRHDrgmtRfKVd+SHJlkCXOg4IYP5gxmpLxnvXEdE3AKcMfPXfgGQ9yRaH+gMSISQQiT977I+U7pc+p/m9poX+8AROakJD0bjdXjq5unKpW6s2zCdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwWsPG8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAD4C43390;
	Wed, 31 Jan 2024 01:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706663226;
	bh=lzTwGueTYIb1jToBziHXzSWjEOTNjYl0a5BAlrJq8jU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TwWsPG8GsChyQ2qrM0PvdOwiPSW55TruvJPUgTnH2KVcCF6P9a0JUyE9nTpvlXnRq
	 6Njci3f5ZgLW7NqVuBw91CtGZ3k3BzQfM3kUi/WwYljoIc8H9sJnDmyNa1WwPrpEnx
	 /xlR03xF0qxVNpqEnYG3PuR2B9C3HcXn+s+pw5Ty4dd0z4ikvx3XtNBp60PwXgoL/0
	 B26Kp4rMhdl97CTzkoVsgKwyAufDiEFeopWUIbfZX4jSXtMd9G2TLY/HwmyxWaehfJ
	 uUrsMA6K+1eIjG930Lj40xPiapZS3DncsXGd2m7UdGVfUkbLE9CkviNlU+QmAXTiOI
	 nArc72LZjWyzA==
Date: Tue, 30 Jan 2024 17:07:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: William Tu <witu@nvidia.com>
Cc: <bodong@nvidia.com>, <jiri@nvidia.com>, <netdev@vger.kernel.org>,
 <saeedm@nvidia.com>
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Message-ID: <20240130170702.0d80e432@kernel.org>
In-Reply-To: <20240125223617.7298-1-witu@nvidia.com>
References: <20240125045624.68689-1-witu@nvidia.com>
	<20240125223617.7298-1-witu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 14:36:17 -0800 William Tu wrote:
> Add devlink-sd, shared descriptor, documentation. The devlink-sd
> mechanism is targeted for configuration of the shared rx descriptors
> that server as a descriptor pool for ethernet reprsentors (reps)
> to better utilize memory. 

Do you only need this API to configure representors?


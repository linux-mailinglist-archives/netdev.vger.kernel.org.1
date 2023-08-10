Return-Path: <netdev+bounces-26475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC523777EB2
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 19:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCFEA1C2143A
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDA220F8C;
	Thu, 10 Aug 2023 17:01:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C9A1E1C0
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 17:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39B9C433C8;
	Thu, 10 Aug 2023 17:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691686878;
	bh=ug0ToZaQ+26VrxwWyipH2+iRSYZ9hdf+cd7Pw7nfQ64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eJGdZTG/RZeqe7woRktKCv1BPx+OQc5d9o+DYY6rYIue+SIyXt7MNxFi0Hav1Yw3d
	 gKXoOjwOhS25iJsenSED7nbPC3zSRlHDa9dbch9W03hqwTuyT6RMV9pDGwJYQyLMAU
	 0N/Ey1IbN7hm3iHu2eG7A7LFNR1TyKwG71MD6rNOSUwCSp08EN4Hwq6l5Cd9dyLhEs
	 73AUSqGF9HgyBcBc8X3+JIsSNrAsGxWcvgPJBUmCEnuU2swk0L9wdLMUCcGaXD0C7i
	 BbxTu47PHKyhnfQjvMParFku8gAmgt+OwUBlCxi0TPlh+iKcOdA+lwKE2sVcWhxFsf
	 uk4D3x79AuEcw==
Date: Thu, 10 Aug 2023 10:01:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gang Li <gang.li@linux.dev>
Cc: Michal Kubecek <mkubecek@suse.cz>, netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] netlink: allow nl_sset return -EOPNOTSUPP to
 fallback to do_sset
Message-ID: <20230810100117.0b562777@kernel.org>
In-Reply-To: <51b2f9c6-fc0f-9e77-6863-2d6b71130c51@linux.dev>
References: <51b2f9c6-fc0f-9e77-6863-2d6b71130c51@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Aug 2023 20:53:02 +0800 Gang Li wrote:
> Subject: [PATCH 1/1] netlink: allow nl_sset return -EOPNOTSUPP to fallback to  do_sset

Please make sure to add the project to the subject next time.
[PATCH ethtool]


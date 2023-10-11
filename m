Return-Path: <netdev+bounces-39771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C1C7C46E2
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 02:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE36280E6A
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 00:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1FC388;
	Wed, 11 Oct 2023 00:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQmvVyYt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF567F9
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 00:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9531C433C7;
	Wed, 11 Oct 2023 00:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696985604;
	bh=mj9vvaX08mP1wsFqvNHjipeBW3oiY6bFRx9YYrrtEjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SQmvVyYtVLEOYvX7+LDjj9zLovnh6YjUlLuuu9OGYshtCFt+Q4D5mWZVMwzjQ30iD
	 kZgYpm11raGEUDegk0Be42OEkyiZnq3KbQTTVIApaN+JyIkHefcUweFGiLX8IfNmw7
	 leFqzFP9Q/dcxXJfYwSvkq3T7Y7eTvYEKGiU6t1cM3Og6yHsohOxn0rFYNRfIgT5zX
	 2+F56R0biKBD4mXU1g+NoKH83puQhQNF+MUP8IoNVU5UQUtX/ZN1Ra8zqlMmbGwQWd
	 UHz8m2UtlDYrm+fnIPCGaklSbR91AmilQjiPeNLoWJCQtZUn94Qv9//ftJRzeJrEsB
	 59ZHJ+YvSXLYA==
Date: Tue, 10 Oct 2023 17:53:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net,
 Liam.Howlett@oracle.com, netdev@vger.kernel.org, oliver.sang@intel.com
Subject: Re: [PATCH v1] Bug fix for issue found by kernel test robot
Message-ID: <20231010175322.0efb8a87@kernel.org>
In-Reply-To: <20231010213549.3662003-1-anjali.k.kulkarni@oracle.com>
References: <20231010213549.3662003-1-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Thanks for the fix! Let's start with some basic process feedback :)

On Tue, 10 Oct 2023 14:35:49 -0700 Anjali Kulkarni wrote:
> Subject: [PATCH v1] Bug fix for issue found by kernel test robot

Subject needs to describe the issue (e.g. fix null-deref due to $xyz)

> cn_netlink_send_mult() should be called with filter & filter_data only
> for EXIT case. For all other events, filter & filter_data should be
> NULL.

We need (1) a Fixes tag pointing to the commit which added the bug
(2) appropriate Reported-by tag (see the syzbot report)

> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
-- 
pw-bot: cr


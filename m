Return-Path: <netdev+bounces-32491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3240797F85
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 02:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD43D2817DD
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 00:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BB736B;
	Fri,  8 Sep 2023 00:07:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA4A368
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 00:07:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821D7C433C8;
	Fri,  8 Sep 2023 00:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694131626;
	bh=P+aXUyIx+U21H1M5Y48wj3+GufrCzFsOSvgFHXvWrgA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bHkQyAc0lB77JjSQlTNLkSR8AeF6yLsN10i96J1YTdaV0TgQzFsGLUdkJyTux9flj
	 SXPjkGozUEmtxGkOIQh5IOFe9lVWLqHnh6IZ0kHuLTabisPR42Xsc8CNo37/WgPOw9
	 tVPVufNcb5jt6hOR+wjhT602oIsNPTgzhleGXB1iwLoGZlQGOrirQzRnbRpNUu0NWW
	 rwgH3NXAKAAY8GvCay3GC/gIgIZa1tRJdf4ynEfys4xbDSHOEshwKm3ROq1RVF3W5c
	 dsEv6fmtDth4JsAYzvjB47lLgy1k4nj5Gd/AHG+p3eskXk7IP5Jgxa4nPlkvFxf2Ah
	 gBd/g1TAburig==
Message-ID: <060ee8d4-3b78-c360-ac36-3f6609a5da89@kernel.org>
Date: Thu, 7 Sep 2023 18:07:05 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] vdpa: consume device_features parameter
Content-Language: en-US
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: allen.hubbe@amd.com, drivers@pensando.io, jasowang@redhat.com,
 mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, shannon.nelson@amd.com
References: <29db10bca7e5ef6b1137282292660fc337a4323a.1683907102.git.allen.hubbe@amd.com>
 <b4eeb1b9-1e65-3ef5-1a19-ecd0b14d29e9@oracle.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <b4eeb1b9-1e65-3ef5-1a19-ecd0b14d29e9@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/7/23 2:41 PM, Si-Wei Liu wrote:
> Hi David,
> 
> Why this patch doesn't get picked in the last 4 months? Maybe the
> subject is not clear, but this is an iproute2 patch. Would it be
> possible to merge at your earliest convenience?
> 
> PS, adding my R-b to the patch.
> 

It got marked "Not applicable":
https://patchwork.kernel.org/project/netdevbpf/patch/29db10bca7e5ef6b1137282292660fc337a4323a.1683907102.git.allen.hubbe@amd.com/

Resend the patch with any reviewed by tags and be sure to cc me.



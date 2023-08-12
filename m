Return-Path: <netdev+bounces-26985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B395779C2D
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 03:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B620D1C20A94
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 01:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321C1A2D;
	Sat, 12 Aug 2023 01:02:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2999E64B
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 01:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E79FC433C8;
	Sat, 12 Aug 2023 01:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691802174;
	bh=TW00OTazVnzY5glwiEUj36zrMi+rWEbjlvVO8Y0bFjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fm/RY8l9z6PTI5gb0/4raKaSc9c1aBuEwrq5aze3mdytVjevCainytJvGMnWYYeve
	 QkBYw/8KmFTrC+iXCUGt9oEDFHGb/uUHlv1x7XQf/ndVlskgMwdq7ei8b/JParD6GI
	 RkijYxqX2i8MrLATjz/oI6lnXpDZomQ7oGGvWW+B1w0ApRzOP8USsA5ITNOPsQ1yHG
	 KPZ2/AWj743uk4osgfYVjMtI4RHhpsSc13JhTvq1Q3DSjcGZxOS+kBu5cEX0YRKDjI
	 nX2NW9kxb2sTqnUCm41f1cd/pT6MZ6k1LsNPq5MWkko27KEJ2xv5OnpETuTpi/Dz5b
	 qkNMn5Esj4asA==
Date: Fri, 11 Aug 2023 18:02:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
 idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v4 00/13] devlink: introduce selective dumps
Message-ID: <20230811180253.0114d307@kernel.org>
In-Reply-To: <20230811155714.1736405-1-jiri@resnulli.us>
References: <20230811155714.1736405-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Aug 2023 17:57:01 +0200 Jiri Pirko wrote:
> For SFs, one devlink instance per SF is created. There might be
> thousands of these on a single host. When a user needs to know port
> handle for specific SF, he needs to dump all devlink ports on the host
> which does not scale good.

Acked-by: Jakub Kicinski <kuba@kernel.org>


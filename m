Return-Path: <netdev+bounces-116213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E5E9497E7
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 21:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D73281C61
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4724F8A0;
	Tue,  6 Aug 2024 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDJCbWcc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EDB18D62B;
	Tue,  6 Aug 2024 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722970838; cv=none; b=IBiyEGQMmyAtfontwJxIK4BjpjjNH/X38KMdBoP1JiD1oawlDzZnQs9ztrA5E/KsMrMBBcMSb5s+qFum//O6YhLnucI/SOA2aMWH1Ix8IbKpF4QeUAzKphaCC/rqkNNzvcCP/SwEv+e91B8pYVTsHFwgZAXtqPZqQN7xwZgp6Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722970838; c=relaxed/simple;
	bh=Xaguw25vGST+m4rKcPcqkDDVvJTgQ1ZajBE1ca0YgEM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4YWwJUEWtu6VwuWyIVbORfgfW9SI0pX+GTkxnT4lPlrrsAmr7+zWW6qw5gm7BhlrzIAmGuBMwYcN7UobCws2aRADzDG0AI3B5ahPtQQ+8QtesHuK4TOcjrSDfVrYkD+dQi/aNAldSoxOTqLP+ueVuZSCKFV053s4Z5tLEI1GMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDJCbWcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05224C32786;
	Tue,  6 Aug 2024 19:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722970838;
	bh=Xaguw25vGST+m4rKcPcqkDDVvJTgQ1ZajBE1ca0YgEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JDJCbWcc1n6PKSb7QjkQhoWp+rSou41n3Q0l2EBZR401u/nymzYvafmEUCIZbL/LQ
	 N/Tle52QhuBW81tPQjuaJKlrrFgWquGXsQVx6qFM0SCe2JDxxeCm/h3xOYM1Ojnex5
	 hCKBXc5WTk52mXfMcY0w1Boc1iFpbIhJlg40Md9viQ9Z7C3Q5NMfTPGaqcwAadT3/o
	 Ya+3dozMvxit2N2zwcwir5EMzYGqbo2VogZLVqutbQCix/NNVTwnA0e0ezROyzmaVZ
	 r8bmR0YJlT1fhNo+u3OXrhbNPxKz82P1CB/zSvLieyMtjmCDrkFZ/MB1i4V7YakcXD
	 Ou8Sy+N8tVn1g==
Date: Tue, 6 Aug 2024 12:00:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Randy Li <ayaka@soulik.info>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: tuntap: add ioctl() TUNGETQUEUEINDEX
 to fetch queue index
Message-ID: <20240806120037.76a279fe@kernel.org>
In-Reply-To: <20240801134929.206678-1-ayaka@soulik.info>
References: <20240801134929.206678-1-ayaka@soulik.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Aug 2024 21:49:21 +0800 Randy Li wrote:
> +		if(put_user(tfile->queue_index, (unsigned int __user*)argp))

Checkpatch has some legitimate complains about this line:

ERROR: "(foo*)" should be "(foo *)"
#58: FILE: drivers/net/tun.c:3160:
+		if(put_user(tfile->queue_index, (unsigned int __user*)argp))

ERROR: space required before the open parenthesis '('
#58: FILE: drivers/net/tun.c:3160:
+		if(put_user(tfile->queue_index, (unsigned int __user*)argp))


Assuming Willem is okay with the feature, please add appropriate tests
in tools/testing/selftests/net/tap.c
-- 
pw-bot: cr


Return-Path: <netdev+bounces-54241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D736B8065B6
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82AC11F2178F
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 03:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC86ED2F3;
	Wed,  6 Dec 2023 03:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCHPodtZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1378D2F1
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 03:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26ABC433C9;
	Wed,  6 Dec 2023 03:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701833969;
	bh=AOh4lvJyKZj7kvL0oUkXbn5GgEexeKClRJghtB512pQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gCHPodtZj4IpJntXyhnoXQ/MQiB15BDKR3zRn3FHWwvMp5kVfUB0p5ZOUzlLxJtpa
	 S/huHRCKU5++jmhZaLSHq5SvnU6YHR4GRSYwMvsrcX0IpU0yYGhODXY92gkrZICbvs
	 LuwXg7mkDMxEgl+YCoAbvMqXbRbGkITgV3P3JWSSPjYEJVbJafrtKnlJAIja5DG1Iz
	 Al+k/w+gBrjmPuZpSoDlP0cJwU3rAVOZMSsnVMUWy4OdKbMMpYBp/WVPJSokNN0W8p
	 uqp5RQg5XIw6hqMZMMVGzBW1z2j6Pg7IeR9uSq5gHMksOtCRa05RCjcjiuobN02KvL
	 JtKQqopWHN8sQ==
Message-ID: <416f1e84-1293-470f-b613-d676fe9e4f93@kernel.org>
Date: Tue, 5 Dec 2023 20:39:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ipv6: support reporting otherwise unknown prefix
 flags in RTM_NEWPREFIX
Content-Language: en-US
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shirley Ma <mashirle@us.ibm.com>,
 Lorenzo Colitti <lorenzo@google.com>
References: <20231204195252.2004515-1-maze@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231204195252.2004515-1-maze@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/4/23 12:52 PM, Maciej Żenczykowski wrote:
> Lorenzo points out that we effectively clear all unknown
> flags from PIO when copying them to userspace in the netlink
> RTM_NEWPREFIX notification.

The existing flags have been there since before git (2005) and no new
ones have been added. So, what is the problem with existing code?
conflicts with an out-of-tree patch?


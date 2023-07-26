Return-Path: <netdev+bounces-21170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F773762A31
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 06:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A07A2819D4
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 04:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D9553AE;
	Wed, 26 Jul 2023 04:17:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D321C5399
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 04:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FF6C433CD;
	Wed, 26 Jul 2023 04:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690345019;
	bh=jmLkPu8Wb9gfHfkDQVJVu381ycJxv8EbdFX++KNl2Ec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jNUaiZQR+1GQyqSIL/p+aCORyGTEBDbGVQ3EayyH6y9vyzBnYFL5d/vDBk3lTyBkx
	 Rw/4p2K1LVOHdmK8v3HOP2fib5PR940oHvF8V4eEiS3XgAjOP4h/zCq01vp9vUu6EJ
	 oYrV1EuuDDLTIEFL7ZFuwXFBDQK8uZYS4WSzq6WBq8bOtTkBTZsnVZCi8VPGI4rBxa
	 gdojjLKrGDM0SJYGOeF1YJdtsXJI9ljS49PqT6mZ2s4+6g6RccWm6vnxeMyg/IYZWm
	 zsiZUJNfAYGWsk8h9FV42nr0V6kZ7QrbPs4okyPQ8sFjGezVU44vD37NSn3hB0j30b
	 lEwkg5FS5ARBQ==
Date: Tue, 25 Jul 2023 21:16:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 0/3] tools/net/ynl: Add support for
 netlink-raw families
Message-ID: <20230725211657.346b9e5e@kernel.org>
In-Reply-To: <20230725162205.27526-1-donald.hunter@gmail.com>
References: <20230725162205.27526-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 17:22:02 +0100 Donald Hunter wrote:
> This patchset adds support for netlink-raw families such as rtnetlink.
> 
> The first patch contains the schema definition.
> The second patch extends ynl to support netlink-raw
> The third patch adds rtnetlink addr and route message types

Haven't gotten to it today, unfortunately, but very exciting!


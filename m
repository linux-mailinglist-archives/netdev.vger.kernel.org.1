Return-Path: <netdev+bounces-15588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C44748A6B
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 19:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50237281088
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 17:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60A7134B9;
	Wed,  5 Jul 2023 17:31:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78244134AD
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 17:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBD7C433C7;
	Wed,  5 Jul 2023 17:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688578272;
	bh=u0jGPwyF5W+GPgmlKbTrpvhnlr4JFUEeciYVh9XcQiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dZM1qGa1ol/JmRR+D26/xCKiHBx5+S+HxW+KaNVZWIv7MD+R1c0WXbZGArE1wAj3q
	 0714IDwKUZokt2phMjqikW70TCadkUBH9+siwwUOnudstPQSzRkSjDPrQve4dpKypC
	 H29EUcOkMitHDOGq4uv61EluPKvRZXmuTiVoNQkCzC3/I48ZT3yAO9Wc6XFm/Ifi7I
	 2e96sxBtRxPouJ1WSWMGzWJ9ij8ggR5fJQyzxZQIeRm3hDZs3WV5v7pL0+CbMvbBzU
	 mZ+CjH7JCn6QNwgWDVXZTe1SZBFtMPHYkYTdAQBfcPuTjBPu9e1FaxF1fYLEQicM2m
	 0uIMmhqk1jyPg==
Date: Wed, 5 Jul 2023 10:31:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "M. Haener" <michael.haener@siemens.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH v2 0/3] net: dsa: SERDES support for mv88e632x family
Message-ID: <20230705103111.1a7fb88b@kernel.org>
In-Reply-To: <20230704065916.132486-1-michael.haener@siemens.com>
References: <20230704065916.132486-1-michael.haener@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Jul 2023 08:59:03 +0200 M. Haener wrote:
> This patch series brings SERDES support for the mv88e632x family.

Not sure if this was said already - you'll need to repost once
Russell's patches are merged. It's a good practice to send patches 
with unmet dependencies as RFC.


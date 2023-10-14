Return-Path: <netdev+bounces-40926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBAD7C91E2
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48586282DF1
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993C3374;
	Sat, 14 Oct 2023 00:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EziUhmAK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4297E
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 00:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C00C433C8;
	Sat, 14 Oct 2023 00:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697244558;
	bh=1OuDIBPSP56OUSXV6qWm3oIscqloJHF80yZOdxmXzzk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EziUhmAKbTqpkwuYG9l0nluYQyRN5FLIl8ERSAF/+UAIC4Qrr7Zg2xRWfIfDgaooC
	 ak5pNzXgNN188KkL3x9sT3rNO7u3bEKeG5LAq1N8gmJU2yjOALjiZz0vxc/GdKKNoJ
	 F+xp9r3T8waq1mRDkesG48rXy4srH5KKOsfOf0pxak8AzSingxvngivCP+AETQ+UP2
	 x4snNRPgNRy9rswMi/LCQbMMSpfMsfsgzuEr71o3Lag/wrPy0DwQ2u2iygbPIJg8Et
	 t3/ThcvKgLjWGqNcZFEi33HnqoWSMb64M6sk3/L2riBcOFaxA2FalS9Tvr8famcvTT
	 VVkM98ZvAIiVw==
Date: Fri, 13 Oct 2023 17:49:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Networking <netdev@vger.kernel.org>,
 Loic Poulain <loic.poulain@linaro.org>, Sergey Ryazanov
 <ryazanov.s.a@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Mat Martineau
 <martineau@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, "Srivatsa S.
 Bhat (VMware)" <srivatsa@csail.mit.edu>, Alan Stern
 <stern@rowland.harvard.edu>, Jesper Juhl <jesperjuhl76@gmail.com>
Subject: Re: [PATCH net 2/2] MAINTAINERS: Remove linuxwwan@intel.com mailing
 list
Message-ID: <20231013174916.40707d19@kernel.org>
In-Reply-To: <20231013014010.18338-3-bagasdotme@gmail.com>
References: <20231013014010.18338-1-bagasdotme@gmail.com>
	<20231013014010.18338-3-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Oct 2023 08:40:09 +0700 Bagas Sanjaya wrote:
> Messages submitted to the ML bounce (address not found error). In
> fact, the ML was mistagged as person maintainer instead of mailing
> list.

Johannes, no chance we can get someone to help with IOSM?


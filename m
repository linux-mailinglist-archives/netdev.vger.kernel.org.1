Return-Path: <netdev+bounces-54258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52CA8065F4
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 05:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B5428224A
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5773ADDCA;
	Wed,  6 Dec 2023 04:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbM5kLln"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE69D52D
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 04:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6960FC433C7;
	Wed,  6 Dec 2023 04:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701835496;
	bh=jzpjtvDk5xiEmJex94u1NCKjiMJwNLQQggjgz4Gc5Vs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KbM5kLlnvgfK/xBYKFPHQa33kGf+8iPh7VmT4fbFqbQkpauhakjMt9yTKslwbWFNI
	 SaQcW4uOpvtYVLIFZp0ZMI4WO7uh4xKbxWpRNzKxjtXNonHT+kpnFX5pak5F1H/dIL
	 gVniZNSJUWwowpYqxShmMOny1g9Uyy3VIvoY3KvV+0vE4TgMUWZpZWqGHBQ9Et3eBY
	 jYCwM/4ENaM5NWuIGwW8G3FTOTRQ9EsevfV6YEts5Le7HiLhRdbZ1dyQTZf4XGh2WZ
	 tc3AvH3mnR4xgZt/k+JPc+QdnOMXP/i5k/c7w8yihpwyc9d0mv4tA3BbyRKw537G8/
	 cS23D/25OJSfg==
Date: Tue, 5 Dec 2023 20:04:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH 8/8] dpaa2-switch: cleanup the egress flood of an unused
 FDB
Message-ID: <20231205200455.2292acf6@kernel.org>
In-Reply-To: <20231204163528.1797565-9-ioana.ciornei@nxp.com>
References: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
	<20231204163528.1797565-9-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Dec 2023 18:35:28 +0200 Ioana Ciornei wrote:
> In case a switch interface is joining a bridge, its FDB might change. In
> case this happens, we have to recreate the egress flood setup of the FDB
> that we just left. For this to happen, keep track of the old FDB and
> just call dpaa2_switch_fdb_set_egress_flood() on it.

Is this not a fix? FWIW the commit message is a bit hard to parse,
rephrasing would help..


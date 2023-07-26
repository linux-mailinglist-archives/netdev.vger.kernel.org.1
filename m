Return-Path: <netdev+bounces-21667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D757642A3
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 01:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E22541C21470
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA86DBE5C;
	Wed, 26 Jul 2023 23:37:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58D9A944
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 23:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3221C433C8;
	Wed, 26 Jul 2023 23:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690414640;
	bh=kIjqVjQCDiahZu4Q4NPqvjK29shzIgoTZHTKOwLB5DQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BthAIYKoupn/sFgM6qinYWqrypV0mq8RugQR/zl4AXjLyz5KQG6eAMlO8PfV00cVc
	 xMR91pcNUwhQoUnKny32Y6JK9niPcCD5oqIdSn8jyGcMfcu9KLI7iUwdgn+XawTIC2
	 EK0fWahFVNSkZofrLe1CkJTqBvrqxLfKLCj6Y8xAZz4Xsmk+3jPvi5VnHzJzPNrASC
	 7ojj7/xGAefEf7L1f0G6WN1cvw+7dil2NX0wO6IZKITKdmXSUssgWoTkLvI7YYHUH6
	 QomULVV0gosqCgsKniGWDHtn/ozuAZhmfp3hW7CP63LCdXLNIn+7k02ybJk6Z/5fSY
	 rRBAR1qd4FFzg==
Date: Wed, 26 Jul 2023 16:37:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next 3/4] ynl: regenerate all headers
Message-ID: <20230726163718.6b744ccf@kernel.org>
In-Reply-To: <20230725233517.2614868-4-sdf@google.com>
References: <20230725233517.2614868-1-sdf@google.com>
	<20230725233517.2614868-4-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 16:35:16 -0700 Stanislav Fomichev wrote:
> Also add small (and simple - no dependencies) makefile rule do update
> the UAPI ones.

I was thinking people would use:

./tools/net/ynl/ynl-regen.sh -f

for this. It is slightly more capable. Can we perhaps hook the new make
target to just run that script?


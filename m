Return-Path: <netdev+bounces-15834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B28C274A161
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 17:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735C628133F
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 15:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2A9AD2D;
	Thu,  6 Jul 2023 15:48:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B731AD25
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 15:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDC3C433C7;
	Thu,  6 Jul 2023 15:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688658481;
	bh=4ASIsjcCMXJ6y3BmrH23jMs2Uiv/tnU9i09G/DMp9i8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PsUdJCiPG2ZCBQJG2eka4OFYlYQdogV7Ar1J3g9NEI4VfTjSoAJIf2dOK1IqK95mh
	 I6iP+r5jNWf0hUmQPPtTotHi0NUu3m6MhV17q9t9Kc/8r/RBzehV4vqneSrlBRN4hx
	 V/0CTuE9xT4Zi89Tn0ntAd+l8vI13+yuRfUqJ1iMik7xwSVVzDkbWx22XOlbiCK+ab
	 h74R6h3/AfHD3ybFrrBLc/nK6GimGlcfzUtEMQdUKqnKoPIKioiD0ZyJbVFBgMSO7E
	 isukZTMpyXvCbBlvwNjdcqWyyc8nFqXbLQ3y6nItWHjnjyTu2kir8us3LIvhc514Dd
	 5bJ5BFF0jG0Yg==
Date: Thu, 6 Jul 2023 08:48:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wang Ming <machel@vivo.com>
Cc: Sunil Goutham <sgoutham@marvell.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com, simon.horman@corigine.com
Subject: Re: [PATCH net v2] net:thunder:Fix resource leaks in
 device_for_each_child_node() loops
Message-ID: <20230706084800.579bd030@kernel.org>
In-Reply-To: <20230706123021.8174-1-machel@vivo.com>
References: <20230706123021.8174-1-machel@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Jul 2023 20:30:11 +0800 Wang Ming wrote:
> The device_for_each_child_node() loop in
> bgx_init_of_phy() function should have
> fwnode_handle_put() before break
> which could avoid resource leaks.
> This patch could fix this bug.

Don't ignore previous feedback
-- 
pw-bot: cr


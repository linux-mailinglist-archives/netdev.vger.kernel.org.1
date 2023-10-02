Return-Path: <netdev+bounces-37479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C807B589A
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 19:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5C740283E6B
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 17:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ECF1DDD7;
	Mon,  2 Oct 2023 17:07:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4E61A73C
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 17:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA201C433C8;
	Mon,  2 Oct 2023 17:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696266462;
	bh=jYjBN7hUBvdHjoT7jKI5LL8GGyIxG4jttpVPeu6SGJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nlUdZX3csePmoZmt3/sZKSzHo9rU2ARGplQ35OARJ9B+o5VHnqeWID+diJ8vHGAhV
	 i5k3bt4aBj8JTCAW3ZDyvPgAvHkwpyCUCnTb0844A3P2Rnr1O4VdhceMxmdbymdHzH
	 V37ry8WYwIWUZ7WiqQOP9+D7K6DfkdMrkf9gwfXlLpP9gnNoq4qu8vCcjKp1MJNOke
	 G88iiBg7sHODTjUx76fkeql6rAgp5ZsEVYCF183kEsTulkdgRAjRlSOz7uEHvV+87J
	 wE6Y3FfWiXAH5fIlWOdjk1ZtSb3cT7kZwreaBbaZT0GeXem5LqC9gdCtyBqK+Fy9th
	 BqF/bGfXLZEmQ==
Date: Mon, 2 Oct 2023 19:07:38 +0200
From: Simon Horman <horms@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net-next] sctp: Spelling s/preceeding/preceding/g
Message-ID: <20231002170738.GA92317@kernel.org>
References: <663b14d07d6d716ddc34482834d6b65a2f714cfb.1695903447.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <663b14d07d6d716ddc34482834d6b65a2f714cfb.1695903447.git.geert+renesas@glider.be>

On Thu, Sep 28, 2023 at 02:17:48PM +0200, Geert Uytterhoeven wrote:
> Fix a misspelling of "preceding".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms@kernel.org>



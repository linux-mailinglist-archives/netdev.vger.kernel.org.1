Return-Path: <netdev+bounces-26498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C1E777F4E
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 19:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750331C2126E
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AAA214F6;
	Thu, 10 Aug 2023 17:42:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58FA1E1C0
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 17:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4514C433C8;
	Thu, 10 Aug 2023 17:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691689333;
	bh=Kb5aaFpzQN9oVjA6jAch1Ze7xXj2uPE8xEabWrDEROY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IHWo5eKb4A5lJxVViPx3IymLLaOfyS5RjJ0zYHTfkFNhiz7vCzu/H/UNzOSRf8t/I
	 TkIwaSBH8eVlE+PMWlY/uakyqGE1DvRsqQN/jsk8G1eF+ihFcHDRt5elv9N30o76ve
	 o2hx0gxiSAXT6m20M7VzjOMFVCZWsNP98EuBjpR4wi8+eeMGPIetUgB2+qz0MHwq/+
	 UQsZDsAF8actX/qcnBkwNDopgVRtR9oUB+evUyzTPxpXaFT7rE47hnuQ4igEqgN8Nn
	 sQVqbfW7GQWcori/EdkDrwJbHL5mC8Eg8yToi4SbCI8vM3JGwm3R+ZOBTnZ7RFGhTF
	 Wy+zIy2kZYu0A==
Date: Thu, 10 Aug 2023 19:42:08 +0200
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>,
	Frantisek Krenzelok <fkrenzel@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Apoorv Kothari <apoorvko@amazon.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH net-next v3 1/6] tls: remove tls_context argument from
 tls_set_sw_offload
Message-ID: <ZNUhcNAX8ENOUOwY@vergenet.net>
References: <cover.1691584074.git.sd@queasysnail.net>
 <49bb1e97ace3d18c7b57b2ae6a5011643d351f0a.1691584074.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49bb1e97ace3d18c7b57b2ae6a5011643d351f0a.1691584074.git.sd@queasysnail.net>

On Wed, Aug 09, 2023 at 02:58:50PM +0200, Sabrina Dubroca wrote:
> It's not really needed since we end up refetching it as tls_ctx. We
> can also remove the NULL check, since we have already dereferenced ctx
> in do_tls_setsockopt_conf.
> 
> v2: reverse xmas tree
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


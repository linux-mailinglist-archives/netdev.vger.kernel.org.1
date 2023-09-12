Return-Path: <netdev+bounces-33284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B5B79D4BB
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 17:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92EDF1C20DE3
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 15:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5734F18C0E;
	Tue, 12 Sep 2023 15:24:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF20A31
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 15:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844C8C433B6;
	Tue, 12 Sep 2023 15:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694532273;
	bh=bnpZMEb8ISRduLgq8852O5UPYlyL34vHsYHSSG0B1Cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kY6a9kDv7XOhCebA5SqE9LUpt84RjGB+3DMB8ILXVxc90Ts/z/h3EqOB4M1CvMVmI
	 AKo0N4nbvfxG5yYSEFEFyPtJzO7pcplr+nC86lAqm+xxqy5cGDId9iRdaJvbjAHKP9
	 2dzGKThpMelG5p5yrDSIb34vn4e2zNtngGc4Tlqlb+kd+nMZESrDzlQSoXE8kpMDMS
	 dos4Vqzg81YWg2hMAhxN+DBtNiYvFX5y3bWMvmOMni6CBo0LY7tMV0inxwfboMkrw6
	 s0QiWHHEEQb1vx980o4mRJG8rlkOzuKMM7pb2zEQYgMxXtT0jq4HZqXHH+LmZyU5k+
	 dGjtO3tUpr0FQ==
Date: Tue, 12 Sep 2023 17:24:28 +0200
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Cai Huoqing <cai.huoqing@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: hinic: Use devm_kasprintf()
Message-ID: <20230912152428.GK401982@kernel.org>
References: <198375f3b77b4a6bae4fdaefff7630414c0c89fe.1694461804.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <198375f3b77b4a6bae4fdaefff7630414c0c89fe.1694461804.git.christophe.jaillet@wanadoo.fr>

On Mon, Sep 11, 2023 at 09:50:52PM +0200, Christophe JAILLET wrote:
> Use devm_kasprintf() instead of hand writing it.
> This is less verbose and less error prone.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Simon Horman <horms@kernel.org>



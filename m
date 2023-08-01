Return-Path: <netdev+bounces-23107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B06AB76AD72
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E8A1C2086B
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 09:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8091F95E;
	Tue,  1 Aug 2023 09:29:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15906AAD
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 09:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C59C433C7;
	Tue,  1 Aug 2023 09:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690882165;
	bh=kG7SZXNiyzexHlcARYSO8y3yfKIQTqbHV/gn8ppwj7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qp1vf7zbWCj83RAWtH4zS6s5sN7zmoIO1oVXN/wXUdICldHhd+o/PzI0CwttdB09b
	 6iuS57v6Uc1frELDjlWj/XRDZjNl+RpDh/Zv3ITCidaAY37rMgqy8dnm/5v675KirV
	 t7Q7eMKwCg5NQdl4cww4n8izCutfzX9sInFZed/h+rmiAHjwZVIEBc8l55OOyxxyaf
	 RourzjLYRlvCcBhbN5OUJJhLAJYhFVkTvMT1ZR6yDpQSGKWjqPEm0OhYVpupj0E6NX
	 gjm6dxZ6vzNPfgLF8zDDXBueY+wmwgSwwYa/R53NBkyHFeqHWrn6as907XM2PhbaWb
	 9tyLHq/4Ss5Mw==
Date: Tue, 1 Aug 2023 11:29:21 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] sctp: Remove unused function declarations
Message-ID: <ZMjQceSII+1AukF1@kernel.org>
References: <20230731141030.32772-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731141030.32772-1-yuehaibing@huawei.com>

On Mon, Jul 31, 2023 at 10:10:30PM +0800, Yue Haibing wrote:
> These declarations are never implemented since beginning of git history.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>



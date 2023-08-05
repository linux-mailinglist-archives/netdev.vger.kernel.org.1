Return-Path: <netdev+bounces-24664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EE4770F78
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 13:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE93282206
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 11:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79906AD27;
	Sat,  5 Aug 2023 11:38:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863BFBA29
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 11:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D5FC433C8;
	Sat,  5 Aug 2023 11:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691235538;
	bh=mdOfSg+8MIlWNZ0pYho1Dmcclp6xmx0lcb9XKLXwNB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yp7D9UoBfYemc+BSVqEWfDkZ2gXVpPYRl3YbCM3VNojywQuY+bSjWw7c+J8LJEPWW
	 PN27KjjO4sPtohM5SMOwe+EPvj1equfr/+G8yHir8u1aXXOAUVSMDB4XuwLuTjAwEv
	 +W3dAsND+CSb8zUZdbgxHFiE1kAdzlm+uFKLNMYRWml4RTl01pWKiD50xZozCJ4FiU
	 wJrnji7Lpkyi8Vn5HctwhArpShSX819N16cuwU5maJHoDan+6gT7/VCG1AU6Fg6rc6
	 GtGKcDqnC8/XJb8VeAw3StKgHVZJlbQouud0vTpppG3H8nnNQRALxa4k8s6sGcrxot
	 FyVYOcsDw8Lag==
Date: Sat, 5 Aug 2023 13:38:54 +0200
From: Simon Horman <horms@kernel.org>
To: Li Zetao <lizetao1@huawei.com>
Cc: ioana.ciornei@nxp.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: Remove redundant initialization owner
Message-ID: <ZM40zhGh0Fh4LpUI@vergenet.net>
References: <20230804095946.99956-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804095946.99956-1-lizetao1@huawei.com>

On Fri, Aug 04, 2023 at 05:59:44PM +0800, Li Zetao wrote:
> This patch set removes redundant initialization owner when register a
> fsl_mc_driver driver

Reviewed-by: Simon Horman <horms@kernel.org>



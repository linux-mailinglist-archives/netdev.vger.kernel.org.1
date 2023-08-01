Return-Path: <netdev+bounces-23125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793B676B054
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 12:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345B82817EE
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 10:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DD8200DD;
	Tue,  1 Aug 2023 10:06:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A121F94D
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 10:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D42C433C8;
	Tue,  1 Aug 2023 10:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690884371;
	bh=q4WMkjTaZT940k8v/3UokpHQEL5OOBvQGiMemA8FEks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=srFyPeIpWbFw81W51LGBRhTrfwfFVdrDW4ErDSObjj1u3MwvKP/aRucJQKqz9i/3z
	 EoxUyyHIPf8rfbkDlZetklatXWufSIKR2VfnmJrBA7ZZV6SA57oi0hPeuMjzq6+T3S
	 LCsM0HqxqCnWW04EtzEULH+xuc3W6LNP6T79g+Ak7UStuvxlP/VdCso5PUu9xoFA/V
	 +4R/h1B0+o+LGv5l8gIZw1O5Xu58IIpVTJrHWcJVG6iZHPNtO/z2+TNtJc7PTutVQ5
	 o/o1fQSQTATnf+82xNWNU9oICKBHVyIOc6JkL1lJhKxuN0GVrpJRa1TZ+tBRRQaBNv
	 YLsWn7tNktHag==
Date: Tue, 1 Aug 2023 12:06:07 +0200
From: Simon Horman <horms@kernel.org>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: madalin.bucur@nxp.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, sean.anderson@seco.com, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH net-next] net: Remove duplicated include in mac.c
Message-ID: <ZMjZD9Ce5dSTI5Et@kernel.org>
References: <20230801005041.74111-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801005041.74111-1-yang.lee@linux.alibaba.com>

On Tue, Aug 01, 2023 at 08:50:41AM +0800, Yang Li wrote:
> ./drivers/net/ethernet/freescale/fman/mac.c: linux/of_platform.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6039
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Looking at git history, I think that a slightly better prefix would be
'net: fman: '.

	Subject: [PATCH net-next] net: fman: ...

But other than that, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


Return-Path: <netdev+bounces-30627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024D878844C
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 12:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956BA2817C6
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 10:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476F5C8F3;
	Fri, 25 Aug 2023 10:11:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C04C2EB
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 10:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5ADC433C8;
	Fri, 25 Aug 2023 10:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692958260;
	bh=YmW35iV9RR6C5qLFh0XMh3A2cKMtU422JhbQaQsDM8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MTpbnqDk888dmnCbR+qIx5JUar6rwhfF59vaybYlzxM6Q7VOxo0j/lYQpjRZvr3JG
	 c+2TFzUeZZxfngfVdUNAZcLhw59SmDw/mskR3dPuqDu4OutOdMAQAZAAmhPRSgKafH
	 OdP/iQNuG0HTOMssXDeP+YQ9whJkAMfjJOKOlvhWdlloQ6zZ6c6dlCv3oWIiKJ2cFO
	 YYepKXKnRGR9n3dUtKxZv50A8m1PJpggpMqh9MQV9siTyR7G0kysrcif6qtgf9Wca8
	 J8aofXCmqaZPYdmK7szIWdfww8JP7Xrn20HihIrN1mZgNVTLYoBOmCpIv2SOZ+TBY1
	 Rg6J/9Lg8jeoQ==
Date: Fri, 25 Aug 2023 12:10:53 +0200
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net PATCH V4 0/3] Fix PFC related issues
Message-ID: <20230825100638.GL3523530@kernel.org>
References: <20230824081032.436432-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824081032.436432-1-sumang@marvell.com>

On Thu, Aug 24, 2023 at 01:40:29PM +0530, Suman Ghosh wrote:
> This patchset fixes multiple PFC related issues related to Octeon.
> 
> Patch #1: octeontx2-pf: Fix PFC TX scheduler free
> 
> Patch #2: octeontx2-af: CN10KB: fix PFC configuration
> 
> Patch #3: octeonxt2-pf: Fix backpressure config for multiple PFC
> priorities to work simultaneously
> 
> Hariprasad Kelam (1):
>   octeontx2-af: CN10KB: fix PFC configuration
> 
> Suman Ghosh (2):
>   octeontx2-pf: Fix PFC TX scheduler free
>   cteonxt2-pf: Fix backpressure config for multiple PFC priorities to
>     work simultaneously

For series,

Reviewed-by: Simon Horman <horms@kernel.org>



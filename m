Return-Path: <netdev+bounces-24420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C341677022D
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 15:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1502826F6
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 13:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915F8C14A;
	Fri,  4 Aug 2023 13:48:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFCEC2DB
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 13:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3827CC433C7;
	Fri,  4 Aug 2023 13:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691156882;
	bh=M3AVbzofjePunM1DJ7jUjc6Jb+HBc0C43cmjoAAht64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=og8ScSaRJ7ah3csLRIwxK6DDDeJSwU5/mFi3z9XBdxDr5V7yHSJNswUJrrVIG4GWg
	 zRRLZ7NqW0YTI4kX/jwoJN+g1Jrh6YQiae1gHZbA0btZ+2c9NzAoT+pl6U5rzk2hMs
	 /bKcCcIzcQ/poM0xXvlK25y/lIrEHgldy332svvNYgEP1fHoidhlKH+SGksC5no2Gi
	 YJ2EghEpJnD9YI8gcRLSC0vpJAcdpqMSo3+l+FCq2992okRfRWGbkCyaT6rbiteZvx
	 ZPQdkh77HID2E4LrbMqXQVzdf3rwJiexwkRViYnb6MDQe2wGpObheb6MLPXPegQmY0
	 c59R7l3pbEvwA==
Date: Fri, 4 Aug 2023 15:47:57 +0200
From: Simon Horman <horms@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, alexanderduyck@fb.com
Subject: Re: [PATCH net-next 0/2] net: renesas: rswitch: Add speed change
 support
Message-ID: <ZM0BjaVJ6D+tAXOj@kernel.org>
References: <20230803120621.1471440-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803120621.1471440-1-yoshihiro.shimoda.uh@renesas.com>

+ Alexander Duyck

On Thu, Aug 03, 2023 at 09:06:19PM +0900, Yoshihiro Shimoda wrote:
> Add speed change support at runtime for the latest SoC version.
> Also, add ethtool .[gs]et_link_ksettings.
> 
> Yoshihiro Shimoda (2):
>   net: renesas: rswitch: Add runtime speed change support
>   net: renesas: rswitch: Add .[gs]et_link_ksettings support

Thanks Shimoda-san,

this looks good to me.

For the series,

Reviewed-by: Simon Horman <horms@kernel.org>




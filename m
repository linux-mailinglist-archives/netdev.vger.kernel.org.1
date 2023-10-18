Return-Path: <netdev+bounces-42202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6BC7CDA48
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 13:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9AF281B69
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 11:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D2C1DA4A;
	Wed, 18 Oct 2023 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6yl07hG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662DC16427
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 11:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB87C433C7;
	Wed, 18 Oct 2023 11:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697628425;
	bh=VPd3dNhUEmZFXtITkpQzFS1TASvG6VdmVTe37B/we34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l6yl07hGFV6tcoLemF7fp6G/GxLXkdJabzIWoKIHCQcvrZypQtSLhp6Pokuu6fHJE
	 FTIl0ZnZPVivdgJNOYFdcpAeMaSdruX4fLSXX9n9akVg4lkjfJyE6BSUQD0Nl+K+wN
	 pJCQB1Er98jfNLP5p7dTsAvgT1nLV1yE7HKh+YUlvo2ss7kO9h8F6AUdM+D9D1gvQs
	 eu8fqjEDNkr072XRgFtOxnb3qCXtOGXIbVdw1hKqSCIErxFjm11OL6Cwvrp6jRlHti
	 xEAzm/NoqbNxCKUUQHZ6A/2uJwaL+MhrjeIiEBlQ7UtZ30MLUVyrmlHj2Vte3spfgf
	 1PrelXFzCl6cw==
Date: Wed, 18 Oct 2023 13:26:58 +0200
From: Simon Horman <horms@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] rswitch: Use unsigned int for port
 related array index
Message-ID: <20231018112658.GK1940501@kernel.org>
References: <20231017113402.849735-1-yoshihiro.shimoda.uh@renesas.com>
 <20231017113402.849735-2-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017113402.849735-2-yoshihiro.shimoda.uh@renesas.com>

On Tue, Oct 17, 2023 at 08:34:01PM +0900, Yoshihiro Shimoda wrote:
> Array index should not be negative, so modify the condition of
> rswitch_for_each_enabled_port_continue_reverse() macro, and then
> use unsigned int instead.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Simon Horman <horms@kernel.org>



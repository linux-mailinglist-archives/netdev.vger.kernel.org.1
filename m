Return-Path: <netdev+bounces-52865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FB08007CD
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 10:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFEAD2817CC
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 09:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F9A1F934;
	Fri,  1 Dec 2023 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POVNK/b8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F280D1C6A9
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 09:58:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0CBC433C9;
	Fri,  1 Dec 2023 09:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701424734;
	bh=MyorjKQYbtVSpbBJboZrJOBowqJDICf5+G93U5kPraI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=POVNK/b8fBIwpTZKLT1FLBnnQTMvkV3Or4wWeZmfpB9NTZNZju7zAy6/NhB1b8AN3
	 WEJAp6lHgj1VFZbe+MptFZHuQpmGC94byOaNr27CwRWhV2IbxOsdjQNOXJIzDeLqZN
	 epNLsucZxb12CUzwI5a+G7gZAJdVf8HZ1PjlmgAiaQA82/VAncBYjl/tID9Fzh/XiE
	 Zgg0jwIpEh2MG97PXRMVLC8kjoXIA524beqMX1sUINGYzDGD8Jsc+A87UVLKIKhOu7
	 JrjCw7mAw1JPT1Kfi/Fe1nHhzzc7QeHYik+wLZpUIkzSBWVdfDcp6XGnhA+MGRkHuW
	 aoKQmkXQhpKVw==
Date: Fri, 1 Dec 2023 09:58:48 +0000
From: Simon Horman <horms@kernel.org>
To: Jan Glaza <jan.glaza@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Andrii Staikov <andrii.staikov@intel.com>,
	Sachin Bahadur <sachin.bahadur@intel.com>
Subject: Re: [PATCH iwl-next] ice: ice_base.c: Add const modifier to params
 and vars
Message-ID: <20231201095848.GT32077@kernel.org>
References: <20231129073611.8816-1-jan.glaza@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129073611.8816-1-jan.glaza@intel.com>

On Wed, Nov 29, 2023 at 02:36:11AM -0500, Jan Glaza wrote:
> Add const modifier to function parameters and variables where appropriate
> in ice_base.c and corresponding declarations in ice_base.h.
> 
> The reason for starting the change is that read-only pointers should be
> marked as const when possible to allow for smoother and more optimal code
> generation and optimization as well as allowing the compiler to warn the
> developer about potentially unwanted modifications, while not carrying
> noticable negative impact.

Hi Jan,

it's probably not worth respinning for this, but: noticeable

> 
> Reviewed-by: Andrii Staikov <andrii.staikov@intel.com>
> Reviewed-by: Sachin Bahadur <sachin.bahadur@intel.com>
> Signed-off-by: Jan Glaza <jan.glaza@intel.com>
> ---
> This change is done in one file to get comment feedback and, if positive,
> will be rolled out across the entire ice driver code.

The nit above notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


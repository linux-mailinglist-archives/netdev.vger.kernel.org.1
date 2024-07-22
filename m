Return-Path: <netdev+bounces-112441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB21C939160
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 17:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286EB1C2148F
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 15:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA8E16DEC9;
	Mon, 22 Jul 2024 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ctkw50sv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F1116DEB4
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660760; cv=none; b=ZOMOZpEHJa7v4F8bee5VMQqF6jfLDyCEFnAHC4SKKUKwPUsJvCdgBpvEgN+BO+HWhVZ/fukjY7ovh85NEpe++tfAtpy79YvnjJn0HI/xPl/189mznoRb75WA+EdC8pdooItqnEIB8MP0URlzuBDlQHEuh+GsGjxdkpV9Wv7gfRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660760; c=relaxed/simple;
	bh=TK0al/uMs3CK1iORM5isxOj7FXQB4yZNGw7sDKCCumc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCL9O3rN6r9buRqdfqgtpEi+1QDu18KmT4rmK8xMJmoEYBQfwnuR5IrpeHmvUdS3nF3Z0S2dla06LNmKIv3XF4sfAh26L9RQ/7ygGUYF7Het8lPGP+94zksl9LU8Q5QdG4KSpObjD2kzEkWb/166y4GIJqx0RGvV2yurfcbdgf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ctkw50sv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A2EC116B1;
	Mon, 22 Jul 2024 15:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721660760;
	bh=TK0al/uMs3CK1iORM5isxOj7FXQB4yZNGw7sDKCCumc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ctkw50svmiBxfrO11lusc6eUku33OYFvtxyeSuGg4faCPC5wDa207G/XpSUjfGxcL
	 hkzcmPc+j0fTtLwiLXKJ31SpOVqBADgJ2JKbrPfclZbBqQHxz+cWoV8aII1oDFLO6W
	 dq0OamqGYmEv+H/RwBrd65gcpS8BKNq2UvGquBBGf5+wYqL9nb2Vhy5Lk8XDBKQmyP
	 /sbwPq8erJCLRkizeTzsGDlRYHlcme0ZNhxwe3T9sxleCqZDU+6IEQqaej+6D/dV7n
	 82Ehkzowe3NdV0ztKqKB//szWEKTv7u/Oebt64dpO2I/EtmxX6Rm1W1n/RoncgKHe4
	 lD5E9W4MI9kKg==
Date: Mon, 22 Jul 2024 16:05:56 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH iwl-next v3 01/13] ice: add parser create and destroy
 skeleton
Message-ID: <20240722150556.GM715661@kernel.org>
References: <20240710204015.124233-1-ahmed.zaki@intel.com>
 <20240710204015.124233-2-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710204015.124233-2-ahmed.zaki@intel.com>

On Wed, Jul 10, 2024 at 02:40:03PM -0600, Ahmed Zaki wrote:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> Add new parser module which can parse a packet in binary and generate
> information like ptype, protocol/offset pairs and flags which can be later
> used to feed the FXP profile creation directly.
> 
> Add skeleton of the create and destroy APIs:
> ice_parser_create()
> ice_parser_destroy()
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>



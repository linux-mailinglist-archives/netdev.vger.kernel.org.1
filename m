Return-Path: <netdev+bounces-167485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49424A3A7B6
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 20:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E75CE7A2359
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF3021B9FF;
	Tue, 18 Feb 2025 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaWsIK75"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE6721B9C7
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907385; cv=none; b=tOUjrYUUGfpcIc3pJOEYANTZC3XO1UyPm4DCRKMJfQStyXqC3zJ03Vv5bR/m5TlVgD2jBkU+zHD2f4+dGKYOKaei6bpmn/GyN3G3P7n8J7kzAw/Uy2OaZ3TiKJ522NW1Dto8Zkrc/pb6ZCaQ/cJJdUwvGWNqpOeHNOPujx7x37o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907385; c=relaxed/simple;
	bh=rpy08+i5Ju1eRhG0DTlZGfECB5S6Bc7ltgjn/tyYVMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Go6ZU9Ggu35zbxOatptcWV2E/zS+OsoVpyZ2x+6rUNt1aKrb0ll+hpsGjC7M8iXySKfTBShsS3HA62xwAJAadsQkLv+6oBHoif9+MEC/CfEa+ylEI3AoSUy9sh6ptGV2bDdU3+0lzjnaY05KUI0r289fQjVfQzsF4d2c1v8Cqvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaWsIK75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B48C4CEE2;
	Tue, 18 Feb 2025 19:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739907384;
	bh=rpy08+i5Ju1eRhG0DTlZGfECB5S6Bc7ltgjn/tyYVMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UaWsIK75PFWjaD9KDhCtqrBISkbXro9ej/bGiBell1nUKupW3KjmUnIEw0PDcsUA2
	 OEcA8ObMU6DF17z9ZX7ZNPriEqSZ7x5REkzqYLbzsKEINflF/0X456aU5dByt9v7hc
	 j7+cb5DzbC41gE9Xlpab5MzNmiUSMdblAdzA0wgEiaMY9mha61Y3vD/u7PnQoDREM5
	 eiOZziJtbGQJCBg38+l/I7vNblTblFBjXIUGSBz96oIyRF0aYM24zkQjfudMaeBbn9
	 R+1dBPv4ZuYfeoZ800SnVXLHz6EswA1VQQQqc/6JKN4w2WN9zdaiTFDmH5N58xLuR9
	 er2BA+Ey6SncQ==
Date: Tue, 18 Feb 2025 19:36:19 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	marcin.szycik@linux.intel.com, jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com, piotr.kwapulinski@intel.com,
	anthony.l.nguyen@intel.com, dawid.osuchowski@intel.com,
	pmenzel@molgen.mpg.de
Subject: Re: [iwl-next v3 1/4] ixgbe: add MDD support
Message-ID: <20250218193619.GH1615191@kernel.org>
References: <20250217090636.25113-1-michal.swiatkowski@linux.intel.com>
 <20250217090636.25113-2-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217090636.25113-2-michal.swiatkowski@linux.intel.com>

On Mon, Feb 17, 2025 at 10:06:33AM +0100, Michal Swiatkowski wrote:
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Add malicious driver detection to ixgbe driver. The supported devices
> are E610 and X550.
> 
> Handling MDD events is enabled while VFs are created and turned off
> when they are disabled. here is no runtime command to enable or
> disable MDD independently.
> 
> MDD event is logged when malicious VF driver is detected. For example VF
> can try to send incorrect Tx descriptor (TSO on, but length field not
> correct). It can be reproduced by manipulating the driver, or using DPDK
> driver with incorrect descriptor values.
> 
> Example log:
> "Malicious event on VF 0 tx:128 rx:128"
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>



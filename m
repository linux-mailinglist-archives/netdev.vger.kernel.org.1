Return-Path: <netdev+bounces-128758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 575EE97B854
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 09:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8E21F22CFC
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 07:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5951547D4;
	Wed, 18 Sep 2024 07:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjPfdOO6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372BD14B94A;
	Wed, 18 Sep 2024 07:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726643215; cv=none; b=YZR3loM7FRBKdkZ8dI8ZXrIYQu9hXnJl05tOe/5IelJwXckcFNUgqkGAyJlkFl8sWInxAp3jtMWuGgIa7w1B8c6QNkDGKKYc3M3nacs8WvmSt3qWJ08rLGnpEZKCvQQ1HTtYY7CNOQCEtMXTP4bmVyGzEJJtt1ugN3U7egKYJq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726643215; c=relaxed/simple;
	bh=JHFisloYJ8iNozFHBXze6I2YOCTCLbb8vU2LUj9xLzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIDx/RjJfDZe1vb3HGyQ5BtU6SFViOWI+fOBjTAHhjJXcpOkOgtcJwlXdSirUTHy2lNprAAJz884kIDRpAaMrykZ3GyhDeNjd9appv4GEnv1VxB1IzPkltyl+MewEV4K5Fu2RYb4YmuNPz7xicA2pL7vPdib+rnDMezYOwFmHlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjPfdOO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4FAC4CECE;
	Wed, 18 Sep 2024 07:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726643214;
	bh=JHFisloYJ8iNozFHBXze6I2YOCTCLbb8vU2LUj9xLzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YjPfdOO6zoXO5DtfASuViQvoPC6Jn+8HRSlyH/Ja2NsNA5j3c7kzMZ7Cgzc75/9Mk
	 2rUDnDJeMiAAb8SWvctJhsjVtHR6DVJB6LXE1vbRIe/q/xkhT9/sP2p8h15b8lLJbA
	 6GeRtVhUfX0XggY+yje0tmM6jc1H7NCCxWoyal9sgqQ9/5Zhk9+oA3H5CaEYvs7T9t
	 xFTUL9GlFJBEXawzaHut5UkoqGWOxvQGQHfE5ZeAnQbq0+Xxe+PIjrQ7HwNM53pAQY
	 u7PS2CEdhP/qbusMWyS9Bi8QpCFdL8Jj9omWc5PoNSqN42Np9slQJsFJRXZJaXfcVy
	 fuzboYA/oXy5w==
Date: Wed, 18 Sep 2024 08:06:49 +0100
From: Simon Horman <horms@kernel.org>
To: KhaiWenTan <khai.wen.tan@linux.intel.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Tan Khai Wen <khai.wen.tan@intel.com>
Subject: Re: [PATCH net v2 1/1] net: stmmac: Fix zero-division error when
 disabling tc cbs
Message-ID: <20240918070649.GR167971@kernel.org>
References: <20240918061422.1589662-1-khai.wen.tan@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918061422.1589662-1-khai.wen.tan@linux.intel.com>

On Wed, Sep 18, 2024 at 02:14:22PM +0800, KhaiWenTan wrote:
> The commit b8c43360f6e4 ("net: stmmac: No need to calculate speed divider
> when offload is disabled") allows the "port_transmit_rate_kbps" to be
> set to a value of 0, which is then passed to the "div_s64" function when
> tc-cbs is disabled. This leads to a zero-division error.
> 
> When tc-cbs is disabled, the idleslope, sendslope, and credit values the
> credit values are not required to be configured. Therefore, adding a return
> statement after setting the txQ mode to DCB when tc-cbs is disabled would
> prevent a zero-division error.
> 
> Fixes: b8c43360f6e4 ("net: stmmac: No need to calculate speed divider when offload is disabled")
> Cc: <stable@vger.kernel.org>
> Co-developed-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
> ---
> v2:
>   - reflected code for better understanding
> v1: https://patchwork.kernel.org/project/netdevbpf/patch/20240912015541.363600-1-khai.wen.tan@linux.intel.com/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


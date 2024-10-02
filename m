Return-Path: <netdev+bounces-131239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FC698D855
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F9D1F23960
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68EC1D0965;
	Wed,  2 Oct 2024 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3X0+eKl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7561D04B4;
	Wed,  2 Oct 2024 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877483; cv=none; b=VLngNCvkS+E7kbnClJjuG/CrUKSLkAYKvqfAJicEYCCjun1s31NBXy2pNOGbyksM04VA9hgKi1xchPKnG7LT3QmkOO8WANK/ZWEcK615eSTllqPJ7eiZQmXEwiM1xpNJev/bpMVxPV9xYLlARq1OYfwQpLjvQO73e3vOYVTUrGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877483; c=relaxed/simple;
	bh=mjanN9GeGC4nh8dJ7hZsfZmAW3eRQ//5yJPpCjN6w6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=psPAnJVSc+orh2qTbHHcV/UZSK8AuROWMzHaDn5h0JhMEqdY7GNbFSss9i1dK8sliYJnV2g9FeJT6z6HnvyY8dhlGvEa7xhuCPpa9acCFOe7+XbNkhx3yb78CJNiXYaLfhd+AgZ7YhW8Tlp1bpVbS3QJTsxiSmOJwK2tQGtghV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3X0+eKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC30CC4CEC2;
	Wed,  2 Oct 2024 13:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727877483;
	bh=mjanN9GeGC4nh8dJ7hZsfZmAW3eRQ//5yJPpCjN6w6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i3X0+eKlv6JkUVi2aOcUsN5GoimQJCi89BsLebI4cw4ECXwfJMPL5i6u22XQihBEF
	 qTlUnCjqiYYtEsbZ7CxHitGBV1ktdaw9vBmBQCYZnf//zlTCdoHjgh3T2lImH/lveM
	 Qd2nMK0dc88KjwDQTKbkv6ROUJORWtxGK1CmpCj96l7k2VwShFleze5U+CY6lrQVaj
	 yclegzCFl+Jk6yPKrS8xkuJSUchEkdUfQ+7TLtpKNaK0uVJNoIPEaRIdOveSj+zPx3
	 2+pdRa5SuaD7mcrLN/r3Xuo2kKRUv4t+qcyzSGfH+cbI9VdIsGGRtjMrSRT0lhLcZT
	 tAYzvEE4uXFxA==
Date: Wed, 2 Oct 2024 06:58:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v2] net: stmmac: dwmac4: Add ip payload error
 statistics
Message-ID: <20241002065801.595db51a@kernel.org>
In-Reply-To: <20240930110205.44278-1-minda.chen@starfivetech.com>
References: <20240930110205.44278-1-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 19:02:05 +0800 Minda Chen wrote:
> Add dwmac4 ip payload error statistics, and rename discripter bit macro

descriptor
        ^

> because latest version descriptor IPCE bit claims ip checksum error or
> l4 segment length error.

What is an L4 segment length error on Rx?
Seems to me that reusing ip_payload_err here will be confusing
-- 
pw-bot: cr


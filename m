Return-Path: <netdev+bounces-64088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFBF8310C6
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 02:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CAD286358
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 01:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA90185D;
	Thu, 18 Jan 2024 01:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8tbFDJO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AFE1844;
	Thu, 18 Jan 2024 01:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705540599; cv=none; b=YFZzgfZeBzCO+Q87YN7GcAgnNuV0c9q5ADBm/B7pT6ueVks1Z6oebUuu/Q6gCQB8QfScgAZJ9pi8Sc7nW7/M1luPRtyv3d5JPo/yzQolJkxR8QRwYHftLRtpWIE6b6elQ8oUj8ZQzHLheI87FGa2VVb8CymY3GE2tJFaPMOs7Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705540599; c=relaxed/simple;
	bh=g8zKDNiY5o4wiSCjxwfxoT8kfB92NmOAP1J+PsIjU8U=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=YAquS2xx2AZSfFehdiPPcov6wLgORnPjWm/Jq0DEYWOiDNjGW+RJAE2Yz/6mtw2avsnmeXEZnsvMuEz6LKduIjgeW4QIUoRS1iUxo4/0Gck0UXCsUZLtli5o/W9MKz/HBsttHuBYPC8wSyIqG94qLE7zXG7p1lDErFeNeviIDp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8tbFDJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0875C433C7;
	Thu, 18 Jan 2024 01:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705540599;
	bh=g8zKDNiY5o4wiSCjxwfxoT8kfB92NmOAP1J+PsIjU8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K8tbFDJOJUb+BXENbmbKG0l1IYfIrmJHvT6+u2sNi4s+VI9L5CYjwKxjp6pCi21PH
	 Ki3wiKgpAaOfBHic2MyN8iRq2wKCNyK79ygXBkKCcI0b68XQiG9u9sN2ek7KF8997D
	 4IQNizvp5Uq14cYoRPUOVvdbgi7eY1T7ph9Xu4LsAzoRPf5wsIY5GKUQ3N5efpm2Jf
	 wdJbdjil/8WAkT/Mnr9gkIfk7q0TGmhDfuLcCmpGGLJWLuHpW0+QT++tWAwJLVSoXw
	 D9Q4QM9r39S/bOBgJcDogo/BdAG7rO5QH7JtnZYN1dyPSeXICNGymggA97vZ1OgqVe
	 GPvcwBZyBFwxQ==
Date: Wed, 17 Jan 2024 17:16:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew@lunn.ch,
 dan.carpenter@linaro.org, grygorii.strashko@ti.com,
 jacob.e.keller@intel.com, robh@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, jan.kiszka@siemens.com
Subject: Re: [PATCH v2 0/8] Add support for ICSSG-based Ethernet on SR1.0
 devices
Message-ID: <20240117171634.60df7f9b@kernel.org>
In-Reply-To: <20240117161602.153233-1-diogo.ivo@siemens.com>
References: <20240117161602.153233-1-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jan 2024 16:14:54 +0000 Diogo Ivo wrote:
>   net: ti: icssg-config: add SR1.0-specific configuration bits

FWIW looks like this patch didn't make it to the list.


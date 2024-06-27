Return-Path: <netdev+bounces-107101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DBD919D27
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 04:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60A53B222C4
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 02:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D296AC0;
	Thu, 27 Jun 2024 02:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3ZAW++N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDDEC8E9;
	Thu, 27 Jun 2024 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719454216; cv=none; b=HSWK8Luxe9Da9EW5uUf8euBhTpcjiqI12NdT0RKTuyzS9wonHRtKfZ9Y6NLElkwzwVOv1/Iv+rDXMR67Gopn/kkqKCkv8n1JsroU4GDFKZj4LTIjDYYw6Z76+XPB1nJ1tx+EnvRl4JNbsPvedpNZrpUrxGJxUZNoJhM6Adkb15Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719454216; c=relaxed/simple;
	bh=tFtxfeMc7SGHIUR1bQ5pL1fVi3eC4jE/VtMxB0zlD1k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCwRM2/GyqUUX0Iv5x/D+QwW2aTBiY248L6mhXRoMNvMRVC33+1DNkIvR5Kx7z8BY4X7az/dE/9wY0nR4a6q3xLnWVw+8AXZUPTJh6mdFufuPVPDry+h+VkFfd+g8BdwqJtWSXUbQVKEiufc9r2pquacSDW7S+YPHKQJ7F3Z9og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3ZAW++N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1A4C116B1;
	Thu, 27 Jun 2024 02:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719454215;
	bh=tFtxfeMc7SGHIUR1bQ5pL1fVi3eC4jE/VtMxB0zlD1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K3ZAW++NToUpp3ANh2rii0rqvgF5xpVoMruoZqgyIQ73Bi3UC6Z8/oovT6Gl78M/W
	 eFNJ8Wv4+7ZZ2qoqHruVHXYCAjqkfc8MYQ/H/zr9hRUGDc54VA3MWd2qosR+gmHCxK
	 3WmbOKkp4LqkIQSyUAFgQqya9BJssqz73Om6fRyU5qez8LOG+oqXgwNsI354WFp6Pc
	 sFYsC9duJP8qEs4ohr26jRQkrQ+Ch2wHHWHFWhrO8w/TcY2U6jlR0gPsKcjfAZeHC3
	 0rsTa1nDOmftY5MX74uEb3iTINEaaDHStpimeYFTXjYdf9uN7TbZ3qH6Us8xaTshGQ
	 rRjbQuuaYf3NA==
Date: Wed, 26 Jun 2024 19:10:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jon Kohler <jon@nutanix.com>
Cc: Christian Benvenuti <benve@cisco.com>, Satish Kharat
 <satishkh@cisco.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] enic: add ethtool get_channel support
Message-ID: <20240626191014.25b9b352@kernel.org>
In-Reply-To: <20240626005339.649168-1-jon@nutanix.com>
References: <20240626005339.649168-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 17:53:38 -0700 Jon Kohler wrote:
> +		channels->combined_count = 1;

clang complains about the lack of break or fallthrough here,
as annoying and pointless of a warning as it is :(

drivers/net/ethernet/cisco/enic/enic_ethtool.c:627:2: note: insert 'break;' to avoid fall-through
  627 |         default:
      |         ^
      |         break; 

> +	default:
> +		break;
-- 
pw-bot: cr


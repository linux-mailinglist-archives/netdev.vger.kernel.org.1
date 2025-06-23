Return-Path: <netdev+bounces-200403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB6FAE4D5E
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 21:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58535189F152
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 19:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB9B29DB7F;
	Mon, 23 Jun 2025 19:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbIRG5bq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37DD1684A4;
	Mon, 23 Jun 2025 19:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750705918; cv=none; b=RD+hpH0FyhWZN7QpUVaOidJ5ICPu+Jz2qJWTf6Y1aEGnWvFCCPOR6FNAheUSGsLONrGUqdBLlPapgh1dxwootR2UIZ03DZ+QqoyM2t+15n0msTxImWUydelIJY/XM0M8l4Ngfz8Z4ldBHZ+Gq8wGYoajpW84rQnwehg6IveeOEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750705918; c=relaxed/simple;
	bh=wQpBfJtqfm7zo7Dh99r69MQT/s3LRy86Wfbs8ULYgu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q7Wtkim4gy9jyOZbTqY0olivH3TA1Yd1hvMJxU2xweAKI0ikr/hap0M4u40WLvhRTtqiPe4Il7NpHu9DW/0Jb2oa7+QWy9kwvEZ7uIPKd/waA/vUbHB8rSM0TiBfQ2Urq1krZgCgb8eG5sVjsYsHE5lDBor/jG5GgBMHIeZCwGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbIRG5bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E546CC4CEEA;
	Mon, 23 Jun 2025 19:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750705917;
	bh=wQpBfJtqfm7zo7Dh99r69MQT/s3LRy86Wfbs8ULYgu4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dbIRG5bqefCGDX25Fd6N2Gfq6cyERMtEo67jUaeeUVQEfD/vOKNJ9W+iVbkEFe41Z
	 t1VLomqdjKYdwolEsTt4xNOrl69EGgaucS0HpujQT9zZjceXmGhLnKQB5kBUUjx4fZ
	 qG+x/I48aRQ/8xX+CaEOLSr80CJHL22H/6sq3rhNQOBsfMfV5OKJ9TG7ProIubWOe7
	 sr6DMzVqdr8SzqFAAwumVjn1jKb8yGSYzSbb8uoojLSiYzjmZ47ZI66raQKgstNKbS
	 PZdLONi9R3oRiHFRoSwkEFSLlXR5snRmgBFhaGn4Pq6JzLoOqPlArkM999SDxvLkuH
	 uiq/NgOJsFmzA==
Message-ID: <9b99ac8d-4bb1-47ef-880c-90d351eeeb02@kernel.org>
Date: Mon, 23 Jun 2025 14:11:55 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 RESEND] clk: socfpga: agilex: add support for the Intel
 Agilex5
To: Matthew Gerlach <matthew.gerlach@altera.com>, mturquette@baylibre.com,
 sboyd@kernel.org, richardcochran@gmail.com, linux-clk@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
 Teh Wen Ping <wen.ping.teh@intel.com>
References: <20250623185320.7276-1-matthew.gerlach@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20250623185320.7276-1-matthew.gerlach@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/25 13:53, Matthew Gerlach wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Add support for Intel's SoCFPGA Agilex5 platform. The clock manager
> driver for the Agilex5 is very similar to the Agilex platform, so
> it is reusing most of the Agilex clock driver code.
> 
> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
> Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
> Changes in v5:
> - Remove incorrect usage of .index and continue with the old way
>    of using string names.
> - Add lore links to revision history.
> - Link to v4: https://lore.kernel.org/lkml/20250417145238.31657-1-matthew.gerlach@altera.com/T/#u
> 

You sent 3 versions of this in span of 3 hours! What's going on? are 
they all the same version?

Dinh



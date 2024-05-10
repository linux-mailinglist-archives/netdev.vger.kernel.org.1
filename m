Return-Path: <netdev+bounces-95281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A8E8C1CF7
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362CD1C21C90
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E804D148FE0;
	Fri, 10 May 2024 03:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcQTMgYO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C430913BAC8
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715311430; cv=none; b=I6+UeTxDVMTj5dnspSR5E69XP/mP/XhI+/4a/sF9uSLtbiMOeJ4izHo+dSfH0E3zPs6XXCG3oN4XDMz13ETiP9vI4ij10X8csj1l+xYrimHzcDVBQ1NINenm0URC4W+oaG/wMlm/boqjfhiIqRD8DKSfXFMPpPPpfytNvzCP74c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715311430; c=relaxed/simple;
	bh=vrrKEd8fwUu5I0itSui6G/hqVDBjeQ6xTZvXvaDOCOo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHxMKY5BELCCGqWiUDDhBh8yc23XLsAS/6CkingcJW2iZ22PoOY53sjxfou3A4jaU/tSCn2PKef+HOgiJ9Fc81eKKXb4m2Ol+EOSvbRlpidCSysWqGl2U4crSmEOz9ayKOabBEWUm9Xmx/mrbQGN0i7/7mhvveHSfqZEgH0WA4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcQTMgYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C28C116B1;
	Fri, 10 May 2024 03:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715311430;
	bh=vrrKEd8fwUu5I0itSui6G/hqVDBjeQ6xTZvXvaDOCOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rcQTMgYOkoPNdwi4WqlJfw9SpThMESBGCbStQYufQNNfZoYKDUdZwgYo1vWtoaQY4
	 GtgEdjyqtB1Xy6dKgpk3eUyhODT29aa0CdNRN+Qpd0cqFXR3cSDYcEBwsxHT7Jv+V3
	 PjkWvxjiGuNsUeYYFeeUURoZQhsS/N3oCP/Vad6daJ2DnkRk3lkSawcBEShPQe3vMd
	 UUP1lSWuqq3wxsCBojzHtrpvsnvM6AprguS1LtGe8Kl15767Uk97m7C6TfwiGCj4bk
	 Q5gSDSHPKUfnZgPkpVzKFJQ9HwBcd4NDQlmI1YX31fTTnw9zoQejb20lytBdNO65Et
	 G8fh9iiM2SgaA==
Date: Thu, 9 May 2024 20:23:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] ptp: ocp: adjust serial port symlink creation
Message-ID: <20240509202349.5cc20dd8@kernel.org>
In-Reply-To: <20240508132144.11560-1-vadim.fedorenko@linux.dev>
References: <20240508132144.11560-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 May 2024 13:21:44 +0000 Vadim Fedorenko wrote:
> +#include "../tty/serial/8250/8250.h"

Hm, is there no cleaner way to get the device structs?
Could you repost and CC the serial/8250 maintainers?
Greg can probably tell us how to do this..
-- 
pw-bot: cr


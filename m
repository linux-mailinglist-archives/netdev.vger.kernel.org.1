Return-Path: <netdev+bounces-163742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F591A2B755
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CCA9188951A
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36B31799F;
	Fri,  7 Feb 2025 00:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9opnII2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC16B652
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 00:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738888790; cv=none; b=I66zEFe13aaUpbImaAKyf4RH29ncTbFf5aKtoJkuSxFKO26cc4VTzCh7+DK7InNfI6rHmjV3of0PkwIPh2hzC91qyzjVdYBmZGGY4DjaqB1TLxdHj67Ymm+r9YVvqrTKd2Dci2WTvBLNEoxKXkAWmZbPPR8zDwSzAwWPDCwSnU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738888790; c=relaxed/simple;
	bh=huNkBQeJW5IRjnMzes6IdNxKMJXQ4wyfsH4ego2Q9oc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruhGxrKMnJz/OhAQ5ELuTdfZvqqn3kI0DjciufkuuGBPNmfC6HNkN09vFSrN0+2uRi1zc1M45kdKQ/REDmAQRZ8oEs28fjaTl/UES1UtTyjMqtuVwFuno9wRhP0iURMtqH0kS1O9eXU34gPE6Na0eej+D8XHJ1liLCLTvkR0y6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9opnII2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23355C4CEDD;
	Fri,  7 Feb 2025 00:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738888790;
	bh=huNkBQeJW5IRjnMzes6IdNxKMJXQ4wyfsH4ego2Q9oc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G9opnII2nPLreTQGOVQDobjE6NMOfMv7P27FX2WBzjb2Szs/g8ue/QXlmhztg6nI6
	 BzYBBy2x0v8PgNPDiFYUwpEVGpl+xwTUeYM/AJjaO44etdDprtNWDNi56Z+0WkzArG
	 4uSWL/9baUJ0n9823gWsaZAtAUDc1LxTrkv1TfR0yJuvNdSJ8WdC3pC1rDDAFvK5tq
	 C5VLIR+7b17+PEKesFLeaVvY5xklrPA7EH9oksDxOv69PZKAJ6+7CyVirmpR9SG2g9
	 //ntqv0AVEE8e3EzjFoyLN69gYB7vl9wv0dzG+eIMqXsucuu5qFn4S2BsfZa3/W+eL
	 vBT8WuXcxDHgQ==
Date: Thu, 6 Feb 2025 16:39:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: <netdev@vger.kernel.org>, <mkubecek@suse.cz>, <matt@traverse.com.au>,
 <daniel.zahka@gmail.com>, <amcohen@nvidia.com>,
 <nbu-mlxsw@exchange.nvidia.com>
Subject: Re: [PATCH ethtool-next v4 00/16] Add JSON output to --module-info
Message-ID: <20250206163949.370011ae@kernel.org>
In-Reply-To: <20250205155436.1276904-1-danieller@nvidia.com>
References: <20250205155436.1276904-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 17:54:20 +0200 Danielle Ratson wrote:
> Add JSON output for 'ethtool -m' / --module-info, following the
> guideline below:
> 
> 1. Fields with description, will have a separate description field.
> 2. Units will be documented in a separate module-info.json file.
> 3. ASCII fields will be presented as strings.
> 4. On/Off is rendered as true/false.
> 5. Yes/no is rendered as true/false.
> 6. Per-channel fields will be presented as array, when each element
>    represents a channel.
> 7. Fields that hold version, will be split to major and minor sub
>    fields.
> 
> This patchset suppose to extend [1] to cover all types of modules.
> 
> Patchset overview:
> Patches #1-#7: Preparations.
> Patches #8-#9: Add JSON output support for CMIS compliant modules.
> Patches #10-#11: Add JSON output support for SFF8636 modules.
> Patches #12-#14: Add JSON output support for SFF8079 and SFF8472 modules.
> Patch #15: Add a new schema JSON file for units documentation.
> Patches #16: Add '-j' support to ethtool

Acked-by: Jakub Kicinski <kuba@kernel.org>

Thanks a lot for doing this work!


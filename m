Return-Path: <netdev+bounces-139735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA149B3ED5
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 01:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5E4CB221FA
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ADC624;
	Tue, 29 Oct 2024 00:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrV0EHnS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6481D621
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 00:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730160409; cv=none; b=dP+P6nZJ9yvfglJa06xSWVx6lg7TG4/wGFApLk7ZolqLSXxPxC/StzThPAdrS/sGRT9nKT7hovpy9rNMPsHSpfUDvI1CGu7DdowI0OLAIhjMNFt1tAyJItlJ7CIwBJnZXT5grsv4aWSI/oS0Lr5Ko6KjzEjRj55IovYWzF6tboc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730160409; c=relaxed/simple;
	bh=whapr0AT47w17oHuLDGhDO4PwQbQXaDJ01PJ7w8zslA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qn0Qyo0dTSzqfiwEwTthyNmRKTKq+lTNwatR+Pc0549kbAIdIn8hN6zE0dG1KemfQFvO2IpkF9CJJGWXIi6vrG55p99c29yQZS8+vkKgdXF8bIcBrgnbrAP4btUOxRnH2+6G3dOvfuIBF/WYfNvV/0qAfAvN2CC+B4ByXCkN9xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrV0EHnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5EDC4CEC3;
	Tue, 29 Oct 2024 00:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730160408;
	bh=whapr0AT47w17oHuLDGhDO4PwQbQXaDJ01PJ7w8zslA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mrV0EHnSIYwLU5JyCeO1wQ6T7Saej3xWHwdYU8I02s1s5rtz/C6+Q8GE4mctfIfSd
	 aUwbSpFmJi4GwKH7ChycNmVboVp1ErB2HB01Fskfs8VjFOYjpDmBYsaJKFegleY2J1
	 fOYN0l7DI9JDJJroJvi9Vv1XU4foBJd6IXqw3vxwh8PWwCDafug4pThKnWBe518NmK
	 wIRnhjfs8rghRZWpgnaWioh856mu6kyGgytCuOr+NpaXYWTImwtGXjdutC6JtVae0q
	 Rxujhdhl9zXwDz6zva24VOIky4CKOCCCefvCFSHLbf8CLh9FFDCDHEI58NCAgZJlt5
	 iL4NA7oeOBeFg==
Date: Mon, 28 Oct 2024 17:06:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Joe
 Damato <jdamato@fastly.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: yaml gen NL families support in iproute2?
Message-ID: <20241028170647.65357d64@kernel.org>
In-Reply-To: <20241028164055.3059fad4@hermes.local>
References: <ce719001-3b87-4556-938d-17b4271e1530@redhat.com>
	<61184cdf-6afc-4b9b-a3d2-b5f8478e3cbb@kernel.org>
	<ZxbAdVsf5UxbZ6Jp@LQ3V64L9R2>
	<42743fe6-476a-4b88-b6f4-930d048472f9@redhat.com>
	<20241028135852.2f224820@kernel.org>
	<845f8156-e7f5-483f-9e07-439808bde7a2@kernel.org>
	<20241028151534.1ef5cbb5@kernel.org>
	<20241028164055.3059fad4@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 16:40:55 -0700 Stephen Hemminger wrote:
> > I can only find this thread now:
> > https://lore.kernel.org/all/20240302193607.36d7a015@kernel.org/
> > Could be a misunderstanding, but either way, documenting an existing
> > tool seems like strictly less work than recreating it from scratch.  
> 
> Is the toolset willing to maintain the backward compatibility guarantees
> that iproute2 has now? Bpf support was an example of how not to do it.

The specs are UAPI.

The Python and CLI tooling are a very thin layer of code basically
converting between JSON and netlink using the specs, so by virtue 
of specs being UAPI they should be fully backward compatible.

The C library is intended to be fully backward compatible, but right
now only supports static linking.


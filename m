Return-Path: <netdev+bounces-71581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5298F854093
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 01:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CAA928C193
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 00:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C9E63407;
	Tue, 13 Feb 2024 23:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="see6h/R4"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F076340C
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 23:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707868775; cv=none; b=Q8g8yUVDGvIAytds/O68U13yZ2bdTpFgLxlNXugJp6iSIpQicQ5EO+rEYQEwQ8ePYt1nH7xDTgZvtwIY1IPB+mqMPNW25XE3Pmu4P2jdi8z5yd8kFbLi01Lfmvhk6pFhNLP9IfQiy4o7RvN6otaSUenrFhICHgBVVW6/gwY/kJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707868775; c=relaxed/simple;
	bh=fIHnT72RmFnCRVtHzUu1cU53ELE9zjXta/gN1RCqbuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKAPiKtZBi7G4vWaI9JNX9FL18BEpjw+WJHns28Veek01ad/oVOsJRt7UYgwe0O8cRVKh+Jl2CovMfU7+eXajdFiPLUfxNkNl9ua1CJgdrWswqeqxneAHxvUCA8loohlg4yHd/5oGsy+mi8cdu/9QTffJ3G4Zk/zh+QSYkldgjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=see6h/R4; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <88f94f9b-450a-430a-bb1b-d7a9cc91ed23@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707868771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HE8wixMfvF9gR+MTIy9zbR8cItQUovLobuTz81UtOWw=;
	b=see6h/R4n9/SEkbXMtyHoEsPKwQPhyHKLdSDcA/8QUUUe5sfViX1jZqTdY/3syhgbCR38J
	OVRz2AUk2Zb0MVqI989x5gyWKKAFAO8DcZlCEno5KSJ65rGNlIOX23k7VZapggFHfH/xuH
	B8uczkNf1MTPAaqB9eq6wf5h3W1TJpU=
Date: Tue, 13 Feb 2024 15:59:22 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH iproute2 v7 2/3] ss: pretty-print BPF socket-local storage
Content-Language: en-US
To: Quentin Deslandes <qde@naccy.de>, netdev@vger.kernel.org
Cc: David Ahern <dsahern@gmail.com>, Martin KaFai Lau
 <martin.lau@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>,
 kernel-team@meta.com, Matthieu Baerts <matttbe@kernel.org>
References: <20240212154331.19460-1-qde@naccy.de>
 <20240212154331.19460-3-qde@naccy.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240212154331.19460-3-qde@naccy.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/12/24 7:43 AM, Quentin Deslandes wrote:
> ss is able to print the map ID(s) for which a given socket has BPF
> socket-local storage defined (using --bpf-maps or --bpf-map-id=). However,
> the actual content of the map remains hidden.
> 
> This change aims to pretty-print the socket-local storage content following
> the socket details, similar to what `bpftool map dump` would do. The exact
> output format is inspired by drgn, while the BTF data processing is similar
> to bpftool's.
> 
> ss will use libbpf's btf_dump__dump_type_data() to ease pretty-printing
> of binary data. This requires out_bpf_sk_storage_print_fn() as a print
> callback function used by btf_dump__dump_type_data(). vout() is also
> introduced, which is similar to out() but accepts a va_list as
> parameter.
> 
> ss' output remains unchanged unless --bpf-maps or --bpf-map-id= is used,
> in which case each socket containing BPF local storage will be followed by
> the content of the storage before the next socket's info is displayed.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>



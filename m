Return-Path: <netdev+bounces-188455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD42AACDF2
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 21:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C9A3BE7ED
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 19:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680C11EB182;
	Tue,  6 May 2025 19:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bGbRqFfD"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CFA146593
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746559190; cv=none; b=LqfTokWgiFQWaTp9NIF0LJuS6leKwue9WBOVNO9GhvPX1d+tyUKmnrelKpVd4T9+JamkACmkobdrAix0k1MrTRON42PrZtcyROFl7fjVOeKOn7YcB95uEAeDm3RXWEbaWYza+J3d9vbMwPxgZ12/pdO6M0S2hpRyAj3VkQNerDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746559190; c=relaxed/simple;
	bh=O4iUXLWrZXZck8vlO/L6Vrt4ipaBA7stezc8WKyzAHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQDF/LVlgtkcu5v2jN1Dk6/eYncTTYWAF4yzWvFkUDVfxosbYcMtmYiaW0mOjIQQUkjEjNAR/sZR+ZseyTl1W8VWwA2CsRA1/fJt9jCBJbeIVZDITXiqgdi9kdJJxBTrQkigPHTJQIJ2QGyo665BMoaO2rrhSa0h2XjIhIV8U9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bGbRqFfD; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bbe5b4db-0c32-4695-9f2b-ebc042c040cd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746559185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGGM4QzihND7W8iisc3MSKWoS/VAPC5ZZRQIJ+BalY8=;
	b=bGbRqFfDP/IV+uIomjlLc3wNt8hMA3cxt3tC//iH+nitmlI3MLOPKRTuK/N1LaK0yPrNT1
	1XhS7y1AOBaMyf7aMdzU4L95m+BlSh/Fw0XbnJYmntghVl0FgfQXULcmwHDTbXdVxb2vn0
	P4oxbIi5LkbHre48Y3mWpwUKcsBozf8=
Date: Tue, 6 May 2025 12:19:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 2/2] bpf: Clarify handling of mark and tstamp by
 redirect_peer
To: Paul Chaignon <paul.chaignon@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Network Development <netdev@vger.kernel.org>
References: <1728ead5e0fe45e7a6542c36bd4e3ca07a73b7d6.1746460653.git.paul.chaignon@gmail.com>
 <ccc86af26d43c5c0b776bcba2601b7479c0d46d0.1746460653.git.paul.chaignon@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <ccc86af26d43c5c0b776bcba2601b7479c0d46d0.1746460653.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/5/25 12:58 PM, Paul Chaignon wrote:
> When switching network namespaces with the bpf_redirect_peer helper, the
> skb->mark and skb->tstamp fields are not zeroed out like they can be on
> a typical netns switch. This patch clarifies that in the helper
> description.
> 
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>

Jakub, could you help to land them to the net tree? Thanks.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>



Return-Path: <netdev+bounces-240956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64028C7CC76
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 11:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 10CE8345109
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 10:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711E31494A8;
	Sat, 22 Nov 2025 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="ANiA5gZ+"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902A6CA5A
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763806697; cv=none; b=fB5h5hyycqgchqM4pjGif+/PmH8bzpa0tyvom4rMktM9HVTXqyQaXsIOhc9tMDjR6AHcaBuWLkZjUF15w7Dyev9qSdl7fcXNQdrKDxeL19WVxUxgsBRY727fkKtdbCR1x1j8Ciw52mObx1vgpy+BNL7B1lQT8Nio6M/mJibV5i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763806697; c=relaxed/simple;
	bh=/ie7fr7qfZOhjGcC4xEajrrkpWzhF5CAg/Lj58q3YMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TE72uGCRPhHoHli9fwhdlaHCDJQFvzt9rZ7kJjG9ViscQROj9kXg4LSVXcpN8ecOP/Qvwv5XoDY8ssnHS4BDFYY1m69K0Oz+RpzpyTijUkdV6L1ocOKrIMakuKQtsvitDpqRgpEFCE+axD+SPytu3ECKkwLc5dWNnaG8DDpEPc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=ANiA5gZ+; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id C18C7200BBBD;
	Sat, 22 Nov 2025 11:18:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be C18C7200BBBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1763806693;
	bh=3LlhpuaHGm5ihGh+wXm3jYgSMazoNXGqGu16QyCmZao=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ANiA5gZ+InTU1g3y3mqomIwZ0ffju3Sn0Q4k4ZJnn7TGF8k/2lKThMC6/ktmYXr+g
	 uV5irVg+36mqnfliz4YrFdw/jQ0EdxAikE1lhYw318WIxTlTttzRY9RnTg2ABgDTVf
	 fmWjHFkXdOz+R0U6o3Nw9vk/UF/gu7VJtDngIFJloc0yDQzEsDASnUzwpjpz+ctxUw
	 dWKdSKiMes2OUNZSDLvDKV7MP00YnijKl+Cn3L/KbCaRH54oHr3lhAH/DJIuVmmNG0
	 7Ats6JZlNOTFZhg9vEkFkjWcBAGds24NRdW/1VZgYxjVpxUkHkfy8RSfPnB9v/xsVS
	 mqDm1U+xKDaew==
Message-ID: <59f897f8-4358-418d-a6ed-d422bb6d7cb4@uliege.be>
Date: Sat, 22 Nov 2025 11:18:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] uapi: ioam6: adjust the maximum size of a schema
To: David Ahern <dsahern@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20251120163342.30312-1-justin.iurman@uliege.be>
 <69709e39-a6e2-4289-9202-f5776109f42e@uliege.be>
 <6d950048-4647-4e10-a4db-7c53d0cfabd9@kernel.org>
 <55c4c96e-c11f-49d7-8207-4f5179d380a7@uliege.be>
 <437c2cc9-37ce-40f1-91a2-cbfeb667da5c@kernel.org>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <437c2cc9-37ce-40f1-91a2-cbfeb667da5c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/25 20:18, David Ahern wrote:
> On 11/21/25 11:55 AM, Justin Iurman wrote:
>>
>> You're right, it might be too risky. Besides, the current code (i.e.,
>> IOAM6_MAX_SCHEMA_DATA_LEN=1020) doesn't break anything per se, it was
>> mainly for convenience. Do you think it would be OK to introduce a new
>> constant in the uapi, as suggested above? Or did your comment also apply
>> to that part?
> 
> You cannot break any existing implementation which means kernel side you
> have to allow the current DATA_LEN. Given that there is little point in
> trying to change it now. If the spec has a 240B limit, you could return
> a warning message telling users when they exceed it. UAPI wise I think
> we are stuck with what exists.

That's what I suspected and feared. Anyway, as I said, this change was 
purely for convenience, so no big deal. I think this is a good idea to 
return a warning to users, thanks! I'll submit that to net-next.


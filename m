Return-Path: <netdev+bounces-122164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3037896036F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 09:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D067A1F2291D
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 07:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A0F155C97;
	Tue, 27 Aug 2024 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="X0P/MEOT"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1865145B10
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744510; cv=none; b=hV4L0f+o7k4xIsCx5r+V8wKzHIP16u1QpE0Ghuqzn8AyBBKkO87x+87r/TOrPF1Z2bWGOJFVkyHqvUKc29McrL2qaly6KNeaep+57jTvSIPOuIuj5CREo1mvdSuE2u4ngqi9cCFAiqAHpe2GKZi3bGW0LQw2XcpEzSp9F21ZjLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744510; c=relaxed/simple;
	bh=8nLX8Gsn6K97MZA3oISwte7q22e1l7/nSWNRmTt/RU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLK4rT88mJYQq2bL3tJjY2F+pnpSUwhAxj4SzBTYI3nsNNmZLn1s2eHAyGue0vvUNl7dx/yBz1C8NDnxoq621yxyukNwPWksciRxdWT0vjlX7dO5t4JtXJIwQneF8jDQ8NdUX5QiaiGNonq1Aopdoqbqb5frjDaOcb/ddnwWk3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=X0P/MEOT; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id DE670200C963;
	Tue, 27 Aug 2024 09:41:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be DE670200C963
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1724744505;
	bh=iIdSjugLXzGVwC/ZFpXzUaad4AKc8GjSTU1gircKYug=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X0P/MEOTgPVf9Ke3ILAGMavkg0FfgGWPhgemihN5m/HmSfcV7MXYY/TM+XniDz74/
	 69s49PGbqeb+bG1LK/fvumtbnf3sj8Ty1uVfW6Qj7ZK7cxBq3X2YdhWDr9xkWOU5lI
	 brih56xpC52/cn/zwcpETtB/f6CYzQHz3ZtN7MPddfhe88+SpqpUxHijrcCXe8pkPn
	 Sb18YyPHRUemQof3PLaEsRktvXKHyJHR3gfpE6wX9hfXGxO2rKeCEhfZWJAIdoclKz
	 bsdn+QVRGec5i5isXZ6MzrFZFiS3V0x6SEROFZ2d36gTIH4IoAZIFUFOLI32Ybkqb/
	 Y98EL0SIW4Plg==
Message-ID: <e8420765-dec6-4802-8255-89f9f6965c59@uliege.be>
Date: Tue, 27 Aug 2024 09:41:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 1/2] ip: lwtunnel: tunsrc support
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org
References: <20240826135229.13220-1-justin.iurman@uliege.be>
 <20240826135229.13220-2-justin.iurman@uliege.be>
 <20240826085914.445c3510@hermes.local>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20240826085914.445c3510@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/24 17:59, Stephen Hemminger wrote:
> On Mon, 26 Aug 2024 15:52:28 +0200
> Justin Iurman <justin.iurman@uliege.be> wrote:
> 
>> -	if (mode != IOAM6_IPTUNNEL_MODE_INLINE)
>> +	if (mode != IOAM6_IPTUNNEL_MODE_INLINE) {
>> +		if (tb[IOAM6_IPTUNNEL_SRC]) {
>> +			print_string(PRINT_ANY, "tunsrc", "tunsrc %s ",
>> +				     rt_addr_n2a_rta(AF_INET6,
>> +						     tb[IOAM6_IPTUNNEL_SRC]));
>> +		}
>> +
>>   		print_string(PRINT_ANY, "tundst", "tundst %s ",
>>   			     rt_addr_n2a_rta(AF_INET6, tb[IOAM6_IPTUNNEL_DST]));
>> +	}
> 
> Looks good.
> These strings should be printed with
> 		print_color_string(PRINT_ANY, COLOR_INET6, ...
> 
> but that is not urgent. Just to follow convention.

Ack, thanks! I can submit -v3 now to include the change though. WDYT?


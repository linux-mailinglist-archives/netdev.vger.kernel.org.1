Return-Path: <netdev+bounces-118782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CBE952C52
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11286285D7D
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2191714D7;
	Thu, 15 Aug 2024 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="GjCwSBjM"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BF917BEA1
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723715275; cv=pass; b=PzYRZf0QoJw6MVDZLRLk17TL505CvIBqViNUyOxPQwCGTO5cjyOpScFeTfL80HgR2zpdQisiOFqepva+n1nVF91lPBjGeCwK3D28/QlTGMa07eiVwxXBHCW2f9SZpXHnynStyz8z4Sp9T9JJXQCj+uHPpVly+lFxh60sb6Kmytg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723715275; c=relaxed/simple;
	bh=sxTvxtnWxPR7Q+d977+scVbigRXzUut2FV1ILipA368=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVDzf577AXppJccaXaFkI+W8ns9U+qKsjF497/NbK9b84NxEIAgm7KkNmY6SK/tSGJpdqjZJCUUNzpDNsVSdqIoIbGxW0WlkMlV5gByQ+EdW7BXiC1hsR6gRFyt6CcVkmKr+bDypnM99vTKKRS2dMTuCCqZTlMjNDLUlzBiN//A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=GjCwSBjM; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1723715268; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SnYUZXRNxlkrXBCUvZfuhVA5KsAm24+fukXEOvirDdhaMRzAALRSL0ZN4EcnfEGcsyvc65QU31wzhkX1QFcfS0vKoXhvxW7k9Zw+k3TivDGnjxOMGBHJ5U6fQz6F1qNW2YrewZBotIm5aRCYpoI+QWOsACmO1ToqOrjgf4Rdmrc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723715268; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=356dEpTfEZHn3nJOBx2qdCZ0XzBTfnP1fQPjBMW+JtI=; 
	b=MrpWudRV7HyLLQ2I5oglFgoIvO7KB9VzvgSuk0eyrlM/rHXf5rkymoksJQynnf9FtygLV/O3Cu71Wfb5WPQejuzDpbDBGGZLRvVWoBOoBN/aEaV9th2eg2bcF8/E3xKpTo/zpq23pCyafIOvF03qd0Hyb1B9hM2sKKdSgtEMR3o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723715268;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=356dEpTfEZHn3nJOBx2qdCZ0XzBTfnP1fQPjBMW+JtI=;
	b=GjCwSBjMtNVjHRoHPOYqh8kFKrZbB84jWXVnOV7esKqaXWF3FrV/qfhtmWJ94070
	1FQtYfwiFUSGQf+RlsQM5LqxGITeR6+7WRCuEXnarlfsIT/SZwmOlq6zf0u8XwbOdow
	yILIDrq90TVWWuGpvYIklowWFO+Y3VL0gT8VRM97Bsm7ARLqOOOLXVeKSsOKymQHVcs
	Mv3m+/eWcyubysd78F5IU5tNXfjVpTvdqIphetQzUcSveuFrF39LBIFxn1hTL6qfONo
	riatY1dDYy494VxHRE3F3EDJ+d2CwLbvoTNAq45aAjcEZl+PlD7ZYvxJ91moKUSUpBh
	DAeWjpmFgw==
Received: by mx.zohomail.com with SMTPS id 1723715267493990.3269060617112;
	Thu, 15 Aug 2024 02:47:47 -0700 (PDT)
Message-ID: <fa372172-ef1c-4cbb-8126-7665d3e15251@machnikowski.net>
Date: Thu, 15 Aug 2024 11:47:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] ptp: Implement timex esterror support
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, jacob.e.keller@intel.com, vadfed@meta.com,
 darinzon@amazon.com, kuba@kernel.org
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <20240813125602.155827-2-maciek@machnikowski.net>
 <Zr2Cun2AhVLRAm1t@hoboy.vegasvil.org>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <Zr2Cun2AhVLRAm1t@hoboy.vegasvil.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 15/08/2024 06:23, Richard Cochran wrote:
> On Tue, Aug 13, 2024 at 12:56:00PM +0000, Maciek Machnikowski wrote:
>> The Timex structure returned by the clock_adjtime() POSIX API allows
>> the clock to return the estimated error. Implement getesterror
>> and setesterror functions in the ptp_clock_info to enable drivers
>> to interact with the hardware to get the error information.
> 
> So this can be implemented in the PTP class layer directly.  No need
> for driver callbacks.
Sorry - missed that one in the previous answer.

I can implement a generic support in case all the information are
exchanged locally, but the driver hooks are needed for a use case of
separate function owning the synchronization, or an autonomous sync
devices (Time Cards). Would a fallback if getesterror==NULL be enough?

Regards,
Maciek

>  
>> getesterror additionally implements returning hw_ts and sys_ts
>> to enable upper layers to estimate the maximum error of the clock
>> based on the last time of correction.
> 
> But where are the upper layers?
> 
>> This functionality is not
>> directly implemented in the clock_adjtime and will require
>> a separate interface in the future.
> 
> We don't add interfaces that have no users.
> 
> Thanks,
> Richard


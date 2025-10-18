Return-Path: <netdev+bounces-230664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BF4BEC98D
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 09:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59F85E6860
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 07:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4632E284B2E;
	Sat, 18 Oct 2025 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rf0OR0T+"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2956F9443
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760773405; cv=none; b=Qq0BrXfTx+0LGoG0YRBXedxU+MyOEMFPfxeTw91EL0cXA6aBcCWpfNu7s5nqnI12NpsiS+3994X1sZ4yUiA9+wcXd+VN3A7a2c8F+KvkInqOU3DbThWONuTZHXkp3184+xZ+Qpjic42mcEXcgatBisPeT9+md5VXfUt1a6jeK/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760773405; c=relaxed/simple;
	bh=F6o5xuD/rEaG0v6EJNW/4wJ09DXvQktJ9h7IiFVRojI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mW0vEP9gtSrv7Eg58FbY4qm8thtWeTgzLNUquaQna3S+RrPV5uorjalKdS7wkOmIsVSWRNvppeVqa8WzidcFGRqBXbdZPZAqrPxL0/Ku0nK3aar27l83jFiJjUU2NF0IUWYXZkkP3EAlPyEV7Jrn1nB4FkijmX5cdx8BlIXNhI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rf0OR0T+; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CE09BC09A07;
	Sat, 18 Oct 2025 07:43:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 20D6B6069D;
	Sat, 18 Oct 2025 07:43:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F3132102F2343;
	Sat, 18 Oct 2025 09:42:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760773399; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=BrMMsk9VBVt4yUp2jMiSJe8MPMPTFyVYedP9FgMnb7c=;
	b=Rf0OR0T+dhtzVXq5CsJLvyo9tJp01jc+xfMcYMVyaVUy1ovb41EuvzSdNJh3q8MwMYLLOg
	eRH6oNPSnc/lvTnpjLdcSYqrpAO+I/eulSqZ5TBSJosUm+bjArDm4Mqvfa9JsYFSNs+pOn
	WDZuotNyTSJV+ODF9R7bMIzK0NCJAN8xQvsL+DN3ZsDaTZebx0kpWuwIwqVy13ITQnjBvX
	P85z/GtqPJ3bw7jVNB0JKdHwWKerNHfBrN3AuduHhy4UocMx1H5pddfrOScVGCaEskhLmD
	WvLtSpoOdsIK3Zwz0lDnx+kDriDemgk08RCAQWo4AmjSlApxCsxWE0hzsoFuJw==
Message-ID: <d40cbc17-22fa-4829-8eb0-e9fd26fc54b1@bootlin.com>
Date: Sat, 18 Oct 2025 09:42:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: stmmac: Allow supporting coarse
 adjustment mode
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
 <20251015102725.1297985-3-maxime.chevallier@bootlin.com>
 <20251017182358.42f76387@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251017182358.42f76387@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub,

On 18/10/2025 03:23, Jakub Kicinski wrote:
> On Wed, 15 Oct 2025 12:27:22 +0200 Maxime Chevallier wrote:
>> The DWMAC1000 supports 2 timestamping configurations to configure how
>> frequency adjustments are made to the ptp_clock, as well as the reported
>> timestamp values.
>>
>> There was a previous attempt at upstreaming support for configuring this
>> mode by Olivier Dautricourt and Julien Beraud a few years back [1]
>>
>> In a nutshell, the timestamping can be either set in fine mode or in
>> coarse mode.
>>
>> In fine mode, which is the default, we use the overflow of an accumulator to
>> trigger frequency adjustments, but by doing so we lose precision on the
>> timetamps that are produced by the timestamping unit. The main drawback
>> is that the sub-second increment value, used to generate timestamps, can't be
>> set to lower than (2 / ptp_clock_freq).
>>
>> The "fine" qualification comes from the frequent frequency adjustments we are
>> able to do, which is perfect for a PTP follower usecase.
>>
>> In Coarse mode, we don't do frequency adjustments based on an
>> accumulator overflow. We can therefore have very fine subsecond
>> increment values, allowing for better timestamping precision. However
>> this mode works best when the ptp clock frequency is adjusted based on
>> an external signal, such as a PPS input produced by a GPS clock. This
>> mode is therefore perfect for a Grand-master usecase.
>>
>> We therefore attempt to map these 2 modes with the newly introduced
>> hwtimestamp qualifiers (precise and approx).
>>
>> Precise mode is mapped to stmmac fine mode, and is the expected default,
>> suitable for all cases and perfect for follower mode
>>
>> Approx mode is mapped to coarse mode, suitable for Grand-master.
> 
> I failed to understand what this device does and what the problem is :(
> 
> What is your ptp_clock_freq? Isn't it around 50MHz typically? 
> So 2 / ptp_freq is 40nsec (?), not too bad?

That's not too bad indeed, but it makes a difference when acting as
Grand Master, especially in this case because you don't need to
perform clock adjustments (it's sync'd through PPS in), so we might
as well take this opportunity to improve the TS.

> 
> My recollection of the idea behind that timestamping providers
> was that you can configure different filters for different providers.
> IOW that you'd be able to say:
>  - [precise] Rx stamp PTP packets 
>  -  [approx] Rx stamp all packets
> not that you'd configure precision of one piece of HW..

So far it looks like only one provider is enabled at a given time, my
understanding was that the qualifier would be used in case there
are multiple timestampers on the data path, to select the better one
(e.g. a PHY that supports TS, a MAC that supports TS, we use the 
best out of the two).

However I agree with your comments, that's exactly the kind of feedback
I was looking for. This work has been tried several times now each
time with a different uAPI path, I'm OK to consider that this is out
of the scope of the hwprov feature.

> If the HW really needs it, just lob a devlink param at it?

I'm totally OK with that. I'm not well versed into devlink, working mostly with
embedded devices with simple-ish NICs, most of them don't use devlink. Let me
give it a try then :)

Thanks for taking a look at this,

Maxime




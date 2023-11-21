Return-Path: <netdev+bounces-49820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3911C7F393C
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 23:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6669FB21A07
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 22:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C66D56476;
	Tue, 21 Nov 2023 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSP2u9Hk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34165645D
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 22:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21076C433C8;
	Tue, 21 Nov 2023 22:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700606167;
	bh=Ov06uefYFHyG5gwX8OkJtStrYJotBPFjp9TDBCxGkWI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=jSP2u9Hk2qvvGl6CUEvF1866knzE37BMWpgzWXWZR9zbHiKmkEe9MIhcp2lTxQbnr
	 ursEZuHOYqr6pRFs2JtZZrsb2jRSz4+ZNl8p16vkHsSHLqhVFYK+SoaupZ16nCbq7j
	 5GravrjxBZ8wclhlFOD+YPhMBvdeNTEf72hMPbH2fuYoWYtAr1oQ5FqeGz77CqhHV7
	 YUc8hJt4FXqLZJ/1p9P328Tz0oWQzH+JEy9eIeH/DOslIs9YSPBBx0lLXW5FwloxIM
	 z1IMSXHInFJ8vKBOFBQbajFOyGLFl01iQmGBJx6bQsS2b2539AuDLl0bn3Cdb8jdhA
	 3xXBqofXEAXsg==
Message-ID: <7afdc7d6-1382-48c0-844b-790dcb49fdc2@kernel.org>
Date: Tue, 21 Nov 2023 23:35:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 2/2] net: dsa: realtek: load switch variants on demand
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
 linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, arinc.unal@arinc9.com
References: <20231117235140.1178-1-luizluca@gmail.com>
 <20231117235140.1178-3-luizluca@gmail.com>
 <9460eced-5a3b-41c0-b821-e327f6bd06c9@kernel.org>
 <20231120134818.e2k673xsjec5scy5@skbuf>
 <b304af68-7ce1-49b5-ab62-5473970e618f@kernel.org>
 <CAJq09z5nOnwtL_rOsmReimt+76uRreDiOW_+9r==YJXF4+2tYg@mail.gmail.com>
 <95381a84-0fd0-4f57-88e4-1ed31d282eee@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <95381a84-0fd0-4f57-88e4-1ed31d282eee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/11/2023 23:15, Krzysztof Kozlowski wrote:
> How is this even related to the problem? Please respond with concise
> messages.
> 
>> the "XXXX" for modprobe. For DSA tags, module names are generated
>> according to a fixed rule based on the tag name. However, the switch
>> variants do not have a fixed relation between module name and switch
>> families (actually, there is not even a switch family name). I could
>> (and did in a previous RFC) use the match data to inform each module
>> name. However, it adds a non-obvious relation between the module name
>> (defined in Makefile) and a string in code. I was starting to
>> implement a lookup table to match compatible strings to their module
>> names when I realized that I was just mapping a string to a module
>> name, something like what module alias already does. That's when the
>> MODULE_ALIAS("<the compatible string>") was introduced.
>>
>> After this discussion, I have some questions:
>>
>> I'm declaring the of_device_id match table in realtek-common as it is
>> the same for both interfaces. I also moved MODULE_DEVICE_TABLE(of,
>> realtek_common_of_match) to realtek-common. Should I keep the
>> MODULE_DEVICE_TABLE() on each interface module (referencing the same
>> table), or is it okay to keep it in the realtek-common module? If I
> 
> Why would you have the same compatible entries in different modules? You
> do understand that device node will become populated on first bind (bind
> of the first device)?
> 
>> need to move it to each interface module, can I reuse a shared
>> of_device_id match table declared in realtek-common?
>>
>> If MODULE_ALIAS is not an acceptable solution, what would be the right
>> one? Go back to the static mapping between the compatible string and
>> the module name or is there a better solution?

Probably the solution is to make the design the same as for all other
complex drivers supporting more than one bus. If your ID table is
defined in modules A and B, then their loading should not depend on
aliases put in some additional "common" module. We solved this many
times for devices residing on multiple buses (e.g. I2C and SPI), so why
this has to be done in reverse order?

If you ask what would be the acceptable solution, then my answer is: do
the same as for most of other drivers, do not reinvent stuff like
putting same ID table or module alias in two modules. The table is
defined only once in each driver being loaded on uevent. From that
driver you probe whatever device you have, including calling any common
code, subprobes, subvariants etc.

Best regards,
Krzysztof



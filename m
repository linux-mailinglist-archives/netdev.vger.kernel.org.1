Return-Path: <netdev+bounces-24718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755BC77165E
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 19:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239EA2811AD
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 17:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BC663A4;
	Sun,  6 Aug 2023 17:53:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8857D5696
	for <netdev@vger.kernel.org>; Sun,  6 Aug 2023 17:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE5BC433C7;
	Sun,  6 Aug 2023 17:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691344421;
	bh=TiEcOPbSzVD11ZN5C0JGXcIfrthE91VTmMn1kJ2hHw8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PLYFUhc4c2EfIWmheHVngM7CkBbPeNKza7QyeGlk8VaDRUZSqt3uEDlcZgFcEq/nA
	 caNltPlf76c6Gt5SorNokpC60hbI3TysPqPcA8ACp+YjygEGwlyAhm0WeOjqljiIHy
	 8wEYdbet8HkYehfMjTJVU4y5E+e/WHbxgmBFdaOHXc8SIzFK2qu98D22WERhFWEdyK
	 dgkoi5QkYG38JrfdW5aLlJNEwnByYpW8Ujwi7KVB4MZtCuKEALPvlxuEXCx6iPtDiT
	 L4rRKrRMHP6oJOe8P+r4oVKtlDkr6fDSEefoo0/jDkYs4XuLG6ZLuaag/LA+rDNsus
	 kAbg6awR19i2A==
Message-ID: <5b4bd1cd-ff2d-3aef-8e14-ec3b3c158864@kernel.org>
Date: Sun, 6 Aug 2023 12:53:38 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/5] dt-bindings: clock: add Intel Agilex5 clock
 manager
Content-Language: en-US
To: "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>,
 Conor Dooley <conor.dooley@microchip.com>
Cc: "Ng, Adrian Ho Yin" <adrian.ho.yin.ng@intel.com>,
 "andrew@lunn.ch" <andrew@lunn.ch>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Turquette, Mike" <mturquette@baylibre.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "wen.ping.teh@intel.com" <wen.ping.teh@intel.com>
References: <20230801010234.792557-4-niravkumar.l.rabara@intel.com>
 <20230802025842.1260345-1-niravkumar.l.rabara@intel.com>
 <20230802-reuse-diffusion-d41ed8175390@wendy>
 <DM6PR11MB3291627AB955685C345F7B71A20BA@DM6PR11MB3291.namprd11.prod.outlook.com>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <DM6PR11MB3291627AB955685C345F7B71A20BA@DM6PR11MB3291.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/2/23 02:14, Rabara, Niravkumar L wrote:
> 
> 
>> -----Original Message-----
>> From: Conor Dooley <conor.dooley@microchip.com>
>> Sent: Wednesday, 2 August, 2023 3:02 PM
>> To: Rabara, Niravkumar L <niravkumar.l.rabara@intel.com>
>> Cc: Ng, Adrian Ho Yin <adrian.ho.yin.ng@intel.com>; andrew@lunn.ch;
>> conor+dt@kernel.org; devicetree@vger.kernel.org; dinguyen@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; linux-clk@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Turquette, Mike <mturquette@baylibre.com>;
>> netdev@vger.kernel.org; p.zabel@pengutronix.de;
>> richardcochran@gmail.com; robh+dt@kernel.org; sboyd@kernel.org;
>> wen.ping.teh@intel.com
>> Subject: Re: [PATCH v3 3/5] dt-bindings: clock: add Intel Agilex5 clock
>> manager
>>
>> On Wed, Aug 02, 2023 at 10:58:42AM +0800, niravkumar.l.rabara@intel.com
>> wrote:
>>> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>>>
>>> Add clock ID definitions for Intel Agilex5 SoCFPGA.
>>> The registers in Agilex5 handling the clock is named as clock manager.
>>>
>>> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
>>> Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>>
>> Damn, I was too late - you already sent a v3 :/
>>
>> However, there only seems to be a v3 of this one patch and it was sent in
>> reply to the v2 series? The normal thing to do is resend the entire series, not
>> just one patch, as a new thread. Not using a new thread may make it harder
>> to apply & will also bury the email in people's mailboxes that use things like
>> mutt. A single patch as a reply is also confusing, as the rest of the v3 looks like
>> it is missing!
>>
>> Thanks,
>> Conor.
> 
> Sorry I made a mistake.
> Should I send out entire series with PATCH v3 subject? Or should I wait for review comment on remaining patches and then send entire series with rework and  subject prefix PATCH v3?
> 

No need to send out a V3. I've applied patches 1-3 and 5. Will give a 
little more time for the clk patch.

Dinh


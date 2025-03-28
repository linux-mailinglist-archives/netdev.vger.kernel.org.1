Return-Path: <netdev+bounces-178078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A27A74668
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 10:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF97017CAE4
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 09:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C237C2139A2;
	Fri, 28 Mar 2025 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6zF2ynJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F381DE2BA;
	Fri, 28 Mar 2025 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743154652; cv=none; b=Xh4jRhWK+tzMn0qBNd6+rIq06yITOq1LcyyDN9B7q08E+ejQKwvPwVzTCETZO+bWDQ5moJ/h8YU8ZnS62F9Ioji4tJapVkAq/d+8YY/weuGa3ugriu0RooLtLk73t1UP0bOJumHMO5I+9TKlxjNvOUC78fafGH4jXWVyHpLmTc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743154652; c=relaxed/simple;
	bh=0fclWiepa/taOkA725bzSJS68oko6/7LBYyWLSBlxDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D9WEYIXOJPjbe1ye0TMm3mN5KtH+/uMIEDQLXsWE4/AdkYla2N4jPefgenA+gu3n4O18cwRFY07mSYU5khaxeRUHbkuAvKm9mNNaBTz9gtJqtbqYVvV3oe8mfJxnDjVTa/wat2TMr92k9gGQH0YvE6OYXDukDLOYeaSnnhiXY6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6zF2ynJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3417EC4CEE4;
	Fri, 28 Mar 2025 09:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743154652;
	bh=0fclWiepa/taOkA725bzSJS68oko6/7LBYyWLSBlxDk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q6zF2ynJhkl5yzeak6vXduN2dKM0dPK06WtOZjKVWlDcX+jDEkRlfrb0z/bpCWrFQ
	 s1EcLmtlgGwo8b92WifNdbPK4wKYyywEvhNfjffG0Gpb/a53QnmBclbjvMOw8K3V1g
	 acBPl828nzpd2rQwz6ZMuO1fHgaZabV8kL/ahqz1Oil8Z4bx/HO7332WS2hlwt3PxA
	 L8ooAvtN2RxJ6f1ZnQ5eNiRvU5Kijdk5hXahXllqD4QS8M1X1K2Oj9VqYc+CAlLsSm
	 S5All6X3M5xlVSZ6ymvycs7IvOPM2CEgibXJhF75BcZ2WoPemBh4NIBWVJvZBOzWO0
	 9BhC0gm7ww3QQ==
Message-ID: <aad0e28d-1164-47fb-b08b-ee70d94eab9c@kernel.org>
Date: Fri, 28 Mar 2025 10:37:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] arm64: dts: fsd: Add Ethernet support for FSD SoC
To: Swathi K S <swathi.ks@samsung.com>, krzk+dt@kernel.org,
 linux-fsd@tesla.com, robh@kernel.org, conor+dt@kernel.org,
 richardcochran@gmail.com, alim.akhtar@samsung.com
Cc: jayati.sahu@samsung.com, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pankaj.dubey@samsung.com, ravi.patel@samsung.com, gost.dev@samsung.com
References: <CGME20250307045516epcas5p3b4006a5e2005beda04170179dc92ad16@epcas5p3.samsung.com>
 <20250307044904.59077-1-swathi.ks@samsung.com>
 <017801db9fbc$81bfa490$853eedb0$@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <017801db9fbc$81bfa490$853eedb0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/2025 09:36, Swathi K S wrote:
> 
> 
>> -----Original Message-----
>> From: Swathi K S <swathi.ks@samsung.com>
>> Sent: 18 March 2025 16:22
>> To: 'krzk+dt@kernel.org' <krzk+dt@kernel.org>; 'linux-fsd@tesla.com'
>> <linux-fsd@tesla.com>; 'robh@kernel.org' <robh@kernel.org>;
>> 'conor+dt@kernel.org' <conor+dt@kernel.org>; 'richardcochran@gmail.com'
>> <richardcochran@gmail.com>; 'alim.akhtar@samsung.com'
>> <alim.akhtar@samsung.com>
>> Cc: 'jayati.sahu@samsung.com' <jayati.sahu@samsung.com>; 'linux-arm-
>> kernel@lists.infradead.org' <linux-arm-kernel@lists.infradead.org>; 'linux-
>> samsung-soc@vger.kernel.org' <linux-samsung-soc@vger.kernel.org>;
>> 'devicetree@vger.kernel.org' <devicetree@vger.kernel.org>; 'linux-
>> kernel@vger.kernel.org' <linux-kernel@vger.kernel.org>;
>> 'netdev@vger.kernel.org' <netdev@vger.kernel.org>;
>> 'pankaj.dubey@samsung.com' <pankaj.dubey@samsung.com>;
>> 'ravi.patel@samsung.com' <ravi.patel@samsung.com>;
>> 'gost.dev@samsung.com' <gost.dev@samsung.com>
>> Subject: RE: [PATCH v8 0/2] arm64: dts: fsd: Add Ethernet support for FSD
>> SoC
>>
>>
>>
>>> -----Original Message-----
>>> From: Swathi K S <swathi.ks@samsung.com>
>>> Sent: 07 March 2025 10:19
>>> To: krzk+dt@kernel.org; linux-fsd@tesla.com; robh@kernel.org;
>>> conor+dt@kernel.org; richardcochran@gmail.com;
>>> alim.akhtar@samsung.com
>>> Cc: jayati.sahu@samsung.com; swathi.ks@samsung.com; linux-arm-
>>> kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org;
>>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
>>> netdev@vger.kernel.org; pankaj.dubey@samsung.com;
>>> ravi.patel@samsung.com; gost.dev@samsung.com
>>> Subject: [PATCH v8 0/2] arm64: dts: fsd: Add Ethernet support for FSD
>>> SoC
>>>
>>> FSD platform has two instances of EQoS IP, one is in FSYS0 block and
>>> another one is in PERIC block. This patch series add required DT file
>>> modifications for the same.
>>>
>>> Changes since v1:
>>> 1. Addressed the format related corrections.
>>> 2. Addressed the MAC address correction.
>>>
>>> Changes since v2:
>>> 1. Corrected intendation issues.
>>>
>>> Changes since v3:
>>> 1. Removed alias names of ethernet nodes
>>>
>>> Changes since v4:
>>> 1. Added more details to the commit message as per review comment.
>>>
>>> Changes since v5:
>>> 1. Avoided inserting node in the end and inserted it in between as per
>>> address.
>>> 2. Changed the node label.
>>> 3. Separating DT patches from net patches and posting in different
>> branches.
>>>
>>> Changes since v6:
>>> 1. Addressed Andrew's review comment and removed phy-mode from
>> .dtsi
>>> to .dts
>>>
>>> Changes since v7:
>>> 1. Addressed Russell's review comment-Implemented clock tree setup in
>>> DT
>>>
>>
>> Hi,
>> The DT binding and driver patches corresponding to this patch is now
>> reflecting in linux-next
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-
>> next.git/diff/Documentation/devicetree/bindings/net/tesla,fsd-
>> ethqos.yaml?id=f654ead4682a1d351d4d780b1b59ab02477b1185
>>
> 
> Hi reviewers, 
> Could you please confirm whether this set of patches can be considered for review or should I resend them?

Don't ping during merge window.

Best regards,
Krzysztof


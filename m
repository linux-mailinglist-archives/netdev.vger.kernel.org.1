Return-Path: <netdev+bounces-211487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3CDB193CE
	for <lists+netdev@lfdr.de>; Sun,  3 Aug 2025 13:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33CFD7AB6D4
	for <lists+netdev@lfdr.de>; Sun,  3 Aug 2025 11:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7CA25B687;
	Sun,  3 Aug 2025 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHuiIEhb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCC4192B90;
	Sun,  3 Aug 2025 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754219569; cv=none; b=VJUOBS8MWIL5Q0wz8nbM5nw3uj7STDYVtEZ03FH9hEYUxNOeL7Wc2d55D/+boJF5TaTBmqUeiCVPOsbK7eZ8y+4fioobY2u2Ckh9u8lL8s8x73fiYMdb6KT64Bgc4xapeVY7v8YqvyXg9QoXfkpE7bNrCSCH89J+wCy/LKshKV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754219569; c=relaxed/simple;
	bh=/DuWb1PqPZaSu8+vdQF93J8DpOZRJnKyJD1SGitokQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBLvcyytjktXuxSvEmKGdyimU+Cr8VBiUvP/6sub9+8CREGCcpwQtlxkmU3+t/+R7B7dOetubHrS4U8/d+0XqqnXwUlUieRjr31jd6IFbNpBLhrB7PJFgAnYJM61tEP+jGNqFMU1lcl4w2d3JlDJLUaBPgILoaex+TFwJMIaSPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHuiIEhb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E459C4CEEB;
	Sun,  3 Aug 2025 11:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754219569;
	bh=/DuWb1PqPZaSu8+vdQF93J8DpOZRJnKyJD1SGitokQk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bHuiIEhblA1gkXkFNEpp9tUT5E7hqrgJikoUwwNI38O7V03BCmkkme6O2SqRSNygM
	 MWLbAUwRxhjhKIRIStlbMJEchhXdR7aMXNysFrf/42PXT2I0V4B/i0v8U++JnVe5kf
	 JnaH67c/pa5pVZjUeVHQ/dDNSR8GG27yaGVOpoKOrwnoHZALCkjqaZRdf+VyZ845gk
	 Ch1ui3i2o8jLy7ko8khFXmD7Ug3IM0rEWupS0/aTG/sV2KJLLgtQmGX2MaKed0rZF0
	 gnAxDFKWbslkPKo1dMualzXAkIczlqL5qrl5McRMBISAJ/oczoMZsXcv1TctdAmYNd
	 30E7j/4VJFDeQ==
Message-ID: <db39e1ff-8f83-468c-a8cb-0dd7c5a98b85@kernel.org>
Date: Sun, 3 Aug 2025 13:12:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] dt-bindings: dpll: Add clock ID property
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250717171100.2245998-1-ivecera@redhat.com>
 <20250717171100.2245998-2-ivecera@redhat.com>
 <5ff2bb3e-789e-4543-a951-e7f2c0cde80d@kernel.org>
 <6937b833-4f3b-46cc-84a6-d259c5dc842a@redhat.com>
 <20250721-lean-strong-sponge-7ab0be@kuoka>
 <804b4a5f-06bc-4943-8801-2582463c28ef@redhat.com>
 <9220f776-8c82-474b-93fc-ad6b84faf5cc@kernel.org>
 <466e293c-122f-4e11-97d2-6f2611a5178e@redhat.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <466e293c-122f-4e11-97d2-6f2611a5178e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/07/2025 09:23, Ivan Vecera wrote:
> 
> 
> On 23. 07. 25 8:25 dop., Krzysztof Kozlowski wrote:
>> On 21/07/2025 14:54, Ivan Vecera wrote:
>>> On 21. 07. 25 11:23 dop., Krzysztof Kozlowski wrote:
>>>> On Fri, Jul 18, 2025 at 02:16:41PM +0200, Ivan Vecera wrote:
>>>>> Hi Krzysztof,
>>>>>
>>>>> ...
>>>>>
>>>>> The clock-id property name may have been poorly chosen. This ID is used by
>>>>> the DPLL subsystem during the registration of a DPLL channel, along with its
>>>>> channel ID. A driver that provides DPLL functionality can compute this
>>>>> clock-id from any unique chip information, such as a serial number.
>>>>>
>>>>> Currently, other drivers that implement DPLL functionality are network
>>>>> drivers, and they generate the clock-id from one of their MAC addresses by
>>>>> extending it to an EUI-64.
>>>>>
>>>>> A standalone DPLL device, like the zl3073x, could use a unique property such
>>>>> as its serial number, but the zl3073x does not have one. This patch-set is
>>>>> motivated by the need to support such devices by allowing the DPLL device ID
>>>>> to be passed via the Device Tree (DT), which is similar to how NICs without
>>>>> an assigned MAC address are handled.
>>>>
>>>> You use words like "unique" and MAC, thus I fail to see how one fixed
>>>> string for all boards matches this. MACs are unique. Property value set
>>>> in DTS for all devices is not.
>>>>> You also need to explain who assigns this value (MACs are assigned) or
>>>> if no one, then why you cannot use random? I also do not see how this
>>>> property solves this...  One person would set it to value "1", other to
>>>> "2" but third decide to reuse "1"? How do you solve it for all projects
>>>> in the upstream?
>>>
>>> Some background: Any DPLL driver has to use a unique number during the
>>> DPLL device/channel registration. The number must be unique for the
>>> device across a clock domain (e.g., a single PTP network).
>>>
>>> NIC drivers that expose DPLL functionality usually use their MAC address
>>> to generate such a unique ID. A standalone DPLL driver does not have
>>> this option, as there are no NIC ports and therefore no MAC addresses.
>>> Such a driver can use any other source for the ID (e.g., the chip's
>>> serial number). Unfortunately, this is not the case for zl3073x-based
>>> hardware, as its current firmware revisions do not expose information
>>> that could be used to generate the clock ID (this may change in the
>>> future).
>>>
>>> There is no authority that assigns clock ID value ranges similarly to
>>> MAC addresses (OUIs, etc.), but as mentioned above, uniqueness is
>>> required across a single PTP network so duplicates outside this
>>> single network are not a problem.
>>
>> You did not address main concern. You will configure the same value for
>> all boards, so how do you solve uniqueness within PTP network?
> 
> This value differs across boards, similar to the local-mac-address. The
> device tree specifies the entry, and the bootloader or system firmware
> (like U-Boot) provides the actual value.
This should be clearly explained in commit msg or pull request to dtschema.

Where are patches for U-Boot? lore gives me 0 results.

Best regards,
Krzysztof

